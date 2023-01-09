PL/SQL Developer Test script 3.0
207
declare 
  i integer;
  vContrato     tdvadm.t_slf_contrato.slf_contrato_codigo%type :=  '55000057895-BM';
  vSaque        tdvadm.t_slf_tabela.slf_tabela_saque%type;
  vSaqueOrigem  tdvadm.t_slf_tabela.slf_tabela_saque%type;
  vPercen       number := 12;
  vApaga        char(1) := 'S';
  vVigenciaPesq Date ;
  vVigencia     Date := TO_DATE('09/05/2022','DD/MM/YYYY');
  vAuxiiar      integer;
 
begin
   
  i := 0;

  for C_msgc in (select '5500058294-V-SP' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500058294-V-NO' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500058294-V-MG' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057918-V-SS' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057918-V-NN' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057918-V-EE' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057902-DX' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057880-ISO' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057880-INS' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057877-RMF' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '5500057870-RT' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '55000057896-DOR' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual union
                 select '55000057895-BM' contrato,5.58 percent,to_date('01/06/2022','dd/mm/yyyy') vigencia from dual )
  Loop


     vPercen := 1 + (c_msgc.percent / 100);
     vVigencia := c_msgc.vigencia;
     vAuxiiar := 0;
     i := i + 1;

     For C_msg in (select ta.slf_tabela_codigo,
                          ta.slf_tabela_saque,
                          ta.slf_tabela_vigencia,
                          nvl(ta.slf_tabela_status,'N') slf_tabela_status
                   from tdvadm.t_slf_tabela ta
                   where ta.slf_tabela_contrato = c_msgc.contrato
                     and ta.slf_tabela_saque = (select max(ta1.slf_tabela_saque)
                                                from tdvadm.t_slf_tabela ta1
                                                where ta1.slf_tabela_codigo = ta.slf_tabela_codigo))
     Loop 
        If ( c_msg.slf_tabela_vigencia < vVigencia ) and 
           ( c_msg.slf_tabela_status = 'N' ) Then
           insert into tdvadm.t_slf_tabela
           select ta.SLF_TABELA_CODIGO,
                  ta.GLB_ROTA_CODIGO,
                  lpad(c_msg.slf_tabela_saque + 1,4,'0') SLF_TABELA_SAQUE,
                  ta.GLB_CONDPAG_CODIGO,
                  ta.SLF_TABELA_TIPO,
                  ta.GLB_CLIENTE_CGCCPFCODIGO,
                  ta.GLB_MERCADORIA_CODIGO,
                  vVigencia SLF_TABELA_VIGENCIA,
                  ta.GLB_EMBALAGEM_CODIGO,
                  ta.SLF_TABELA_DTGRAVACAO,
                  ta.GLB_TPCARGA_CODIGO,
                  ta.GLB_LOCALIDADE_CODIGO,
                  ta.SLF_TABELA_CONTATO,
                  ta.SLF_TABELA_OBSTABELA,
                  ta.GLB_VENDFRETE_CODIGO,
                  ta.SLF_TABELA_OBSFATURAMENTO,
                  ta.SLF_TABELA_LOTACAOFLAG,
                  ta.SLF_TABELA_ISENTO,
                  ta.SLF_TABELA_DESCRICAO,
                  ta.SLF_TPCALCULO_CODIGO,
                  ta.SLF_TABELA_PEDREAJAUT,
                  ta.SLF_TABELA_PEDATUALIZA,
                  ta.SLF_TABELA_ORIGEMDESTINO,
                  ta.SLF_TABELA_STATUS,
                  ta.SLF_TABELA_VIAGEMMIN,
                  ta.SLF_TABELA_VIAGEMMAX,
                  ta.SLF_TABELA_VIAGEMIDENT,
                  ta.CON_FCOBPED_CODIGO,
                  ta.CON_MODALIDADEPED_CODIGO,
                  ta.SLF_TABELA_TPDESCONTO,
                  ta.SLF_TABELA_DESCONTO,
                  ta.SLF_TABELA_PERCLOTACAO,
                  ta.SLF_TABELA_MSGLOTACAO,
                  ta.SLF_TABELA_ABORTALOTACAO,
                  ta.SLF_TABELA_PESOMINIMO,
                  ta.SLF_TABELA_PESOMAXIMO,
                  ta.SLF_TABELA_OCUPACAO,
                  ta.SLF_TABELA_BASEOCUPACAO,
                  ta.SLF_TABELA_CONTRATO,
                  ta.SLF_TABELA_COMISSIONADO,
                  ta.FCF_TPVEICULO_CODIGO,
                  ta.FCF_TPCARGA_CODIGO,
                  ta.GLB_GRUPOECONOMICO_CODIGO,
                  ta.SLF_TABELA_IMPRIMEOBSCTRC,
                  ta.SLF_TABELA_IMPRIMEOBSVENC,
                  ta.SLF_TABELA_COLETAENTREGA
           from tdvadm.t_slf_tabela ta
           where ta.slf_tabela_contrato = vContrato
             and ta.slf_tabela_codigo = c_msg.slf_tabela_codigo
             and ta.slf_tabela_saque  = c_msg.slf_tabela_saque;
         End If;

         If ( c_msg.slf_tabela_vigencia = vVigencia ) and 
            ( c_msg.slf_tabela_status = 'N' ) Then
            
            vSaque := c_msg.slf_tabela_saque;
            vSaqueOrigem := lpad(c_msg.slf_tabela_saque - 1,4,'0');

         Else
            vSaque := lpad(c_msg.slf_tabela_saque + 1,4,'0');
            vSaqueOrigem := c_msg.slf_tabela_saque;
         End If;
            
         select count(*)
           into vAuxiiar 
         from tdvadm.t_slf_calcfretekm km
         where km.slf_tabela_codigo = c_msg.slf_tabela_codigo
           and km.slf_tabela_saque = vSaque;

         If vApaga = 'S' Then

            delete tdvadm.t_slf_calcfretekm km
            where km.slf_tabela_codigo = c_msg.slf_tabela_codigo
              and km.slf_tabela_saque  = vSaque;

            vAuxiiar := sql%rowcount;
            vAuxiiar := 0;
         End If;
            
         If ( vAuxiiar = 0 ) and ( vSaqueOrigem > 0 ) Then


          insert into tdvadm.t_slf_calcfretekm
          select km.SLF_TABELA_CODIGO,
                 vSaque SLF_TABELA_SAQUE,
                 km.SLF_CALCFRETEKM_KMDE,
                 km.SLF_CALCFRETEKM_KMATE,
                 km.SLF_CALCFRETEKM_PESODE,
                 km.SLF_CALCFRETEKM_PESOATE,
                 km.SLF_TPCALCULO_CODIGO,
                 km.SLF_RECCUST_CODIGO,
                 round(km.SLF_CALCFRETEKM_VALOR * tdvadm.pkg_slf_tabelas.fi_verifica_carga(km.slf_tabela_codigo,km.slf_tabela_saque,';D_FRPSVO;',trim(km.SLF_RECCUST_CODIGO),vPercen),2) SLF_CALCFRETEKM_VALOR,
                 km.SLF_CALCFRETEKM_DESINENCIA,
                 km.SLF_CALCFRETEKM_CODCLI,
                 km.SLF_CALCFRETEKM_TPFRETE,
                 km.SLF_CALCFRETEKM_ORIGEM,
                 km.SLF_CALCFRETEKM_DESTINO,
                 km.SLF_CALCFRETEKM_ORIGEMI,
                 km.SLF_CALCFRETEKM_DESTINOI,
                 km.SLF_CALCFRETEKM_LIMITE,
                 km.SLF_CALCFRETEKM_VALORE,
                 km.SLF_CALCFRETEKM_DESINENCIAE,
                 km.SLF_CALCFRETEKM_VALORF,
                 km.SLF_CALCFRETEKM_DESINENCIAF,
                 km.SLF_CALCFRETEKM_RAIOKMORIGEM,
                 km.SLF_CALCFRETEKM_RAIOKMDESTINO,
                 km.SLF_CALCFRETEKM_IMPEMBUTIDO,
                 km.SLF_CALCFRETEKM_OUTRACOLETAI,
                 km.SLF_CALCFRETEKM_OUTRAENTREGAI,
                 sysdate
          from tdvadm.t_slf_calcfretekm km                             
          where km.slf_tabela_codigo = c_msg.slf_tabela_codigo
            and km.slf_tabela_saque  = vSaqueOrigem;

         End If;
         commit;
     End Loop;
         
     insert into tdvadm.t_slf_clienteped
     select cp.glb_grupoeconomico_codigo,
            cp.glb_cliente_cgccpfcodigo,
            cp.fcf_tpcarga_codigo,
            cp.slf_contrato_codigo,
            vVigencia slf_clienteped_vigencia,
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
     where cp.slf_contrato_codigo = c_msgc.contrato
       and nvl(cp.slf_clienteped_ativo,'S') = 'S'
       and cp.slf_clienteped_vigencia = (select max(cp1.slf_clienteped_vigencia)
                                         from tdvadm.t_slf_clienteped cp1
                                         where cp1.glb_grupoeconomico_codigo = cp.glb_grupoeconomico_codigo
                                           and cp1.glb_cliente_cgccpfcodigo  = cp.glb_cliente_cgccpfcodigo
                                           and cp1.slf_contrato_codigo       = cp.slf_contrato_codigo
                                           and cp1.fcf_tpcarga_codigo        = cp.fcf_tpcarga_codigo
                                           and cp1.fcf_tpveiculo_codigo      = cp.fcf_tpveiculo_codigo);
            
      
      wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'REAJUSTE CONTRATO ' || c_msgc.contrato || ' - ' || trim(rpad(i,3,'0')) || '/013' ,
                                           P_TEXTO   => null,
                                           P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                           P_DESTINO => 'sirlano.drumond@dellavolpe.com.br;sirlanodrumond@gmail.com',
                                           P_COPIA   => null,
                                           P_COPIA2  => null);
      commit;
      
      
   End Loop;
end;
0
9
vPercen
vAuxiiar
vSaque
vVigenciaPesq
c_msg.slf_tabela_vigencia
c_msg.slf_tabela_codigo
c_msg.slf_tabela_saque
c_msg.slf_tabela_status
vSaqueOrigem
