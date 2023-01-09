PL/SQL Developer Test script 3.0
95
-- Created on 16/05/2019 by DESENV 
declare 
    tp_ipf_valefrete tdvipf.t_ipf_valefrete%rowtype;
    cPercentINSSEMP  Constant number := 0.020;
begin
  -- Test statements here
  for c_msg in (select vf.con_conhecimento_codigo,
                       vf.con_conhecimento_serie,
                       vf.glb_rota_codigo,
                       vf.con_valefrete_saque,
                       vf.con_catvalefrete_codigo,
                       vf.glb_localidade_codigoori,
                       vf.glb_localidade_codigodes,
                       vf.glb_tpmotorista_codigo,
                       vf.con_valefrete_carreteiro,
                       vf.con_valefrete_placa,
                       vf.con_valefrete_placasaque,
                       vf.frt_conjveiculo_codigo,
                       vf.con_valefrete_dataemissao,
                       vf.con_valefrete_datacadastro,
                       vf.con_valefrete_custocarreteiro,
                       vf.con_valefrete_tipocusto,
                       vf.con_valefrete_pesocobrado,
                       vf.con_valefrete_pedagio,
                       vf.con_valefrete_outros,
                       vf.con_valefrete_status,
                       vf.con_valefrete_impresso,
                       vf.cax_boletim_data,
                       vf.glb_rota_codigocx
                from tdvadm.t_con_valefrete vf
                where to_char(vf.con_valefrete_datacadastro,'yyyymm') <= :pReferencia
                  and to_char(vf.con_valefrete_datacadastro,'yyyymm') >= '01/01/2019'
                  and vf.con_conhecimento_codigo = '002913'
                  and vf.glb_rota_codigo = '264'
                  )
  Loop
    
     
      tp_ipf_valefrete.ipf_valefrete_chave           := c_msg.con_conhecimento_codigo || c_msg.con_conhecimento_serie || c_msg.glb_rota_codigo || c_msg.con_valefrete_saque ; 
      tp_ipf_valefrete.ipf_valefrete_codigo          := c_msg.con_conhecimento_codigo ; 
      tp_ipf_valefrete.ipf_valefrete_serie           := c_msg.con_conhecimento_serie ; 
      tp_ipf_valefrete.ipf_valefrete_rota            := c_msg.glb_rota_codigo ; 
      tp_ipf_valefrete.ipf_valefrete_saque           := c_msg.con_valefrete_saque ; 
      tp_ipf_valefrete.con_catvalefrete_codigo       := c_msg.con_catvalefrete_codigo ; 
      tp_ipf_valefrete.ipf_valefrete_origem          := c_msg.glb_localidade_codigoori ; 
      tp_ipf_valefrete.ipf_valefrete_destino         := c_msg.glb_localidade_codigodes ; 
      tp_ipf_valefrete.glb_tpmotorista_codigo        := c_msg.glb_tpmotorista_codigo ; 
      tp_ipf_valefrete.ipf_valefrete_motoristacpf    := c_msg.con_valefrete_carreteiro ; 
      tp_ipf_valefrete.ipf_valefrete_motoristanome   := null ;
      tp_ipf_valefrete.ipf_valefrete_placa           := c_msg.con_valefrete_placa ; 
      tp_ipf_valefrete.ipf_valefrete_placasaque      := c_msg.con_valefrete_placasaque ; 
      If substr(c_msg.con_valefrete_placa,1,3) = '000' Then
         tp_ipf_valefrete.frt_veiculo_codigo         := c_msg.con_valefrete_placa ; 
         tp_ipf_valefrete.ipf_valefrete_placa        := trim(tdvadm.pkg_frtcar_veiculo.FN_GET_PLACA(c_msg.con_valefrete_placa,c_msg.con_valefrete_datacadastro,'CAV'));
      End If;   
      tp_ipf_valefrete.ipf_valefrete_eixos           := 0;
      tp_ipf_valefrete.ipf_valefrete_emissao         := c_msg.con_valefrete_dataemissao ; 
      tp_ipf_valefrete.ipf_valefrete_cadastro        := c_msg.con_valefrete_datacadastro ; 
      tp_ipf_valefrete.ipf_valefrete_fimviagem       := null ; 
      tp_ipf_valefrete.ipf_tpfinviagem_codigo        := null ; 
      tp_ipf_valefrete.ipf_valefrete_kmperc          := 0 ; 
      tp_ipf_valefrete.ipf_valefrete_kmvazio         := 0 ; 
      tp_ipf_valefrete.ipf_valefrete_mix             := 0 ; 
     
      If nvl(c_msg.con_valefrete_status,'N') = 'N' Then 
         tp_ipf_valefrete.ipf_valefrete_frete           := c_msg.con_valefrete_custocarreteiro;
         If c_msg.con_valefrete_tipocusto = 'T' Then
         Begin
           -- erro quanto o custo supera R$ 1.000000,00
            tp_ipf_valefrete.ipf_valefrete_frete        := round(c_msg.con_valefrete_custocarreteiro * c_msg.con_valefrete_pesocobrado,2);
         exception
         when OTHERS Then
            raise_application_error(-20002,tp_ipf_valefrete.ipf_valefrete_chave);
         End;
      Else
         tp_ipf_valefrete.ipf_valefrete_frete := 0;
      End If;    

      tp_ipf_valefrete.ipf_valefrete_pedagio         := nvl(c_msg.con_valefrete_pedagio,0) ; 
      tp_ipf_valefrete.ipf_valefrete_fretesp         := tp_ipf_valefrete.ipf_valefrete_frete - tp_ipf_valefrete.ipf_valefrete_pedagio ; 
      tp_ipf_valefrete.ipf_valefrete_outros          := c_msg.con_valefrete_outros ; 
      tp_ipf_valefrete.ipf_valefrete_insspartemp     := tp_ipf_valefrete.ipf_valefrete_fretesp * cPercentINSSEMP ; 
      tp_ipf_valefrete.ipf_valefrete_estadia         := 0 ; 
      tp_ipf_valefrete.ipf_valefrete_pneu            := 0 ; 
      tp_ipf_valefrete.ipf_valefrete_status          := nvl(c_msg.con_valefrete_status,'N') ;
      tp_ipf_valefrete.ipf_valefrete_impresso        := nvl(c_msg.con_valefrete_impresso,'N') ;
      tp_ipf_valefrete.ipf_valefrete_caixa           := c_msg.cax_boletim_data ; 
      tp_ipf_valefrete.ipf_valefrete_caixart         := c_msg.glb_rota_codigocx ; 
      tp_ipf_valefrete.ipf_valefrete_dtprocessamento := sysdate ; 

  
    
  End Loop;
  
end;
1
pReferencia
1
201901
5
1
tp_ipf_valefrete.ipf_valefrete_chave
