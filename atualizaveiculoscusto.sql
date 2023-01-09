
select * from "bw2hana"."/IMO/D_MD05"@TDHDSAPBW;
select * from "BW2HANA"."/IMO/D_MD05"@TDHDSAPS4;

select * from "/1LT/DSS4D000091"@TDHDSAPS4

select *
from dba_views v
where v.TEXT_VC like '%@%'
  and v.OWNER not in ('SYS')
  
  select *
  from tdvadm.v_kill_sessoes k
  where lower(k.OSUSER) like '%sirla%'
ALTER SYSTEM DISCONNECT SESSION '3484,46764' IMMEDIATE;
ALTER SYSTEM DISCONNECT SESSION '3931,2006' IMMEDIATE;
ALTER SYSTEM DISCONNECT SESSION '7863,35310' IMMEDIATE;

migdv.pkg_migracao_sap

"_SYS_BIC"."TDV.TDV_ORACLE/CV_MOTORISTA"@TDHDSAPBW;

select * from migdv.customer_s_address

select *
from sapbwtdv.cv_motorista


select * from synchro.cor_localidade_pessoa lp where lp.pfj_codigo in ('07410101000180', -- EMPREITEIRA R & C LTDA
                                                                       '19134703000130');-- FERNANDO BUENO FRANCISCO

select * from synchro.cor_pessoa p where p.pfj_codigo in ('07410101000180', -- EMPREITEIRA R & C LTDA
                                                          '19134703000130');-- FERNANDO BUENO FRANCISCO



select *
from tdvadm.t_car_veiculo v
where v.car_veiculo_placa in ('HRR1531','FSR7920','FWB7H20')

select * from tdvadm.t_fcf_tpveiculo tp where tp.fcf_tpveiculo_codigo in ('06','05')

select tpvc.car_tpveiculo_codigo,
       tpvc.car_tpveiculo_descricao,
       tpvc.car_tpveiculo_lotmax,
       tpvc.car_tpveiculo_tipo,
       tpvc.fcf_tpveiculo_codigo
from tdvadm.t_car_tpveiculo tpvc 
where 0 = 0
--  and tpvc.car_tpveiculo_codigo in ('10','16','37')
  and 0 = (select count(*)
           from tdvadm.t_fcf_tpveiculo tpv
           where tpv.fcf_tpveiculo_codigo = tpvc.fcf_tpveiculo_codigo)
--for update
  ;
select *
from tdvadm.t_fcf_tpveiculo tv
order by to_number(tv.fcf_tpveiculo_codigo);
select r.ipf_reccust_referencia,
       r.ipf_valefrete_chave,
       vf.con_valefrete_datacadastro,
       vf.con_valefrete_placa,
       vf.glb_tpmotorista_codigo,
       r.fcf_tpveiculo_codigocol,
       r.fcf_tpveiculo_codigo,
       r.fcf_tpveiculo_descricao,
       r.ipf_valefrete_eixos,
       (select v.car_tpveiculo_codigo
        from tdvadm.t_car_veiculo v
        where v.car_veiculo_placa = r.ipf_valefrete_placa
          and v.car_veiculo_saque = (select max(v1.car_veiculo_saque)
                                     from tdvadm.t_car_veiculo v1
                                     where v1.car_veiculo_placa = v.car_veiculo_placa)) tpveicarveic,
       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CAV'),'C') cavalo,
       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CAR'),'C') carreta1,
       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CA2'),'C') carreta2,
       tdvadm.pkg_frtcar_veiculo.FN_RETFCFTPVEICULO(vf.con_valefrete_placa,vf.con_valefrete_datacadastro) funcao
from tdvipf.v_ipf_reccust r,
     tdvadm.t_con_valefrete vf
where 0 = 0
--  and r.ipf_valefrete_chave = '136732A16201'
/*  
  and SUBSTR(r.ipf_valefrete_chave,1,11) in ('000002A1770','000003A1770','000005A1770','000015A1761','000016A1760','000025A1760','000036A1760',
                                             '000037A1760','000039A1760','000039A1761','000041A1760','000044A1760','000063A1760','000067A1760',
                                             '000071A1760','000072A1760','000075A1760','000077A1760','000087A1760','000096A1760','000108A1760')
*/ 
  and ( r.fcf_tpveiculo_descricao is null or trim(nvl(r.fcf_tpveiculo_codigo,'NE')) = 'NE' )
  and r.ipf_valefrete_chave = vf.con_conhecimento_codigo || vf.con_conhecimento_serie || vf.glb_rota_codigo || vf.con_valefrete_saque;

select *
from tdvipf.t_ipf_valefrete vf
where vf.ipf_valefrete_chave = '277933A10112'
  and vf.ipf_valefrete_placa = c_msg.con_valefrete_placa;

selec

select r.ipf_valefrete_placa,count(distinct SUBSTR(r.ipf_valefrete_chave,1,11)) qtdevales, count(*) qtdelinhas 
from tdvipf.v_ipf_reccust r,
                     tdvadm.t_con_valefrete vf
                where 0 = 0
--                  and r.ipf_valefrete_chave = '136732A16201'
                /*  and SUBSTR(r.ipf_valefrete_chave,1,11) in ('000002A1770','000003A1770','000005A1770','000015A1761','000016A1760','000025A1760','000036A1760',
                                                             '000037A1760','000039A1760','000039A1761','000041A1760','000044A1760','000063A1760','000067A1760',
                                                             '000071A1760','000072A1760','000075A1760','000077A1760','000087A1760','000096A1760','000108A1760')
                */  and ( r.fcf_tpveiculo_descricao is null or trim(nvl(r.fcf_tpveiculo_codigo,'NE')) = 'NE' )
                  and r.ipf_valefrete_codigo = vf.con_conhecimento_codigo
                  and r.ipf_valefrete_serie = vf.con_conhecimento_serie
                  and r.ipf_valefrete_rota = vf.glb_rota_codigo
                  and r.ipf_valefrete_saque = vf.con_valefrete_saque
group by r.ipf_valefrete_placa                  

select *
from tdvadm.t_frt_veiculo v
where v.frt_veiculo_placa = 'CMW8362';
select *
from tdvadm.t_car_veiculo v
where v.car_veiculo_placa = 'CMW8362';



           
select *
from tdvadm.
select * from tdvadm.t_fcf_tpveiculo;




select * from tdvadm.v_rh_doacoes x
where x.ANO = '2020'
select * from tdvadm.v_rh_compras x
where x.ANO = '2020'



select *
from tdvadm.t_glb_banco b
where upper(b.glb_banco_nome) like '%CITIBANK%';
select *
from tdvadm.t_glb_agencia a
where a.glb_agencia_numero = '0001'
  or upper(a.glb_agencia_nome) like '%TEMPORA%' for update;

select *
from tdvadm.t_cpg_borderos b
where b.cpg_borderos_data >= to_date('01/08/2021','dd/mm/yyyy')
  and b.glb_agencia_numero = '0001';
