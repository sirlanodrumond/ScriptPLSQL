PL/SQL Developer Test script 3.0
88
-- Created on 11/12/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vRowID rowid;
  vQtde   integer;
  vPesq varchar2(20);
begin
  -- Test statements here
  
/*
  
  select s.glb_testestr_id,
         s.glb_testedt_1,
         s.glb_testestr_1,
         s.glb_testestr_2,
         s.glb_testestr_3,
         s.glb_testestr_4,
         s.glb_testestr_5,
         s.glb_testestr_6,
         s.glb_testedt_2
   from tdvadm.t_glb_testestr s
    where s.glb_testestr_1 = 'CTE_CTB_NFAT';
*/    
  
  
  
    i := 0;
    delete tdvadm.t_glb_testestr s
    where s.glb_testestr_1 = 'CTE_CTB_NFAT';
    commit;
    for c_msg in (select rownum,
                         c.con_conhecimento_dtembarque,
                         c.con_conhecimento_codigo,
                         c.con_conhecimento_serie,
                         c.glb_rota_codigo
                  from tdvadm.t_con_conhecimento c
                  where 0 = 0
                  --  and c.con_conhecimento_dtembarque >= '01/01/2018'
                    and c.con_conhecimento_entrega is not null
                    and c.con_conhecimento_serie <> 'XXX'
--                    and c.con_conhecimento_codigo = '201710'
                    and c.con_conhecimento_flagcancelado is null
                    and c.con_fatura_codigo is null)
    Loop
      vPesq := '%' || c_msg.con_conhecimento_codigo || '-' || c_msg.glb_rota_codigo || ',FAT:%';
      vRowID := null;
      vQtde := 0;
      select max(rowid),
             count(*)
        into vRowID,
             vQtde
      from tdvadm.t_ctb_movimento m
      where m.ctb_movimento_dtmovto >= to_date('16/09/2019','dd/mm/yyyy')
        and m.ctb_pconta_codigo_partida = '110303131990'
        and m.ctb_movimento_descricao like vPesq;
--     If vQtde > 0 Then
        i := i + 1;
        insert into tdvadm.t_glb_testestr s
        (s.glb_testestr_id,
         s.glb_testedt_1,
         s.glb_testestr_1,
         s.glb_testestr_2,
         s.glb_testestr_3,
         s.glb_testestr_4,
         s.glb_testestr_5,
         s.glb_testestr_6,
         s.glb_testedt_2
        ) values
        (i,
         c_msg.con_conhecimento_dtembarque,
         'CTE_CTB_NFAT', 
         c_msg.con_conhecimento_codigo,
         c_msg.con_conhecimento_serie,
         c_msg.glb_rota_codigo,
         vQtde,
         vRowID,
         sysdate
        );
        commit;
        
--     End IF; 
        
      
    End Loop;
                
  
end;
0
4
vPesq
vRowID
vQtde
i 
