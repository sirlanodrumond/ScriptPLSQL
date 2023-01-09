-- Add/modify columns 
alter table TDVADM.T_FCF_VEICULODISP add fcf_veiculodisp_pedagio number(10,2);
alter table TDVADM.T_FCF_VEICULODISP add fcf_veiculodisp_km number;
-- Add comments to the columns 
comment on column TDVADM.T_FCF_VEICULODISP.fcf_veiculodisp_pedagio
  is 'Valor do Pedagio fechado';
comment on column TDVADM.T_FCF_VEICULODISP.fcf_veiculodisp_km
  is 'Km do Percurso';

-- Add/modify columns 
alter table TDVADM.T_FCF_FRETECAR add fcf_fretecar_pednofrete char(1);
-- Add comments to the columns 
comment on column TDVADM.T_FCF_FRETECAR.fcf_fretecar_pednofrete
  is 'Se tem pedagio no Frete';


select * from tdvadm.t_fcf_fretecar

TDVADM.sp_gera_valefrete;
TDVADM.SP_CON_INSERE_VALEFRETENOVO;
TDVADM.SP_CON_INSERE_VALEFRETENOVO1;
TDVADM.PKG_CFE_FRETE;
TDVADM.PKG_CON_VALEFRETE;
tdvadm.sp_busca_fretecarreteiro;
tdvadm.pkg_fifo_valefrete; --.sp_cria_ValeFrete;


select * from dba_source s where upper(s.TEXT) like '%SP_CON_INSERE_VALEFRETE%'

