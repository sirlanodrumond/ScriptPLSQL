PL/SQL Developer Test script 3.0
55
begin
  -- Call the procedure
  
  select n.arm_nota_numero,
         n.glb_cliente_cgccpfremetente,
         n.arm_nota_serie,
         n.arm_janelacons_sequencia
    into :pnota,
         :pcnpj,
         :pserie,
         :codjan
  from tdvadm.t_arm_nota n,
       tdvadm.t_arm_coleta c,
       tdvadm.t_arm_janelacons jc         
  where n.arm_nota_sequencia = :pSequencia
    and n.arm_janelacons_sequencia = jc.arm_janelacons_sequencia
    and n.arm_coleta_ncompra = c.arm_coleta_ncompra
    and n.arm_coleta_ciclo = c.arm_coleta_ciclo;
  
  pkg_slf_contrato.sp_getjanelanota(pnota => :pnota,
                                    pcnpj => :pcnpj,
                                    pserie => :pserie,
                                    pjanelaini => :pjanelaini,
                                    pjanelafim => :pjanelafim,
                                    pgeracte => :pgeracte);
                                    

    
  open :pcursor for select n.arm_nota_numero,
                           n.glb_cliente_cgccpfremetente,
                           n.arm_nota_serie,
                           n.slf_contrato_codigo contratocalc,
                           n.arm_nota_localcoletai coletacalc,
                           n.arm_nota_localentregai entregacal,
                           c.arm_coleta_entcoleta entcolcalc,
                           c.fcf_tpcarga_codigo cargacalc,
                           :pjanelaini janicalc,
                           :pjanelafim janfcalc,
                           jc.slf_contrato_codigo contratojan,
                           jc.arm_janelacons_coleta coletajan,
                           jc.arm_janelacons_entrega entregajan,
                           jc.arm_janelacons_entcol entcoljan,
                           jc.fcf_tpcarga_codigo cargajan,
                           jc.arm_janelacons_dtinicio janijan,
                           jc.arm_janelacons_dtfim janfjan
                    from tdvadm.t_arm_nota n,
                         tdvadm.t_arm_coleta c,
                         tdvadm.t_arm_janelacons jc         
                    where n.arm_nota_sequencia = :pSequencia
                      and n.arm_janelacons_sequencia = jc.arm_janelacons_sequencia
                      and n.arm_coleta_ncompra = c.arm_coleta_ncompra
                      and n.arm_coleta_ciclo = c.arm_coleta_ciclo;

                                  
end;
9
pSequencia
1
3858723
4
pnota
1
3264
4
pcnpj
1
09287895000161
5
pserie
1
021
5
pjanelaini
1
30/04/2019 16:00:01
12
pjanelafim
1
30/04/2019 22:00:00
12
pgeracte
1
A                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
codjan
1
1076807
5
pcursor
1
<Cursor>
116
0
