select *
from tdvadm.v_fcf_fretecar fc
where fc.origemibge = '3550308'
  and fc.destinoibge = '2111300'
  and fc.codveic = '1'
for update
;  

32000  
3118601

select * from tdvadm.t_fcf_fretecar fc
where fc.fcf_fretecar_origemi = '3550308'
  and fc.fcf_fretecar_destinoi = '2111300'
  and fc.fcf_tpveiculo_codigo = '1'
for update
  ;
  
  -- Add/modify columns 
alter table T_FCF_FRETECAR modify fcf_fretecar_passandopor default '00000';

-- Create/Recreate primary, unique and foreign key constraints 
alter table T_FCF_FRETECAR
  drop constraint PK_FCF_FRETECAR cascade;
alter table T_FCF_FRETECAR
  add constraint PK_FCF_FRETECAR primary key (FCF_FRETECAR_ORIGEM, FCF_FRETECAR_DESTINO, FCF_FRETECAR_TPFRETE, FCF_TPVEICULO_CODIGO, FCF_TPCARGA_CODIGO, FCF_FRETECAR_VIGENCIA, FCF_FRETECAR_PASSANDOPOR)
  using index 
  tablespace TSMGERAL
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 1M
    minextents 1
    maxextents unlimited
  );


  
select * from tdvadm.t_glb_localidade lc
where lc.glb_localidade_descricao like '%CONTA%'
  
