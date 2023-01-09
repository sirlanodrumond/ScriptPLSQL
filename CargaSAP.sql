-- Dados Basicos Proprietrio Cavalo
select *
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Dados Basicos Proprietrio Carreta
select *
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Dados Basicos Motoristas
select *
from tdvadm.v_car_motoristasdadosbasico p
where p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
;

-- Impostos Proprietario do Cavalo
-- IR
select p."Nº sistema externo",
       'IC'	"Categoria",
       'R5'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- IR
select p."Nº sistema externo",
       'IC'	"Categoria",
       'R5'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- INSS
select p."Nº sistema externo",
       'IN'	"Categoria",
       'NI'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- INSS
select p."Nº sistema externo",
       'IN'	"Categoria",
       'N1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Sest Senat
select p."Nº sistema externo",
       'Z1'	"Categoria",
       'Z1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- Sest Senat
select p."Nº sistema externo",
       'Z1'	"Categoria",
       'Z1'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- INSS Patronal
select p."Nº sistema externo",
       'IN'	"Categoria",
       'N3'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigo
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
-- Imposto Proprietrio Carreta
-- INSS Patronal
select p."Nº sistema externo",
       'IN'	"Categoria",
       'N3'	"Codigo",
       null	Sujeito
from tdvadm.v_car_proprietariodadosbasico p
where p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
;


select p."Nº sistema externo",
       'Z001' "Tipo de identificação",
       tc.car_carreteiro_cnhcodigo "Nº de identificação",
       'DETRAN' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       tc.car_carreteiro_cnhvecto "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and nvl(tc.car_carreteiro_cnhvecto,trunc(sysdate)) > trunc(sysdate)
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z001' "Tipo de identificação",
       tc.car_carreteiro_cnhcodigo "Nº de identificação",
       'DETRAN' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       tc.car_carreteiro_cnhvecto "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and nvl(tc.car_carreteiro_cnhvecto,trunc(sysdate)) > trunc(sysdate)
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z002' "Tipo de identificação",
       tc.car_carreteiro_mop "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z002' "Tipo de identificação",
       tc.car_carreteiro_mop "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z003' "Tipo de identificação",
       'CARGA INDIVISIVEL' "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z003' "Tipo de identificação",
       'CARGA INDIVISIVEL' "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z004' "Tipo de identificação",
       'ATESTADO' "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z004' "Tipo de identificação",
       'ATESTADO' "Nº de identificação",
       'DELLA VOLPE' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_mop is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z005' "Tipo de identificação",
       tp.car_proprietario_inps_codigo "Nº de identificação",
       'INSS' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."Nº sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_inps_codigo is not null
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z005' "Tipo de identificação",
       tp.car_proprietario_inps_codigo "Nº de identificação",
       'INSS' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."Nº sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_inps_codigo is not null
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z006' "Tipo de identificação",
       tp.car_proprietario_rgcodigo "Nº de identificação",
       'SSP-' || tp.glb_estadorg_codigo "Instituição responsável",
       tp.car_proprietario_rgemissao "Data da entrada",
       null "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."Nº sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_rgcodigo is not null
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z006' "Tipo de identificação",
       tc.car_carreteiro_rgcodigo "Nº de identificação",
       'SSP' || tc.glb_estadorg_codigo "Instituição responsável",
       null "Data da entrada",
       null "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_rgcodigo is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z007' "Tipo de identificação",
       tp.car_proprietario_cgccpfcodigo "Nº de identificação",
       'RF' "Instituição responsável",
       null "Data da entrada",
       null "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_proprietario tp
where 0 = 0
  and p."Nº sistema externo" = tp.car_proprietario_cgccpfcodigo
  and tp.car_proprietario_cgccpfcodigo is not null
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z007' "Tipo de identificação",
       tc.car_carreteiro_cpfcodigo "Nº de identificação",
       'RF' "Instituição responsável",
       null "Data da entrada",
       null "Início de validade",
       null "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.car_carreteiro_cpfcodigo is not null
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
                                 from tdvadm.t_con_valefrete vf
                                 where vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z008' "Tipo de identificação",
       tc.Car_Carreteiro_Prontuariocodig "Nº de identificação",
       'DETRAN' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       NULL "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_proprietariodadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.Car_Carreteiro_Prontuariocodig IS NOT NULL
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select v.car_proprietario_cgccpfcodigoc
                                 from tdvadm.t_con_valefrete vf,
                                      tdvadm.t_car_veiculo v
                                 where vf.con_valefrete_placa = v.car_veiculo_placa
                                   and vf.con_valefrete_placasaque = v.car_veiculo_saque
                                   and vf.con_valefrete_datacadastro >= '01/01/2016')
union
select p."Nº sistema externo",
       'Z008' "Tipo de identificação",
       tc.Car_Carreteiro_Prontuariocodig "Nº de identificação",
       'DETRAN' "Instituição responsável",
       sysdate "Data da entrada",
       sysdate "Início de validade",
       NULL "Fim de validade",
       'BR' "País",
       null "Região"
from tdvadm.v_car_motoristasdadosbasico p,
     tdvadm.t_car_carreteiro tc
where 0 = 0
  and p."Nº sistema externo" = tc.car_carreteiro_cpfcodigo
  and tc.Car_Carreteiro_Prontuariocodig IS NOT NULL
  and tc.car_carreteiro_saque = (select max(tc1.car_carreteiro_saque)
                                 from tdvadm.t_car_carreteiro tc1
                                 where tc1.car_carreteiro_cpfcodigo =  tc.car_carreteiro_cpfcodigo)
  and p."Nº sistema externo" in (select vf.con_valefrete_carreteiro
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
