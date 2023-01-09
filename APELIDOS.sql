select c.frt_conjveiculo_codigo CONJUNTO,
       c.frt_conjunto_apdotracao TRACAO,
       (select count(*)
        from tdvadm.t_frt_conteng ce
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo) temengate,
       (select v.frt_veiculo_datavenda
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao = 'S') dtvenda,
       (select mm.frt_marmodveic_codigo || '-' || mm.frt_marmodveic_marca || '-' || mm.frt_marmodveic_modelo
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao = 'S') marcamodTRACAO,

       (select ap.frt_marcmodapelido_codigo || '-' || ap.frt_marcmodapelido_descricao
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao = 'S') aptrancao
from tdvadm.t_frt_conjunto c
where substr(c.frt_conjveiculo_codigo,1,3) = '000'
  and 0 < (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.con_valefrete_placa = c.frt_conjveiculo_codigo
             and vf.con_valefrete_datacadastro >= '01/01/2017');

select c.frt_conjveiculo_codigo CONJUNTO,
       c.frt_conjunto_apdocarreta1 CARRETA1,
       (select count(*)
        from tdvadm.t_frt_conteng ce
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo) temengate,
       (select v.frt_veiculo_datavenda
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select min(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) dtvendaeng1
           ,
       (select mm.frt_marmodveic_codigo || '-' || mm.frt_marmodveic_marca || '-' || mm.frt_marmodveic_modelo
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select min(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) marcamodCARRETA1,

       (select ap.frt_marcmodapelido_codigo || '-' || ap.frt_marcmodapelido_descricao
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select min(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) apCARRETA1
from tdvadm.t_frt_conjunto c
where substr(c.frt_conjveiculo_codigo,1,3) = '000'
  and 0 < (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.con_valefrete_placa = c.frt_conjveiculo_codigo
             and vf.con_valefrete_datacadastro >= '01/01/2017');
              

select c.frt_conjveiculo_codigo CONJUNTO,
       c.frt_conjunto_apdocarreta2 CARRETA2,
       (select count(*)
        from tdvadm.t_frt_conteng ce
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo) temengate,
       (select v.frt_veiculo_datavenda
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select max(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) dtvendaCARRETA2
           ,
       (select mm.frt_marmodveic_codigo || '-' || mm.frt_marmodveic_marca || '-' || mm.frt_marmodveic_modelo
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select max(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) marcamodCARRETA2,

       (select ap.frt_marcmodapelido_codigo || '-' || ap.frt_marcmodapelido_descricao
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = c.frt_conjveiculo_codigo
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select max(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S')) apCARRETA2
from tdvadm.t_frt_conjunto c
where substr(c.frt_conjveiculo_codigo,1,3) = '000'
  and 0 < (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.con_valefrete_placa = c.frt_conjveiculo_codigo
             and vf.con_valefrete_datacadastro >= '01/01/2017');

select ce.frt_conjveiculo_codigo conjunto,
       ce.frt_conjunto_apdotracao aptracao,
       ce.frt_conjunto_apdocarreta1 carreta1,
       ce.frt_conjunto_apdocarreta2 carreta2,
       ap.frt_apelido_descricao apconjunto,
       ap.fcf_tpveiculo_codigo tpveiccod,
       (select count(*)
        from tdvadm.t_frt_conteng ce1
        where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo) temengate,
       (select v.frt_veiculo_datavenda
        from tdvadm.t_frt_conteng ce1,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
          and ce1.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao = 'S') dtvenda,
       (select mm.frt_marmodveic_codigo || '-' || mm.frt_marmodveic_marca || '-' || mm.frt_marmodveic_modelo
        from tdvadm.t_frt_conteng ce1,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce1.frt_conjveiculo_codigo = ce.frt_conjveiculo_codigo
          and ce1.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao = 'S') marcamodTRACAO
from tdvadm.t_frt_conjunto ce,
     tdvadm.t_frt_apelido ap
where 0 = 0
--  and ce.frt_conjveiculo_codigo = '0001608'
  and nvl(ce.frt_conjunto_apdotracao,'00') || nvl(ce.frt_conjunto_apdocarreta1,'00') || nvl(ce.frt_conjunto_apdocarreta2,'00') = nvl(ap.frt_marcmodapelido_tracao (+),'00') || nvl(ap.frt_marcmodapelido_carreta1 (+),'00') || nvl(ap.frt_marcmodapelido_carreta2 (+),'00')
  and 0 < (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.con_valefrete_placa = ce.frt_conjveiculo_codigo
             and vf.con_valefrete_datacadastro >= '01/01/2017');



select mm.frt_marmodveic_codigo cod,
       mm.frt_marmodveic_marca marca,
       mm.frt_marmodveic_modelo modelo,
       mm.frt_marmodveic_capacidade_max capacidade,
       ma.frt_marcmodapelido_descricao apelido
from tdvadm.t_frt_marmodveic mm,
     tdvadm.t_frt_marcmodapelido ma
where mm. frt_marcmodapelido_codigo = ma.frt_marcmodapelido_codigo (+)
  and 0 < (select count(*)
           from tdvadm.t_frt_veiculo v
           where v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
             and v.frt_veiculo_datavenda is null);


select ap.frt_apelido_sequencia seq,
       ap.frt_marcmodapelido_tracao tracao,
       ap.frt_marcmodapelido_carreta1 carreta1,
       ap.frt_marcmodapelido_carreta2 carreta2,
       ap.frt_marcmodapelido_carreta3 carreta3,
       ap.frt_apelido_descricao descricao,
       ap.fcf_tpveiculo_codigo tpveiccod,
       tv.fcf_tpveiculo_descricao veiculodesc
from tdvadm.t_frt_apelido ap,
     tdvadm.t_fcf_tpveiculo tv
where ap.fcf_tpveiculo_codigo = tv.fcf_tpveiculo_codigo;
             
              


              

select *
        from tdvadm.t_frt_conteng ce,
             tdvadm.t_frt_veiculo v,
             tdvadm.t_frt_marmodveic mm,
             tdvadm.t_frt_marcmodapelido ap,
             tdvadm.t_frt_tpveiculo tv
        where ce.frt_conjveiculo_codigo = '0003286'
          and ce.frt_veiculo_codigo = v.frt_veiculo_codigo
          and v.frt_marmodveic_codigo = mm.frt_marmodveic_codigo
          and mm.frt_marcmodapelido_codigo = ap.frt_marcmodapelido_codigo (+)
          and mm.frt_tpveiculo_codigo  = tv.frt_tpveiculo_codigo
          and tv.frt_tpveiculo_tracao <> 'S'
          and v.frt_veiculo_codigo = (select min(v1.frt_veiculo_codigo)    
                                      from tdvadm.t_frt_conteng ce1,
                                           tdvadm.t_frt_veiculo v1,
                                           tdvadm.t_frt_marmodveic mm1,
                                           tdvadm.t_frt_tpveiculo tv1
                                      where ce1.frt_conjveiculo_codigo = '0003286'
                                        and ce1.frt_veiculo_codigo = v1.frt_veiculo_codigo
                                        and v1.frt_marmodveic_codigo = mm1.frt_marmodveic_codigo
                                        and mm1.frt_tpveiculo_codigo = tv1.frt_tpveiculo_codigo
                                        and tv1.frt_tpveiculo_tracao <> 'S');







select *
from fpw.funciona f
where upper(f.funomfunc) like '%MARIANA%'

select ce.frt_conjveiculo_codigo conjunto,
       ce.frt_conjunto_apdotracao aptracao,
       ce.frt_conjunto_apdocarreta1 carreta1,
       ce.frt_conjunto_apdocarreta2 carreta2
from tdvadm.t_frt_conjunto ce
where 0 = 0


select *
from tdvadm.t_frt_marmodveic mm
where mm.frt_marmodveic_codigo = '000107'; 
select *
from tdvadm.t_frt_marcmodapelido mm
where mm.frt_marmodveic_codigo = '000107';

  
