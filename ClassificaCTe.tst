PL/SQL Developer Test script 3.0
94
-- Created on 10/01/2018 by DESENV 
declare 
  -- Local variables here
  i integer;

-- 022532 A1 237
-- 022533 A1 237
-- 830728 A1 197
-- 830908 A1 197
-- 798196 A1 021
-- 798236 A1 021

  
  pCte    tdvadm.t_con_conhecimento.con_conhecimento_codigo%type := '798196';
  pCteSr  tdvadm.t_con_conhecimento.con_conhecimento_serie%type := 'A1';
  pCteRt  tdvadm.t_con_conhecimento.glb_rota_codigo%type := '021';
  vCte    tdvadm.t_con_conhecimento.con_conhecimento_codigo%type;
  vCteSr  tdvadm.t_con_conhecimento.con_conhecimento_serie%type;
  vCteRt  tdvadm.t_con_conhecimento.glb_rota_codigo%type;
  vNota   tdvadm.t_con_nftransporta.con_nftransportada_numnfiscal%type;
  vRemte  tdvadm.t_con_nftransporta.glb_cliente_cgccpfcodigo%type;
  vSerie  tdvadm.t_con_nftransporta.con_nftransportada_serienf%type;
  vStatus char(2);
begin
  -- Test statements here
  Begin
     select con_nftransportada_numnfiscal,
            glb_cliente_cgccpfcodigo,
            con_nftransportada_serienf
       into vNota,
            vRemte,
            vSerie
     from tdvadm.t_con_nftransporta nf
     where nf.con_conhecimento_codigo = pCte
       and nf.con_conhecimento_serie = pCteSr
       and nf.glb_rota_codigo = pCteRt;
  Exception
    When NO_DATA_FOUND Then
        vStatus := 'NE';
    When TOO_MANY_ROWS Then
        vStatus := 'MN';
    End;

    IF vStatus is null Then
       Select count(*)
          into i
       from tdvadm.t_con_nftransporta nf
       where nf.con_nftransportada_numnfiscal = vNota
         and nf.glb_cliente_cgccpfcodigo = vRemte
         and nf.con_nftransportada_serienf = vSerie
         and 0 = (select count(*)
                  from tdvadm.t_arm_notacte nct
                  where nct.con_conhecimento_codigo = nf.con_conhecimento_codigo
                    and nct.con_conhecimento_serie = nf.con_conhecimento_serie
                    and nct.glb_rota_codigo = nf.glb_rota_codigo
                    and nct.arm_notacte_codigo <> 'NO');
       If i = 2 Then
          Select nf.con_conhecimento_codigo,
                 nf.con_conhecimento_serie,
                 nf.glb_rota_codigo
            into vCte,
                 vCteSr,
                 vCteRt
          from tdvadm.t_con_nftransporta nf
          where nf.con_nftransportada_numnfiscal = vNota
            and nf.glb_cliente_cgccpfcodigo = vRemte
            and nf.con_nftransportada_serienf = vSerie
            and nf.con_conhecimento_codigo <> pCte
            and nf.con_conhecimento_serie = pCteSr
            and nf.glb_rota_codigo = pCteRt;
          If pCte > vCte Then
             vStatus := 'SB';
          Else
             vStatus := 'NO';
          End If;  
       ElsIf i = 1 Then
          Begin
             select nct.arm_notacte_codigo
                 into vStatus
             from tdvadm.t_arm_notacte nct
             where nct.con_conhecimento_codigo = pCte
               and nct.con_conhecimento_serie = pCteSr
               and nct.glb_rota_codigo = pCteRt;
          Exception
            When NO_DATA_FOUND Then
               vStatus := 'NO';
            End;
       Else
          vStatus := 'MN';
       End If;
      
   End If;
   
end;
0
2
vStatus
i
