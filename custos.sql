select *
from dba_source s
where s.owner = 'TDVIPF'
  and upper(s.TEXT) like '%T_SLF_PERCURSO%';
  
  select * from TDVIPF.v_IPF_RECCUST_DIRETOS
  
  select x.CON_VALEFRETE_KMCALCULO_SOMA,x.*
  from TDVIPF.T_IPF_RECCUST_DIRETOS x
  where x.con_valefrete_codigo = '146550'
    and x.glb_rota_codigo_valefrete = '060';
    

select VF.CON_CATVALEFRETE_CODIGO,VF.* from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo = '146550'
  and vf.glb_rota_codigo = '060';

select vf.con_conhecimento_codigo vfrete,
       vf.glb_rota_codigo rota,
       vf.con_valefrete_saque sq,
       vf.con_valefrete_placa placa,
       vf.con_catvalefrete_codigo categoria,
       vf.con_valefrete_datacadastro cadastro
from tdvadm.t_con_valefrete vf
where vf.con_valefrete_placa = '0002062'

  
  
      SELECT SUM(CASE WHEN NVL(DECODE(ABS(nvl(P.SLF_PERCURSO_KM,0))+nvl(P.SLF_PERCURSO_KM,0),0,0,nvl(P.SLF_PERCURSO_KM,0)),0) = 0 THEN NVL(VF.CON_VALEFRETE_KMPREVISTA,0) ELSE NVL(P.SLF_PERCURSO_KM,0) END)
      select vf.con_valefrete_placa,
             vf.con_valefrete_datacadastro viagem,
             (select max(vf1.con_valefrete_datacadastro)
              from tdvadm.t_con_valefrete vf1
              where vf1.con_valefrete_placa = vf.con_valefrete_placa
                AND VF.CON_CATVALEFRETE_CODIGO IN (SELECT RRC.CON_CATVALEFRETE_CODIGO 
                                                   FROM TDVIPF.T_IPF_RECCUST_ROTA_CATEGORIA RRC 
                                                   WHERE RRC.IPF_RECCUST_ROTA_CATEGORIA_RAT = 'S' 
                                                     AND RRC.GLB_ROTA_CODIGO = '060')) ultimavg,
             P.SLF_PERCURSO_KM,
             VF.CON_VALEFRETE_KMPREVISTA KMPREVISTA,
             VF.GLB_LOCALIDADE_CODIGOORI CODIGOORI,
             VF.GLB_LOCALIDADE_CODIGODES CODIGODES,
             TDVIPF.PKG_RECCUST_DIRETOS.FN_CALCULA_FIMVIAGEM_VF2('201702',
                                                                 VF.CON_CONHECIMENTO_CODIGO,
                                                                 VF.CON_CONHECIMENTO_SERIE,
                                                                 VF.GLB_ROTA_CODIGO,
                                                                 VF.CON_VALEFRETE_SAQUE) dtcalc
        FROM TDVADM.T_CON_VALEFRETE VF,
             TDVADM.T_CON_VFRETECONHEC VFC,
             TDVADM.T_SLF_PERCURSO P 
       WHERE VFC.CON_VALEFRETE_CODIGO          = VF.CON_CONHECIMENTO_CODIGO
         AND VFC.CON_VALEFRETE_SERIE           = VF.CON_CONHECIMENTO_SERIE
         AND VFC.GLB_ROTA_CODIGOVALEFRETE      = VF.GLB_ROTA_CODIGO
         AND VFC.CON_VALEFRETE_SAQUE           = VF.CON_VALEFRETE_SAQUE
         AND VF.CON_CONHECIMENTO_CODIGO        = '146550'
         AND VF.CON_CONHECIMENTO_SERIE         = 'A1'
         AND VF.GLB_ROTA_CODIGO                = '060'
         AND P.GLB_LOCALIDADE_CODIGOORIGEM(+)  = VF.GLB_LOCALIDADE_CODIGOORI
         AND P.GLB_LOCALIDADE_CODIGODESTINO(+) = VF.GLB_LOCALIDADE_CODIGODES
         AND NVL(VF.CON_VALEFRETE_STATUS,'N') = 'N'
         AND VF.CON_VALEFRETE_IMPRESSO = 'S'
         AND VF.CON_CATVALEFRETE_CODIGO IN (SELECT RRC.CON_CATVALEFRETE_CODIGO 
                                              FROM TDVIPF.T_IPF_RECCUST_ROTA_CATEGORIA RRC 
                                             WHERE RRC.IPF_RECCUST_ROTA_CATEGORIA_RAT = 'S' 
                                               AND RRC.GLB_ROTA_CODIGO = vf.glb_rota_codigo)
         AND TDVIPF.PKG_RECCUST_DIRETOS.FN_CALCULA_FIMVIAGEM_VF2('201702',
                                                                 vf.con_conhecimento_codigo,
                                                                 vf.con_conhecimento_serie,
                                                                 vf.glb_rota_codigo,
                                                                 VF.CON_VALEFRETE_SAQUE) IS NOT NULL -- NÃO CONSIDERAR VIAGENS INCOMPLETAS
                                     ;
  


exec TDVIPF.Pkg_Reccust_Diretos.SP_CALCULA('201701');
commit;
exec TDVIPF.Pkg_Reccust_Diretos.SP_CALCULA('201702');
commit;


    SELECT MIN((SELECT MIN(VF.CON_VALEFRETE_DATAEMISSAO-1) FV
              FROM TDVADM.T_CON_VALEFRETE VF 
             WHERE VF.CON_VALEFRETE_PLACA       = RCD.CON_VALEFRETE_PLACA
               AND VF.CON_VALEFRETE_DATAEMISSAO > RCD.CON_VALEFRETE_EMISSAO
               AND VF.CON_CATVALEFRETE_CODIGO  IN ('01','10'))) FIMVIAGEM 
--     SELECT RCD.CON_VALEFRETE_PLACA,RCD.CON_VALEFRETE_EMISSAO,RCD.CON_CATVALEFRETE_CODIGO,RCD.CON_CONHECIMENTO_REFERENCIA
      FROM TDVIPF.T_IPF_RECCUST_DIRETOS RCD
     WHERE RCD.CON_VALEFRETE_CODIGO         = '007216'
       AND RCD.CON_VALEFRETE_SERIE          = 'A1'
       AND RCD.GLB_ROTA_CODIGO_VALEFRETE    = '330'
       AND RCD.CON_VALEFRETE_SAQUE          = '1'
       AND RCD.CON_VALEFRETE_MOTORISTA_TIPO = 'F'
       AND RCD.CON_CONHECIMENTO_REFERENCIA  = '201701'      
 
  
select vf.con_conhecimento_codigo,
       vf.con_conhecimento_serie,
       vf.glb_rota_codigo,
       vf.con_valefrete_saque,
       vf.glb_localidade_codigoori,
       vf.glb_localidade_codigodes,
       (select p.slf_percurso_kmtdv
        from tdvadm.t_slf_percurso p
        where p.glb_localidade_codigoorigem = vf.glb_localidade_codigoori
          and p.glb_localidade_codigodestino = vf.glb_localidade_codigodes) km
from tdvadm.t_con_valefrete vf
where (vf.con_conhecimento_codigo,
       vf.con_conhecimento_serie,
       vf.glb_rota_codigo,
       vf.con_valefrete_saque) in (select distinct vfc1.con_valefrete_codigo,
                                                   vfc1.con_valefrete_serie,
                                                   vfc1.glb_rota_codigovalefrete,
                                                   vfc1.con_valefrete_saque
                                   from tdvadm.t_con_vfreteconhec vfc1
                                   where (vfc1.con_conhecimento_codigo,
                                          vfc1.con_conhecimento_serie,
                                          vfc1.glb_rota_codigo) in (select vfc.con_conhecimento_codigo,
                                                                           vfc.con_conhecimento_serie,
                                                                           vfc.glb_rota_codigo
                                                                   from tdvadm.t_con_vfreteconhec vfc
                                                                   where vfc.con_valefrete_codigo =  '007216'
                                                                     and vfc.glb_rota_codigovalefrete = '330'
                                                                     and vfc.con_valefrete_saque = '1'))
   
  

select *
from tdvadm.t_slf_percurso p
where p.glb_localidade_codigoorigem = '48990   '
  and p.glb_localidade_codigodestino = '08550   '
FOR UPDATE
  



SELECT P.SLF_PERCURSO_CODIGO CODPER,
       P.SLF_PERCUSO_DESCRICAO DESCRICAO,
       P.GLB_LOCALIDADE_CODIGOORIGEM ORIGEM,
       P.GLB_LOCALIDADE_CODIGODESTINO DESTINO,
       P.SLF_PERCURSO_KM KM,
       P.SLF_PERCURSO_FLAGCONS FLAGCONS,
       P.SLF_PERCURSO_DTATUALIZACAO DTATU
FROM TDVADM.T_SLF_PERCURSO P
--UPDATE TDVADM.T_SLF_PERCURSO P
--  SET P.SLF_PERCURSO_FLAGCONS = 'N',
--      P.SLF_PERCURSO_DTATUALIZACAO = NULL,
--      P.SLF_PERCURSO_KM = 0
WHERE P.SLF_PERCURSO_KM <= 0
  AND 0 < (SELECT COUNT(*)
           FROM TDVADM.T_CON_VALEFRETE VF
           WHERE VF.GLB_LOCALIDADE_CODIGOORI = P.GLB_LOCALIDADE_CODIGOORIGEM
             AND VF.GLB_LOCALIDADE_CODIGODES = P.GLB_LOCALIDADE_CODIGODESTINO
             AND VF.CON_VALEFRETE_DATACADASTRO >= '31/12/2016')
ORDER BY 5 DESC
             


SELECT *
FROM TDVADM.T_CON_VALEFRETE VF
WHERE VF.CON_VALEFRETE_DATACADASTRO >= '31/12/2016'
  AND VF.GLB_LOCALIDADE_CODIGOORI = '32000   '
  AND VF.GLB_LOCALIDADE_CODIGODES = '49000   '           
FOR UPDATE;

SELECT *
FROM TDVADM.T_SLF_PERCURSO P
WHERE P.GLB_LOCALIDADE_CODIGOORIGEM = '18138'
  AND P.GLB_LOCALIDADE_CODIGODESTINO = '18125'    
FOR UPDATE;
  
  

SELECT 

  
select c.con_conhecimento_codigo,
       c.con_conhecimento_serie,
       c.glb_rota_codigo,
       c.con_conhecimento_dtembarque,
       c.con_conhecimento_flagcancelado,
       c.con_conhecimento_placa,
       c.con_valefrete_codigo,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_PSCOBRAD') peso
from tdvadm.t_con_conhecimento c
where c.con_conhecimento_codigo = '826719'
  and c.con_conhecimento_serie = 'A1'
  and c.glb_rota_codigo = '197'
  
  A1197
;

select vf.con_conhecimento_codigo vfcodigo,
       vf.glb_rota_codigo vfrota,
       vf.con_valefrete_saque sq,
       vf.con_catvalefrete_codigo || '-' || cat.con_catvalefrete_descricao vfcat,
       vf.con_valefrete_datacadastro vfcad,
       vf.con_valefrete_pesoindicado vfpesoind,
       vf.con_valefrete_pesocobrado vfpesocob,
       vf.con_valefrete_placa vfplaca,
       vf.con_valefrete_impresso vfimp,
       vf.cax_boletim_data vfcaxia, 
       vf.glb_localidade_codigoori vforigem,
       vf.glb_localidade_codigodes vfdestino,
       tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(vf.glb_localidade_codigoori,vf.glb_localidade_codigodes) vfkm,
       c.con_conhecimento_codigo ctecodigo,
       c.glb_rota_codigo cterota,
       c.con_conhecimento_dtembarque cteemb,
       c.con_conhecimento_flagcancelado ctecanc,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_PSCOBRAD') I_PSCOBRAD,
       c.con_conhecimento_placa cteplaca
from tdvadm.t_con_vfreteconhec vfc,
     tdvadm.t_con_valefrete vf,
     tdvadm.t_con_conhecimento c,
     tdvadm.t_con_catvalefrete cat
where 0 = 0
  and vfc.con_conhecimento_codigo = '826719'
  and vfc.con_conhecimento_serie = 'A1'
  and vfc.glb_rota_codigo = '197'
  and vfc.con_valefrete_codigo = vf.con_conhecimento_codigo
  and vfc.con_valefrete_serie = vf.con_conhecimento_serie
  and vfc.glb_rota_codigovalefrete = vf.glb_rota_codigo
  and vfc.con_valefrete_saque = vf.con_valefrete_saque   
  and vf.con_catvalefrete_codigo = cat.con_catvalefrete_codigo
  and vfc.con_conhecimento_codigo = c.con_conhecimento_codigo
  and vfc.con_conhecimento_serie = c.con_conhecimento_serie
  and vfc.glb_rota_codigo = c.glb_rota_codigo     

999871A1197

select *
from tdvipf.t_ipf_conhec c
where c.ipf_conhec_codigo = '999871'
;
select * 
from tdvipf.t_ipf_valefrete vf
where vf.ipf_valefrete_chave = '824200A11971'
;

select *
from tdvipf.t_ipf_valefretecte c
where c.con_conhecimento_codigo = '999871';

select *
from tdvipf.v_ipf_reccust v
where v.ipf_conhec_chave = '999871 197'

select *
from tdvipf.t_ipf_reccust v
where v.ipf_conhec_chave = '999871A1197'

