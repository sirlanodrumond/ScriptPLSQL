tdvadm.pkg_slf_calculos
-- PARAMETROS DE CIOT
Categoria liberada
CATVFLIB

Parâmetro msg VIAGEM SEM CIOT
UTILIZA_IDOPER

select * from tdvadm.t_usu_perfil ap
where ap.usu_perfil_codigo in ('CATVFLIB','UTILIZA_IDOPER');
select * from tdvadm.t_usu_aplicacaoperfil ap
where ap.usu_perfil_codigo in ('CATVFLIB','UTILIZA_IDOPER')
  and ( ap.glb_rota_codigo in ('060','061') or ap.usu_usuario_codigo = 'aferreira' ) 
for update;
  


-- Procedure Principal
tdvadm.sp_gera_valefretecoleta;

-- Tabela Principal
tdvadm.v_arm_coletaorigemdestinojava;

-- Usuarios de Santos
select u.usu_usuario_codigo ,
       u.usu_usuario_nome,
       u.usu_usuario_cpf ,
       u.glb_rota_codigo ,
       u.usu_usuario_tppessoa,
       u.usu_usuario_ativo 
from tdvadm.t_usu_usuario u
where 0 = 0
--  and u.glb_rota_codigo = '060'
  and u.usu_usuario_tppessoa = 'F'
  and u.usu_usuario_codigo in ('aferreira',
                               'vblanco',
                               'wdaraujo',
                               'lsneves',
                               'leneves',
                               'gusilva',
                               'adcsantos',
                               'hfsantos',
                               'lasantana',
                               'msandrade',
                               'cpossato',
                               'mdssilva',
                               'fgomes',
                               'mrnserafim')
;                

                 



-- Pegando nr do Contrato
Select co.arm_coleta_ncompra,
       co.arm_coleta_ciclo,
       co.arm_coleta_cnpjpagadorferete,
       cc.slf_contrato_codigo,
       cc.glb_clientecontrato_ativo
from tdvadm.t_arm_coleta co,
     tdvadm.t_glb_clientecontrato cc
where co.arm_coleta_cnpjpagadorferete = cc.glb_cliente_cgccpfcodigo (+)
  and co.arm_coleta_ncompra = '000785'
  and co.arm_coleta_ciclo = '005';
  
-- Verificando CTe

select *
from tdvadm.t_con_conhecimento c
where c.arm_coleta_ncompra = '000785'
  and c.arm_coleta_ciclo = '005';
    
-- Verificando o Vinculo
select ct.arm_coleta_ncompra,
       ct.arm_coleta_ciclo,
       ct.con_conhecimento_codigo,
       ct.glb_rota_codigo,
       ca.arm_carregamento_codigo
from tdvadm.t_con_conhecimento ct,
     tdvadm.t_arm_carregamento ca
where ct.arm_carregamento_codigo = ca.arm_carregamento_codigo (+)
  and ct.arm_coleta_ncompra = '000785'
  and ct.arm_coleta_ciclo = '005';

-- Conferencia dos fretes na Mesa
select * from xlsuser.v_fcf_fretecarAlan; -- Descontinuada
select * from xlsuser.v_fcf_fretecar; -- Atual



-- AUT-e
-- PROC
tdvadm.pkg_sch_procedures.sp_cad_frete; 
select p.protocolo,
       p.Recebido,
       p.Processado,
       p.critica,
       p.origem,
       p.destino,
       p.passpor,
       p.codveic,
       p.pesode,
       p.pesoate,
       p.frete,
       p.desf,
       p.pedagio,
       p.Vigencia,
       p.usuario,
       p.origemD,
       p.destinoD,
       p.passporD,
       p.Veiculo,
       p.Lotacao,
       p.Eixos,
       p.integra_rowid
from tdvadm.v_fcf_fretecar_protocolo p
where p.protocolo in (select br.glb_benasserec_chave --,br.glb_benasserec_fileanexoorig,br.glb_benasserec_origem
                      from rmadm.t_glb_benasserec br
                      where trunc(br.glb_benasserec_gravacao) = '23/04/2021'
                        and br.glb_benasserec_chave > '1360300'
                        and lower(br.glb_benasserec_fileanexo) like '%xls%'
                        and br.glb_benasserec_assunto = 'MSG=CADFRETE')
order by 1,5 DESC




-- para reprocessar um protocolo   
update tdvadm.t_edi_integra i
  set i.edi_integra_processado = null,
      i.edi_integra_critica = null
where i.edi_integra_protocolo in ('1360151','1359962','1360298')
(select br.glb_benasserec_chave --,br.glb_benasserec_fileanexoorig,br.glb_benasserec_origem
                      from rmadm.t_glb_benasserec br
                      where trunc(br.glb_benasserec_gravacao) = '23/04/2021'
--                        and br.glb_benasserec_chave > '1360054'
                        and lower(br.glb_benasserec_fileanexo) like '%xls%'
                        and br.glb_benasserec_assunto = 'MSG=CADFRETE')
;  

-- Pegando cogigo FROTA
select v.frt_veiculo_placa,v.frt_veiculo_codigo,ce.frt_conjveiculo_codigo
from tdvadm.t_frt_veiculo v,
     tdvadm.t_frt_conteng ce
where v.frt_veiculo_codigo = ce.frt_veiculo_codigo
  and v.frt_veiculo_placa =  'FPA5J24';
-- Pegando o VeiculoDisp

select *
from tdvadm.t_fcf_veiculodisp vd
where ( vd.car_veiculo_placa = 'FPA5J24' or vd.frt_conjveiculo_codigo = '0003642' )
  and vd.fcf_veiculodisp_data >= sysdate - 1;
  
-- Ajuste do motorista na coleta
tdvadm.pkg_fifo_ctrc



select *
from dba_source s
where lower(s.TEXT) like '%con_valefrete_codigo2%'

select f.fcf_solveic_cod,
       f.fcf_veiculodisp_codigo,
       f.con_valefrete_codigo,
       f.con_valefrete_codigo2,
       f.arm_coleta_ncompra
from tdvadm.t_fcf_fretecarmemo f
where f.arm_coleta_ncompra like '%006347%' 
for update;

tdvadm.pkg_con_valefrete 
  


select *
from tdvadm.t_arm_carregamento c
where c.arm_carregamento_codigo =  '3312986'
for update;

select *
from tdvadm.t_fcf_veiculodisp vd
where vd.fcf_veiculodisp_codigo = '6902779'
for update;


  

SELECT *
FROM TDVADM.V_GLB_CADASTROGERAL G
WHERE G.CONJUNTO = '0003564'
;

SELECT CE.FRT_CONJVEICULO_CODIGO CONJUNTO,
       CE.FRT_MOTORISTA_CODIGO CODMOT,
       (SELECT M.FRT_MOTORISTA_CPF
        FROM TDVADM.T_FRT_MOTORISTA M
        WHERE M.FRT_MOTORISTA_CODIGO = CE.FRT_MOTORISTA_CODIGO) Cpf,
       (SELECT M.FRT_MOTORISTA_NOME
        FROM TDVADM.T_FRT_MOTORISTA M
        WHERE M.FRT_MOTORISTA_CODIGO = CE.FRT_MOTORISTA_CODIGO) MOTORISTA,
       TDVADM.PKG_FRTCAR_VEICULO.FN_RETFCFTPVEICULO(CE.FRT_CONJVEICULO_CODIGO) TPvEICULO,
       (SELECT TV.FCF_TPVEICULO_DESCRICAO
        FROM TDVADM.T_FCF_TPVEICULO TV
        WHERE TV.FCF_TPVEICULO_CODIGO = RPAD(TDVADM.PKG_FRTCAR_VEICULO.FN_RETFCFTPVEICULO(CE.FRT_CONJVEICULO_CODIGO),3)) VEICULO,
       TDVADM.PKG_FRTCAR_VEICULO.fn_RetTpVeiculo(CE.FRT_CONJVEICULO_CODIGO) TIPO
FROM TDVADM.T_FRT_CONJUNTO CE
WHERE 0 = 0
  AND CE.FRT_MOTORISTA_CODIGO IS NOT NULL
  AND CE.FRT_CONJVEICULO_CODIGO = '0003564'
;

SELECT *
FROM TDVADM.T_FCF_VEICULODISP VD
WHERE VD.FRT_CONJVEICULO_CODIGO = '0003564'
  AND VD.FCF_VEICULODISP_DATA >= SYSDATE - 15
FOR UPDATE  ;

SELECT *
FROM TDVADM.T_CON_VALEFRETE VF
WHERE VF.FCF_VEICULODISP_CODIGO = '6901061'

  
  
  


SELECT *
FROM TDVADM.T_CON_VALEFRETE VF
WHERE (VF.CON_CONHECIMENTO_CODIGO,
       VF.CON_CONHECIMENTO_SERIE,
       VF.GLB_ROTA_CODIGO) IN (SELECT VFC.CON_VALEFRETE_CODIGO,
                                          VFC.CON_VALEFRETE_SERIE,
                                          VFC.GLB_ROTA_CODIGOVALEFRETE
                                   FROM TDVADM.T_CON_VFRETECOLETA VFC
                                   WHERE VFC.ARM_COLETA_NCOMPRA = ''
                                     AND VFC.ARM_COLETA_CICLO = '')
      

tdvadm.sp_gera_valefretecoleta

select *
from xlsuser.v_fcf_fretecar vc
where vc.origem like '%GUARUJA%'
  and vc.destino like '%SANTOS%'

select *
from tdvadm.v_arm_coletaorigemdestinojava jv
where jv.coleta = '004428'
  and jv.ciclo = '005'

select * from tdvadm.t_fcf_fretecar fc
where fc.fcf_fretecar_origem = '11400'
  and fc.fcf_fretecar_destino = '11100'
  and fc.fcf_fretecar_passandopor = '09000'
  and fc.fcf_tpveiculo_codigo = '20'
  
      select fc.fcf_fretecar_origem,-- = '11400'
             fc.fcf_fretecar_destino,-- = '11100'
             fc.fcf_fretecar_passandopor,-- = '09000'
             fm.*
      from tdvadm.t_fcf_fretecarmemo fm,
           tdvadm.t_fcf_veiculodisp vd,
           tdvadm.t_fcf_solveic sv,
           tdvadm.t_fcf_fretecar fc
      where fm.fcf_veiculodisp_codigo = vd.fcf_veiculodisp_codigo(+)
        and fm.fcf_veiculodisp_sequencia = vd.fcf_veiculodisp_sequencia(+)
        and fm.fcf_solveic_cod = sv.fcf_solveic_cod(+)
        and ( vd.car_veiculo_placa = 'CPJ5816' or vd.frt_conjveiculo_codigo = 'CPJ5816' ) 
        and nvl(vd.fcf_veiculodisp_flagvalefrete,'N') = 'N'
        and sv.usu_usuario_cancel is null
        and fm.fcf_fretecar_rowid = fc.fcf_fretecar_rowid 
        and fm.arm_coleta_ncompra is null
        and instr('004428',nvl(fm.arm_coleta_ncompra,'XXXXXX')) = 0
        and fc.fcf_fretecar_origem = '11400'
        and fc.fcf_fretecar_destino = '11100'
        and fc.fcf_fretecar_passandopor = '09000'
        
        ;
  
  select *
  from tdvadm.t_fcf_tpveiculo tp
  where tp.fcf_tpveiculo_codigo = '20'
  
  
carreg 3309873
coleta 004428 / 005
Placa  CPJ5816
vDisp  6901138-0
  
  select *
  from tdvadm.t_fcf_fretecarmemo m
  where 0 = 0
    and m.fcf_veiculodisp_codigo = '6901138'
--    and m.arm_coleta_ncompra like '004428%'
for update
  
  select *
  from tdvadm.t_arm_coleta co
  where co.arm_coleta_ncompra = '004428'
    and co.arm_coleta_ciclo = '005';
    
  select *
  from tdvadm.t_arm_coleta_motorista co
  where co.arm_coleta_ncompra = '004428'
    and co.arm_coleta_ciclo = '005';

  select *
  from tdvadm.t_con_conhecimento co
  where co.arm_coleta_ncompra = '004428'
    and co.arm_coleta_ciclo = '005';
    
  select *
  from tdvadm.t_fcf_veiculodisp vd
  where vd.car_veiculo_placa = 'CPJ5816'
    and trunc(vd.fcf_veiculodisp_data) = '23/04/2021'
  for update;
    
  select *
  from tdvadm.t_Con_Valefrete vf
  where vf.fcf_veiculodisp_codigo =  '6901138'
  
  tdvadm.pkg_fifo_manifesto
