create table tdvipf.t_ipf_valefrete20200814
as
select * from tdvipf.t_ipf_valefrete;

update tdvipf.t_ipf_valefrete v1
  set v1.ipf_valefrete_provbonus = 0;
commit;  

update tdvipf.t_ipf_valefrete v1
  set v1.ipf_valefrete_provbonus = tdvipf.pkg_reccust_diretos2019.FN_RETORNAVALORFRETEBONUS(v1.ipf_valefrete_codigo, 
                                                                                            v1.ipf_valefrete_serie,
                                                                                            v1.ipf_valefrete_rota,
                                                                                            v1.ipf_valefrete_saque,
                                                                                            v1.ipf_valefrete_frete,
                                                                                            tdvadm.VFPERCENT_CALC_BONUS,
                                                                                            'B2')
where (v1.ipf_valefrete_codigo,
       v1.ipf_valefrete_serie,
       v1.ipf_valefrete_rota,
       v1.ipf_valefrete_saque) in ( select v.ipf_valefrete_codigo,
                                           v.ipf_valefrete_serie,
                                           v.ipf_valefrete_rota,
                                           v.ipf_valefrete_saque     
                                    from tdvipf.t_ipf_valefrete v,
                                         tdvadm.t_con_valefrete vf
                                    where 0 = 0
                                      and v.ipf_valefrete_codigo = vf.con_conhecimento_codigo
                                      and v.ipf_valefrete_serie = vf.con_conhecimento_serie
                                      and v.ipf_valefrete_rota = vf.glb_rota_codigo
                                      and v.ipf_valefrete_saque = vf.con_valefrete_saque
                                      and vf.con_valefrete_saque = (select min(vf1.con_valefrete_saque)
                                                                    from tdvadm.t_con_valefrete vf1
                                                                    where vf1.con_conhecimento_codigo = vf.con_conhecimento_codigo
                                                                      and vf1.con_conhecimento_serie = vf.con_conhecimento_serie
                                                                      and vf1.glb_rota_codigo = vf.glb_rota_codigo
                                                                      and vf1.cax_boletim_data is not null)
                                    --  and trunc(vf.con_valefrete_datacadastro) >= to_date('01/01/2020')
                                      and instr(upper(nvl(vf.con_valefrete_condespeciais,'X')),'BONUS') > 0
                                      and v.con_catvalefrete_codigo not in ('08','18')
                                      and nvl(v.ipf_valefrete_provbonus,0) = 0
                                      and 0 = nvl((select count(*)
                                                   from tdvadm.t_con_valefrete vf1
                                                   where vf1.con_conhecimento_codigo = vf.con_conhecimento_codigo
                                                     and vf1.con_conhecimento_serie = vf.con_conhecimento_serie
                                                     and vf1.glb_rota_codigo = vf.glb_rota_codigo
                                                     and nvl(vf1.con_valefrete_status,'N') <> 'C'
                                                     and vf1.con_catvalefrete_codigo = '14'),0))
;
commit;
