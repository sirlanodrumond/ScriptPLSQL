-- Dados Basicos Proprietrio Cavalo
select *
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Dados Basicos Proprietrio Carreta
select *
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Dados Basicos Motoristas
select *
from tdvadm.v_car_motoristasdadosbasico p
where p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
;

-- Impostos Proprietario do Cavalo
-- IR
select p."N� sistema externo",
       'IC'	"Categoria",
       'R5'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- IR
select p."N� sistema externo",
       'IC'	"Categoria",
       'R5'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- INSS
select p."N� sistema externo",
       'IN'	"Categoria",
       'NI'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- INSS
select p."N� sistema externo",
       'IN'	"Categoria",
       'N1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Sest Senat
select p."N� sistema externo",
       'Z1'	"Categoria",
       'Z1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- Sest Senat
select p."N� sistema externo",
       'Z1'	"Categoria",
       'Z1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- INSS Patronal
select p."N� sistema externo",
       'IN'	"Categoria",
       'N3'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- INSS Patronal
select p."N� sistema externo",
       'IN'	"Categoria",
       'N3'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
;


select p."N� sistema externo",
       'Z001' "Tipo de identifica��o",
       tc.car_carreteiro_cnhcodigo "N� de identifica��o",
       'DETRAN' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       tc.car_carreteiro_cnhvecto "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and nvl(tc.car_carreteiro_cnhvecto,trunc(sysdate)) > trunc(sysdate)
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z001' "Tipo de identifica��o",
       tc.car_carreteiro_cnhcodigo "N� de identifica��o",
       'DETRAN' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       tc.car_carreteiro_cnhvecto "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and nvl(tc.car_carreteiro_cnhvecto,trunc(sysdate)) > trunc(sysdate)
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z002' "Tipo de identifica��o",
       tc.car_carreteiro_mop "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z002' "Tipo de identifica��o",
       tc.car_carreteiro_mop "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z003' "Tipo de identifica��o",
       'CARGA INDIVISIVEL' "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z003' "Tipo de identifica��o",
       'CARGA INDIVISIVEL' "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z004' "Tipo de identifica��o",
       'ATESTADO' "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z004' "Tipo de identifica��o",
       'ATESTADO' "N� de identifica��o",
       'DELLA VOLPE' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z005' "Tipo de identifica��o",
       tp.car_proprietario_inps_codigo "N� de identifica��o",
       'INSS' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."N� sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_inps_codigo is not null
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z005' "Tipo de identifica��o",
       tp.car_proprietario_inps_codigo "N� de identifica��o",
       'INSS' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."N� sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_inps_codigo is not null
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z006' "Tipo de identifica��o",
       tp.car_proprietario_rgcodigo "N� de identifica��o",
       'SSP-' || tp.glb_estadorg_codigo "Institui��o respons�vel",
       tp.car_proprietario_rgemissao "Data da entrada",
       null "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."N� sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_rgcodigo is not null
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z006' "Tipo de identifica��o",
       tc.car_carreteiro_rgcodigo "N� de identifica��o",
       'SSP' || tc.glb_estadorg_codigo "Institui��o respons�vel",
       null "Data da entrada",
       null "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_rgcodigo is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z007' "Tipo de identifica��o",
       tp.car_proprietario_cgccpfcodigo "N� de identifica��o",
       'RF' "Institui��o respons�vel",
       null "Data da entrada",
       null "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."N� sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_cgccpfcodigo is not null
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z007' "Tipo de identifica��o",
       tc.car_carreteiro_cpfcodigo "N� de identifica��o",
       'RF' "Institui��o respons�vel",
       null "Data da entrada",
       null "In�cio de validade",
       null "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_cpfcodigo is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z008' "Tipo de identifica��o",
       tc.Car_Carreteiro_Prontuariocodig "N� de identifica��o",
       'DETRAN' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       NULL "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.Car_Carreteiro_Prontuariocodig IS NOT NULL
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."N� sistema externo",
       'Z008' "Tipo de identifica��o",
       tc.Car_Carreteiro_Prontuariocodig "N� de identifica��o",
       'DETRAN' "Institui��o respons�vel",
       sysdate "Data da entrada",
       sysdate "In�cio de validade",
       NULL "Fim de validade",
       'BR' "Pa�s",
       null "Regi�o"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."N� sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.Car_Carreteiro_Prontuariocodig IS NOT NULL
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."N� sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
;



select 'MNT-Proxima Manutencao' Relatorio,
       gp.usu_usuario_codigo usuario,
       gp.uti_geraplanilhausu_dtcad cadastro,
       gp.uti_geraplanilhausu_qtdeuso qtdeuso,
       gp.uti_geraplanilhausu_dtultuso dtultuso,
       sysdate dataatual
from tdvadm.t_uti_geraplanilhausu gp
where gp.uti_geraplanilha_codigo = 'manutkm';
