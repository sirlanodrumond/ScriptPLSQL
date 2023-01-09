PL/SQL Developer Test script 3.0
138
-- Created  01/04/2019 by DESENV 
declare 
  -- Local variables here
--5500057870-RT
--5500057877-RMF
--5500057902-DX
--5500057880-INS
--55000057896-DOR
--5500057918-V-NN
--5500057918-V-EE
--5500057918-V-SS
--55000057895-BM
--5500058294-V-MG
--5500058294-V-SP
--5500057880-ISO
--5500058294-V-NO

  vAuxiliarn integer;
  vContratoOri  tdvadm.t_slf_contrato.slf_contrato_codigo%type := '5500057870-RT';
  vContratoDest tdvadm.t_slf_contrato.slf_contrato_codigo%type := '5500057870-RT';
  vVigencia     tdvadm.t_slf_tabela.slf_tabela_vigencia%type   := '21/11/2022';
  vGrupoDestino tdvadm.t_slf_contrato.glb_grupoeconomico_codigo%type;
  vCNPJDestino  tdvadm.t_slf_contrato.glb_cliente_cgccpfcodigo%type;
  vTpTabela     tdvadm.t_slf_tabela%rowtype;
  vTpVerbas     tdvadm.t_slf_calcfretekm%rowtype;
  vTabCod       tdvadm.t_slf_tabela.slf_tabela_codigo%type;
  vTabSaq       tdvadm.t_slf_tabela.slf_tabela_saque%type;
begin
  -- Test statements 
  -- Verificar regras
  -- verificar janelas
  for c_msg in (select ta.slf_tabela_codigo,
                       ta.slf_tabela_saque,
                       ta.slf_tabela_tipo,
                       ta.glb_rota_codigo,
                       ta.glb_grupoeconomico_codigo,
                       ta.glb_cliente_cgccpfcodigo,
                       ta.slf_tabela_contrato,
                       ta.fcf_tpveiculo_codigo,
                       ta.fcf_tpcarga_codigo,
                       ta.slf_tabela_coletaentrega
                from tdvadm.t_slf_tabela ta
                where ta.slf_tabela_contrato = vContratoOri)
   Loop
      -- pesquisa se existe uma tabela para o contrato destina
       Select count(*)
         into vAuxiliarn
       from tdvadm.t_slf_tabela ta
       where ta.slf_tabela_contrato = vContratoDest
         and ta.slf_tabela_tipo = c_msg.slf_tabela_tipo
         and ta.glb_rota_codigo = c_msg.glb_rota_codigo
         and ta.fcf_tpveiculo_codigo = c_msg.fcf_tpveiculo_codigo
         and ta.fcf_tpcarga_codigo = c_msg.fcf_tpcarga_codigo
         and ta.glb_grupoeconomico_codigo = c_msg.glb_grupoeconomico_codigo
         and ta.glb_cliente_cgccpfcodigo = c_msg.glb_cliente_cgccpfcodigo
         and ta.slf_tabela_coletaentrega = c_msg.slf_tabela_coletaentrega;
       -- Criar uma Tabela
       If vAuxiliarn = 0 Then
          select max(ta.slf_tabela_codigo) + 1
            into vTabCod
          from tdvadm.t_slf_tabela ta
          where substr(ta.slf_tabela_codigo,1,3) = '021';
          vTabCod := LPAD(trim(vTabCod),8,'0');
          vTabSaq := '0001';

       select *
         into vTpTabela
       from tdvadm.t_slf_tabela ta
       where ta.slf_tabela_codigo = c_msg.slf_tabela_codigo
         and ta.slf_tabela_saque = c_msg.slf_tabela_saque;
          
       vTpTabela.Slf_Tabela_Codigo := vTabCod;
       vTpTabela.Slf_Tabela_Saque := vTabSaq;
       vTpTabela.Slf_Tabela_Contrato := vContratoDest;
       vTpTabela.Slf_Tabela_Vigencia := nvl(vVigencia,vTpTabela.Slf_Tabela_Vigencia);

       insert into tdvadm.t_slf_tabela values vTpTabela;
       
       insert into tdvadm.t_slf_calcfretekm
       select vTpTabela.Slf_Tabela_Codigo,
              vTpTabela.Slf_Tabela_Saque,
              km.slf_calcfretekm_kmde,
              km.slf_calcfretekm_kmate,
              km.slf_calcfretekm_pesode,
              km.slf_calcfretekm_pesoate,
              km.slf_tpcalculo_codigo,
              km.slf_reccust_codigo,
              km.slf_calcfretekm_valor,
              km.slf_calcfretekm_desinencia,
              km.slf_calcfretekm_codcli,
              km.slf_calcfretekm_tpfrete,
              km.slf_calcfretekm_origem,
              km.slf_calcfretekm_destino,
              km.slf_calcfretekm_origemi,
              km.slf_calcfretekm_destinoi,
              km.slf_calcfretekm_limite,
              km.slf_calcfretekm_valore,
              km.slf_calcfretekm_desinenciae,
              km.slf_calcfretekm_valorf,
              km.slf_calcfretekm_desinenciaf,
              km.slf_calcfretekm_raiokmorigem,
              km.slf_calcfretekm_raiokmdestino,
              km.slf_calcfretekm_impembutido,
              km.slf_calcfretekm_outracoletai,
              km.slf_calcfretekm_outraentregai
       from tdvadm.t_slf_calcfretekm km
       where km.slf_tabela_codigo = c_msg.slf_tabela_codigo 
         and km.slf_tabela_saque = c_msg.slf_tabela_saque;



          insert into tdvadm.t_slf_clienteped cp
          select cp.glb_grupoeconomico_codigo,
                 cp.glb_cliente_cgccpfcodigo,
                 cp.fcf_tpcarga_codigo,
                 vContratoDest,
                 cp.slf_clienteped_vigencia,
                 cp.slf_clienteped_ativo,
                 cp.fcf_tpveiculo_codigo,
                 cp.glb_localidade_codigoori,
                 cp.glb_localidade_codigodes,
                 cp.glb_localidade_codigooriib,
                 cp.glb_localidade_codigodesib,
                 cp.slf_clienteped_valor,
                 cp.slf_clienteped_desinencia,
                 cp.slf_clienteped_codcli,
                 cp.glb_localidade_outracoletai,
                 cp.glb_localidade_outraentregai
          from tdvadm.t_slf_clienteped cp
          where cp.slf_contrato_codigo = vContratoOri;

          
       commit;
       End If;
       
   End Loop;     
                
end;
0
3
vAuxiliarn
vTabCod
c_msg.slf_tabela_codigo
