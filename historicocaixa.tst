PL/SQL Developer Test script 3.0
113
-- Created on 06/12/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vCPFCNPG   tdvadm.t_con_calcvalefrete.con_calcvalefrete_cnpjcpf%type;
  vDtPagto   tdvadm.t_con_calcvalefrete.con_calcvalefrete_dtpgto%type;
  vCartao    tdvadm.t_con_calcvalefrete.con_calcvalefrete_cartao%type;
  vCodOperacao tdvadm.t_con_calcvalefrete.con_calcvalefretetp_codigo%type;
  vCodOPHist   char(2);
  vHistorico varchar2(100) ; --tdvadm.t_cax_movimento.cax_movimento_historico%type;
  
begin
  -- Test statements here
   FOR C_MSG IN (select m.glb_rota_codigo,
                        m.cax_boletim_data,
                        m.cax_movimento_sequencia,
                        m.cax_movimento_documento,
                        m.cax_movimento_historico,
                        m.cax_movimento_valor,
                        m.cax_movimento_documentoref,
                        m.glb_tpdoc_codigo,
                        m.cax_movimento_origem,
                        m.slf_servicos_codigo,
                        M.CAX_MOVIMENTO_USUARIO,
                        M.CAX_MOVIMENTO_CONTABIL,
                        m.rowid
                 from tdvadm.t_cax_movimento m 
                 where m.cax_boletim_data >= '01/12/2017'
                   and m.cax_operacao_codigo = '1200'
                   AND M.CAX_MOVIMENTO_DOCUMENTOREF IS NOT NULL
                   and length(trim(m.cax_movimento_historico)) <> 50)
   Loop
     -- pega o numero do cartao e cpf/cnpj
     If c_msg.glb_tpdoc_codigo = 'VFT' Then
         select cvf.con_calcvalefrete_cnpjcpf,
                cvf.con_calcvalefrete_dtpgto,
                nvl(cvf.con_calcvalefrete_cartao,'0000000000000000') con_calcvalefrete_cartao,
                cvf.con_calcvalefretetp_codigo,
                decode(cvf.con_calcvalefretetp_codigo,'01','AD',
                                                      '02','PD',
                                                      '06','SQ',
                                                      '07','TR',
                                                      '20','SD')
             into vCPFCNPG,
                  vDtPagto,
                  vCartao,
                  vCodOperacao,
                  vCodOPHist
         from tdvadm.t_con_calcvalefrete cvf
         where cvf.con_conhecimento_codigo = substr(c_msg.cax_movimento_documentoref,1,6)
           and cvf.con_conhecimento_serie  = substr(c_msg.cax_movimento_documentoref,7,2)
           and cvf.glb_rota_codigo         = substr(c_msg.cax_movimento_documentoref,9,3)
           and cvf.con_valefrete_saque     = substr(c_msg.cax_movimento_documentoref,12,1)
           and cvf.con_calcvalefretetp_codigo in ('06','07')
           and cvf.con_calcvalefrete_valor = c_msg.cax_movimento_valor;
       
     ElsIf c_msg.glb_tpdoc_codigo in ('VFP','VFA','VFS') Then
         select cvf.con_calcvalefrete_cnpjcpf,
                cvf.con_calcvalefrete_dtpgto,
                nvl(cvf.con_calcvalefrete_cartao,'0000000000000000') con_calcvalefrete_cartao,
                cvf.con_calcvalefretetp_codigo,
                decode(cvf.con_calcvalefretetp_codigo,'01','AD',
                                                      '02','PD',
                                                      '06','SQ',
                                                      '07','TR',
                                                      '20','SD')
             into vCPFCNPG,
                  vDtPagto,
                  vCartao,
                  vCodOperacao,
                  vCodOPHist
         from tdvadm.t_con_calcvalefrete cvf
         where cvf.con_conhecimento_codigo = substr(c_msg.cax_movimento_documentoref,1,6)
           and cvf.con_conhecimento_serie  = substr(c_msg.cax_movimento_documentoref,7,2)
           and cvf.glb_rota_codigo         = substr(c_msg.cax_movimento_documentoref,9,3)
           and cvf.con_valefrete_saque     = substr(c_msg.cax_movimento_documentoref,12,1)
           and cvf.con_calcvalefretetp_codigo = decode(C_MSG.GLB_TPDOC_CODIGO,'VFP','02',
                                                                              'VFA','01',
                                                                              'VFS','20')
           and cvf.con_calcvalefrete_valor = c_msg.cax_movimento_valor;
     End If;
           
     vHistorico := 'VF ' || substr(c_msg.cax_movimento_documentoref,1,6) || '-' || 
                            substr(c_msg.cax_movimento_documentoref,7,2) || '-' ||
                            substr(c_msg.cax_movimento_documentoref,9,3) || '-' ||
                            substr(c_msg.cax_movimento_documentoref,12,1) || ',' ||
                            vCodOPHist || ',' ||
                            to_char(vDtPagto,'DD/MM/YY') || '-CT:' ||
                            vCartao;
     update tdvadm.t_cax_movimento m
       set m.cax_movimento_documento = substr(vCartao,-6,6),
           m.cax_movimento_cgccpf = vCPFCNPG,
           m.cax_movimento_historico = vHistorico,
           m.cax_movimento_historicop = vHistorico
     where m.rowid = c_msg.rowid;
     commit;
   end Loop;
/*
VFP
Documento = nr do cartão
CGCCPF    = proprietario
Historico = VF VVVVVV-SS-RRR-S,PD,DD/MM/YY-CT:CCCCCCCCCCCCCCCC
VFT
Historico = VF VVVVVV-SS-RRR-S,TR,DD/MM/YY-CT:CCCCCCCCCCCCCCCC
ou
Historico = VF VVVVVV-SS-RRR-S,SQ,DD/MM/YY-CT:CCCCCCCCCCCCCCCC
VFS
Historico = VF VVVVVV-SS-RRR-S,SD,DD/MM/YY-CT:CCCCCCCCCCCCCCCC
VFA  
Historico = VF VVVVVV-SS-RRR-S,AD,DD/MM/YY-CT:CCCCCCCCCCCCCCCC
*/
  
end;
0
3
c_msg.cax_movimento_historico
vHistorico
