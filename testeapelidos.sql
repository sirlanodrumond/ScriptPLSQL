select c.frt_conjveiculo_codigo,
       c.frt_conjunto_apdotracao,
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
          and tv.frt_tpveiculo_tracao = 'S') marcamod,

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
             and vf.con_valefrete_datacadastro >= '01/01/2017')

select c.frt_conjveiculo_codigo,
       c.frt_conjunto_apdotracao,
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
                                        and tv1.frt_tpveiculo_tracao <> 'S')) marcamodeng1,

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
                                        and tv1.frt_tpveiculo_tracao <> 'S')) apeng1
from tdvadm.t_frt_conjunto c
where substr(c.frt_conjveiculo_codigo,1,3) = '000'
  and 0 < (select count(*)
           from tdvadm.t_con_valefrete vf
           where vf.con_valefrete_placa = c.frt_conjveiculo_codigo
             and vf.con_valefrete_datacadastro >= '01/01/2017')
              



              

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
                                        and tv1.frt_tpveiculo_tracao <> 'S')


select *
from fpw.funciona f
where upper(f.funomfunc) like '%MARIANA%'



select *
from tdvadm.t_frt_conjunto ce
where ce.frt_conjveiculo_codigo = '0001608'


select *
from tdvadm.t_frt_marmodveic mm
where mm.frt_marmodveic_codigo = '000107'; 
select *
from tdvadm.t_frt_marcmodapelido mm
where mm.frt_marmodveic_codigo = '000107';


