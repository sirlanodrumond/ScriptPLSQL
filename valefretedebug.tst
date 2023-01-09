PL/SQL Developer Test script 3.0
107
Declare
  v_Qrystr  clob;
  v_Blob    blob;
  vAuxiliar integer;
  vFornecedor tdvadm.t_con_vfretepedagio.glb_fornecedor_cgccpf%type;
  vPagador    tdvadm.t_con_vfretepedagio.glb_fornecedor_cgccpf%type;
  
begin

   v_Qrystr := empty_clob;
   :Acao      := tdvadm.pkg_con_valefrete.cSalvar;
   :P_STATUS  := 'N';
   :P_MESSAGE := '';
   select count(*)
     into vAuxiliar
   from tdvadm.t_con_valefrete vf
   where vf.con_conhecimento_codigo = :ValeFrete
     and vf.con_conhecimento_serie = :Serie
     and vf.glb_rota_codigo = :Rota
     and vf.con_valefrete_saque = :Saque;
   If vAuxiliar = 0 Then
     :P_STATUS  := 'E';
     :P_MESSAGE := :P_MESSAGE || ' Vale Frete Não Existe ' || chr(10);
   End If;

   If :P_STATUS = 'N' Then
      select count(*)
        into vAuxiliar
      from tdvadm.t_con_valefrete vf
      where vf.con_conhecimento_codigo = :ValeFrete
        and vf.con_conhecimento_serie = :Serie
        and vf.glb_rota_codigo = :Rota
        and vf.con_valefrete_saque = :Saque
        and nvl(vf.con_valefrete_impresso,'N') = 'S'; 
      If :Acao in ('Imprimir','Consulta','19') Then
         vAuxiliar := 0;
      End If;
      If vAuxiliar = 1 Then
        :P_STATUS  := 'E';
        :P_MESSAGE := :P_MESSAGE || ' Vale Frete Impresso ' || chr(10);
      End If;
   

      If :P_STATUS = 'N' Then
         Begin
            Select vp.glb_fornecedor_cgccpf,
                   vp.glb_cliente_cgccpfcodigo
              into vFornecedor,
                   vPagador
            from tdvadm.t_con_vfretepedagio vp
            where 0 = 0
              and vp.con_conhecimento_codigo = :ValeFrete
              and vp.con_conhecimento_serie = :Serie
              and vp.glb_rota_codigo = :Rota
              and vp.con_valefrete_saque = :Saque;
         exception
            When NO_DATA_FOUND Then
               vFornecedor := null;
               vPagador    := null;
            End;
      
      
         select '<Parametros>' || chr(10) ||
                '   <Input>' || chr(10) ||
                '      <VFNumero>' || vf.con_conhecimento_codigo || '</VFNumero>' || chr(10) ||
                '      <VFSerie>' || vf.con_conhecimento_serie || '</VFSerie>' || chr(10) ||
                '      <VFRota>' || vf.glb_rota_codigo || '</VFRota>' || chr(10) ||
                '      <VFSaque>' || vf.con_valefrete_saque  || '</VFSaque>' || chr(10) ||
                '      <VFAcao>' || :Acao || '</VFAcao>' || chr(10) ||
                '      <VFUsuarioTDV>' || nvl(:Usuario,vf.usu_usuario_codigo) || '</VFUsuarioTDV>' || chr(10) ||
                '      <VFRotaUsuarioTDV>' || vf.glb_rota_codigo || '</VFRotaUsuarioTDV>' || chr(10) ||
                '      <VFAplicacaoTDV>comvlfrete</VFAplicacaoTDV>' || chr(10) ||
                '      <VFVersaoAplicao>21.8.2.1</VFVersaoAplicao>' || chr(10) ||
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
                '      <vfornecedor>' || vFornecedor || '</vfornecedor>' || chr(10) ||      
                '      <vpagador>' || vPagador || '</vpagador>' || chr(10) ||  
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

         PKG_CON_VALEFRETE.SP_CON_VALIDAVALEFRETE(P_QRYSTR => :P_QRYSTR,
                                                   P_XMLOUT => :P_XMLOUT,
                                                   P_STATUS =>  :P_STATUS,
                                                   P_MESSAGE => :P_MESSAGE);
      End If;
   End If;
end;
10
Acao
1
19
5
Usuario
1
fgomes
5
ValeFrete
1
170837
5
Serie
1
A1
5
Rota
1
185
5
Saque
1
1
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
E                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
P_MESSAGE
5
03-Vale Ja Esta Impresso .
 OK
  EXISTEM ENTREGAS SEM DATA
DUVIDAS PROCURA EZEQUIEL
      (11) 2967-8712
5
8
P_MESSAGE
P_STATUS
vTpValefrete.Con_Valefrete_Sestsenat
tpVF.VFCON_VALEFRETE_MULTA
tpvf.vAuxiliar
tpVF.VFAcao
vFornecedor
vPagador
