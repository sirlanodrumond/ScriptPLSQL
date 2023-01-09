PL/SQL Developer Test script 3.0
147
-- Created on 11/08/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vTpnotatransf   tdvadm.t_arm_notatransf%rowtype;
  vErro          varchar2(1000);
begin
  -- Test statements here
  delete tdvadm.t_arm_notatransf;
  for c_msg in (select distinct an.arm_nota_dtinclusao,
                       an.arm_nota_numero,
                       an.glb_cliente_cgccpfremetente,
                       an.slf_contrato_codigo,
                       an.arm_nota_peso,
                       an.arm_nota_localcoletal,
                       an.arm_nota_localentregal,
                       an.arm_armazem_codigo arm_armazem_codigoNT,
                       an.con_conhecimento_codigo || an.con_conhecimento_serie || an.glb_rota_codigo cte,
                       an.arm_embalagem_numero,
                       an.arm_embalagem_flag,
                       an.arm_embalagem_sequencia
                from tdvadm.t_arm_nota an,
                     tdvadm.t_arm_carregamentodet cd
                where an.arm_nota_dtinclusao >= '01/01/2017'
                  and an.arm_embalagem_numero = cd.arm_embalagem_numero
                  and an.arm_embalagem_flag = cd.arm_embalagem_flag
                  and an.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
                  and cd.arm_armazem_codigo_transf is not null
--                  and an.arm_nota_numero in (45728)
--                  and an.glb_cliente_cgccpfremetente = '03327988000439'
                  )
  loop
    vTpnotatransf.Dtinc        := c_msg.arm_nota_dtinclusao;
    vTpnotatransf.Nota         := c_msg.arm_nota_numero;
    vTpnotatransf.Remetente    := c_msg.glb_cliente_cgccpfremetente;
    vTpnotatransf.Contrato     := c_msg.slf_contrato_codigo;
    vTpnotatransf.Peso         := c_msg.arm_nota_peso;
    vTpnotatransf.Loccoleta    := c_msg.arm_nota_localcoletal;
    vTpnotatransf.Locentrega   := c_msg.arm_nota_localentregal;
    vTpnotatransf.Coleta       := tdvadm.fn_busca_codigoibge(vTpnotatransf.Loccoleta,'IBD'); 
    vTpnotatransf.Entrega      := tdvadm.fn_busca_codigoibge(vTpnotatransf.Locentrega,'IBD'); 
    vTpnotatransf.Kmviagem     := tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(vTpnotatransf.Loccoleta,vTpnotatransf.Locentrega);
    vTpnotatransf.Armnota      := c_msg.arm_armazem_codigont;
    vTpnotatransf.Cte          := c_msg.cte;


     for c_msg1 in (select vf.con_valefrete_datacadastro,
                           vf.glb_localidade_codigoori,
                           vf.glb_localidade_codigodes,
                           vf.con_conhecimento_codigo ||'-'||vf.con_conhecimento_serie||'-'||vf.glb_rota_codigo||'-'||vf.con_valefrete_saque vale,
                           vf.con_valefrete_placa placa
                    from tdvadm.t_con_valefrete vf,
                         tdvadm.t_con_vfreteconhec vfc
                    where vf.con_conhecimento_codigo = vfc.con_valefrete_codigo
                      and vf.con_conhecimento_serie = vfc.con_valefrete_serie
                      and vf.glb_rota_codigo = vfc.glb_rota_codigovalefrete
                      and vf.con_valefrete_saque = vfc.con_valefrete_saque 
                      and vf.con_valefrete_saque = (select min(vf1.con_valefrete_saque)
                                                    from tdvadm.t_con_valefrete vf1
                                                    where vf1.con_conhecimento_codigo = vf.con_conhecimento_codigo
                                                      and vf1.con_conhecimento_serie = vf.con_conhecimento_serie
                                                      and vf1.glb_rota_codigo = vf.glb_rota_codigo
                                                      and vf1.Con_Valefrete_Status is null)
                      and vfc.con_conhecimento_codigo = substr(vTpnotatransf.Cte,1,6)
                      and vfc.con_conhecimento_serie = substr(vTpnotatransf.Cte,7,2)
                      and vfc.glb_rota_codigo = substr(vTpnotatransf.Cte,9,3)
                    order by vf.con_valefrete_datacadastro)

     Loop               
        vTpnotatransf.Origdestvfrete := tdvadm.fn_busca_codigoibge(c_msg1.glb_localidade_codigoori,'IBD') || '-' || tdvadm.fn_busca_codigoibge(c_msg1.glb_localidade_codigodes,'IBD'); 
        vTpnotatransf.Kmpernada      := tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(c_msg1.glb_localidade_codigoori,c_msg1.glb_localidade_codigodes);          
        vTpnotatransf.Valefrete      := c_msg1.vale;
        vTpnotatransf.Placa          := c_msg1.placa;


        Begin
          SELECT CA.arm_carregamento_dtcria,
                 CA.arm_carregamento_dtfechamento,
                 CA.arm_armazem_codigo,
                 cd.arm_carregamento_codigo,
                 cd.arm_armazem_codigo_transf,
                 cd.arm_carregamentodet_dcheckin,
                 cd.usu_usuario_codigocheckin
            INTO vTpnotatransf.Criacao,   
                 vTpnotatransf.Dtfechamento,
                 vTpnotatransf.Armcarreg,
                 vTpnotatransf.Carregamento,
                 vTpnotatransf.Armtransf,
                 vTpnotatransf.Armtransf,
                 vTpnotatransf.Uscheckin
          FROM TDVADM.T_ARM_CARREGAMENTO CA,
               TDVADM.T_ARM_CARREGAMENTODET CD
          WHERE CA.ARM_CARREGAMENTO_CODIGO = CD.ARM_CARREGAMENTO_CODIGO
            AND CD.ARM_EMBALAGEM_NUMERO = C_MSG.ARM_EMBALAGEM_NUMERO
            AND CD.ARM_EMBALAGEM_FLAG = C_MSG.ARM_EMBALAGEM_FLAG
            AND CD.ARM_EMBALAGEM_SEQUENCIA = C_MSG.ARM_EMBALAGEM_SEQUENCIA
            AND CA.ARM_CARREGAMENTO_CODIGO = (SELECT MAX(CA1.ARM_CARREGAMENTO_CODIGO)
                                              FROM TDVADM.T_ARM_CARREGAMENTO CA1,
                                                   TDVADM.T_ARM_CARREGAMENTODET CD1
                                              WHERE CA1.ARM_CARREGAMENTO_CODIGO = CD1.ARM_CARREGAMENTO_CODIGO
                                                AND CD1.ARM_EMBALAGEM_NUMERO = C_MSG.ARM_EMBALAGEM_NUMERO
                                                AND CD1.ARM_EMBALAGEM_FLAG = C_MSG.ARM_EMBALAGEM_FLAG
                                                AND CD1.ARM_EMBALAGEM_SEQUENCIA = C_MSG.ARM_EMBALAGEM_SEQUENCIA
                                                AND CA1.ARM_CARREGAMENTO_DTCRIA <= C_MSG1.CON_VALEFRETE_DATACADASTRO);
          If vTpnotatransf.Armcarreg is not null Then
             select a.glb_rota_codigo
                into vTpnotatransf.Rotacarreg
             from tdvadm.t_arm_armazem a
             where a.arm_armazem_codigo = vTpnotatransf.Armcarreg;
          Else
             vTpnotatransf.Rotacarreg := '';
          end IF;
              
          If vTpnotatransf.Armtransf is not null Then
             select a.glb_rota_codigo
               into vTpnotatransf.Rtarmtransf
             from tdvadm.t_arm_armazem a
             where a.arm_armazem_codigo = vTpnotatransf.Armtransf;
          Else
             vTpnotatransf.Rtarmtransf := '';
          End IF;
        Exception
          When OTHERS Then
             vErro := sqlerrm;
             vTpnotatransf.Criacao := '';
             vTpnotatransf.Dtfechamento := '';
             vTpnotatransf.Armcarreg := '';
             vTpnotatransf.Carregamento := '';
             vTpnotatransf.Armtransf := '';
             vTpnotatransf.Armtransf := '';
             vTpnotatransf.Uscheckin := '';
             vTpnotatransf.Rotacarreg := '';
             vTpnotatransf.Rtarmtransf := '';
          End;




        insert into tdvadm.t_arm_notatransf
        values vTpnotatransf ;
        commit;
 

     End Loop;  
  End Loop;
  commit;
end;
0
3
vTpnotatransf.Origdestvfrete
vTpnotatransf.Valefrete
vErro
