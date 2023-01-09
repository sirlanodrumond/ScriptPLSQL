PL/SQL Developer Test script 3.0
327
-- Created on 28/08/2018 by DESENV 
declare 
  tpVF tdvadm.t_con_valefrete%rowtype;
  NVALORRATEIO         NUMBER;
  NVALORRATEIOF        NUMBER;
  NVALORRATEIOP        NUMBER;
  V_NVALORCALCULO      NUMBER;
  V_PEDAGIOFROTA       NUMBER;
  V_PESOCONTRATADO     NUMBER;
  V_VLRDESCONTO        NUMBER;
  V_VALORTOTALCTRC     NUMBER;
  V_PEDAGIOCLI         NUMBER;
  V_BONUS              NUMBER;
  v_valortotalctrccimp NUMBER;
  V_EMITE_BONUS        CHAR(1);
  V_TIPOMOT            CHAR(2);
  v_AgregadoPercDef    NUMBER;
  v_AgregadoPerc       NUMBER;
  v_AgregadoPercCAT    NUMBER;
  v_AgregadoPercPlaca  NUMBER;
  vTemGrupo0020        number;
  vAuxiliar            number;
  
  -- VARIAVEIS PARA PEGAR OS PARAMETROS
  V_PARAMETRO     tdvadm.T_USU_PERFIL.USU_PERFIL_CODIGO%TYPE; 
  V_PARAMTEXTO    tdvadm.T_USU_PERFIL.USU_PERFIL_PARAT%TYPE; 
  v_paramnumber   tdvadm.t_usu_perfil.usu_perfil_paran1%TYPE;
  V_PERC_BONUS    tdvadm.T_USU_PERFIL.USU_PERFIL_PARAT%TYPE; 
 
  -- MONTA O CURSOR PARA PEGAR OS PARAMETROS
  CURSOR C_PARAMETROS IS
    SELECT P.PERFIL, P.TEXTO,p.numerico1
      FROM tdvadm.T_USU_PARAMETROTMP P
     WHERE P.USUARIO = tpVF.USU_USUARIO_CODIGO
       AND P.APLICACAO = 'comvlfrete'
       and P.ROTA = tpVF.GLB_ROTA_CODIGO
       and p.perfil in ('PERCENT_BONUS','VLRAGREGPER','VLRAGREGPER','VLRAGREGPER');

begin
  -- Test statements here
   /******************************************************************************
  *   BEGIN: TDVADM.TG_RATEIACONHEC - BEFORE UPDATE                            *
  ******************************************************************************/
   Select *
     into tpVF
   from tdvadm.t_con_valefrete vf
   where vf.con_conhecimento_codigo = '004167'
     and vf.con_conhecimento_serie = 'A1'
     and vf.glb_rota_codigo = '913'
     and vf.con_valefrete_saque = '1';



    V_EMITE_BONUS := 'N';
     
    -- PEGA PARAMETROS
    tdvadm.sp_usu_parametrossc('comvlfrete', NVL(tpVF.USU_USUARIO_CODIGO,'jsantos'), NVL(tpVF.GLB_ROTA_CODIGO,'010'), 'TRIGGER');
    --
    
    v_AgregadoPerc      := 0;  
    v_AgregadoPercDef   := 0;
    v_AgregadoPercPlaca := 0;
    v_AgregadoPercCAT   := 0;

    OPEN C_PARAMETROS;
    LOOP
      FETCH C_PARAMETROS
        INTO V_PARAMETRO, 
             V_PARAMTEXTO,
             v_paramnumber;
      EXIT WHEN C_PARAMETROS%NOtFOUND;

      IF V_PARAMETRO = 'PERCENT_BONUS' THEN
        V_PERC_BONUS := V_PARAMTEXTO;
      ELSIF V_PARAMETRO = 'VLRAGREGPER' THEN
        v_AgregadoPercDef := v_paramnumber ;
      ELSIF V_PARAMETRO = 'VLRAGREGPER' || TRIM(tpVF.con_valefrete_placa) THEN
        v_AgregadoPercPlaca := v_paramnumber ;
      ELSIF V_PARAMETRO = 'VLRAGREGPER' || TRIM(tpVF.CON_CATVALEFRETE_CODIGO) THEN
        v_AgregadoPercCAT := v_paramnumber ;
      END IF;
    END LOOP;
    CLOSE C_PARAMETROS;

   IF nvl(v_AgregadoPercDef,0) = 0 THEN
      v_AgregadoPercDef := 100;
   END IF;   
    
   IF v_AgregadoPercPlaca > 0 tHEN
      v_AgregadoPerc := v_AgregadoPercPlaca;
   Else
      if v_AgregadoPercCAT > 0 Then  
         v_AgregadoPerc := v_AgregadoPercCAT;
      Else
         v_AgregadoPerc := v_AgregadoPercDef;
      End if;
   End If;      
            
   IF nvl(v_AgregadoPerc,0) = 0 THEN
       v_AgregadoPerc := v_AgregadoPercDef;
   END IF;   
    
   IF nvl(v_AgregadoPerc,0) = 0 THEN
       v_AgregadoPerc := 5;
   END IF;   
    
    -- SE CANCELADO ENTRA COM VALOR DE RATEIO ZERADO
   IF (tpVF.CON_VALEFRETE_STATUS = 'C') THEN
       tpVF.CON_VALEFRETE_VALORRATEIO := 0;
   ELSE
      IF NVL(tpVF.CON_VALEFRETE_PEDPGCLI, 'N') = 'S' THEN 
        V_PEDAGIOCLI := tpVF.CON_VALEFRETE_PEDAGIO;
      ELSE
        V_PEDAGIOCLI := 0;
      END IF;
      
      V_TIPOMOT := tpVF.GLB_TPMOTORISTA_CODIGO ;

      -- Testa se teve desconto de Agregado
      If V_TIPOMOT in ('C','D') Then
         select count(*)
           into vAuxiliar
         from tdvadm.t_con_calcvalefrete cv
         where cv.con_conhecimento_codigo = tpVF.con_conhecimento_codigo
           and cv.con_conhecimento_serie = tpVF.con_conhecimento_serie
           and cv.glb_rota_codigo = tpVF.glb_rota_codigo
           and cv.con_valefrete_saque = tpVF.con_valefrete_saque
           and cv.con_calcvalefretetp_codigo = '05'
           and cv.con_calcvalefrete_valor <> 0 ;
         If vAuxiliar > 0 then
            V_TIPOMOT := 'A';
         End If;
      End If;

      SELECT SUM(NVL(tdvadm.FN_VERBASEMIMPOSTO(X.CON_CONHECIMENTO_CODIGO, X.CON_CONHECIMENTO_SERIE, X.GLB_ROTA_CODIGO, 'I_TTPV'), 1)),
             SUM(NVL(tdvadm.f_busca_conhec_ttpv(X.CON_CONHECIMENTO_CODIGO, X.CON_CONHECIMENTO_SERIE, X.GLB_ROTA_CODIGO), 1)),
             SUM(DECODE(CL.GLB_GRUPOECONOMICO_CODIGO,'0020',1,0))
        INTO V_VALORTOTALCTRC,
             v_valortotalctrccimp,
             vTemGrupo0020
        FROM TDVADM.T_CON_VFRETECONHEC X,
             TDVADM.t_con_conhecimento c,
             TDVADM.t_glb_cliente cl
       WHERE X.CON_VALEFRETE_CODIGO = tpVF.CON_CONHECIMENTO_CODIGO
         AND X.CON_VALEFRETE_SERIE = tpVF.CON_CONHECIMENTO_SERIE
         AND X.GLB_ROTA_CODIGOVALEFRETE = tpVF.GLB_ROTA_CODIGO
         AND X.CON_VALEFRETE_SAQUE = tpVF.CON_VALEFRETE_SAQUE
         AND X.CON_CONHECIMENTO_CODIGO = C.CON_CONHECIMENTO_CODIGO
         AND X.CON_CONHECIMENTO_SERIE  = C.CON_CONHECIMENTO_SERIE
         AND X.GLB_ROTA_CODIGO         = C.GLB_ROTA_CODIGO
         AND C.GLB_CLIENTE_CGCCPFSACADO = CL.GLB_CLIENTE_CGCCPFCODIGO;
    
      IF NVL(V_VALORTOTALCTRC, 0) = 0 THEN
        V_VALORTOTALCTRC := 1;
        v_valortotalctrccimp := 1;
      END IF;
    
      IF NVL(tpVF.CON_VALEFRETE_PESOCOBRADO, 0) = 0 THEN
        V_PESOCONTRATADO := 1;
      ELSE
        V_PESOCONTRATADO := tpVF.CON_VALEFRETE_PESOCOBRADO;
      END IF;

      -- GILES 20/07/2004
      -- QUANDO COMPLEMENTO SOMO AS VERBAS PARA CALCULAR OS CUSTOS
      IF (tpVF.CON_CATVALEFRETE_CODIGO = '05') THEN
         IF (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) = 0) THEN
           NVALORRATEIO := (NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) + 
                            NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) + 
                            NVL(tpVF.CON_VALEFRETE_ESTADIA, 0) + 
                            NVL(tpVF.CON_VALEFRETE_OUTROS, 0)) / V_VALORTOTALCTRC;
           NVALORRATEIOF := (NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) + 
                            NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) + 
                            NVL(tpVF.CON_VALEFRETE_ESTADIA, 0) + 
                            NVL(tpVF.CON_VALEFRETE_OUTROS, 0)) / v_valortotalctrccimp;
           NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
         ELSE
            IF UPPER(tpVF.CON_VALEFRETE_TIPOCUSTO) = 'T' THEN
               NVALORRATEIO := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) - V_PEDAGIOCLI) / V_VALORTOTALCTRC;
               NVALORRATEIOF := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) - V_PEDAGIOCLI) / v_valortotalctrccimp;
               NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
               V_NVALORCALCULO := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) / V_VALORTOTALCTRC;
            
            --NVALORRATEIO := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) * V_PESOCONTRATADO) / V_VALORTOTALCTRC;
            ELSE
               NVALORRATEIO := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) / V_VALORTOTALCTRC;
               NVALORRATEIOF := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) / v_valortotalctrccimp;
               NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
               V_NVALORCALCULO := NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) / V_VALORTOTALCTRC;
            END IF;
         END IF;
      ELSE
         IF UPPER(tpVF.CON_VALEFRETE_TIPOCUSTO) = 'T' THEN
           --NVALORRATEIO := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) * V_PESOCONTRATADO) / V_VALORTOTALCTRC;
          
           --JUNIOR 20/05  (MANEIRA CORRETA DE OBTER O CUSTO CARRETEIRO P/ FRETE POR TONELADA)
            NVALORRATEIO := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) - V_PEDAGIOCLI) / V_VALORTOTALCTRC;
            NVALORRATEIOF := ((NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) - V_PEDAGIOCLI) / v_valortotalctrccimp;
            NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
            V_NVALORCALCULO := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) * V_PESOCONTRATADO) / V_VALORTOTALCTRC;
         ELSE
            NVALORRATEIO := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) / V_VALORTOTALCTRC;
            NVALORRATEIOF := (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) - V_PEDAGIOCLI) / v_valortotalctrccimp;
            NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
            V_NVALORCALCULO := NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0) / V_VALORTOTALCTRC;
         END IF;
      END IF;
    
      IF SUBSTR(tpVF.CON_VALEFRETE_PLACA, 1, 2) = '00' THEN -- FROTA
         IF (tpVF.CON_VALEFRETE_PEDAGIO = 0) AND 
            (NVL(tpVF.CON_VALEFRETE_PEDPGCLI,'N') = 'N') and 
            tpVF.con_catvalefrete_codigo  in ( tdvadm.pkg_con_valefrete.CatTUmaViagem,
                                               tdvadm.pkg_con_valefrete.CatTAvulsoCCTRC    
                                                 ) THEN
             V_PEDAGIOFROTA := NVL(((tdvadm.F_BUSCA_PEDAGIO_PERCURSO_ATU(tpVF.GLB_LOCALIDADE_CODIGOORI, 
                                                                  tpVF.GLB_LOCALIDADE_CODIGODES, 
                                                                  tpVF.CON_VALEFRETE_DATAEMISSAO) *
                                                                  tdvadm.F_RETORNANUMEIXOS(tpVF.CON_VALEFRETE_PLACA)) / 
                                   V_VALORTOTALCTRC), 0);
         ELSE
            V_PEDAGIOFROTA := 0;
         END IF;
         NVALORRATEIOF := 0;
         NVALORRATEIOP := 0;
      ELSE  -- AGREGADO/TERCEIRO
         V_VLRDESCONTO := ((V_NVALORCALCULO * V_VALORTOTALCTRC) - 
                           NVL(tpVF.CON_VALEFRETE_PEDAGIO, 0) - 
                           NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) - 
                           NVL(tpVF.CON_VALEFRETE_VALORVAZIO, 0) -
                           NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) - 
                           NVL(tpVF.CON_VALEFRETE_OUTROS, 0) -
                           NVL(tpVF.CON_VALEFRETE_IRRF, 0) - 
                           NVL(tpVF.CON_VALEFRETE_ESTADIA, 0)) * ( (100 - v_AgregadoPerc) /100 ) ;
         V_VLRDESCONTO := (V_VLRDESCONTO + 
                           NVL(tpVF.CON_VALEFRETE_PEDAGIO, 0) + 
                           NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) + 
                           NVL(tpVF.CON_VALEFRETE_VALORVAZIO, 0) + 
                           NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) +
                           NVL(tpVF.CON_VALEFRETE_OUTROS, 0) +
                           NVL(tpVF.CON_VALEFRETE_IRRF, 0) + 
                           NVL(tpVF.CON_VALEFRETE_ESTADIA, 0));
         IF (TRIM(tdvadm.FN_RETTP_MOTORISTA(tpVF.CON_VALEFRETE_PLACA, tpVF.CON_VALEFRETE_PLACASAQUE, tpVF.CON_VALEFRETE_DATAEMISSAO)) = 'AGREGADO') AND
            (NVL(tpVF.CON_VALEFRETE_VALORCOMDESCONTO, 0) <> NVL(V_VLRDESCONTO, 0)) AND
            (NVL(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, 0)) > 0 and 
            (nvl(tpVF.con_valefrete_impresso,'N') = 'N')  THEN
          -- SE VALE PEDAGIO -- REVER O CONCEITO
             tpVF.CON_VALEFRETE_VALORCOMDESCONTO := ((V_NVALORCALCULO * V_VALORTOTALCTRC) - 
                                                     NVL(tpVF.CON_VALEFRETE_PEDAGIO, 0) - 
                                                     NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) -
                                                     NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) - 
                                                     NVL(tpVF.CON_VALEFRETE_OUTROS, 0) -
                                                     NVL(tpVF.CON_VALEFRETE_ESTADIA, 0)) * ( (100 - v_AgregadoPerc) /100 );  
             tpVF.CON_VALEFRETE_VALORCOMDESCONTO := (tpVF.CON_VALEFRETE_VALORCOMDESCONTO + 
                                                     NVL(tpVF.CON_VALEFRETE_PEDAGIO, 0) + 
                                                     NVL(tpVF.CON_VALEFRETE_VALORESTIVA, 0) +
                                                     NVL(tpVF.CON_VALEFRETE_ENLONAMENTO, 0) + 
                                                     NVL(tpVF.CON_VALEFRETE_OUTROS, 0) +
                                                     NVL(tpVF.CON_VALEFRETE_ESTADIA, 0));
         END IF;
         V_PEDAGIOFROTA := 0;
      END IF;
      
      IF V_TIPOMOT = 'A' THEN
         NVALORRATEIOF := (NVL(tpVF.CON_VALEFRETE_VALORCOMDESCONTO, 0) - V_PEDAGIOCLI) / v_valortotalctrccimp;
         NVALORRATEIOP := NVL(tpVF.CON_VALEFRETE_PEDAGIO - V_PEDAGIOCLI, 0) / v_valortotalctrccimp;
      END IF;
      
    
      IF (NVL(tpVF.CON_VALEFRETE_VALORVAZIO, 0) > 0) AND
         (TRIM(tdvadm.FN_RETTP_MOTORISTA(tpVF.CON_VALEFRETE_PLACA, tpVF.CON_VALEFRETE_PLACASAQUE, tpVF.CON_VALEFRETE_DATAEMISSAO)) = 'AGREGADO') THEN   
         tpVF.CON_VALEFRETE_VALORRATEIO := NVALORRATEIO + 
                                           V_PEDAGIOFROTA + 
                                           (NVL(tpVF.CON_VALEFRETE_VALORVAZIO, 0) / V_VALORTOTALCTRC);
      ELSE
         tpVF.CON_VALEFRETE_VALORRATEIO := NVALORRATEIO + V_PEDAGIOFROTA;
      END IF;
    
   END IF;

   IF (nvl(tpVF.con_valefrete_impresso,'N') = 'N') and ( TO_DATE(TO_CHAR(tpVF.CON_VALEFRETE_DATACADASTRO,'DD/MM/YYYY'),'DD/MM/YYYY') >= TRUNC(SYSDATE))  THEN
       tpVF.CON_VALEFRETE_DATACADASTRO := tpVF.CON_VALEFRETE_DATACADASTRO;
   END IF;    


   IF TO_DATE(TO_CHAR(tpVF.CON_VALEFRETE_DATACADASTRO,'DD/MM/YYYY'),'DD/MM/YYYY') >= TRUNC(SYSDATE)-90  THEN
      BEGIN
        SELECT GLB_ROTA_CALCBONUS
           INTO V_EMITE_BONUS
        FROM T_GLB_ROTA
        WHERE GLB_ROTA_CODIGO = tpVF.GLB_ROTA_CODIGO;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            V_EMITE_BONUS := 'N';
      END;
         
      
      IF (V_EMITE_BONUS = 'S') THEN
         if nvl(tpVF.con_valefrete_impresso,'N') = 'N' Then   

            IF (tpVF.CON_CATVALEFRETE_CODIGO NOT IN (tdvadm.pkg_con_valefrete.CatTBonusManifesto,
                                                     tdvadm.pkg_con_valefrete.CatTBonusCTRC)) THEN

               IF (tpVF.CON_VALEFRETE_TIPOCUSTO) = 'T' THEN
                  --V_BONUS := ((tpVF.CON_VALEFRETE_CUSTOCARRETEIRO * tpVF.CON_VALEFRETE_PESOCOBRADO) * TO_NUMBER(V_PERC_BONUS) / 100);
                  V_BONUS := tdvadm.fn_retornavalorfretebonus(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO * tpVF.CON_VALEFRETE_PESOCOBRADO, TO_NUMBER(V_PERC_BONUS), 'B2');
               ELSE
              --V_BONUS := ((tpVF.CON_VALEFRETE_CUSTOCARRETEIRO) * TO_NUMBER(V_PERC_BONUS) / 100);
                 V_BONUS := tdvadm.fn_retornavalorfretebonus(tpVF.CON_VALEFRETE_CUSTOCARRETEIRO, TO_NUMBER(V_PERC_BONUS), 'B2');
               END IF;
            end if; 
         END IF;
      END IF;
   -- PEDE PARA ATUALIZAR O CUSTO DE TODOS OS VALES DE MESMO NUMERO
      UPDATE tdvadm.T_CON_VFRETECONHEC V
         SET CON_VFRETECONHEC_RECALCULA     = 'S',
             CON_VFRETECONHEC_RATEIORECEITA = NULL,
             -- ATUALIZA SOMENTE O VALE DE FRETE com o saque
             CON_VFRETECONHEC_RATEIOFRETE = decode(CON_VALEFRETE_SAQUE,tpVF.CON_VALEFRETE_SAQUE,nvl(NVALORRATEIOF,0),CON_VFRETECONHEC_RATEIOFRETE),
             CON_VFRETECONHEC_RATEIOPEDAGIO = decode(CON_VALEFRETE_SAQUE,tpVF.CON_VALEFRETE_SAQUE,nvl(NVALORRATEIOP,0),CON_VFRETECONHEC_RATEIOPEDAGIO)
        WHERE CON_VALEFRETE_CODIGO = tpVF.CON_CONHECIMENTO_CODIGO
         AND CON_VALEFRETE_SERIE = tpVF.CON_CONHECIMENTO_SERIE
         AND GLB_ROTA_CODIGOVALEFRETE = tpVF.GLB_ROTA_CODIGO;
   END If;  



end;
1
NEW
0
-5
4
NVALORRATEIO
NVALORRATEIOF
NVALORRATEIOP
V_NVALORCALCULO
