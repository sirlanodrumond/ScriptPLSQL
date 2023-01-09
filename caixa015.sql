
/*
-- reverter a transferencia
alter trigger TDVADM.TG_BD_CAX_MOVIMENTO disable;
delete tdvadm.t_cax_movimento m
where m.cax_boletim_data = '24/03/2018'
  and m.glb_rota_codigo = '015'
  and m.cax_movimento_origem = 'O'
  and m.cax_movimento_contabil = 'S'
  and m.cax_movimento_usuario = 'jsantos';
update tdvadm.t_cax_movimento m
  set m.cax_movimento_documentoref = null
where m.cax_movimento_documentoref in (select ac.acc_acontas_numero || '-' || ac.acc_contas_ciclo from tdvadm.t_acc_acontas ac where ac.acc_acontas_datatransf = '24/03/2018');
alter trigger TDVADM.TG_BD_CAX_MOVIMENTO enable;

alter trigger TDVADM.TG_BUD_ACC_ACONTAS disable;
update tdvadm.t_acc_acontas ac
  set  ac.acc_acontas_datatransf = null
where ac.acc_acontas_datatransf = '24/03/2018' ; 
alter trigger TDVADM.TG_BUD_ACC_ACONTAS enable;
exec tdvadm.SP_CAX_FECHAMENTOMes('015','24/03/2018');
*/

select m.cax_movimento_origem,count(*) from tdvadm.t_cax_movimento m
where m.glb_rota_codigo = '015'
  and m.cax_boletim_data = '23/04/2018'
group by m.cax_movimento_origem;


select *
from tdvadm.t_Cax_boletim m
where m.cax_boletim_data = '23/04/2018'
  and m.glb_rota_codigo = '015';
  
  
  

      
  
select m.glb_rota_codigo rota,
       m.cax_boletim_data boletim,
       m.cax_movimento_sequencia sequencia,
       m.cax_movimento_documentoref docref,
       m.glb_rota_codigo_referencia rotaref,
       m.cax_movimento_documento documento,
       m.frt_conjveiculo_codigo conjunto,
       m.cax_movimento_historico historico,
       m.cax_operacao_codigo operacao,
       op.cax_operacao_descricao descricao,
       (decode(op.cax_operacao_tipo,'S',-1,1) * m.cax_movimento_valor) valor,
       op.cax_operacao_tipo tipo,
       m.cax_movimento_origem origem
from tdvadm.t_cax_movimento m,
     tdvadm.t_cax_operacao op
where 0 = 0
  and m.glb_rota_codigo = '015'
  and m.cax_boletim_data = '23/04/2018'
/*  and m.cax_movimento_documentoref in (select ac.acc_acontas_numero || '-' || ac.acc_contas_ciclo
                                       from tdvadm.t_acc_acontas ac
                                       where ac.acc_acontas_datatransf = '24/04/2018')
*/  and m.cax_operacao_codigo = op.cax_operacao_codigo
  and m.glb_rota_codigo_operacao = op.glb_rota_codigo_operacao
--  and m.cax_movimento_historico like '%AC%'
--  and ( m.cax_movimento_historico like '%30004481%' or m.cax_movimento_historico like '%30004658%' )
--  and m.cax_operacao_codigo in ('2600','2120','1300','2000')
order by 1,2,3;


select m.cax_movimento_documentoref docref,
       sum((decode(op.cax_operacao_tipo,'S',-1,1) * m.cax_movimento_valor)) valor
from tdvadm.t_cax_movimento m,
     tdvadm.t_cax_operacao op
where 0 = 0
--  and m.glb_rota_codigo = '015'
  and m.cax_movimento_documentoref in (select ac.acc_acontas_numero || '-' || ac.acc_contas_ciclo
                                       from tdvadm.t_acc_acontas ac
                                       where ac.acc_acontas_datatransf = '24/03/2018')
  and m.cax_operacao_codigo = op.cax_operacao_codigo
  and m.glb_rota_codigo_operacao = op.glb_rota_codigo_operacao
--  and m.cax_movimento_historico like '%AC%'
--  and ( m.cax_movimento_historico like '%30004481%' or m.cax_movimento_historico like '%30004658%' )
--  and m.cax_operacao_codigo in ('2600','2120','1300','2000')
group by m.cax_movimento_documentoref;

select d.acc_acontas_numero || d.acc_contas_ciclo acerto,
       sum(d.acc_vales_valor) valor,
       count(*) qtde
from tdvadm.t_acc_vales d
where (d.acc_acontas_numero,d.acc_contas_ciclo) in (select ac.acc_acontas_numero,ac.acc_contas_ciclo
                                                    from tdvadm.t_acc_acontas ac
                                                    where ac.acc_acontas_datatransf = '24/03/2018')
group by d.acc_acontas_numero || d.acc_contas_ciclo;                                                    


select d.acc_acontas_numero || d.acc_contas_ciclo acerto,
       sum(d.acc_despesas_valor) valor,
       sum(d.acc_despesas_inss) inss,
       sum(d.acc_despesas_irrf) irrf
from tdvadm.t_acc_despesas d
where (d.acc_acontas_numero,d.acc_contas_ciclo) in (select ac.acc_acontas_numero,ac.acc_contas_ciclo
                                                    from tdvadm.t_acc_acontas ac
                                                    where ac.acc_acontas_datatransf = '24/03/2018')
group by d.acc_acontas_numero || d.acc_contas_ciclo;
                                                    
select d.acc_acontas_numero || d.acc_contas_ciclo acerto,
       sum(d.frt_movvazio_valor) valor,
       count(*) qtde
from tdvadm.t_frt_movvazio d
where (d.acc_acontas_numero,d.acc_contas_ciclo) in (select ac.acc_acontas_numero,ac.acc_contas_ciclo
                                                    from tdvadm.t_acc_acontas ac
                                                    where ac.acc_acontas_datatransf = '24/03/2018')
group by d.acc_acontas_numero || d.acc_contas_ciclo;                                                      



select *
from tdvadm.t_cax_boletim bo
where bo.glb_rota_codigo = '015'
  and bo.cax_boletim_data >= '15/03/2018';

select *
from tdvadm.t_ctb_logtransf x
where x.ctb_logtransf_sistema = 'CAX'
  and x.ctb_logtransf_data >= '01/03/2018'
  



select *
from tdvadm.t_uti_geraplanilha gp
where gp.uti_geraplanilha_titulo like '%ACC%'
  
SELECT * FROM TDVADM.V_ACC_CAIXAACERTO X WHERE TO_CHAR(X.DATA,'YYYYMM') = '201803';
SELECT * FROM TDVADM.V_ACC_CAIXAOUTROSDOC X WHERE TO_CHAR(X.DATA,'YYYYMM') = '201803';
select * from tdvadm.v_acc_caxiasemvale;
select * from tdvadm.v_acc_caxia015semvale;
select * from tdvadm.v_acc_valescax015semacc C
WHERE C.vale = 133537


select * from tdvadm.v_acc_valessemcax015; 



CREATE OR REPLACE VIEW TDVADM.V_ACC_CAIXAOUTROSDOC AS
SELECT M.GLB_ROTA_CODIGO CX,
       M.CAX_BOLETIM_DATA DATA,
       m.cax_movimento_sequencia seq,
       M.CAX_OPERACAO_CODIGO OPER,
       OP.CAX_OPERACAO_DESCRICAO DESOPER,
       M.CAX_MOVIMENTO_DOCUMENTO DOCUMENTO,
       M.CAX_MOVIMENTO_VALOR * DECODE(OP.CAX_OPERACAO_TIPO,'S',-1,1) VALOR,
       OP.CAX_OPERACAO_TIPO TP,
       M.CAX_MOVIMENTO_HISTORICO HISTORICO,
       M.CAX_MOVIMENTO_USUARIO USUARIO,
       M.CAX_MOVIMENTO_ORIGEM origem,
       M.CAX_MOVIMENTO_DTGRAVACAO GRAVACAO
FROM TDVADM.T_CAX_MOVIMENTO M,
     TDVADM.T_CAX_OPERACAO OP
WHERE M.GLB_ROTA_CODIGO_OPERACAO = OP.GLB_ROTA_CODIGO_OPERACAO
  AND M.CAX_OPERACAO_CODIGO = OP.CAX_OPERACAO_CODIGO
  AND M.GLB_ROTA_CODIGO = '015'
  AND M.CAX_MOVIMENTO_ORIGEM <> 'O'
  AND M.CAX_BOLETIM_DATA >= '01/01/2018'
  
  
SELECT *
FROM TDVADM.T_CAX_OPERACAO OP
WHERE OP.CAX_OPERACAO_CODIGO IN ('2412', -- ESTORNO 1127
                                 '1267') -- ESTORNO 2167 
  
  
SELECT *
FROM TDVADM.T_CAX_MOVIMENTO M
WHERE M.CAX_MOVIMENTO_DOCUMENTO = '133537'
  AND M.GLB_ROTA_CODIGO = '015'

SELECT * FROM TDVADM.T_ACC_VALES V
WHERE V.ACC_VALES_NUMERO = 133537





  
  
select *
from tdvadm.t_cax_movimento m
where m.cax_movimento_documentoref like '30004734%'

select * from tdvadm.t_acc_acontas a
where 0 = 0
--  and a.acc_acontas_numero in ('30004734','30004315','30004547')
  and trunc(a.acc_acontas_datatransf) = '01/01/1900'
  and trunc(a.acc_acontas_data) >= to_date('01/01/2017','dd/mm/yyyy')
  and a.acc_acontas_referencia is not null
  and a.acc_acontas_valor_receita > 0;
  
select *
from tdvadm.t_cax_movimento m
where 0 = 0
  and m.glb_rota_codigo = '015'
  and m.cax_movimento_documento in (select a.acc_acontas_numero
                                    from tdvadm.t_acc_acontas a
                                    where 0 = 0
                                    --  and a.acc_acontas_numero in ('30004734','30004315','30004547')
                                      and trunc(a.acc_acontas_datatransf) = '01/01/1900'
--                                      and trunc(a.acc_acontas_data) >= to_date('01/01/2017','dd/mm/yyyy')
                                      and a.acc_acontas_referencia is not null
                                      and a.acc_acontas_valor_receita > 0);


select *
from tdvadm.t_acc_despesas d
where 0 = 0
  and (d.acc_acontas_numero,
       d.acc_contas_ciclo)  in (select a.acc_acontas_numero,a.acc_contas_ciclo
                                    from tdvadm.t_acc_acontas a
                                    where 0 = 0
                                    --  and a.acc_acontas_numero in ('30004734','30004315','30004547')
                                      and trunc(a.acc_acontas_datatransf) = '01/01/1900'
--                                      and trunc(a.acc_acontas_data) >= to_date('01/01/2017','dd/mm/yyyy')
                                      and a.acc_acontas_referencia is not null
                                      and a.acc_acontas_valor_receita > 0);

select *
from tdvadm.t_acc_vales v
where 0 = 0
  and (v.acc_acontas_numero,
       v.acc_contas_ciclo)  in (select a.acc_acontas_numero,a.acc_contas_ciclo
                                    from tdvadm.t_acc_acontas a
                                    where 0 = 0
                                    --  and a.acc_acontas_numero in ('30004734','30004315','30004547')
                                      and trunc(a.acc_acontas_datatransf) = '01/01/1900'
--                                      and trunc(a.acc_acontas_data) >= to_date('01/01/2017','dd/mm/yyyy')
                                      and a.acc_acontas_referencia is not null
                                      and a.acc_acontas_valor_receita > 0);
                                      
                                      

                                      

    




create or replace view xlsuser.v_arm_etiquetaunica
as
select * from tdvadm.v_arm_etiquetaunica
