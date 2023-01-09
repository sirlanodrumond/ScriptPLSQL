PL/SQL Developer Test script 3.0
58
-- Created on 17/08/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  pReferencia char(6) := '201801';
  vVeiculoDisp    tdvadm.t_con_valefrete.fcf_veiculodisp_codigo%type;
  vVeiculoDispSeq tdvadm.t_con_valefrete.fcf_veiculodisp_sequencia%type;
  vRowId          tdvadm.t_con_valefrete.fcf_fretecar_rowid%type;
  vGlb_LocalidadeOrigem  tdvadm.t_fcf_fretecar.fcf_fretecar_origem%type;
  vGlb_LocalidadeDestino tdvadm.t_fcf_fretecar.fcf_fretecar_destino%type;
  vValor                 tdvadm.t_fcf_fretecar.fcf_fretecar_valor%type;
  vDesinencia            tdvadm.t_fcf_fretecar.fcf_fretecar_desinencia%type;
begin
  -- Test statements here
  for c_msg in (Select d.con_valefrete_codigo,
                       d.con_valefrete_serie,
                       d.glb_rota_codigo_valefrete,
                       d.con_valefrete_saque,
                       d.rowid
                from tdvipf.t_ipf_reccust_diretos d
                where d.con_conhecimento_referencia = pReferencia)
  Loop
      Select vf.fcf_fretecar_rowid
        into vRowId
      from tdvadm.t_con_valefrete vf
      where vf.con_conhecimento_codigo = c_msg.con_valefrete_codigo
        and vf.con_conhecimento_serie = c_msg.con_valefrete_serie
        and vf.glb_rota_codigo = c_msg.glb_rota_codigo_valefrete
        and vf.con_valefrete_saque = c_msg.con_valefrete_saque;
      
      If nvl(vRowId,0) <> 0  Then  
         Begin
         select fc.fcf_fretecar_origem,
                fc.fcf_fretecar_destino,
                fc.fcf_fretecar_valor,
                fc.fcf_fretecar_desinencia
           into vGlb_LocalidadeOrigem,
                vGlb_LocalidadeDestino,
                vValor,
                vDesinencia
         From tdvadm.t_fcf_fretecar fc
         where fc.fcf_fretecar_rowid = vRowId;
         exception
           When NO_DATA_FOUND Then
               vValor := 0;
           End;       
      End If;
      If vValor > 0 Then
         update tdvipf.t_ipf_reccust_diretos d
            set d.fcf_fretecar_rowid = vRowId,
                d.glb_localidade_codigo_msori = vGlb_LocalidadeOrigem,
                d.glb_localidade_codigo_msdes = vGlb_LocalidadeDestino,
                d.fcf_fretecar_valor = vValor
         where d.rowid = c_msg.rowid;
      End If;
      
  End Loop;
end;
0
2
vRowId
vValor
