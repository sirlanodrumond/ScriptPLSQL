|QX 
select g.arquivo,count(*)
from tdvadm.t_arq_gravados g
group by g.arquivo
having count(*) > 1

select *
from T_EDI_IMAGEMLOADER x
where lower(x.edi_imagemloader_col01) like '%.jpg%'
  and lower(x.edi_imagemloader_col01) like '%recuperada%'

select *
from tdvadm.t_arq_gravados ag
  where trim(lower(ag.completo)) = 'x:\imagens\04\201106\001390a17400400010002.jpg'
  
-- 4.435.679  

-- 4.406.320
-- 4.411.542 - 5.222

select trunc(g.pesquisa) pesq,g.glb_grupoimagem_codigo, count(*)
from tdvadm.t_arq_gravados g
where 0 = 0
  and g.glb_grupoimagem_codigo = '04'
--  and trunc(g.pesquisa) >= to_date('01/10/2020','dd/mm/yyyy')
  and g.diretorio like '%/Recuperadas/%'
group by trunc(g.pesquisa),g.glb_grupoimagem_codigo
order by 1;

select * from tdvadm.t_edi_integracsv

select y.completo,
                       y.diretorio,
                       y.arquivo,
                       tdvadm.fn_tamarquivo(y.diretorio,y.arquivo) TAM
select count(*)
                from (select trim(replace(replace(substr(x.edi_integra_col01,3),'\','/'),chr(13),null)) completo,
                             '/'|| replace(substr(x.edi_integra_col01,4,instr(x.edi_integra_col01,'\',-1)-4),'\','/') || '/'  diretorio,
                             trim(replace(substr(x.edi_integra_col01,instr(x.edi_integra_col01,'\',-1) + 1),chr(13),null)) arquivo
                      from tdvadm.t_edi_integracsv x
                     ) y
where 0 = (select count(*)'2
           from tdvadm.t_arq_gravados ag
           where ag.completo = y.completo
             and trunc(ag.pesquisa) >= to_date('03/10/2020','dd/mm/yyyy'))
             
select * from tdvadm.v_lock_tables
  

select tdvadm.fn_tamarquivo(g.diretorio,g.arquivo) tam,
       g.* 
from tdvadm.t_arq_gravados g
where g.arquivo = '001390A17400400010002.jpg';

select y.completo,
       y.diretorio,
       y.arquivo,
       tdvadm.fn_tamarquivo(y.diretorio,y.arquivo) TAM
from (select trim(replace(substr(x.edi_integra_col01,3),'\','/')) completo,
             '/'|| replace(substr(x.edi_integra_col01,4,instr(x.edi_integra_col01,'\',-1)-4),'\','/') || '/'  diretorio,
             trim(replace(substr(x.edi_integra_col01,instr(x.edi_integra_col01,'\',-1) + 1),chr(13),null)) arquivo
      from tdvadm.t_edi_integracsv x
      where x.edi_integra_col01 like '%001390A17400400010002.jpg%'
     ) y

/imagens/04/201106/ - 001390A17400400010002.jpg
/imagens/04/201106/ - 001390A17400400010002.jpg


    records delimited by newline
    preprocessor 'append_filename.sh'
    fields terminated by ';'
    MISSING FIELD VALUES ARE NULL


wservice.pkg_con_nfsev50

select *
from tdvadm.t_glb_keyimagem k
where k.glb_grupoimagem_codigo = '04'
order by k.glb_grupoimagem_ordem

tdvadm.pkg_glb_roboimagens.sp_getimgctrc;



-- SELECT usado pelo ROBO
      select nvl(c.glb_compimagem_arquivado, 'N'),
             nvl(c.glb_compimagem_expirado, 'N'),
             trunc(c.glb_compimagem_dtgravacao),
             nvl(c.glb_compimagem_tamanho,-1),
             c.con_conhecimento_codigo,                            
             c.con_conhecimento_serie,                             
             c.glb_rota_codigo,                                    
             c.glb_grupoimagem_codigo,                             
             c.glb_tpimagem_codigo,                                
             c.glb_tparquivo_codigo,                               
             c1.con_conhecimento_dtembarque,                       
             c.glb_compimagem_tamanho tamanho,
             c.glb_compimagem_hash,
             c.glb_compimagem_hashb64  ,
             c.glb_compimagem_localservidor,
             c.glb_compimagem_disponivel                    
        from t_glb_compimagem c,                                   
             t_con_conhecimento c1                                 
       where 0=0
         and c.con_conhecimento_codigo = c1.con_conhecimento_codigo
         and c.con_conhecimento_serie = c1.con_conhecimento_serie  
         and c.glb_rota_codigo = c1.glb_rota_codigo
         and nvl(c.glb_compimagem_arquivado, 'N') != 'S'           
         and nvl(c.glb_compimagem_expirado, 'N') != 'S' 
         and nvl(c.glb_compimagem_tamanho,-1) > 0 
         and trunc(c.glb_compimagem_dtgravacao) >= trunc(sysdate-7)
   union
      select nvl(c.glb_compimagem_arquivado, 'N'),
             nvl(c.glb_compimagem_expirado, 'N'),
             trunc(c.glb_compimagem_dtgravacao),
             nvl(c.glb_compimagem_tamanho,-1),
             c.con_conhecimento_codigo,                            
             c.con_conhecimento_serie,                             
             c.glb_rota_codigo,                                    
             c.glb_grupoimagem_codigo,                             
             c.glb_tpimagem_codigo,                                
             c.glb_tparquivo_codigo,                               
             c1.con_conhecimento_dtembarque,                       
             c.glb_compimagem_tamanho tamanho,
             c.glb_compimagem_hash,
             c.glb_compimagem_hashb64  ,
             c.glb_compimagem_localservidor,
             c.glb_compimagem_disponivel                    
        from t_glb_compimagem c,                                   
             t_con_conhecimento c1                                 
       where 0=0
         and c.con_conhecimento_codigo = c1.con_conhecimento_codigo
         and c.con_conhecimento_serie = c1.con_conhecimento_serie  
         and c.glb_rota_codigo = c1.glb_rota_codigo
         and nvl(c.glb_compimagem_arquivado, 'N') != 'S'           
         and nvl(c.glb_compimagem_expirado, 'N') != 'S' 
         and nvl(c.glb_compimagem_tamanho,-1) > 0 
         and (c1.con_conhecimento_codigo,
              c1.glb_rota_codigo) IN (SELECT distinct X1.GLB_TESTESTR_3,
                                             X1.GLB_TESTESTR_4
                                      FROM TDVADM.T_GLB_TESTESTR X1
                                      WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002')


-- CONTAGEM DE QUANTO FALTA
      select c.con_conhecimento_codigo,                            
             c.con_conhecimento_serie,                             
             c.glb_rota_codigo,                                    
             COUNT(*) QTDE
        from t_glb_compimagem c,                                   
             t_con_conhecimento c1                                 
       where 0=0
         and c.con_conhecimento_codigo = c1.con_conhecimento_codigo
         and c.con_conhecimento_serie = c1.con_conhecimento_serie  
         and c.glb_rota_codigo = c1.glb_rota_codigo
         and nvl(c.glb_compimagem_arquivado, 'N') != 'S'           
         and nvl(c.glb_compimagem_expirado, 'N') != 'S' 
         and nvl(c.glb_compimagem_tamanho,-1) > 0 
         and (c1.con_conhecimento_codigo,
              c1.glb_rota_codigo) IN (SELECT distinct X1.GLB_TESTESTR_3,
                                             X1.GLB_TESTESTR_4
                                      FROM TDVADM.T_GLB_TESTESTR X1
                                      WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002')

GROUP BY c.con_conhecimento_codigo,                            
             c.con_conhecimento_serie,                             
             c.glb_rota_codigo



SELECT distinct X1.GLB_TESTESTR_3,
                X1.GLB_TESTESTR_4,
                (select count(*)
                 from tdvadm.t_glb_compimagem ci
                 where ci.con_conhecimento_codigo = x1.glb_testestr_3
                   and ci.glb_rota_codigo = x1.glb_testestr_4
                   and ci.glb_grupoimagem_codigo = '04'
                   and ci.glb_tpimagem_codigo = '0001'
                   and ci.glb_subgrupoimagem_codigo = '02'
                   ) qtdeFRENTE,
                (select count(*)
                 from tdvadm.t_glb_compimagem ci
                 where ci.con_conhecimento_codigo = x1.glb_testestr_3
                   and ci.glb_rota_codigo = x1.glb_testestr_4
                   and ci.glb_grupoimagem_codigo = '04'
                   and ci.glb_tpimagem_codigo = '0002'
                   and ci.glb_subgrupoimagem_codigo = '02'
                   ) qtdeVerso
FROM TDVADM.T_GLB_TESTESTR X1
WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002'
         

select x.gravacao,
       x.embarque,
       x.entrega,
       x.pesquisa,
       x.arquivado,
       x.con_conhecimento_codigo cte,
       x.con_conhecimento_serie sr,
       x.glb_rota_codigo rt,
       x.tpimg,
       x.glb_compimagem_localservidor localservidor,
       x.rotausu,
       x.dir1,
       x.servidor3,
       x.glb_compimagem_localservidor2 localservidor2,
       substr(x.dir2,1,instr(x.dir2,'/')-1) dir3,
       x.diretorio,
       x.arquivo,
       x.tamcalc,
       x.tamanhoci,
       x.tamanho,
       x.copia,
       'copy /y \\stnas01\Backups' || replace(x.diretorio || x.arquivo,'/','\') || ' *.jpg' copy2,
       x.glb_compimagem_hash,
       x.chave,
       'update tdvadm.t_glb_compimagem ci set ci.glb_compimagem_tamanho = ' || x.tamcalc || ' where ci.rowid = ' || '''' || x.chave || ''';' updci,
       'update tdvadm.t_arq_gravados ag set ag.arq_gravado_tamanho = ' || x.tamcalc || ' where ag.rowid = ' || '''' || x.chaveag || ''';' updag
from (Select ci.con_conhecimento_codigo,
             ci.con_conhecimento_serie,
             ci.glb_rota_codigo,
             u.glb_rota_codigo rotausu,
             ci.glb_compimagem_localservidor,
             nvl(ci.glb_compimagem_arquivado,'N') arquivado,
             trim(replace(substr(ci.glb_compimagem_localservidor,instr(ci.glb_compimagem_localservidor,'\04\')+4),'\','')) dir1,
             ci.glb_compimagem_localservidor2,
             'copy ' || replace(replace(ci.glb_compimagem_localservidor2,'/imagens/04','\\stnas01\Backups\imagens\04'),'/','\') servidor3,
             trim(replace(substr(ci.glb_compimagem_localservidor2,instr(ci.glb_compimagem_localservidor2,'/04/')+4),'\','')) dir2,
             ag.diretorio,
             ag.arquivo,
             'copy /y ' || replace('\\stnas01\Backups' || ag.diretorio || ag.arquivo || ' \\tdvftp\conhecimento\?????????????????????.jpg','/','\') COPIA,    
             ag.arq_gravado_tamanho tamanho,
             ci.glb_compimagem_tamanho tamanhoci,
             tdvadm.fn_tamarquivo(ag.diretorio,ag.arquivo) tamcalc,
             ci.glb_compimagem_hash,
             AG.PESQUISA,
             ci.glb_compimagem_dtgravacao gravacao,
             c.con_conhecimento_dtembarque embarque,
             c.con_conhecimento_entrega entrega,
             ci.glb_tpimagem_codigo tpimg,
             ci.rowid chave,
             ag.rowid chaveag
      from tdvadm.t_glb_compimagem ci,
           tdvadm.t_con_conhecimento c,
           tdvadm.t_usu_usuario u,
           tdvadm.t_arq_gravados ag
      where 0 = 0
--        and nvl(ci.glb_compimagem_arquivado,'N') = 'N'
--        and ( ag.diretorio is not null )
        and ci.usu_usuario_codigoconf = u.usu_usuario_codigo
--        and c.con_conhecimento_dtembarque >= '01/05/2020'
--        and c.con_conhecimento_entrega is null 
        and ci.con_conhecimento_codigo = c.con_conhecimento_codigo
        and ci.con_conhecimento_serie  = c.con_conhecimento_serie
        and ci.glb_rota_codigo         = c.glb_rota_codigo
        and ci.con_conhecimento_codigo || ci.con_conhecimento_serie || ci.glb_rota_codigo || ci.glb_grupoimagem_codigo || ci.glb_tpimagem_codigo || ci.glb_tparquivo_codigo = substr(ag.arquivo (+),1,21)
        and ci.con_conhecimento_codigo = ag.documento (+)
        and ci.con_conhecimento_serie  = ag.serie (+)
        and ci.glb_rota_codigo         = ag.rota (+)
        ) x
WHERE 0 = 0
  and (x.con_conhecimento_codigo,
       x.glb_rota_codigo) IN (SELECT X1.GLB_TESTESTR_3,
                                     X1.GLB_TESTESTR_4
                              FROM TDVADM.T_GLB_TESTESTR X1
                              WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002'
                                --and x1.glb_testestr_2 in ('202005','202006')
                                )
  and (x.con_conhecimento_codigo,
       x.glb_rota_codigo) IN (SELECT '111859','170' from dual union
                              SELECT '013901','740' from dual union
                              SELECT '055983','460' from dual union
                              SELECT '055984','460' from dual union
                              SELECT '055985','460' from dual union
                              SELECT '055986','460' from dual union
                              SELECT '055987','460' from dual union
                              SELECT '055988','460' from dual union
                              SELECT '055993','460' from dual)
--
  and nvl(x.tamanhoci,0) = 0 and x.pesquisa is not null
order by 4 desc
;
  
  select *
  from migdv.v_pessoassap p1
  where p1.TAB_CPF_CNPJ in (select x1.glb_testestr_2
                            from TDVADM.T_GLB_TESTESTR X1
                            where x1.glb_testestr_1 = 'MIGRACAO');

select distinct p.TIPO2
from migdv.v_pessoassap p
where p.DATA_CORTE >= '01/01/2019'
   or p.TIPO2 = 'A'
group by p.TAB_CPF_CNPJ
having count(*) > 1                            
                            
select p.TAB_CPF_CNPJ
from migdv.v_pessoassap p
where p.DATA_CORTE >= '01/01/2019'
group by p.TAB_CPF_CNPJ
having count(*) > 1                            
                    
        
  
select *
from migdv.vendor_s_suppl_gen
select *
from migdv.vend_ext_s_suppl_gen

;

for update
  




select x1.glb_testestr_1,
       x1.glb_testestr_2,
       x1.glb_testestr_3,
       x1.glb_testestr_4
FROM TDVADM.T_GLB_TESTESTR X1
where X1.GLB_TESTESTR_1 = 'ACHAIMG1002'
for update
  

select *
from tdvadm.t_glb_compimagem ci
where ci.con_conhecimento_codigo = '000003'
  and ci.glb_rota_codigo in ('011','610')
  and ci.glb_compimagem_arquivado = 'N'

update tdvadm.t_glb_compimagem ci set ci.glb_compimagem_tamanho = x where ci.con_conhecimento_codigo = 'v' and ci.glb_rota_codigo = 's' and ci.glb_grupoimagem_codigo = '04' and ci.glb_tpimagem_codigo = '';


SELECT distinct X1.GLB_TESTESTR_2 referencia,
       X1.GLB_TESTESTR_3 CTE,
       X1.GLB_TESTESTR_4 ROTA,
       x1.glb_testestr_5 ENCONTRADO,
       (select u.glb_rota_codigo || '|' || ci.usu_usuario_codigoconf || '|' || ci.glb_compimagem_dtconferencia
        from tdvadm.t_glb_compimagem ci,
             tdvadm.t_usu_usuario u
        where ci.con_conhecimento_codigo = X1.GLB_TESTESTR_3
          and ci.glb_rota_codigo = X1.GLB_TESTESTR_4
          and ci.usu_usuario_codigoconf = u.usu_usuario_codigo
          and ci.glb_tpimagem_codigo = '0001'
          and ci.glb_tparquivo_codigo = '0002') rota_Usuario_Data
FROM TDVADM.T_GLB_TESTESTR X1
WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG'
--  and x1.glb_testestr_2 in ('202005','202006')
--  and nvl(substr(x1.glb_testestr_5,1,1),'X') != 'F'
order by 5

SELECT DISTINCT X1.GLB_TESTESTR_2 REFERENCIA,
       X1.GLB_TESTESTR_3 CTE,
       X1.GLB_TESTESTR_4 ROTA,
       X1.GLB_TESTESTR_5 ENCONTRADO
FROM TDVADM.T_GLB_TESTESTR X1
WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG'
  and nvl(substr(x1.glb_testestr_5,1,1),'X') = 'F'
ORDER BY 1,3,2
                              
  select *
  from tdvadm.t_arq_gravados g
  where g.documento = '373838'


/NDL
    
