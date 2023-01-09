
-- Add/modify columns 
alter table T_FRT_INTMIXCONSUMO add frt_intmixconsumo_motorista varchar2(60);
alter table T_FRT_INTMIXCONSUMO add frt_intmixconsumo_motoristaori varchar2(60);
alter table T_FRT_INTMIXCONSUMO add frt_intmixconsumo_tempodirigindo varchar2(10);
alter table T_FRT_INTMIXCONSUMO add frt_intmixconsumo_tempoparado varchar2(10);
-- Add comments to the columns 
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_id
  is 'ID do veiculo';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixveiculo_id
  is 'ID do Consumo';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_consumo
  is 'Consumo do percurso';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_kmrodado
  is 'Km percorrido';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_data
  is 'Data do Consumo';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_motorista
  is 'Nome do Motorista';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_motoristaori
  is 'Nome do Motorista Original';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_tempodirigindo
  is 'Tempo total dirigindo';
comment on column T_FRT_INTMIXCONSUMO.frt_intmixconsumo_tempoparado
  is 'Tempo tatal parado';

  alter table TDVADM.T_EDI_INTEGRAMIXCSV
  access parameters 
  (
    records delimited by newline
    fields terminated by ','  OPTIONALLY ENCLOSED BY '"'
    MISSING FIELD VALUES ARE NULL
  );
alter table TDVADM.T_EDI_INTEGRAMIXCSV
  location (PLANS:'MIX01.csv',PLANS:'MIX02.csv',PLANS:'MIX03.csv',PLANS:'MIX04.csv');
 
truncate table tdvadm.t_frt_intmixconsumo;

-- 01/01/2019
-- 30/06/2019

insert into tdvadm.t_frt_intmixconsumo
select * from tdvadm.v_edi_integramixcsv c;
commit;


select c.frt_intmixveiculo_id,
       to_char(c.frt_intmixconsumo_data,'yyyymm') refamo,
       sum(c.frt_intmixconsumo_kmrodado) rodado,
       count(*) qtde
from tdvadm.v_edi_integramixcsv c
where c.frt_intmixveiculo_id = '3492'
group by c.frt_intmixveiculo_id,to_char(c.frt_intmixconsumo_data,'yyyymm')


	
select min(c.frt_intmixconsumo_data) menor,max(c.frt_intmixconsumo_data)
from tdvadm.t_frt_intmixconsumo c;


select * from tdvadm.t_edi_integramixcsv c
where c.edi_integra_col02 = '3492';
	
tdvipf.T_IPF_CENTROCUSTORATEADODRU

select * from tdvadm.t_cad_infofrete x
where x.cad_frete_codigo = 481;
select * from tdvadm.t_cad_frete x
where x.cad_frete_codigo = 481;
