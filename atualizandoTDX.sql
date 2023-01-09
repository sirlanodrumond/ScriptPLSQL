-- atualizando o TDX

/* -- Para inserir uma linha do BENASSE

insert into rmadm.t_glb_benasserec
select *
from rmadm.t_glb_benasserec@database_tdp br
where br.glb_benasserec_chave = &protocolo
  and 0 = (select count(*)
           from rmadm.t_glb_benasserec br1
           where br1.glb_benasserec_chave = br.glb_benasserec_chave);


insert into TDVADM.T_EDI_INTEGRA                                                                  
select *
from TDVADM.T_EDI_INTEGRA@database_tdp i
where i.edi_integra_protocolo = &protocolo
  and 0 = (select count(*)
           from tdvadm.t_edi_integra i2
           where i2.edi_integra_protocolo = i.edi_integra_protocolo
             and i2.edi_integra_sequencia = i.edi_integra_sequencia);
*/

-- CENTRO DE CUSTO
insert into tdvadm.t_glb_centrocusto 
select * from tdvadm.t_glb_centrocusto@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_centrocusto c
           where c.glb_centrocusto_codigo = c1.glb_centrocusto_codigo);
commit;


insert into tdvadm.t_glb_rota 
select * from tdvadm.t_glb_rota@database_tdp r1
where 0 = (select count(*)
           from tdvadm.t_glb_rota r
           where r.glb_rota_codigo = r1.glb_rota_codigo);

insert into tdvadm.t_glb_grupoeconomico 
select * from tdvadm.t_glb_grupoeconomico@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_grupoeconomico c
           where c.glb_grupoeconomico_codigo = c1.glb_grupoeconomico_codigo);
commit;

insert into tdvadm.t_slf_contrato 
select * from tdvadm.t_slf_contrato@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_slf_contrato c
           where c.slf_contrato_codigo = c1.slf_contrato_codigo);
commit;


insert into TDVADM.T_SLF_TPFRETE
SELECT * FROM TDVADM.T_SLF_TPFRETE@database_tdp R
WHERE 0 = (SELECT COUNT(*)
           FROM TDVADM.T_SLF_TPFRETE R1
           WHERE R1.SLF_TPFRETE_CODIGO = R.SLF_TPFRETE_CODIGO);
           

insert into tdvadm.t_glb_tpcarga 
select * from tdvadm.t_glb_tpcarga@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_tpcarga c
           where c.glb_tpcarga_codigo = c1.glb_tpcarga_codigo);

insert into tdvadm.t_fcf_tpcarga 
select * from tdvadm.t_fcf_tpcarga@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_fcf_tpcarga c
           where c.fcf_tpcarga_codigo = c1.fcf_tpcarga_codigo);

insert into tdvadm.t_fcf_limitecargas lc
select * from tdvadm.t_fcf_limitecargas@database_tdp d1
where 0 = (select count(*)
           from tdvadm.t_fcf_limitecargas d
           where d.fcf_tpcarga_codigo = d1.fcf_tpcarga_codigo);

insert into tdvadm.t_fcf_tpveiculo 
select * from tdvadm.t_fcf_tpveiculo@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_fcf_tpveiculo c
           where c.fcf_tpveiculo_codigo = c1.fcf_tpveiculo_codigo);
commit;


insert into tdvadm.t_glb_cliente 
select * from tdvadm.t_glb_cliente@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_cliente c
           where c.glb_cliente_cgccpfcodigo = c1.glb_cliente_cgccpfcodigo);
commit;

update tdvadm.t_glb_cliente cl
  set cl.glb_cliente_vlrlimite = 9999999999
where cl.glb_cliente_vlrlimite <> 9999999999;
commit;  

update tdvadm.t_glb_cliente cl
  set cl.glb_grupoeconomico_codigo = nvl((select cl1.glb_grupoeconomico_codigo 
                                          from tdvadm.t_glb_cliente@database_tdp cl1 
                                          where cl1.glb_cliente_cgccpfcodigo = cl.glb_cliente_cgccpfcodigo),'9998');
commit;  


insert into tdvadm.t_glb_portaria
select * from tdvadm.t_glb_portaria@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_portaria c
           where c.glb_portaria_id = c1.glb_portaria_id);
commit;
           
insert into tdvadm.t_glb_cliend
select * from tdvadm.t_glb_cliend@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_cliend c
           where c.glb_cliente_cgccpfcodigo = c1.glb_cliente_cgccpfcodigo
             and c.glb_tpcliend_codigo = c1.glb_tpcliend_codigo);
commit;


update tdvadm.t_USU_USUARIO xx
  set xx.usu_usuario_senha = (select u.usu_usuario_senha from tdvadm.t_usu_usuario@database_tdp u where u.usu_usuario_codigo = xx.usu_usuario_codigo );
commit;




insert into tdvadm.t_USU_USUARIO 
select * from tdvadm.t_USU_USUARIO@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_USU_USUARIO c
           where C.USU_USUARIO_codigo = c1.USU_USUARIO_codigo)
  and 0 < (select count(*)
           from tdvadm.t_glb_cliente cl
           where cl.glb_cliente_cgccpfcodigo = c1.usu_usuario_cnpjlogin);
commit;

alter trigger COLETA.tg_usuario_web disable;

INSERT INTO coleta.usuario_web u
select * from coleta.usuario_web@database_tdp c1
where 0 = (select count(*) 
           from coleta.usuario_web c
           where c.cd_login_user = c1.cd_login_user);
commit;
alter trigger COLETA.tg_usuario_web enable;

insert into tdvadm.t_USU_APLICACAO
    (USU_APLICACAO_CODIGO,
    USU_APLICACAO_DESCRICAO,
    USU_APLICACAO_NOMEMENU,
    USU_APLICACAO_ICONE,
    USU_APLICACAO_PATH,
    USU_APLICACAO_VERSAO,
    USU_APLICACAO_DATAVERSAO,
    USU_APLICACAO_NOMEPROJETO,
    USU_APLICACAO_RELPATH,
    USU_APLICACAO_EXT,
    USU_APLICACAO_ATUALIZA,
    USU_APLICACAO_DTULTUTILIZA,
    USU_APLICACAO_VERSAOLD,
    USU_APLICACAO_TIPO,
    USU_APLICACAO_URLWEB)
select USU_APLICACAO_CODIGO,
    USU_APLICACAO_DESCRICAO,
    USU_APLICACAO_NOMEMENU,
    USU_APLICACAO_ICONE,
    USU_APLICACAO_PATH,
    USU_APLICACAO_VERSAO,
    USU_APLICACAO_DATAVERSAO,
    USU_APLICACAO_NOMEPROJETO,
    USU_APLICACAO_RELPATH,
    USU_APLICACAO_EXT,
    USU_APLICACAO_ATUALIZA,
    USU_APLICACAO_DTULTUTILIZA,
    USU_APLICACAO_VERSAOLD,
    USU_APLICACAO_TIPO,
    USU_APLICACAO_URLWEB
from tdvadm.t_USU_APLICACAO@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_USU_APLICACAO c
           where C.USU_APLICACAO_codigo = c1.USU_APLICACAO_codigo);
commit;




alter trigger TDVADM.TG_TRAVA_CLI_TABELA disable;

update tdvadm.t_slf_tabela ta
  set ta.slf_tabela_status = (select ta1.slf_tabela_status 
                              from tdvadm.t_slf_tabela@database_tdp ta1 
                              where ta1.slf_tabela_codigo = ta.slf_tabela_codigo 
                                and ta1.slf_tabela_saque = ta.slf_tabela_saque);
commit;
insert into tdvadm.t_slf_tabela 
select * from tdvadm.t_slf_tabela@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_slf_tabela c
           where c.slf_tabela_codigo = c1.slf_tabela_codigo
             and c.slf_tabela_saque = c1.slf_tabela_saque);


           
alter trigger TDVADM.TG_TRAVA_CLI_TABELA enable;
commit;



--alter system checkpoint global;
--ALTER SYSTEM SET ddl_lock_timeout=60;
--truncate table tdvadm.t_slf_calcfretekm ;
            

insert into tdvadm.t_slf_calcfretekm 
select * from tdvadm.t_slf_calcfretekm@database_tdp cl
where cl.slf_tabela_saque = (select max(ta.slf_tabela_saque)
                            from tdvadm.t_slf_tabela@database_tdp ta
                            where ta.slf_tabela_codigo = cl.slf_tabela_codigo)
  and 0 = (select count(*) 
           from tdvadm.t_slf_calcfretekm c
           where c.SLF_TABELA_CODIGO             = cl.SLF_TABELA_CODIGO            
             and c.SLF_TABELA_SAQUE              = cl.SLF_TABELA_SAQUE             
             and c.SLF_CALCFRETEKM_KMDE          = cl.SLF_CALCFRETEKM_KMDE         
             and c.SLF_CALCFRETEKM_KMATE         = cl.SLF_CALCFRETEKM_KMATE        
             and c.SLF_CALCFRETEKM_PESODE        = cl.SLF_CALCFRETEKM_PESODE       
             and c.SLF_CALCFRETEKM_PESOATE       = cl.SLF_CALCFRETEKM_PESOATE      
             and c.SLF_TPCALCULO_CODIGO          = cl.SLF_TPCALCULO_CODIGO         
             and c.SLF_RECCUST_CODIGO            = cl.SLF_RECCUST_CODIGO           
             and c.SLF_CALCFRETEKM_ORIGEM        = cl.SLF_CALCFRETEKM_ORIGEM       
             and c.SLF_CALCFRETEKM_DESTINO       = cl.SLF_CALCFRETEKM_DESTINO      
             and c.SLF_CALCFRETEKM_ORIGEMI       = cl.SLF_CALCFRETEKM_ORIGEMI      
             and c.SLF_CALCFRETEKM_DESTINOI      = cl.SLF_CALCFRETEKM_DESTINOI     
             and c.SLF_CALCFRETEKM_TPFRETE       = cl.SLF_CALCFRETEKM_TPFRETE      
             and c.SLF_CALCFRETEKM_OUTRACOLETAI  = cl.SLF_CALCFRETEKM_OUTRACOLETAI 
             and c.SLF_CALCFRETEKM_OUTRAENTREGAI = cl.SLF_CALCFRETEKM_OUTRAENTREGAI);
commit;             

delete tdvadm.t_slf_clientecargas cl;
insert into tdvadm.t_slf_clientecargas
select * from tdvadm.t_slf_clientecargas@database_tdp;

delete tdvadm.t_slf_clienteregras cl;
insert into tdvadm.t_slf_clienteregras
select * from tdvadm.t_slf_clienteregras@database_tdp;


delete tdvadm.t_slf_clienteped cl;
insert into tdvadm.t_slf_clienteped
select * from tdvadm.t_slf_clienteped@database_tdp;

delete tdvadm.t_slf_cliregrasveic cl;
insert into tdvadm.t_slf_cliregrasveic
select * from tdvadm.t_slf_cliregrasveic@database_tdp;

delete tdvadm.T_ARM_COLETACARGAVEICULO ;
insert into tdvadm.T_ARM_COLETACARGAVEICULO 
select * from tdvadm.T_ARM_COLETACARGAVEICULO@database_tdp;


           

insert into tdvadm.t_glb_tpcarga 
select * from tdvadm.t_glb_tpcarga@database_tdp tc 
where 0 = (select count(*)
           from tdvadm.t_glb_tpcarga a
           where a.glb_tpcarga_codigo = tc.glb_tpcarga_codigo);

insert into tdvadm.t_arm_tpcarga 
select * from tdvadm.t_arm_tpcarga@database_tdp tc 
where 0 = (select count(*)
           from tdvadm.t_arm_tpcarga a
           where a.arm_tpcarga_codigo = tc.arm_tpcarga_codigo);

commit;
           


           
insert into tdvadm.t_glb_clientecontrato 
select * from tdvadm.t_glb_clientecontrato@database_tdp c1
where 0 = (select count(*) 
           from tdvadm.t_glb_clientecontrato c
           where c.glb_cliente_cgccpfcodigo = c1.glb_cliente_cgccpfcodigo
             and c.slf_contrato_codigo = c1.slf_contrato_codigo);
commit;


alter trigger TDVADM.TG_BIUC_SLF_PERCURSO_NOVO disable;
alter trigger TDVADM.TG_BU_SLF_PERCURSO_BLOQUPDATE disable;
insert into tdvadm.t_slf_percurso
select * from tdvadm.t_slf_percurso@database_tdp x
where 0 = (select count(*)
           from tdvadm.t_slf_percurso p
           where p.slf_percurso_codigo = p.slf_percurso_codigo);

update tdvadm.t_slf_percurso a
  set a.slf_percurso_km = (select p.slf_percurso_km from tdvadm.t_slf_percurso@database_tdp p where p.slf_percurso_codigo = a.slf_percurso_codigo)
where nvl(a.slf_percurso_km,0) = 0;

alter trigger TDVADM.TG_BIUC_SLF_PERCURSO_NOVO enable;
alter trigger TDVADM.TG_BU_SLF_PERCURSO_BLOQUPDATE enable;
           



DELETE TDVADM.T_USU_APLICACAOPERFIL;
DELETE TDVADM.T_USU_PERFILDETALHE;
DELETE TDVADM.T_USU_PERFIL ;


INSERT INTO TDVADM.T_USU_PERFIL
SELECT x.*,'S' Ativo FROM TDVADM.T_USU_PERFIL@database_tdp x;
commit;

INSERT INTO TDVADM.T_USU_PERFILDETALHE
SELECT * FROM TDVADM.T_USU_PERFILDETALHE@database_tdp;
commit;

alter trigger TDVADM.TG_USU_PERFIL_USUARIO disable;
alter trigger TDVADM.TG_BID_BAIXAEOCORRENCIATIT disable;
alter trigger TDVADM.TG_BID_BLOQUEIOVEICULOS disable;
INSERT INTO TDVADM.T_USU_APLICACAOPERFIL
SELECT * FROM TDVADM.T_USU_APLICACAOPERFIL@database_tdp;
commit;
alter trigger TDVADM.TG_USU_PERFIL_USUARIO enable;
alter trigger TDVADM.TG_BID_BAIXAEOCORRENCIATIT enable;
alter trigger TDVADM.TG_BID_BLOQUEIOVEICULOS enable;
commit;

ALTER TRIGGER TDVADM.TG_BLOQ_DUPLICIDADEINSS DISABLE;
ALTER TRIGGER TDVADM.TG_BIU_PROPRIETARIO_TPPESSOA DISABLE;

insert into tdvadm.t_car_proprietario 
select * from tdvadm.t_car_proprietario@database_tdp p
where 0 = (select count(*)
           from tdvadm.t_car_proprietario p1
           where p1.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo);


update  tdvadm.t_car_proprietario p
  set  (p.car_proprietario_inps_codigo,
        p.car_proprietario_razaosocial,     
        p.car_proprietario_datanasc) = (select p1.car_proprietario_inps_codigo,
                                               nvl(p1.car_proprietario_razaosocial,'sem nome'),
                                               p1.car_proprietario_datanasc
                                        from tdvadm.t_car_proprietario@database_tdp p1
                                        where p1.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo)
where p.car_proprietario_inps_codigo is not null
  and 0 < (select count(*)
           from tdvadm.t_car_proprietario@database_tdp p1
           where p1.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo);
alter trigger tdvadm.tg_bloq_duplicidadeinss enable;
alter trigger tdvadm.TG_BIU_PROPRIETARIO_TPPESSOA enable;

commit;



                                        
