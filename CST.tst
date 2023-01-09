PL/SQL Developer Test script 3.0
44
-- Created on 11/04/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer := 0;
begin
  -- Test statements here
  
  
  for c_msg in (select c.con_conhecimento_dtembarque,
                       c.con_conhecimento_codigo,
                       c.con_conhecimento_serie,
                       c.glb_rota_codigo,
                       c.con_conhecimento_cst cstTAB,
                       (select cxml.con_conhecimento_cst
                        from tdvadm.V_CTE_INFCONHECIMENTO cxml
                        where cxml.con_conhecimento_codigo = c.con_conhecimento_codigo
                          and cxml.glb_rota_codigo = c.glb_rota_codigo) cstSefaz,
                       (select idf.stc_codigo
                        from synchro.cor_dof dof,
                             synchro.cor_idf idf
                        where dof.dof_sequence = idf.dof_sequence
                          and dof.tdv_sistema_origem = c.con_conhecimento_codigo || c.con_conhecimento_serie || c.glb_rota_codigo) CSTSYNCHRO,
                       cf.rowid cRowid
                from tdvadm.t_con_conhecimento c,
                     tdvadm.t_con_conheccfop cf
                where 0 = 0
                  and c.con_conhecimento_dtembarque >= '01/01/2021'
                  and c.con_conhecimento_codigo = cf.con_conhecimento_codigo
                  and c.con_conhecimento_serie = cf.con_conhecimento_serie
                  and c.glb_rota_codigo = cf.glb_rota_codigo
                  and cf.con_conhecimento_cst is null)
  Loop
     update tdvadm.t_con_conheccfop cf
     set cf.con_conhecimento_cst = c_msg.csttab,
         cf.con_conhecimento_cstsefaz = c_msg.cstsefaz,
         cf.cor_idf_stc_codigo = c_msg.CSTSYNCHRO
     where cf.rowid = c_msg.cRowid;
     i := i + 1;
     If mod(i,50) = 0 Then
        Commit;
     End If;
  End Loop;                

end;
0
0
