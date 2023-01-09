-- 576.238
select disponivel,
       cte,
       sr,
       rota,
       rotausu,
       usuario,
       tpimagem,
       localservidor,
       localservidor2,
       localimg,
       arquivo,
       'copy \\stnas01\Backups' || localimg || arquivo || ' \\tdvftp\conhecimento\?????????????????????.jpg' COPIA,    
       tam,
       tamcalc,
       dtpesquisaok
from (select ci.glb_compimagem_disponivel disponivel,
             ci.con_conhecimento_codigo cte,
             ci.con_conhecimento_serie sr,
             ci.glb_rota_codigo rota,
             u.glb_rota_codigo rotausu,
             u.usu_usuario_nome usuario,
             ci.glb_tpimagem_codigo tpimagem,
             ci.glb_compimagem_tamanho tam,
             ci.glb_compimagem_localservidor localservidor,
             replace('\imagens' || substr(ci.glb_compimagem_localservidor,instr(ci.glb_compimagem_localservidor,'\04\')),'\','/') localimg,
             ci.con_conhecimento_codigo || ci.con_conhecimento_serie || ci.glb_rota_codigo || ci.glb_grupoimagem_codigo || ci.glb_tpimagem_codigo || ci.glb_tparquivo_codigo || '.jpg' Arquivo,
             tdvadm.fn_tamarquivo( replace('\imagens' || substr(ci.glb_compimagem_localservidor,instr(ci.glb_compimagem_localservidor,'\04\')),'\','/'),
                                  ci.con_conhecimento_codigo || ci.con_conhecimento_serie || ci.glb_rota_codigo || ci.glb_grupoimagem_codigo || ci.glb_tpimagem_codigo || ci.glb_tparquivo_codigo || '.jpg') tamcalc,
             ci.glb_compimagem_localservidor2 localservidor2,
             ci.glb_compimagem_dtpesquisaok dtpesquisaok
      from tdvadm.t_glb_compimagem ci,
           tdvadm.t_usu_usuario u
      where ci.usu_usuario_codigoconf = u.usu_usuario_codigo
        and trunc(ci.glb_compimagem_disponivel) >= to_date('01/04/2020','dd/mm/yyyy')
        and ci.glb_compimagem_arquivado = 'S'
        and ci.glb_subgrupoimagem_codigo = '02'
        and 
      order by ci.glb_compimagem_disponivel desc)
  ;
  

      


select trunc(g.pesquisa) pesq,g.glb_grupoimagem_codigo, count(*)
from tdvadm.t_arq_gravados g
where 0 = 0
  and g.glb_grupoimagem_codigo = '04'
--  and trunc(g.pesquisa) >= to_date('01/10/2020','dd/mm/yyyy')
--  and g.diretorio not like '%/Recuperadas/%'
group by trunc(g.pesquisa),g.glb_grupoimagem_codigo
order by 1;

update tdvadm.t_slf_tabela ta set ta.slf_tabela_status = 'N' where ta.rowid = 'x';


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
/*  and (x.con_conhecimento_codigo,
       x.glb_rota_codigo) IN (SELECT X1.GLB_TESTESTR_3,
                                     X1.GLB_TESTESTR_4
                              FROM TDVADM.T_GLB_TESTESTR X1
                              WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002'
                                --and x1.glb_testestr_2 in ('202005','202006')
                                )
*/  and (x.con_conhecimento_codigo,
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




TDVADM.PKG_GLB_ROBOIMAGENS





SELECT distinct X1.GLB_TESTESTR_3,
                                             X1.GLB_TESTESTR_4
                                      FROM TDVADM.T_GLB_TESTESTR X1
                                      WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002' UNION
                                      SELECT '111859','170' from dual union
                                      SELECT '013901','740' from dual union
                                      SELECT '055983','460' from dual union
                                      SELECT '055984','460' from dual union
                                      SELECT '055985','460' from dual union
                                      SELECT '055986','460' from dual union
                                      SELECT '055987','460' from dual union
                                      SELECT '055988','460' from dual union
                                      SELECT '055993','460' from dual)


                                      SELECT '111859','170' from dual union
                                      SELECT '013901','740' from dual union
                                      SELECT '055983','460' from dual union
                                      SELECT '055984','460' from dual union
                                      SELECT '055985','460' from dual union
                                      SELECT '055986','460' from dual union
                                      SELECT '055987','460' from dual union
                                      SELECT '055988','460' from dual union
                                      SELECT '055993','460' from dual;
                                                                            
SELECT distinct X1.GLB_TESTESTR_3,
                X1.GLB_TESTESTR_4
FROM TDVADM.T_GLB_TESTESTR X1
WHERE X1.GLB_TESTESTR_1 = 'ACHAIMG1002'                                      
and (X1.GLB_TESTESTR_3,
     X1.GLB_TESTESTR_4) in (SELECT '111859','170' from dual union
                                      SELECT '013901','740' from dual union
                                      SELECT '055983','460' from dual union
                                      SELECT '055984','460' from dual union
                                      SELECT '055985','460' from dual union
                                      SELECT '055986','460' from dual union
                                      SELECT '055987','460' from dual union
                                      SELECT '055988','460' from dual union
                                      SELECT '055993','460' from dual)
                                      



tdvadm.pkg_fifo_carregctrc



select *
from tdvadm.t_arm_coletaocor o
where o.arm_coletaocor_codigo = '88'

select h.arm_coleta_ncompra,
       h.arm_coleta_ciclo,
       (select count(*) 
        from tdvadm.t_arm_nota an 
        where an.arm_coleta_ncompra = h.arm_coleta_ncompra 
          and an.arm_coleta_ciclo = h.arm_coleta_ciclo) nota,   
       h.arm_coleta_dtsolicitacao,
       h.arm_coleta_dtgravacao,
       h.arm_coleta_dtimp,
       h.arm_coleta_dtfechamento,
       h.arm_coleta_placa
from tdvadm.t_arm_coleta h
where 0 = 0
 and h.arm_coletaocor_codigo = '88'
  and h.arm_coleta_ciclo = '004'
--  and h.arm_coleta_ncompra in ('636704','632249','626995')
order by h.arm_coleta_ncompra,h.arm_coleta_sequencia

order by h.arm_coleta_dtsolicitacao desc;

  
tdvadm.pkg_fifo_carregctrc;
