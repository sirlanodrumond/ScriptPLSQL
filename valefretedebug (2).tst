PL/SQL Developer Test script 3.0
46
Declare
  v_Qrystr clob;
  v_Blob   blob;
begin
   v_Qrystr := empty_clob;
   select '<Parametros>' || chr(10) ||
          '   <Input>' || chr(10) ||
          '      <VFNumero>' || vf.con_conhecimento_codigo || '</VFNumero>' || chr(10) ||
          '      <VFSerie>' || vf.con_conhecimento_serie || '</VFSerie>' || chr(10) ||
          '      <VFRota>' || vf.glb_rota_codigo || '</VFRota>' || chr(10) ||
          '      <VFSaque>' || vf.con_valefrete_saque  || '</VFSaque>' || chr(10) ||
          '      <VFAcao>Salvar</VFAcao>' || chr(10) ||
          '      <VFUsuarioTDV>' || vf.usu_usuario_codigo || '</VFUsuarioTDV>' || chr(10) ||
          '      <VFRotaUsuarioTDV>' || vf.glb_rota_codigo || '</VFRotaUsuarioTDV>' || chr(10) ||
          '      <VFAplicacaoTDV>comvlfrete</VFAplicacaoTDV>' || chr(10) ||
          '      <VFVersaoAplicao>21.6.28.1</VFVersaoAplicao>' || chr(10) ||
          '      <VFProcedureDelphi></VFProcedureDelphi>' || chr(10) ||
          '      <CON_CATVALEFRETE_CODIGO>' || vf.con_catvalefrete_codigo  || '</CON_CATVALEFRETE_CODIGO>' || chr(10) ||
          '      <CON_SUBCATVALEFRETE_CODIGO></CON_SUBCATVALEFRETE_CODIGO>' || chr(10) ||
          '      <CON_VALEFRETE_PERCETDES>20</CON_VALEFRETE_PERCETDES>' || chr(10) ||
          '      <CON_VALEFRETE_MULTA>' || trim(replace(to_char(vf.con_valefrete_multa),',','.')) || '</CON_VALEFRETE_MULTA>' || chr(10) ||
          '      <CON_VALEFRETE_PLACA>' || vf.con_valefrete_placa || '</CON_VALEFRETE_PLACA>' || chr(10) ||
          '      <CON_VALEFRETE_PLACASAQUE>' || vf.con_valefrete_placasaque || '</CON_VALEFRETE_PLACASAQUE>' || chr(10) ||
          '      <CON_VALEFRETE_CUSTOCARRETEIRO>' || trim(replace(to_char(vf.con_valefrete_custocarreteiro),',','.')) || '</CON_VALEFRETE_CUSTOCARRETEIRO>' || chr(10) ||    
          '      <CON_VALEFRETE_TIPOCUSTO>' || vf.con_valefrete_tipocusto || '</CON_VALEFRETE_TIPOCUSTO>' || chr(10) ||
          '      <FCF_FRETECAR_ROWID>' || vf.fcf_fretecar_rowid || '</FCF_FRETECAR_ROWID>' || chr(10) ||
          '      <FCF_VEICULODISP_CODIGO>' || vf.fcf_veiculodisp_codigo  || '</FCF_VEICULODISP_CODIGO>' || chr(10) ||
          '      <FCF_VEICULODISP_SEQUENCIA>' || trim(vf.fcf_veiculodisp_sequencia) || '</FCF_VEICULODISP_SEQUENCIA>' || chr(10) ||
          '      <GLB_CLIENTE_CGCCPFCODIGO></GLB_CLIENTE_CGCCPFCODIGO>' || chr(10) ||   
          '   </Input>' || chr(10) ||
          '</Parametros>'
      into v_Qrystr
   from tdvadm.t_con_valefrete vf
   where 0 = 0
     and vf.con_conhecimento_codigo = :ValeFrete
     and vf.con_conhecimento_serie = :Serie
     and vf.glb_rota_codigo = :Rota
     and  vf.con_valefrete_saque = :Saque;
     
   :P_QRYSTR := glbadm.pkg_glb_blob.f_clob2blob(v_QRYSTR,v_Blob);  

   PKG_CON_VALEFRETE .SP_CON_VALIDAVALEFRETE(P_QRYSTR => :P_QRYSTR,
                                            P_XMLOUT => :P_XMLOUT,
                                            P_STATUS => :P_STATUS,
                                            P_MESSAGE => :P_MESSAGE);
end;
8
ValeFrete
1
046292
5
Serie
1
A1
5
Rota
1
530
5
Saque
1
2
5
P_QRYSTR
1
<BLOB>
113
P_XMLOUT
1
<CLOB>
112
P_STATUS
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
P_MESSAGE
3

Ac Solicitada Salvar-09
  OK
5
3
P_MESSAGE
P_STATUS
vTpValefrete.Con_Valefrete_Sestsenat
