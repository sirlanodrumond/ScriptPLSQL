PL/SQL Developer Test script 3.0
100
-- Created on 13/05/2019 by DESENV 
declare 
  -- Local variables here
  i integer;
  vXmlDeb cLob;
  vStatus  char(1);
  vMessage varchar2(4000);
begin
  -- Test statements here
  
   for c_msg in (select VF.CON_VALEFRETE_DATACADASTRO DATA,
                        nvl(v.car_proprietario_cgccpfcodigo,'61139432000172') prop,
                        vf.con_valefrete_carreteiro carret,
                        ca.car_carreteiro_saque carretsq,
                        vf.con_conhecimento_codigo VFRETE,
                        vf.con_conhecimento_serie SR,
                        vf.glb_rota_codigo ROTA,
                        vf.con_valefrete_saque SQ,
                        vf.con_catvalefrete_codigo catvf,
                        vf.con_valefrete_custocarreteiro VALOR ,
                        vf.con_valefrete_placa  PLACA,
                        vf.con_valefrete_placasaque PLACASQ,
                        vf.glb_tpmotorista_codigo tpmot,
                        vf.usu_usuario_codigo usucad,
                        VF.GLB_CLIENTE_CGCCPFCODIGO TRANSPORTADORA,
                        VF.CON_VALEFRETE_STATUS STATUS,
                        nvl(vf.con_valefrete_impresso,'N') AUT_IMP,
                        (SELECT COUNT(*)
                          FROM tdvadm.t_car_contacorrente cc
                          where cc.car_veiculo_placa = VF.CON_VALEFRETE_PLACA
                            and cc.car_contacorrente_historico = VF.CON_CONHECIMENTO_CODIGO || VF.CON_CONHECIMENTO_SERIE || VF.GLB_ROTA_CODIGO || VF.CON_VALEFRETE_SAQUE) ACHOUCC,
                        (SELECT COUNT(*)
                          FROM tdvadm.t_Crp_Titreceber TR
                          where TR.CRP_TITRECEBER_NUMTITULO = VF.CON_CONHECIMENTO_CODIGO
                          AND TR.CRP_TITRECEBER_DTGERACAO >= TRUNC(VF.CON_VALEFRETE_DATACADASTRO) ) ACHOUTIT
                  from tdvadm.t_con_valefrete vf,
                       tdvadm.t_car_veiculo v,
                       tdvadm.t_car_carreteiro ca
                  where 0 = 0
                  --  AND TRUNC(VF.CON_VALEFRETE_DATACADASTRO) >= '01/01/2019'
                    AND VF.CON_CATVALEFRETE_CODIGO = '10'
                    AND SUBSTR(VF.CON_VALEFRETE_PLACA,1,3) <> '000'
                    and vf.con_valefrete_placa = v.car_veiculo_placa (+)
                    and vf.con_valefrete_placasaque = v.car_veiculo_saque (+)
                    and vf.con_valefrete_carreteiro = ca.car_carreteiro_cpfcodigo
                    and vf.con_valefrete_placa = ca.car_veiculo_placa
                    and vf.con_valefrete_placasaque = ca.car_veiculo_saque
                    and trunc(vf.con_valefrete_datacadastro) >= to_date('01/01/2018','dd/mm/yyyy')
                    and ca.car_carreteiro_saque = (select max(ca1.car_carreteiro_saque)
                                                   from tdvadm.t_car_carreteiro ca1
                                                   where ca1.car_carreteiro_cpfcodigo = ca.car_carreteiro_cpfcodigo
                                                     and ca1.car_veiculo_placa = ca.car_veiculo_placa
                                                     and ca1.car_veiculo_saque = ca.car_veiculo_saque)
                    AND 0 = (SELECT COUNT(*)
                             FROM tdvadm.t_car_contacorrente cc
                             where cc.car_veiculo_placa = VF.CON_VALEFRETE_PLACA
                               and cc.car_contacorrente_historico = VF.CON_CONHECIMENTO_CODIGO || VF.CON_CONHECIMENTO_SERIE || VF.GLB_ROTA_CODIGO || VF.CON_VALEFRETE_SAQUE)
                    and 0 = (SELECT COUNT(*)
                             FROM tdvadm.t_Crp_Titreceber TR
                             where TR.CRP_TITRECEBER_NUMTITULO = VF.CON_CONHECIMENTO_CODIGO
                             AND TR.CRP_TITRECEBER_DTGERACAO >= TRUNC(VF.CON_VALEFRETE_DATACADASTRO) )
                  )  
  
   Loop
  
      If ( c_msg.tpmot   = 'A' ) and
         ( c_msg.aut_imp = 'S' ) Then
          vXmlDeb :=         '<Parametros> ';
          vXmlDeb := vXmlDeb || '   <Input>';
          vXmlDeb := vXmlDeb || '     <pProprietario>' || trim(c_msg.prop) || '</pProprietario> ';
          vXmlDeb := vXmlDeb || '     <pVeiculo>' || c_msg.placa  || '</pVeiculo>';
          vXmlDeb := vXmlDeb || '     <pVeiculoSq>' || c_msg.placasq  || '</pVeiculoSq>';
          vXmlDeb := vXmlDeb || '     <pMotorista>' || trim(c_msg.carret) || '</pMotorista>';
          vXmlDeb := vXmlDeb || '     <pMotoristaSq>' || c_msg.carretsq || '</pMotoristaSq>';
          vXmlDeb := vXmlDeb || '     <pRotaUsuario>' || nvl(c_msg.rota,'010') || '</pRotaUsuario>';
          vXmlDeb := vXmlDeb || '     <pUsuario>' || trim(c_msg.usucad) || '</pUsuario>';
          vXmlDeb := vXmlDeb || '     <pAplicacao>comvlfrete</pAplicacao>';
          vXmlDeb := vXmlDeb || '     <pDocumento>'|| c_msg.vfrete || c_msg.sr || c_msg.rota || c_msg.sq  ||'</pDocumento>';
          vXmlDeb := vXmlDeb || '     <pValorDebitar>' || trim(to_char(c_msg.valor)) || '</pValorDebitar>';
          vXmlDeb := vXmlDeb || '     <pVencimento></pVencimento>';
          vXmlDeb := vXmlDeb || '     <pTpLancamento>VFT</pTpLancamento>';
          vXmlDeb := vXmlDeb || '     <pTpDespesa>005-0001</pTpDespesa>';
          vXmlDeb := vXmlDeb || '     <pTpDocumento></pTpDocumento>';
          vXmlDeb := vXmlDeb || '     <pTpDebito></pTpDebito>';
          vXmlDeb := vXmlDeb || '     <pTpOperacao></pTpOperacao>';
          vXmlDeb := vXmlDeb || '     <pOBS>Lancamento Automatico VFT</pOBS>';
          vXmlDeb := vXmlDeb || '     <pHistoricoLancamento>' || c_msg.vfrete || c_msg.sr || c_msg.rota || c_msg.sq  || '</pHistoricoLancamento>';
          vXmlDeb := vXmlDeb || '     <pVersao>12.7.27.3</pVersao>';
          vXmlDeb := vXmlDeb || '   </Input>';
          vXmlDeb := vXmlDeb || '</Parametros>';   

--          tdvadm.pkg_car_proprietario.Sp_DebitaContaCorrente(vXmlDeb,vStatus,vMessage);
          vStatus := vStatus;
          dbms_output.put_line(vStatus || ' - ' || vMessage);
      End If;
      
      
   End Loop;
    
end;
0
3
c_msg.tpmot
c_msg.STATUS
c_msg.AUT_IMP
