PL/SQL Developer Test script 3.0
60
-- Created on 01/02/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  pConhec tdvadm.t_con_conhecimento.con_conhecimento_codigo%type := '696302';
  pSerie  tdvadm.t_con_conhecimento.con_conhecimento_serie%type  := 'A1';
  pRota   tdvadm.t_con_conhecimento.glb_rota_codigo%type         := '011';
  --vPagador  tdvadm.t_con_conhecimento.glb_cliente_cgccpfsacado%type; 
  --vGrupo    tdvadm.t_glb_cliente.glb_grupoeconomico_codigo%type;
  --vContrato tdvadm.t_slf_contrato.slf_contrato_codigo%type;
  --vTipoRet  varchar2(10);
  
begin
  -- Test statements here
  Select c.glb_cliente_cgccpfsacado sacado,
         cl.glb_grupoeconomico_codigo grupo,
         substr(tdvadm.pkg_slf_utilitarios.fn_retorna_contratocod(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO),1,15) CONTRATO
     into :vPagador,
          :vGrupo,
          :vContrato
  from tdvadm.t_con_conhecimento c,
       tdvadm.t_glb_cliente cl
  where c.con_conhecimento_codigo = pConhec
    and c.con_conhecimento_serie = pSerie
    and c.glb_rota_codigo = pRota
    and c.glb_cliente_cgccpfsacado = cl.glb_cliente_cgccpfcodigo;
    
  :vTipoRet := tdvadm.pkg_slf_contrato.FN_SLF_CLIENTEREGRACARGA(P_CNPJ     => :vPagador,
                                                                P_CONTRATO => :vContrato,
                                                                P_GRUPO    => :vGrupo);
                                                                
        IF :vTipoRet = 'GCT' THEN -- ACHOU POR GRUPO/CNPJ/CONTRADO
          :vPagador  := :vPagador ; 
          :vGrupo    := :vGrupo   ;
          :vContrato := :vContrato; 
        ELSIF :vTipoRet = 'GC' THEN -- ACHOU POR GRUPO/CNPJ
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        ELSIF :vTipoRet = 'GT' THEN -- ACHOU GRUPO/CONTRATO
          :vPagador  := tdvadm.pkg_slf_contrato.QualquerCliente;
        ELSIF :vTipoRet = 'G' THEN --ACHOU POR GRUPO
          :vPagador  := tdvadm.pkg_slf_contrato.QualquerCliente;
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        ELSIF :vTipoRet = 'C' THEN --ACHOU POR CLIENTE
          :vGrupo    := tdvadm.pkg_slf_contrato.QualquerGrupo;
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        ELSIF :vTipoRet = 'T' THEN --ACHOU POR CONTRATO
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        ELSIF :vTipoRet = 'QQQ' THEN --POR QUALQUER COISA
          :vPagador  := tdvadm.pkg_slf_contrato.QualquerCliente;
          :vGrupo    := tdvadm.pkg_slf_contrato.QualquerGrupo;
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        ELSE
          :vPagador  := tdvadm.pkg_slf_contrato.QualquerCliente;
          :vGrupo    := tdvadm.pkg_slf_contrato.QualquerGrupo;
          :vContrato := tdvadm.pkg_slf_contrato.QualquerContrato;
        END IF;

  End If;
                                                              
end;
4
vTipoRet
1
GT
5
vPagador
1
99999999999999      
5
vGrupo
1
0628
5
vContrato
1
C2018010119
5
4
vPagador
vGrupo
vContrato
vTipoRet
