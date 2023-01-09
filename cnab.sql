
select *
from rmadm.t_glb_benasserec br
where br.glb_benasserec_fileanexoorig is not null
  and br.glb_benasserec_chave in ('2596549','2596460')
  and trunc(br.glb_benasserec_gravacao) >= to_date('30/11/2022','dd/mm/yyyy');
  
select i.edi_integra_protocolo,min(i.edi_integra_gravacao) menor, max(i.edi_integra_gravacao) maior,count(*) qtde
from tdvadm.t_edi_integra i
where trunc(i.edi_integra_gravacao) >=  to_date('30/11/2022','dd/mm/yyyy')
group by i.edi_integra_protocolo;


select br.glb_benasserec_status,
       br.glb_benasserec_chave,
       br.glb_benasserec_gravacao,
       br.glb_benasserec_origem,
       br.glb_benasserec_assunto
from rmadm.t_glb_benasserec br
where trunc(br.glb_benasserec_gravacao) = '01/12/2022'
  and br.glb_benasserec_fileanexoorig is not null
  and upper(br.glb_benasserec_assunto) like '%EXTR%'
order by 2;




select *
from tdvadm.t_glb_extrato2 e
where e.glb_banco_numero = '745'
order by 1,2,4,6,7
for update
   
-- Verifica o Extrato
select x.glb_banco_numero banco,
       x.glb_extrato2_data data,
       x.glb_extrato2_documento documento,
       x.glb_extrato2_historico historico,
       x.glb_extrato2_tipo,
       x.usu_usuario_codigo,
       sum(x.glb_extrato2_valor) valor,
       count(*) registros,
       x.glb_extrato2_usado usado
from tdvadm.t_glb_extrato2 x
where x.glb_extrato2_data >= '20/11/2022'
  and x.glb_banco_numero not in ('001','237')
  and x.glb_extrato2_tipo = 'C'
group by x.glb_banco_numero,
         x.glb_extrato2_data,
         x.glb_extrato2_tipo,
         x.usu_usuario_codigo,
         x.glb_extrato2_documento,
         x.glb_extrato2_historico,
         x.glb_extrato2_usado
order by 1,2         
;
select e.glb_extrato_banco banco,
       e.glb_extrato_dtmovimento data,
       sum(e.glb_extrato_valor) valor,
       count(*) qtde
from tdvadm.t_glb_extrato e
where trunc(e.glb_extrato_dtmovimento) >= '20/11/2022'
group by e.glb_extrato_banco,
         e.glb_extrato_dtmovimento ;
                 
-- Verificando quais titulos foram baixados com o protocolo

select *
from tdvadm.t_crp_titrecevento ev
where 0 = 0
--  and ev.crp_titrecevento_dtevento >= to_date('01/12/2022','dd/mm/yyyy')
  and ev.crp_titrecevento_obs like '%2611423%';
  
2000006515
select *
from tdvadm.t_edi_integra i
where 0 = 0
--  and i.edi_integra_protocolo = '2611423'
  and i.edi_integra_col12 = '2000006515';


select *
from rmadm.t_glb_benasserec br
where br.glb_benasserec_assunto like '%2611423%'
for update
   
select *
from tdvadm.t_glb_banco b
where b.glb_banco_numero = '745';
select *
from tdvadm.t_glb_agencia a
where a.glb_banco_numero = '745';
select *
from tdvadm.t_glb_contas c
where c.glb_banco_numero = '745'
for update;

;
pkg_edi_controle  

select *
from tdvadm.t_edi_conciliacaosap cs
where 0 = 0
  and cs.protocolo in ('2611423')
  and cs.documento = '2000006515';
  
  select *
  from rmadm.t_glb_benasserec br
  where br.glb_benasserec_chave = 2611423
     or br.glb_benasserec_assunto like '%2611423%'  ;
     
   

 
