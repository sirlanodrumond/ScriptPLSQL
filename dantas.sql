select * from tdvipf.v_ipf_valesfrete v
where v.codigo_CTE in ('002924','001913','001004','000286')
  and v.rota_CTE = '062';

SEELCT * FROM TDVADM.V_CTB_CENTROCUSTOANALITICO C;
           
select * from dba_source s where lower(s.TEXT) like '%ctb_movimentooc_cargacol%'

SELECT * FROM tdvipf.T_IPF_RECCUST_ROTA_CATEGORIA c
where c.glb_rota_codigo = '062';


select * from tdvipf.v_ipf_conhecimento x
where to_char(x.EMBARQUE,'YYYYMM') = '201804'
  and 0 = (select COUNT(*)
           from tdvipf.v_ipf_valesfrete v
           where v.CODIGO_cte = x.CODIGO
             and v.serie_CTE = x.SERIE
             and v.rota_CTE = x.ROTA);

select * from tdvipf.T_ipf_log;
select count(*)
from tdvipf.t_ipf_reccust_diretos d
where 0 = 0             
  and d.con_conhecimento_referencia = '201804';
  

--  delete tdvipf.T_ipf_log i where i.ipf_log_referencia = '201804';
--  DELETE tdvipf.T_IPF_RECCUST_DIRETOS CD WHERE CD.CON_CONHECIMENTO_REFERENCIA = '201804';
--  insert into tdvipf.T_ipf_log values ('201804',1,'CARREGA CONHECIMENTOS COM VALES DE FRETE VINCULADOS.',sysdate,null);
--  Commit;
--  exec tdvipf.pkg_reccust_diretos.SP_CARREGA_RECCUST('01/04/2018','30/04/2018');     -- CARREGA CONHECIMENTOS COM VALES DE FRETE VINCULADOS.
--  update tdvipf.T_ipf_log lo set lo.ipf_log_fim = sysdate where lo.ipf_log_referencia = '201804' and lo.ipf_log_processo = 1;
--  commit;
  

  
select * from tdvipf.t_ipf_log l


select x.ARMAZEM_ATUAL,x.ALMOX,count(*) from tdvadm.v_arm_notasarmazens_online x
group by x.ARMAZEM_ATUAL,x.ALMOX


-- Tem na producao e nao tem no Roberto
select c.con_conhecimento_dtembarque dtembarque,
       c.con_conhecimento_codigo cte,
       c.con_conhecimento_serie sr,
       c.glb_rota_codigo rota,
       tdvadm.pkg_slf_utilitarios.fn_retorna_contrato(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo) contrato,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_TTPV') valor,
       to_char(c.con_conhecimento_dtembarque,'YYYYMM') refcte,
       (select min(to_char(vfc.con_vfreteconhec_dtgravacao,'yyyymm'))
        from tdvadm.t_con_vfreteconhec vfc
        where vfc.con_conhecimento_codigo = c.con_conhecimento_codigo
          and vfc.con_conhecimento_serie = c.con_conhecimento_serie
          and vfc.glb_rota_codigo = c.glb_rota_codigo) refvf,
        C.CON_CONHECIMENTO_PLACA PLACA
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_dtembarque >= '01/01/2018'
  and c.con_conhecimento_dtembarque < '01/05/2018'
  and c.con_conhecimento_flagcancelado is null
  and c.con_conhecimento_serie <> 'XXX'
  and 0 = (select count(*)
           from tdvipf.t_ipf_reccust_diretos d
           where 0 = 0
--             and d.con_conhecimento_referencia = to_char(c.con_conhecimento_dtembarque,'YYYYMM')
             and d.con_conhecimento_codigo = c.con_conhecimento_codigo
             and d.con_conhecimento_serie = c.con_conhecimento_serie
             and d.glb_rota_codigo_conhecimento = c.glb_rota_codigo);



-- Comparando com a Contabilidade
select c.con_conhecimento_dtembarque,
       c.con_conhecimento_codigo cte,
       c.con_conhecimento_serie sr,
       c.glb_rota_codigo rota,
       tdvadm.pkg_slf_utilitarios.fn_retorna_contrato(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo) contrato,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_TTPV') valor
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_dtembarque >= '01/04/2018'
  and c.con_conhecimento_dtembarque < '01/05/2018'
  and c.con_conhecimento_flagcancelado is null
  and c.con_conhecimento_serie <> 'XXX'
  and 0 = (select count(*)
           from tdvadm.t_con_conhecctb d
           where d.con_conhecimento_codigo = c.con_conhecimento_codigo
             and d.con_conhecimento_serie = c.con_conhecimento_serie
             and d.glb_rota_codigo = c.glb_rota_codigo);
--  and tdvadm.pkg_slf_utilitarios.fn_retorna_contrato(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo) = 'MRO-RAIZEN-0119-XXX'


-- selecao do Roberto
SELECT C.CON_CONHECIMENTO_CODIGO                               CODIGO,
       C.CON_CONHECIMENTO_SERIE                                SERIE,
       C.GLB_ROTA_CODIGO                                       ROTA,
       TRUNC(C.CON_CONHECIMENTO_DTEMBARQUE)                    EMBARQUE,
       TRUNC(C.CON_CONHECIMENTO_ENTREGA)                       ENTREGA,
       C.GLB_LOCALIDADE_CODIGOORIGEM                           ORIGEM,
       C.GLB_LOCALIDADE_CODIGODESTINO                          DESTINO,
       C.GLB_CLIENTE_CGCCPFSACADO                              SACADO,
       tdvipf.PKG_RECCUST_DIRETOS.FN_BUSCA_DESC_SLF(C.SLF_SOLFRETE_CODIGO,C.SLF_SOLFRETE_SAQUE) DESC_SLF,
       TRIM(TDVADM.PKG_SLF_UTILITARIOS.FN_RETORNA_CONTRATO(C.CON_CONHECIMENTO_CODIGO,
                                                           C.CON_CONHECIMENTO_SERIE,
                                                           C.GLB_ROTA_CODIGO)) CONTRATO,
       tdvipf.pkg_reccust_diretos.FN_CALC_FRPSVO_SI(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO)  VALOR,
       NVL(ADVL.CON_CALCVIAGEM_VALOR,0)            VALOR_SEGURO,
       tdvipf.pkg_reccust_diretos.FN_CALC_PEDAGIO_SI(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO) VALOR_PEDAGIO,
       CTB.CON_CONHECCTB_VALOR_INSS                VALOR_INSS,
       CTB.CON_CONHECCTB_VALOR_ICMS                VALOR_ICMS,
       TDVADM.FN_BUSCAIDVIAGEMPETRANS(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO) IDVIAGEM,
       tdvadm.FN_TPCOLETA(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO) EXPRESSO,
       C.USU_USUARIO_SAIDA USUARIO
  FROM TDVADM.T_CON_CONHECCTB CTB,
       TDVADM.T_CON_CONHECIMENTO C,
       TDVADM.V_CON_I_ADVL ADVL
 WHERE C.CON_CONHECIMENTO_CODIGO    = CTB.CON_CONHECIMENTO_CODIGO
   AND C.CON_CONHECIMENTO_SERIE     = CTB.CON_CONHECIMENTO_SERIE
   AND C.GLB_ROTA_CODIGO            = CTB.GLB_ROTA_CODIGO
   AND ADVL.CON_CONHECIMENTO_CODIGO = CTB.CON_CONHECIMENTO_CODIGO
   AND ADVL.CON_CONHECIMENTO_SERIE  = CTB.CON_CONHECIMENTO_SERIE
   AND ADVL.GLB_ROTA_CODIGO         = CTB.GLB_ROTA_CODIGO
   AND NVL(CTB.CON_CONHECCTB_FLAGCANCELADO,'N') = 'N'
--   and ctb.con_conhecimento_codigo = '007216'
   AND TRUNC(C.CON_CONHECIMENTO_DTEMBARQUE) >= '01/04/2018'
   AND TRUNC(C.CON_CONHECIMENTO_DTEMBARQUE) <= '30/04/2018';

select *
from glbadm.v_job_parados



select M.CTB_MOVIMENTO_DOCUMENTO,
                              M.CTB_MOVIMENTO_DSEQUENCIA,
                              m.ctb_movimento_dtmovto,
                              m.ctb_movimento_origempr,
                              m.ctb_movimento_origem,
                              m.ctb_movimento_descricao,
                              m.ctb_movimento_origem,
                              m.ctb_movimento_origempr
                       from tdvadm.t_ctb_movimento m
                       where m.ctb_referencia_codigo_partida = '201708'
--                         and m.ctb_movimento_origempr in ('1','A')
                         and m.ctb_movimento_tvalor = 'C'
                         and substr(m.ctb_movimento_descricao,1,3) in ('CTe','NFS')
                         and m.ctb_pconta_codigo_partida not in ('441001000015','441001000025')
                         and m.ctb_movimento_descricao not like '%ICMS,%'
                         and m.ctb_movimento_descricao not like '%ICMS A%'
                         and m.ctb_movimento_descricao not like '%,ISS A%'
                         and m.ctb_movimento_descricao not like '%,FAT:%'
                         and m.ctb_movimento_descricao not like '%RET.ISS%'
                         and 0 = (select count(*)
                                  from tdvadm.t_ctb_movimentoOC m1
                                  where m1.ctb_movimento_documento = M.CTB_MOVIMENTO_DOCUMENTO
                                    and m1.ctb_movimento_dsequencia = M.CTB_MOVIMENTO_DSEQUENCIA
                                    and m1.ctb_movimento_dtmovto = m.ctb_movimento_dtmovto);
select * from tdvadm.t_ctb_origem;;


                                    
