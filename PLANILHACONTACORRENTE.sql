-- SIMULADOR
select s.dtincialded,
       trunc(s.dtData) data,
       trunc(s.dtvenc) VENC,
       s.motorista motorista,
       s.proprietario proprietario,
       s.veiculo veiculo,
       s.documento, 
       s.docref,
       s.car_contacorrente_valor * decode(s.car_contacorrente_tplancamento,'D',1,-1) valor,
       s.car_contacorrente_tplancamento tplanc,
       s.car_contacorrente_historico historico,
       s.car_contacorrente_obs obs
from tdvadm.V_CAR_CONTACORRENTEsimulador s
where 0 = 0
  and trim(s.cpncnpjprop) = ?
  and to_date(s.dtdata,'dd/mm/yyyy') >= to_date(decode(?,'01/01/2001',s.dtincialded,?),'dd/mm/yyyy');
  
  SELECT *
  FROM TDVADM.T_CON_VALEFRETE VF
  WHERE VF.CON_CONHECIMENTO_CODIGO = '117251'
    AND VF.GLB_ROTA_CODIGO = '421';
    
    select * from glbadm.v_job_rodando;
    select * from glbadm.v_job_todos x
    where upper(x.WHAT) like '%MAN%'
      and x.JOB = 192889;
    
    glbadm.PGK_GLB_MANUTENCAO.SP_MANUTENCAO_HORA
    
-- DUPLICIDADE
select cc.car_proprietario_cgccpfcodigo prop,
       cc.car_contacorrente_documento doc,
       sum(decode(cc.car_contacorrente_tplancamento,'D',cc.car_contacorrente_valor,0)) valorD,
       sum(decode(cc.car_contacorrente_tplancamento,'D',1,0)) qtdeD,
       sum(decode(cc.car_contacorrente_tplancamento,'C',cc.car_contacorrente_valor,0)) valorC,
       sum(decode(cc.car_contacorrente_tplancamento,'C',1,0)) qtdec
from tdvadm.t_car_contacorrente cc,
     tdvadm.t_car_proprietario p
where cc.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo
  and trunc(cc.car_contacorrente_data) >= trunc(p.car_proprietario_dtincialded)
  and cc.car_contacorrente_documento = cc.car_contacorrente_docref
group by cc.car_proprietario_cgccpfcodigo,
         cc.car_contacorrente_documento;


-- DATA INVERTIDA
select * from xlsuser.v_car_contacorrentexlsdtinv
select * from tdvadm.v_car_contacorrentedtinv;

-- COM FILTRO
select * from xlsuser.v_car_contacorrentexls;

SELECT * FROM WSERVICE.T_GLB_EMAILPEND


select * from tdvadm.v_slf_tabelakm k
where k.contrato = 'C2017070112'
  and k.verbacod like '%OT%'
  and k.codcarga = '24'
  
  ;
  
  select *
  from tdvadm.t_con_calcconhecimento c
  where c.con_conhecimento_codigo = '779622'
    and c.glb_rota_codigo = '060'
    and c.SLF_RECCUST_CODIGO in ('D_FRPSVO','D_OT2');


select c.con_conhecimento_dtembarque,c.*
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_codigo = '057978'
  and c.glb_rota_codigo = '610'
  and c.con_conhecimento_dtembarque >= '01/12/2019'
  ;
  select *
  from tdvadm.t_glb_rota r where r.glb_rota_codigo in ('610','620')
  
    
  select *
  from tdvadm.t_ctb_movimento m
  where m.ctb_movimento_descricao like '%057978%'
    and m.ctb_movimento_dtmovto >= '01/12/2019'
    ;
  select d.ctrl_situacao_dof from synchro.cor_dof d
  where d.tdv_sistema_origem = '057978A1610'
   
    
  select *
  from tdvadm.t_con_loggeracao lg
  where lg.arm_carregamento_codigo = '2473287'
  order by 1;
  
  SELECT CK.*,
         T.GLB_MERCADORIA_CODIGO,
         T.SLF_TABELA_COLETAENTREGA,
         T.SLF_TABELA_TIPO,
         T.FCF_TPVEICULO_CODIGO,
         T.FCF_TPCARGA_CODIGO,
         T.GLB_CLIENTE_CGCCPFCODIGO,
         T.GLB_GRUPOECONOMICO_CODIGO,
         T.SLF_TABELA_CONTRATO,
         1 vPESOCOBRADO,
         1 vFATORRATEIO,
         'OK' vRetorno,
         CK.ROWID
    FROM TDVADM.T_SLF_CALCFRETEKM CK, TDVADM.T_SLF_TABELA T
   WHERE 0 = 0
     AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
     AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE
     AND NVL(T.SLF_TABELA_STATUS, 'N') = 'N'
     AND T.SLF_TABELA_CONTRATO = 'C2017070112'
     AND T.GLB_GRUPOECONOMICO_CODIGO = '0619'
     AND CK.SLF_RECCUST_CODIGO in ('D_FRPSVO','D_OT2')
     AND T.SLF_TABELA_TIPO = 'FOB'
     AND nvl(T.SLF_TABELA_COLETAENTREGA, 'A') in ('N', 'A', 'C')
     AND round(29532, 0) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND
         CK.SLF_CALCFRETEKM_PESOATE
     AND TRIM(NVL(T.FCF_TPVEICULO_CODIGO, '9  ')) = '13'
     AND T.FCF_TPCARGA_CODIGO = '24'
     AND CK.SLF_CALCFRETEKM_ORIGEMI = '3518701'
     AND CK.SLF_CALCFRETEKM_DESTINOI = '3506508'
     AND T.SLF_TABELA_SAQUE =
         (SELECT MAX(T1.SLF_TABELA_SAQUE)
            FROM TDVADM.T_SLF_TABELA T1
           WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
             AND NVL(T1.SLF_TABELA_STATUS, 'N') = 'N'
             AND TO_DATE(T1.SLF_TABELA_VIGENCIA, 'DD/MM/YYYY') <=
                 TO_DATE(SYSDATE, 'DD/MM/YYYY'));
  
  
  
  tdvadm.pkg_edi_controle;
  
  SELECT COUNT(*)
  SELECT E.SLF_CLIREGRASEMAIL_EMAIL
  FROM TDVADM.T_SLF_CLIREGRASEMAIL E
  WHERE E.GLB_GRUPOECONOMICO_CODIGO = 'GRP'
    AND E.GLB_CLIENTE_CGCCPFCODIGO = 'CNPJ'
    AND E.SLF_CONTRATO_CODIGO = 'CONTRATO'
    AND E.SLF_CLIREGRASEMAIL_ATIVO = 'S';
    
    
  
select dba_source s where s.OWNER






            SELECT case when cpv.ind_contr_icms is not null and clv.inscr_estadual is not null then '1'
                        when cpv.ind_contr_icms is not null and (clv.inscr_estadual = 'ISENTO' or clv.inscr_estadual = '' or clv.inscr_estadual is null) then '2'
                        else '9'
                   end
            into   v_ind_dest_c500
            select cpv.pfj_codigo,count(*)
            FROM   synchro.cor_pessoa_vigencia             cpv,
                   synchro.cor_localidade_vigencia         clv
            WHERE  0 = 0
            and cpv.pfj_codigo in (select d.destinatario_pfj_codigo from synchro.cor_dof d where d.dt_fato_gerador_imposto >= '01/01/2020' and substr(d.tdv_sistema_origem,9,3) = '210')
            AND    cpv.pfj_codigo = clv.pfj_codigo
            and    cpv.dt_inicio <= '31/01/2020'
            and    (cpv.dt_fim >= '31/01/2020' or cpv.dt_fim is null)
            and    clv.dt_inicio <= '31/01/2020'
            and    (clv.dt_fim >= '31/01/2020' or clv.dt_fim is null)
            group by cpv.pfj_codigo
            having count(*) > 1
            
            
            
