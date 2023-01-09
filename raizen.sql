select lg.con_loggeracao_codigo seq,
       lg.arm_nota_numero nota,
       lg.con_conhecimento_codigo cte,
       lg.con_loggeracao_obsgeracao obs,
       lg.con_loggeracao_erro erro,
       lg.con_loggeracao_sql sql,
       lg.con_loggeracao_formula formula,
       lg.con_loggeracao_fator fator,
       lg.con_loggeracao_formulatra formulatra,
       lg.con_loggeracao_obsgeracaohtml obshtml,
       lg.con_loggeracao_errohtml errohtml
from tdvadm.t_con_loggeracao lg
where lg.arm_carregamento_codigo = '1415984'
  and ( lg.con_loggeracao_obsgeracao like 'TESTANDO%' or lg.con_loggeracao_obsgeracao like 'BUSCANDO%' )
--  and lg.con_loggeracao_formula is not null
order by 1;

select * from tdvadm.t_fcf_tpcarga


    update tdvadm.t_slf_calcfretekm k
      set k.slf_calcfretekm_origemi = decode(trim(k.slf_calcfretekm_origemi),'AMR06','05571',
                                                                       'AMR07','32001',
                                                                       'AMR08','29132  ',
                                                                       'AMR10','68515',
                                                                       'AMR13','65000',
                                                                       'AMR15','20000',
                                                                       'AMR18','67001',
                                                                       'AMR19','42800',
                                                                       'AMR23','67001',
                                                                       'AMR24','38400',
                                                                       'AMR25','80000',
                                                                       'AMR27','88300',
                                                                       'AMR29','65906',
                                                                       'AMR34','68500',
                                                                       'AMR36','38400',k.slf_calcfretekm_origemi)
    where k.slf_calcfretekm_origemi like 'A%'
      and ( k.slf_tabela_codigo,k.slf_tabela_saque ) in (select ta.slf_tabela_codigo,ta.slf_tabela_saque from tdvadm.t_slf_tabela ta where ta.slf_tabela_contrato = 'C2016080027')
      and rownum < 100
      

select *
from tdvadm.t_slf_clienteped cp
where cp.glb_localidade_codigooriib = '3550308'
  and cp.glb_localidade_codigodesib = '3519071'
  AND CP.SLF_CONTRATO_CODIGO = 'C2016080027'
  AND CP.FCF_TPVEICULO_CODIGO = '1'
  
  
select *
from tdvadm.t_uti_geraplanilha gp
where upper(gp.uti_geraplanilha_titulo) like '%SIMPLES%'  
                                                
  

select * from tdvadm.v_lock_tables


select *
from tdvadm.v_slf_clientecargas cc
where cc.contrato = 'C2017110116'


select *
from tdvadm.t_arm_coleta co
where co.arm_coleta_ncompra = '463760'
  and co.arm_coleta_ciclo = '002'
  


select * from tdvadm.t_arm_carregamento c where c.arm_carregamento_codigo = '1231234'


select co.fcf_tpcarga_codigo,co.fcf_tpveiculo_codigo
from tdvadm.t_arm_coleta co
where co.arm_coleta_ncompra = '708481'
  and co.arm_coleta_ciclo = '002'
  
select *
from tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato = 'C2017110116'
  and ta.slf_tabela_status = 'N';
  
tdvadm.pkg_slf_contrato  ;

select an.arm_nota_numero,
       an.glb_cliente_cgccpfremetente,
       an.arm_nota_serie,
       an.arm_nota_sequencia
from tdvadm.t_arm_nota an
where an.arm_nota_numero = 14882
  and an.glb_cliente_cgccpfremetente like '387711%'
  
  



select *
from fpw.funciona f
where substr(to_char(f.fudtnasc),5,4) = '0315'



SELECT *
FROM FPW.CBO C
WHERE C.CBODESCRIC like '%MOTOT%'
FOR UPDATE
  

SELECT *
FROM TDVADM.V_SLF_CLIENTECARGAS CC
WHERE CC.contrato = 'C2018010119'

SELECT CO.FCF_TPCARGA_CODIGO,CO.*
FROM TDVADM.T_ARM_COLETAHIST CO
WHERE CO.ARM_COLETA_NCOMPRA = '679574'
  AND CO.ARM_COLETA_CICLO = '002'
  

select ta.slf_tabela_codigo,max(ta.slf_tabela_vigencia)
from tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato = 'C2016080027'
  and ta.glb_cliente_cgccpfcodigo = '01599436000101'
  and ta.slf_tabela_status = 'N'
group by ta.slf_tabela_codigo
  

select *
from rmadm.t_glb_benasserec br
where br.glb_benasserec_assunto like '%MSG=PROCINCTAB;PROTOCOLO=548588%'
  and trunc(br.glb_benasserec_gravacao) >= '09/03/2018';

select *
from tdvadm.t_edi_integra i
where i.edi_integra_protocolo = 548121

  
  


select ta.slf_tabela_codigo,ta.slf_tabela_saque,ta.fcf_tpveiculo_codigo,ta.fcf_tpcarga_codigo
from tdvadm.t_slf_tabela ta
--delete tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato = 'C7000067442';    

select *
from tdvadm.v_slf_clientecargas cc
where cc.contrato = 'C7000067442'
for update;


select *
from tdvadm.t_slf_cliregrasveic v
where v.slf_contrato_codigo = 'C7000067442'
for update;

delete tdvadm.t_slf_cliregrasveic v
where v.slf_contrato_codigo = 'C2018010119';
insert into tdvadm.t_slf_cliregrasveic v
select distinct 
       ta.glb_grupoeconomico_codigo,
       ta.glb_cliente_cgccpfcodigo,
       ta.slf_tabela_contrato,
       ta.fcf_tpveiculo_codigo,
       tv.fcf_tpveiculo_descricao,
       ta.fcf_tpcarga_codigo,
       tc.fcf_tpcarga_descricao,
       ta.slf_tabela_vigencia,
       'S',
       (select min(km.slf_calcfretekm_pesode)
        from tdvadm.t_slf_calcfretekm km
        where km.slf_tabela_codigo = ta.slf_tabela_codigo
          and km.slf_tabela_saque = ta.slf_tabela_saque),
       (select max(km.slf_calcfretekm_pesoate)
        from tdvadm.t_slf_calcfretekm km
        where km.slf_tabela_codigo = ta.slf_tabela_codigo
          and km.slf_tabela_saque = ta.slf_tabela_saque),
       'S',
       'S'
from tdvadm.t_slf_tabela ta,
     tdvadm.t_fcf_tpveiculo tv,
     tdvadm.t_fcf_tpcarga tc
--delete tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato = 'C2018010119'
  and ta.fcf_tpveiculo_codigo = tv.fcf_tpveiculo_codigo
  and ta.fcf_tpcarga_codigo = tc.fcf_tpcarga_codigo;
  
update tdvadm.t_slf_cliregrasveic v
  set v.slf_cliregrasveic_nomeveic = decode(trim(v.fcf_tpveiculo_codigo),'23','PEQUENO PORTE (ate 50kg)',
                                                                         '18','PEQUENO PORTE (ate 500kg)',
                                                                         '1','CARRETA (ate 25ton)',
                                                                         '12','CARRETA (ate 27ton)',
                                                                         '13','CARRETA (acima 27001 ton)',
                                                                         '22','UTILITARIO (até 1,5 ton)',
                                                                         '7','3/4 (ate 2,5 ton)',
                                                                         '4','TOCO (ate 5,5 ton)',
                                                                         '3','TRUCK (até 14 ton)',v.slf_cliregrasveic_nomeveic)
where v.slf_contrato_codigo = 'C2018010119';
                                                                         



delete tdvadm.t_arm_coletacargaveiculo x
where x.glb_grupoeconomico_codigo = '0628';

insert into tdvadm.t_arm_coletacargaveiculo 
select distinct c.glb_grupoeconomico_codigo,
       c.fcf_tpcarga_codigo,
       c.slf_cliregrasveic_nomecarga,
       c.fcf_tpveiculo_codigo,
       c.slf_cliregrasveic_nomeveic,
       c.slf_cliregrasveic_faixaf
       ,sysdate,
       null,
       null,
       null,
       'jsantos'
from tdvadm.t_slf_cliregrasveic c
where c.slf_contrato_codigo = 'C2018010119'
order by c.fcf_tpveiculo_codigo,c.fcf_tpcarga_codigo



select an.arm_nota_dtinclusao,
       an.arm_armazem_codigo,
       an.arm_nota_numero,
       an.glb_cliente_cgccpfremetente,
       an.glb_cliente_cgccpfdestinatario,
       an.glb_cliente_cgccpfsacado,
       an.arm_nota_onu
from tdvadm.t_arm_nota an
where 0 = 0
--  and nvl(an.arm_nota_onu,9999) <> 9999
  and an.con_conhecimento_codigo is null
  and an.arm_nota_dtinclusao >= '01/03/2018'
  and an.slf_contrato_codigo = 'C2018010119'
  and an.  


select *
from tdvadm.t_slf_clientecargas cc
where cc.slf_contrato_codigo = 'C2018010119';

update tdvadm.t_slf_clientecargas cc
  set cc.slf_clientecargas_rateia = 'N'
where cc.slf_contrato_codigo = 'C2018010119';

select co.arm_coleta_ncompra,co.arm_coleta_ciclo,co.*
from tdvadm.t_arm_coleta co
where co.arm_coleta_ncompra = '702743';

  
SELECT *         
FROM tdvadm.T_GLB_FORNECEDOR F
WHERE F.GLB_FORNECEDOR_CGCCPF = 'x';


select * from tdvadm.t_fcf_tpcarga tt
where tt.fcf_tpcarga_codigo = '31'



select *
from tdvadm.v_arm_verifcarreg vc
where vc.carreg = '1231206';

sedle



select cl.glb_cliente_cgccpfcodigo cnpj,
       cl.glb_cliente_razaosocial razao,
       cl.glb_grupoeconomico_codigo grupo,
       g.glb_grupoeconomico_nome descgrupo,
       cc.slf_contrato_codigo contrato
from tdvadm.t_glb_cliente cl,
     tdvadm.t_glb_grupoeconomico g,
     tdvadm.t_glb_clientecontrato cc
where cl.glb_cliente_cgccpfcodigo = cc.glb_cliente_cgccpfcodigo (+)
  and cl.glb_grupoeconomico_codigo = g.glb_grupoeconomico_codigo (+)
  and cl.glb_cliente_cgccpfcodigo in ('04169215002801','07921583000213','08070508000178','08070508000330','08070508006532','08070508006613','08070508006702','08070508006885','08070508006966','08070508007261','08070508008314','08070508009477','08070508009558','08070508009639','08070508009710','08070508012001','08070508012184','08070508012265','08070508012427','08070508012508','08070508015795','08070508015876','08619844000399','09538989000166','18686104000167','18734168000196',
                                      '18734200000133','18734203000177','18753150000131','18788137000118','18788137000207','18794615000100','19173220000145','19275443000113','33453598009260','43960335000164','52189420000161','52189420000919','52189420001052','18645875000106','18753157000153','18788137000380');
                                      

select *
from tdvadm.t_slf_percurso_2781910 p
where p.slf_percuso_descricao = 'SP-CUBATAO-PA-MARABA'
for update;






SELECT KM.SLF_CALCFRETEKM_KMDE KMDE,
       KM.SLF_CALCFRETEKM_KMATE KMATE,
       KM.SLF_CALCFRETEKM_PESODE PESODE,
       KM.SLF_CALCFRETEKM_PESOATE PESOATE,
       KM.SLF_CALCFRETEKM_ORIGEMI ORIGEM,
       KM.SLF_CALCFRETEKM_DESTINOI DESTINO,
       KM.SLF_RECCUST_CODIGO VERBA,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0001',KM.SLF_CALCFRETEKM_VALOR,0)) ANTES,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0002',KM.SLF_CALCFRETEKM_VALOR,0)) ATUAL
FROM TDVADM.T_SLF_CALCFRETEKM KM
WHERE 0 = 0
  AND KM.SLF_RECCUST_CODIGO IN  ('D_FRPSVO','D_DP')
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE 
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C46000006358'
                                                       AND TA.SLF_TABELA_STATUS = 'N')
GROUP BY KM.SLF_CALCFRETEKM_KMDE,
         KM.SLF_CALCFRETEKM_KMATE,
         KM.SLF_CALCFRETEKM_PESODE,
         KM.SLF_CALCFRETEKM_PESOATE,
         KM.SLF_CALCFRETEKM_ORIGEMI,
         KM.SLF_CALCFRETEKM_DESTINOI,
         KM.SLF_RECCUST_CODIGO;
         
SELECT KM.SLF_CALCFRETEKM_KMDE KMDE,
       KM.SLF_CALCFRETEKM_KMATE KMATE,
       KM.SLF_CALCFRETEKM_PESODE PESODE,
       KM.SLF_CALCFRETEKM_PESOATE PESOATE,
       KM.SLF_CALCFRETEKM_ORIGEMI ORIGEM,
       KM.SLF_CALCFRETEKM_DESTINOI DESTINO,
       KM.SLF_RECCUST_CODIGO VERBA,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0004',KM.SLF_CALCFRETEKM_VALOR,0)) ANTES,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0005',KM.SLF_CALCFRETEKM_VALOR,0)) ATUAL
FROM TDVADM.T_SLF_CALCFRETEKM KM
WHERE 0 = 0
  AND KM.SLF_RECCUST_CODIGO = 'D_FRPSVO'
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C4600005946'
                                                       AND TA.SLF_TABELA_STATUS = 'N')
GROUP BY KM.SLF_CALCFRETEKM_KMDE,
         KM.SLF_CALCFRETEKM_KMATE,
         KM.SLF_CALCFRETEKM_PESODE,
         KM.SLF_CALCFRETEKM_PESOATE,
         KM.SLF_CALCFRETEKM_ORIGEMI,
         KM.SLF_CALCFRETEKM_DESTINOI,
         KM.SLF_RECCUST_CODIGO;

SELECT KM.SLF_CALCFRETEKM_KMDE KMDE,
       KM.SLF_CALCFRETEKM_KMATE KMATE,
       KM.SLF_CALCFRETEKM_PESODE PESODE,
       KM.SLF_CALCFRETEKM_PESOATE PESOATE,
       KM.SLF_CALCFRETEKM_ORIGEMI ORIGEM,
       KM.SLF_CALCFRETEKM_DESTINOI DESTINO,
       KM.SLF_RECCUST_CODIGO VERBA,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0002',KM.SLF_CALCFRETEKM_VALOR,0)) ANTES,
       SUM(DECODE(KM.SLF_TABELA_SAQUE,'0003',KM.SLF_CALCFRETEKM_VALOR,0)) ATUAL
FROM TDVADM.T_SLF_CALCFRETEKM KM
WHERE 0 = 0
  AND KM.SLF_RECCUST_CODIGO IN ('D_FRPSVO','D_DP')
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C4600005947'
                                                       AND TA.SLF_TABELA_STATUS = 'N')
GROUP BY KM.SLF_CALCFRETEKM_KMDE,
         KM.SLF_CALCFRETEKM_KMATE,
         KM.SLF_CALCFRETEKM_PESODE,
         KM.SLF_CALCFRETEKM_PESOATE,
         KM.SLF_CALCFRETEKM_ORIGEMI,
         KM.SLF_CALCFRETEKM_DESTINOI,
         KM.SLF_RECCUST_CODIGO;







/******************************************************************************************************/



UPDATE TDVADM.T_SLF_CALCFRETEKM KM
  SET KM.SLF_CALCFRETEKM_VALOR = KM.SLF_CALCFRETEKM_VALOR * 1.04
WHERE 0 = 0
  AND TRIM(KM.SLF_RECCUST_CODIGO) IN  ('D_FRPSVO','D_DP')
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE 
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C46000006358'
                                                       AND TA.SLF_TABELA_STATUS = 'N'
                                                       AND TA.SLF_TABELA_SAQUE = '0002');
                                                                
UPDATE TDVADM.T_SLF_CALCFRETEKM KM
  SET KM.SLF_CALCFRETEKM_VALOR = KM.SLF_CALCFRETEKM_VALOR * 1.04
WHERE 0 = 0
  AND TRIM(KM.SLF_RECCUST_CODIGO) IN  ('D_DP')
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C4600005946'
                                                       AND TA.SLF_TABELA_STATUS = 'N'
                                                       AND TA.SLF_TABELA_SAQUE = '0005');

UPDATE TDVADM.T_SLF_CALCFRETEKM KM
  SET KM.SLF_CALCFRETEKM_VALOR = KM.SLF_CALCFRETEKM_VALOR * 1.04
WHERE 0 = 0
  AND TRIM(KM.SLF_RECCUST_CODIGO) IN  ('D_FRPSVO','D_DP')
  AND (KM.SLF_TABELA_CODIGO,KM.SLF_TABELA_SAQUE) IN (select TA.SLF_TABELA_CODIGO,TA.SLF_TABELA_SAQUE
                                                     from tdvadm.t_slf_tabela ta
                                                     where ta.slf_tabela_contrato = 'C4600005947'
                                                       AND TA.SLF_TABELA_STATUS = 'N'
                                                       AND TA.SLF_TABELA_SAQUE = '0003');



SELECT vc.cte,
       vc.rota,
       vc.nota,
       vc.remet,
       vc.carreg carregamento,
       vc.embalagem
FROM TDVADM.V_ARM_VERIFCARREG VC
WHERE Vc.memo = '1411114'
  and vc.flagtrans = 'S';
  
  
  
  SELECT *
  FROM TDVADM.T_SLF_CLIENTECARGAS;
  SELECT *
  FROM TDVADM.T_SLF_CLIREGRASVEIC CV
  WHERE CV.FCF_TPCARGA_CODIGO IN ('37','32','35','36')
  FOR UPDATE
    

  
  


in (select ca.arm_carregamento_codigo from tdvadm.t_arm_carregamento ca where ca.fcf_veiculodisp_codigo = '3229809');



SELECT *
FROM tdvadm.t_fcf_veiculodisp vd
where vd.car_veiculo_placa = 'GTJ5962';


SELECT *
FROM rmadm.t_glb_benasserec b
where trunc(b.glb_benasserec_gravacao) >= '09/03/2018'
  and b.glb_benasserec_origem like 'k%';
  
  
select * from tdvadm.T_ACC_DESPESAS;

SELECT F.GLB_FORNECEDOR_CGCCPF,
       F.GLB_FORNECEDOR_NOME,
       F.GLB_FORNECEDOR_PIS,
       F.GLB_FORNECEDOR_DTNASCIMENTO,
       F.GLB_FORNECEDOR_CBO,
       CB.CBODESCRIC
FROM TDVADM.T_GLB_FORNECEDOR F,
     fpw.cbo cb
WHERE F.GLB_FORNECEDOR_CGCCPF = :CNPJFOR
  and f.glb_fornecedor_cbo = cb.cbocodigo
  
  
select m.glb_rota_codigo rtcax,
       m.cax_boletim_data data,
       m.cax_movimento_sequencia seq,
       m.cax_operacao_codigo operacao,
       op.cax_operacao_descricao descricao,
       m.cax_movimento_valor valor,
       m.cax_movimento_historico historico
from tdvadm.t_cax_movimento m,
     tdvadm.t_cax_operacao op
where m.cax_movimento_documentoref like '024185A05301'
  and m.cax_operacao_codigo = op.cax_operacao_codigo
  and m.glb_rota_codigo_operacao = op.glb_rota_codigo_operacao
order by 2,3

             
select * from tdvadm.v_cte_icms20_3

046721-055
015120-193

SELECT *
FROM TDVADM.T_SLF_RECCUST RC
WHERE RC.SLF_RECCUST_DESCRICAO LIKE '%ICMS%'


select c.con_conhecimento_codigo,
       c.glb_rota_codigo,
       c.con_conhecimento_dtembarque,
       c.con_conhecimento_cst,
       (SELECT CA.CON_CALCVIAGEM_VALOR
        FROM TDVADM.T_CON_CALCCONHECIMENTO CA
        WHERE CA.CON_CONHECIMENTO_CODIGO = C.CON_CONHECIMENTO_CODIGO
          AND CA.CON_CONHECIMENTO_SERIE = C.CON_CONHECIMENTO_SERIE
          AND CA.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO
          AND CA.SLF_RECCUST_CODIGO = 'I_VLICMS')
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_dtembarque >= '01/03/2018'
  and c.con_conhecimento_tributacao = 'S'
  and c.con_conhecimento_cst in ('90','60')
  and c.con_conhecimento_codigo in ('121409','121481')
  
  
  
  
  

SELECT CC.SLF_CLIENTECARGAS_VIGENCIA,
       CC.SLF_CONTRATO_CODIGO,
       CC.GLB_GRUPOECONOMICO_CODIGO,
       CC.GLB_CLIENTE_CGCCPFCODIGO,
       CC.FCF_TPCARGA_CODIGO,
       CC.SLF_TPFRETE_CODIGO,
       (SELECT COUNT(*)
        FROM TDVADM.T_SLF_TABELA TA,
             TDVADM.T_SLF_CALCFRETEKM KM
        WHERE TA.SLF_TABELA_CODIGO = KM.SLF_TABELA_CODIGO
          AND TA.SLF_TABELA_SAQUE = KM.SLF_TABELA_SAQUE
          AND TA.SLF_TABELA_CONTRATO = CC.SLF_CONTRATO_CODIGO
          AND TA.GLB_GRUPOECONOMICO_CODIGO = CC.GLB_GRUPOECONOMICO_CODIGO
          AND TA.GLB_CLIENTE_CGCCPFCODIGO = CC.GLB_CLIENTE_CGCCPFCODIGO
          AND KM.SLF_CALCFRETEKM_TPFRETE = CC.SLF_TPFRETE_CODIGO)
FROM TDVADM.T_SLF_CLIENTECARGAS CC
WHERE CC.SLF_CLIENTECARGAS_ATIVO = 'S'
  AND CC.SLF_CLIENTECARGAS_VIGENCIA = (SELECT MAX(CC1.SLF_CLIENTECARGAS_VIGENCIA)   
                                       FROM TDVADM.T_SLF_CLIENTECARGAS CC1
                                       WHERE CC1.GLB_GRUPOECONOMICO_CODIGO      = CC.GLB_GRUPOECONOMICO_CODIGO
                                         AND CC1.GLB_CLIENTE_CGCCPFCODIGO       = CC.GLB_CLIENTE_CGCCPFCODIGO
                                         AND CC1.SLF_CONTRATO_CODIGO            = CC.SLF_CONTRATO_CODIGO
                                         AND CC1.FCF_TPCARGA_CODIGO             = CC.FCF_TPCARGA_CODIGO
                                         AND CC1.FCF_TPCARGA_CODIGOPESQ         = CC.FCF_TPCARGA_CODIGOPESQ
                                         AND CC1.SLF_TPFRETE_CODIGO             = CC.SLF_TPFRETE_CODIGO
                                         AND CC1.SLF_CLIENTECARGAS_USAVEICULO   = CC.SLF_CLIENTECARGAS_USAVEICULO
                                         AND CC1.SLF_CLIENTECARGAS_USAFAIXAKM   = CC.SLF_CLIENTECARGAS_USAFAIXAKM)
