--[GERAL]
-- Objetos Compilados
SELECT * FROM V_AUDITORIA_DDL A
where lower(a.object_name) like '%v_car_contacorrente%'


 
select * from 

-- Monta um script de Create Select para o MIGDV
tdvadm.v_comparativotabtdhtdp

-- Matando processos
select * from tdvadm.v_kill_sessoes k
where 0 = 0
  and lower(k.OSUSER) like '%vinicius.dantas%'
  and lower(k.PROGRAM) like '%valefrete%'




tdvadm.pkg_arm_coleta

-- Veririfcando JOBS
   -- Rodando
   select * from tdvadm.v_job_rodando;

--[SCHEDULLER]
-- Alterendo tamanho dos LOG´s
select 'EXEC DBMS_SCHEDULER.PURGE_LOG(LOG_HISTORY => 30, JOB_NAME => ''' || t.JOB || ''');'
from tdvadm.v_job_todos t
where t.tipo = 'SCH';

--[CARREGAMENTO]
-- Procedure Principla
tdvadm.pkg_fifo_carregctrc;
-- Procedure das REGRAS e PARTICULARIDADES
tdvadm.pkg_slf_contrato;
-- Fechamento de Carregamento
c:\vBox\Comum\Script\fechacarreg.tst


--[NOTA]
-- Devolvendo uma Nota
tdvadm.pkg_arm_embalagem.Sp_Devolver_EmbalagemNF  

<Parametros>/
   <Input>
      <Nota>9093</Nota>
      <CNPJ>19291268000158</CNPJ>
      <Sequencia>4918102</Sequencia>
      <Chave>31200719291268000158550010000090931068947417</Chave>
      <TipoDevolucao>D</TipoDevolucao>
      <Coleta_Original>491810</Coleta_Original>
      <Usuario>jsantos</Usuario>
      <Rota>160</Rota>
      <Aplicacao>carreg</Aplicacao>
      <Versao>20.3.2.0</Versao>
      <ConheciementoCodigo>236634</ConheciementoCodigo>
      <ConheciementoSerie>A1</ConheciementoSerie>
      <ConheciementoRota>187</ConheciementoRota>
      <PagtoFrete>S</PagtoFrete>
      <IDOcorrencia>8</IDOcorrencia>
      <Coleta>491367</Coleta>
      <Acao>D</Acao>
   </Input>
</Parametros>





-- Fazendo CHECKIN
  pkg_fifo_carregamento .sp_getEmbTransferidas
  <Parametros>
     <Inputs>
        <input>
           <usuario>ezpereira</usuario>
           <rota>011</rota>
           <aplicacao>carreg</aplicacao>
           <armazem>06</armazem>
        </input>
     </Inputs>
  </Parametros>





-- [PROPRIETARIO]
-- Conta Corrente 
Select x.operacao, 
       x.proprietario,
       sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',0,1)) Credito,
       sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',1,0)) Debito,
       sum(x.car_contacorrente_valor * decode(x.car_contacorrente_tplancamento,'D',1,-1)) valor,
       count(*) QTDE,
       min(trunc(x.dtData)) menorDT,
       max(trunc(x.dtData)) maiorDT       
from TDVADM.V_CAR_CONTACORRENTENOVOCONCEITO x
where 0 = 0 
  and x.dtData >= to_date('01/12/2015','dd/mm/yyyy')
--  and x.dtincialded <= to_date('13/10/2020','dd/mm/yyyy')
  and trim(x.operacao) in ('PNEUS/TDV PARCELA')
--  and x.proprietario like '%KENNEDY%'
group by x.operacao,x.proprietario;

--[COLETA]
-- Copiando coleta Script
C:\vBox\Comum\Script\copiandocoletas.sql

-- Verificado coletas daNIMBI
select A.COL_ASN_DTGRAVACAO gravacao,
--       A.COL_ASN_ID IDASN,
       a.col_asn_numero ASN,
       a.arm_coleta_ncompra coleta,
       a.arm_coleta_ciclo ciclo,
              Case
          When a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' and A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
            Then 'DEVOLUCAO'
            Else 'NORMAL'
          end as TIPO,
       (select an.arm_nota_numero || '-' || an.glb_cliente_cgccpfremetente || '-' || an.arm_nota_serie
        from tdvadm.t_arm_nota an
        where an.arm_nota_dtinclusao >= to_date('01/08/2020','dd/mm/yyyy')
          and an.arm_coleta_ncompra = a.arm_coleta_ncompra
          and an.arm_coleta_ciclo = a.arm_coleta_ciclo) qtdenota,
       (select count(distinct c.arm_carregamento_codigo)
        from tdvadm.t_arm_carregamentodet c
        where (c.arm_embalagem_numero,
               c.arm_embalagem_flag,
               c.arm_embalagem_sequencia) in (select an.arm_embalagem_numero,
                                                     an.arm_embalagem_flag,
                                                     an.arm_embalagem_sequencia
                                              from tdvadm.t_arm_nota an
                                              where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) carreg,

        (select count(*)
         from tdvadm.t_con_nftransporta nf
         where nf.con_nftransportada_dtemissao >= to_date('01/08/2020','dd/mm/yyyy')
           and (nf.con_nftransportada_numnfiscal,
                nf.glb_cliente_cgccpfcodigo) in (select lpad(an.arm_nota_numero,9,'0'),
                                                        rpad(an.glb_cliente_cgccpfremetente,20)
                                                 from tdvadm.t_arm_nota an
                                                 where an.arm_coleta_ncompra = a.arm_coleta_ncompra
                                                   and an.arm_coleta_ciclo = a.arm_coleta_ciclo)) qtdcte,
       a.COL_ASN_SPECIALPROCESSCODE,
       a.COL_ASN_TIPOCARGA,         
       A.COL_ASN_FRAGILELOAD,       
       A.COL_ASN_SELFSUPPORTINGLOAD,
       a.col_asn_obs
from tdvadm.t_Col_Asn a
where 0 = 0
  and (a.arm_coleta_ncompra,
       a.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,
                                       co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where  co.xml_coleta_numero in ('V830132154'))
--  and a.col_asn_dtgravacao >= to_date('15/08/2020','dd/mm/yyyy')
  and a.COL_ASN_SPECIALPROCESSCODE = 'BR09' and a.COL_ASN_TIPOCARGA = 'A' AND A.COL_ASN_FRAGILELOAD = '2' AND A.COL_ASN_SELFSUPPORTINGLOAD = '2'
--  and  a.col_asn_numero in ('V830104589','V830117872','N000622937','V830118156','V840020716','V830126794','6593108473','V830127469')



--[TABELAS]
-- Verificando tabelas com chaves duplicadas
select d.tabela,
       d.sq,
       d.vigencia,
       d.contrato,
       d.cnpj,
       d.grupo,
       d.tipo,
       d.tpveic,
       d.carga,
       d.entcol,
       (select count(*)
        from v_slf_tabeladup d1
        where d1.contrato = d.contrato
          and d1.cnpj = d.cnpj
          and d1.grupo = d.grupo
          and d1.tipo = d.tipo
          and d1.tpveic = d.tpveic
          and d1.carga = d.carga
          and d1.entcol = d.entcol) qtde
from v_slf_tabeladup d
where  1 < (select count(*)
            from v_slf_tabeladup d1
            where d1.contrato = d.contrato
              and d1.cnpj = d.cnpj
              and d1.grupo = d.grupo
              and d1.tipo = d.tipo
              and d1.tpveic = d.tpveic
              and d1.carga = d.carga
              and d1.entcol = d.entcol)
order by 4,5,6,7,8,9,10

-- Outras avliacaoes de Tabelas
select * from tdvadm.v_slf_tabelakm;
select * from tdvadm.v_slf_tabelakmsusp;
select * from tdvadm.v_slf_tabelakmcomp;
select * from tdvadm.v_slf_tabelakmutlsaque;
select * from tdvadm.v_slf_tabelakmcompTodos;
select * from tdvadm.v_slf_reajuste;


--{FRETECAR]

-- Verifica se existe algum email de frete
select *
from rmadm.t_glb_benasserec br
where br.glb_benasserec_assunto like '%MSG=CADFRETE%';

select p.protocolo,
/*       p.fcf_fretecar_origem,
       p.fcf_fretecar_destino,
       p.fcf_fretecar_tpfrete,
       p.fcf_tpveiculo_codigo,
       p.fcf_tpcarga_codigo,
       p.fcf_fretecar_valor,
       p.fcf_fretecar_desinencia,
       p.fcf_fretecar_vigencia,
       p.usu_usuario_cadastro,
       p.usu_usuario_alterou,
       p.fcf_fretecar_dtcadastro,
       p.fcf_fretecar_dtalteracao,
       p.fcf_fretecar_pedagio,
       p.fcf_fretecar_altpedagio,
       p.usu_usuario_codigo,
       p.fcf_fretecar_km,
       p.fcf_fretecar_origemi,
       p.fcf_fretecar_destinoi,
       p.fcf_fretecar_rowid,
       p.fcf_fretecar_pednofrete,
       p.FCF_FRETECAR_ALTKM,
       p.fcf_fretecar_passandopor,
       p.fcf_fretecar_passandopori,
*/       p.descorigem,
       p.descdestino,
       p.passandopor,
       p.descveiculo,
       (select count(*)
        from tdvadm.t_fcf_fretecar fc
        where fc.fcf_fretecar_origem = p.fcf_fretecar_origem
          and fc.fcf_fretecar_destino = p.fcf_fretecar_destino
          and fc.fcf_fretecar_passandopor = p.fcf_fretecar_passandopor
          and fc.fcf_fretecar_tpfrete = p.fcf_fretecar_tpfrete
          and fc.fcf_tpveiculo_codigo = p.fcf_tpveiculo_codigo
          and fc.fcf_tpcarga_codigo = p.fcf_tpcarga_codigo
          and fc.fcf_fretecar_origemi = p.fcf_fretecar_origemi
          and fc.fcf_fretecar_destinoi = p.fcf_fretecar_destinoi
          and fc.fcf_fretecar_passandopori = p.fcf_fretecar_passandopori) qtde,
       cursor (select *
        from tdvadm.t_fcf_fretecar fc
        where fc.fcf_fretecar_origem = p.fcf_fretecar_origem
          and fc.fcf_fretecar_destino = p.fcf_fretecar_destino
          and fc.fcf_fretecar_passandopor = p.fcf_fretecar_passandopor
          and fc.fcf_fretecar_tpfrete = p.fcf_fretecar_tpfrete
          and fc.fcf_tpveiculo_codigo = p.fcf_tpveiculo_codigo
          and fc.fcf_tpcarga_codigo = p.fcf_tpcarga_codigo
          and fc.fcf_fretecar_origemi = p.fcf_fretecar_origemi
          and fc.fcf_fretecar_destinoi = p.fcf_fretecar_destinoi
          and fc.fcf_fretecar_passandopori = p.fcf_fretecar_passandopori) achei 
from tdvadm.v_fcf_fretecar_protocolo p
where p.protocolo = 1347696;


select *
from 



-- {TDH / TDX]
-- Atualizando TDV
tdvadm.pkg_hd_atualizatdx



PKG_CFE_FRETE.SP_SET_ALTERARCIOT

'IntegraTdv_Cod=nome=IntegraTdv_Cod|tipo=String|valor=35*' +
'VFNumero=nome=VFNumero|tipo=String|valor=' + p_VF + '*' +
'VFSerie=nome=VFSerie|tipo=String|valor=' + p_Serie + '*' +
'VFRota=nome=VFRota|tipo=String|valor=' + p_Rota + '*' +
'VFSaque=nome=VFSaque|tipo=String|valor=' + p_Saque + '*' +
'VFUsuarioTDV=nome=VFUsuarioTDV|tipo=String|valor=' + p_Usuario + '*' +
'VFRotaUsuarioTDV=nome=VFRotaUsuarioTDV|tipo=String|valor=' + Frm_ValeFrete.v_Rota + '*' +
'VFAplicacaoTDV=nome=VFAplicacaoTDV|tipo=String|valor=comvlfrete*'

    
ID
TDVADM.PKG_CFE_FRETE.SP_GETIDVALIDOGER


Cria
'IntegraTdv_Cod=nome=IntegraTdv_Cod|tipo=String|valor=18*
 VFNumero=nome=VFNumero|tipo=String|valor=<<VFNumero>>*
 VFSerie=nome=VFSerie|tipo=String|valor=<<VFSerie>>*
 VFRota=nome=VFRota|tipo=String|valor=<<VFRota>>*
 VFSaque=nome=VFSaque|tipo=String|valor=<<VFSaque>>*
 VFUsuarioTDV=nome=VFUsuarioTDV|tipo=String|valor=<<VFUsuarioTDV>>*
 VFRotaUsuarioTDV=nome=VFRotaUsuarioTDV|tipo=String|valor=<<VFRotaUsuarioTDV>>*
 VFAplicacaoTDV=nome=VFAplicacaoTDV|tipo=String|valor=comvlfrete*'
                   
TDVADM.PKG_CFE_FRETE .SP_SET_INTEGRAVF                     



-- TABELAS HANA
-- Somente no TDH
Select *
from dba_views v
where lower(v.TEXT_VC) like '%@tdhdsaps4%'
--
tdvadm.V_SAP_IMAGENS;
tdvadm.V_SAP_CTE;


-- Notas
select mandt,count(*) from SAPHANADB.ztmt0004@TDHDSAPS4
group by mandt;

-- pegando a pesagem
select * from SAPHANADB.ZTMT0033@TDHDSAPS4
where ROOT_KEY = '3E40798706021EDAB1DA27FBA94E4DB9';
-- Buscando a TRQ pela chave da nota
select x.* from SAP
HANADB."/SCMTMS/D_TRQITM"@TDHDSAPS4 x
where ZENH_CHAVE = '31200607858230000135550010000159001015900436';

select * from migdv.V_TESTE;


-- Monta um script de Create Select para o MIGDV
tdvadm.v_comparativotabtdhtdp

-- TABELAS
SAPHANADB.ZTMT0004@TDHDSAPS4 -- Tabelas das NFe Integradas no SAP

-- VIEW QUE USAM TABELAS NO SAP
Select * from MIGDV.BANK_MASTER_S_BNKA;
Select * from MIGDV.CUSTOMER_S_ADDRESS;
Select * from MIGDV.CUSTOMER_S_CUST_BANK_DATA;
Select * from MIGDV.CUSTOMER_S_CUST_COMPANY;
Select * from MIGDV.CUSTOMER_S_CUST_CONT;
Select * from MIGDV.CUSTOMER_S_CUST_GEN;
Select * from MIGDV.CUSTOMER_S_CUST_SALES_DATA;
Select * from MIGDV.CUSTOMER_S_CUST_SALES_PARTNER;
Select * from MIGDV.CUSTOMER_S_CUST_TAXNUMBERS;
Select * from MIGDV.CUSTOMER_S_ROLES;
Select * from MIGDV.CUSTREL_S_BUT050;
Select * from MIGDV.EQUIPMENT_S_EQUI;
Select * from MIGDV.FIXED_ASSET_S_CUM_VAL;
Select * from MIGDV.FIXED_ASSET_S_DEPR;
Select * from MIGDV.FIXED_ASSET_S_KEY;
Select * from MIGDV.FIXED_ASSET_S_NETWORTHVALUATIO;
Select * from MIGDV.FIXED_ASSET_S_ORIGIN;
Select * from MIGDV.FIXED_ASSET_S_POSTINGINFORMATI;
Select * from MIGDV.FIXED_ASSET_S_POST_VAL;
Select * from MIGDV.FIXED_ASSET_S_REALESTATE;
Select * from MIGDV.FIXED_ASSET_S_TIMEDEPENDENTDAT;
Select * from MIGDV.FUNC_LOC_S_FUN_LOCATION;
Select * from MIGDV.GL_BALANCES_S_BSIS;
Select * from MIGDV.LINHA_MEIO_TRANSP;
Select * from MIGDV.LINHA_TRANSPORTE;
Select * from MIGDV.MATERIAL_S_MAKT;
Select * from MIGDV.MATERIAL_S_MARA;
Select * from MIGDV.MATERIAL_S_MARC;
Select * from MIGDV.MATERIAL_S_MARD;
Select * from MIGDV.MATERIAL_S_MARM;
Select * from MIGDV.MATERIAL_S_MBEW;
Select * from MIGDV.MATERIAL_S_MLAN;
Select * from MIGDV.N_CUSTOMER_S_CUST_COMPANY;
Select * from MIGDV.N_CUSTOMER_S_CUST_GEN;
Select * from MIGDV.N_CUSTOMER_S_CUST_SALES_DATA;
Select * from MIGDV.N_CUSTOMER_S_CUST_SALES_PARTNER;
Select * from MIGDV.N_CUSTOMER_S_CUST_TAXNUMBERS;
Select * from MIGDV.N_CUSTOMER_S_ROLES;
Select * from MIGDV.OPEN_ITEM_AP_S_BSET;
Select * from MIGDV.OPEN_ITEM_AP_S_BSIK;
Select * from MIGDV.OPEN_ITEM_AP_S_WITH_ITEM;
Select * from MIGDV.OPEN_ITEM_AR_S_BSET;
Select * from MIGDV.OPEN_ITEM_AR_S_BSID;
Select * from MIGDV.OPEN_ITEM_AR_S_WITH_ITEM;
Select * from MIGDV.QUALIF_RECURSO;
Select * from MIGDV.RECURSO;
Select * from MIGDV.TST_CUSTOMER_S_CUST_GEN;
Select * from MIGDV.TST_CUSTOMER_S_CUST_TAXNUMBERS;
Select * from MIGDV.TST_CUSTOMER_S_ROLES;
Select * from MIGDV.VENDOR_S_ROLES;
Select * from MIGDV.VENDOR_S_SUPPL_ADDR;
Select * from MIGDV.VENDOR_S_SUPPL_GEN;
Select * from MIGDV.VENDOR_S_SUPPL_IDENT;
Select * from MIGDV.VENDOR_S_SUPPL_TAXNUMBERS;
Select * from MIGDV.VENDOR_S_SUPPL_WITH_TAX;
Select * from MIGDV.VENDOR_S_SUPP_BANK;
Select * from MIGDV.VEND_EXT_S_ROLES;
Select * from MIGDV.VEND_EXT_S_SUPPL_ADDR;
Select * from MIGDV.VEND_EXT_S_SUPPL_BANK;
Select * from MIGDV.VEND_EXT_S_SUPPL_GEN;
Select * from MIGDV.VEND_EXT_S_SUPPL_IDENT;
Select * from MIGDV.VEND_EXT_S_SUPPL_TAXNUMBERS;
Select * from MIGDV.VEND_EXT_S_SUPPL_WITH_TAX;
Select * from MIGDV.V_TESTE;
Select * from MIGDV.ZONA_TRANSPORTE;
Select * from SAPBWTDV.CV_CONJUNTO;
Select * from SAPBWTDV.CV_CONTABILIDADE_GERAL;
Select * from SAPBWTDV.CV_MOTORISTA;
Select * from SAPBWTDV.CV_NOTAS;
Select * from SAPBWTDV.CV_ORDEM_FRETE;
Select * from SAPBWTDV.CV_PNEUS;
Select * from SAPBWTDV.CV_TABELA_PRECO;
Select * from SAPBWTDV.CV_TITULOS_AP_FORNECEDORES;
Select * from SAPBWTDV.CV_TITULOS_AR_CLIENTES;
Select * from SAPBWTDV.CV_VEICULOS;
Select * from SAPBWTDV.CV_VEICULOS_MANUTENCAO;
 

Select *
from synchro.synitf_dof
