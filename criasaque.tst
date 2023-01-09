PL/SQL Developer Test script 3.0
149
declare 
  pContrato tdvadm.t_slf_contrato.slf_contrato_codigo%type;
  pVigencia tdvadm.t_slf_tabela.slf_tabela_vigencia%type;
  vSaque    tdvadm.t_slf_tabela.slf_tabela_saque%type;
  vAuxiliar number;
begin
--,
--'5500057877-RMF',
--'5500057902-DX',
--'5500057880-INS',
--'55000057896-DOR',
--'5500057918-V-NN',
--'5500057918-V-EE',
--'5500057918-V-SS',
--'55000057895-BM',
--'5500058294-V-MG',
--'5500058294-V-SP',
--'5500057880-ISO',
--'5500058294-V-NO'
  pContrato := '5500057870-RT';
  pVigencia := to_date('21/11/2022','dd/mm/yyyy');
  
  Select count(*)
    into vAuxiliar
  from tdvadm.t_slf_tabela ta
  where ta.slf_tabela_contrato = pContrato
    and ta.slf_tabela_vigencia >= pVigencia;
    
  If vAuxiliar > 0 Then
     raise_application_error(-20011,'Ja existem Vigencias Maiores ou iguais a esta - ' || to_char(pVigencia,'dd/mm/yyyy'));
     return;
  End IF;   

  for c_msg in (select ta.slf_tabela_codigo,
                       max(ta.slf_tabela_saque) saque
                from tdvadm.t_slf_tabela ta  
                where ta.slf_tabela_contrato = pContrato
                group by ta.slf_tabela_codigo)
  Loop
     vSaque := lpad(to_number(c_msg.saque) + 1,4,'0');

     insert into tdvadm.t_slf_tabela 
     select SLF_TABELA_CODIGO,
            GLB_ROTA_CODIGO,
            vSaque,
            GLB_CONDPAG_CODIGO,
            SLF_TABELA_TIPO,
            GLB_CLIENTE_CGCCPFCODIGO,
            GLB_MERCADORIA_CODIGO,
            pVigencia,
            GLB_EMBALAGEM_CODIGO,
            sysdate SLF_TABELA_DTGRAVACAO,
            GLB_TPCARGA_CODIGO,
            GLB_LOCALIDADE_CODIGO,
            SLF_TABELA_CONTATO,
            SLF_TABELA_OBSTABELA,
            GLB_VENDFRETE_CODIGO,
            SLF_TABELA_OBSFATURAMENTO,
            SLF_TABELA_LOTACAOFLAG,
            SLF_TABELA_ISENTO,
            SLF_TABELA_DESCRICAO,
            SLF_TPCALCULO_CODIGO,
            SLF_TABELA_PEDREAJAUT,
            SLF_TABELA_PEDATUALIZA,
            SLF_TABELA_ORIGEMDESTINO,
            SLF_TABELA_STATUS,
            SLF_TABELA_VIAGEMMIN,
            SLF_TABELA_VIAGEMMAX,
            SLF_TABELA_VIAGEMIDENT,
            CON_FCOBPED_CODIGO,
            CON_MODALIDADEPED_CODIGO,
            SLF_TABELA_TPDESCONTO,
            SLF_TABELA_DESCONTO,
            SLF_TABELA_PERCLOTACAO,
            SLF_TABELA_MSGLOTACAO,
            SLF_TABELA_ABORTALOTACAO,
            SLF_TABELA_PESOMINIMO,
            SLF_TABELA_PESOMAXIMO,
            SLF_TABELA_OCUPACAO,
            SLF_TABELA_BASEOCUPACAO,
            SLF_TABELA_CONTRATO,
            SLF_TABELA_COMISSIONADO,
            FCF_TPVEICULO_CODIGO,
            FCF_TPCARGA_CODIGO,
            GLB_GRUPOECONOMICO_CODIGO,
            SLF_TABELA_IMPRIMEOBSCTRC,
            SLF_TABELA_IMPRIMEOBSVENC,
            SLF_TABELA_COLETAENTREGA
      From tdvadm.t_slf_tabela ta
      where ta.slf_tabela_codigo = c_msg.slf_tabela_codigo
        and ta.slf_tabela_saque = c_msg.saque;

      insert into tdvadm.t_slf_calcfretekm 
      select SLF_TABELA_CODIGO,
             vSaque,
             SLF_CALCFRETEKM_KMDE,
             SLF_CALCFRETEKM_KMATE,
             SLF_CALCFRETEKM_PESODE,
             SLF_CALCFRETEKM_PESOATE,
             SLF_TPCALCULO_CODIGO,
             SLF_RECCUST_CODIGO,
             SLF_CALCFRETEKM_VALOR,
             SLF_CALCFRETEKM_DESINENCIA,
             SLF_CALCFRETEKM_CODCLI,
             SLF_CALCFRETEKM_TPFRETE,
             SLF_CALCFRETEKM_ORIGEM,
             SLF_CALCFRETEKM_DESTINO,
             SLF_CALCFRETEKM_ORIGEMI,
             SLF_CALCFRETEKM_DESTINOI,
             SLF_CALCFRETEKM_LIMITE,
             SLF_CALCFRETEKM_VALORE,
             SLF_CALCFRETEKM_DESINENCIAE,
             SLF_CALCFRETEKM_VALORF,
             SLF_CALCFRETEKM_DESINENCIAF,
             SLF_CALCFRETEKM_RAIOKMORIGEM,
             SLF_CALCFRETEKM_RAIOKMDESTINO,
             SLF_CALCFRETEKM_IMPEMBUTIDO,
             slf_calcfretekm_outracoletai ,
             slf_calcfretekm_outraentregai ,
             sysdate slf_calcfretekm_dtgravacao
       from tdvadm.t_slf_calcfretekm km
       where km.slf_tabela_codigo = c_msg.slf_tabela_codigo
         and km.slf_tabela_saque = c_msg.saque;

    
  End Loop;

  insert into tdvadm.t_slf_clienteped cp
  select cp.glb_grupoeconomico_codigo,
         cp.glb_cliente_cgccpfcodigo,
         cp.fcf_tpcarga_codigo,
         cp.slf_contrato_codigo,
         pVigencia,
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
  where cp.slf_contrato_codigo = pContrato;

        
end;
0
3
c_msg.slf_tabela_codigo
c_msg.saque
vSaque
