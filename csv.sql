29/08 11:15
select br.glb_benasserec_chave protocolo,
       br.glb_benasserec_assunto,
       br.glb_benasserec_gravacao enviado,
       br.glb_benasserec_origem remetente,
       br.glb_benasserec_fileanexoorig anexoori,
       br.glb_benasserec_fileanexo anexo,
       br.glb_benasserec_processado processado,
       br.glb_benasserec_status status,
       br.glb_benasserec_fileanexo anexo
from rmadm.t_glb_benasserec br
where trunc(br.glb_benasserec_gravacao) >= to_date('28/08/2020','dd/mm/yyyy')
--  AND BR.GLB_BENASSEREC_CHAVE = 1222443 
  and br.glb_benasserec_assunto like 'MSG=PROCINCTAB%'
order by 1
FOR UPDATE



to_date(SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAI'),'dd/mm/yyyy hh24:mi:ss')

1222443  
1222700

SELECT *
from rmadm.t_glb_benasserec br
where trunc(br.glb_benasserec_gravacao) >= to_date('28/08/2020','dd/mm/yyyy')
--  AND BR.GLB_BENASSEREC_CHAVE = 1222443 
  and br.glb_benasserec_assunto like 'MSG=PROCINCTAB%'
--  AND BR.GLB_BENASSEREC_STATUS = 'OK'
order by 1
FOR UPDATE;

TDVADM.



--DELETE TDVADM.T_SLF_CALCFRETEKM KM
select ta.fcf_tpcarga_codigo,km.Slf_Reccust_Codigo,count(*)
from  TDVADM.T_SLF_CALCFRETEKM KM,
      TDVADM.T_SLF_TABELA TA  
WHERE 0 = 0
  and km.slf_tabela_codigo = ta.slf_tabela_codigo
  and km.slf_tabela_saque = ta.slf_tabela_saque
  and TA.SLF_TABELA_CONTRATO = 'C4600005631'
  and TA.SLF_TABELA_VIGENCIA = '28/08/2020'
group by ta.fcf_tpcarga_codigo,km.Slf_Reccust_Codigo
COMMIT;

tdvadm.pkg_edi_controle SP_BI_GLB_BENASSERECCSV
exec SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('SP_BI_GLB_BENASSERECCSV','N');

select SYS_CONTEXT('PROCESSOUNICO','SP_BI_GLB_BENASSERECCSV') proc,
       SYS_CONTEXT('PROCESSOUNICO','vTABFRETETAB') arquivo,
       SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAI') horai,
       tdvadm.fn_calcula_tempodecorrido(to_date(SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAI'),'dd/mm/yyyy hh24:mi:ss'),
                                        to_date(nvl(trim(SYS_CONTEXT('PROCESSOUNICO','vTABFRETEHORAF')),sysdate),'dd/mm/yyyy hh24:mi:ss'),
                                        'H') TEMPOGASTO,
       tdvadm.f_mascara_valor(SYS_CONTEXT('PROCESSOUNICO','vTABFRETEQTDEREG'),15,0) PROCESSADO,
       tdvadm.f_mascara_valor(SYS_CONTEXT('PROCESSOUNICO','vTABFRETETOTREG'),15,0) TOTAL
from dual;


      SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETEHORAI',TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI:SS'));
      SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETEHORAF','');
      SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETETOTREG','0');
      SYSTEM.pkg_glb_context.sp_set_vlr_PROCESSOUNICO('vTABFRETEQTDEREG','0');


select x.contrato,x.vigencia,X.CODCARGA,x.carga,X.CODVEICULO,x.veiculo,X.TPORIGEM,X.TPDESTINO,X.DES,X.CODCARGA, count(*) qtde
from tdvadm.v_Slf_Calcfretekmpreimpcsv x
where x.planilha in ('200828093457052.csv','200828165047035.csv')
group by x.contrato,x.vigencia,X.CODCARGA,x.carga,X.CODVEICULO,x.veiculo,X.TPORIGEM,X.TPDESTINO,X.DES,X.CODCARGA


SELECT *
FROM TDVADM.T_SLF_CALCFRETEKM KM
WHERE (KM.SLF_TABELA_CODIGO,
       KM.SLF_TABELA_SAQUE) IN (SELECT TA.SLF_TABELA_CODIGO,
                                       TA.SLF_TABELA_SAQUE
                                FROM TDVADM.T_SLF_TABELA TA
                                WHERE TA.SLF_TABELA_CONTRATO = 'C4600005631'
                                  AND TA.SLF_TABELA_VIGENCIA = '28/08/2020') 
                              
tdvadm.pkg_edi_controle

select distinct 
                           s.CODTPORIGEM,
                           s.CODTPDESTINO,
                           s.CODCARGA,
                           rpad(trim(s.CODVEICULO),3) CODVEICULO,
                           s.DES,
                           s.CODVERBA
                      from tdvadm.v_slf_calcfretekmpreimpcsv s
                     where s.CODVERBA = 'D_PD'
                     and s.CARGA <> 'CARGA'
                     AND S.planilha in ('200828093457052.csv')
                     
      
