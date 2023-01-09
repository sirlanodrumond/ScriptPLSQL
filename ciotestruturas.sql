/*        SOLVEIC  */

alter table T_FCF_SOLVEIC add fcf_solveic_container char(1);
alter table T_FCF_SOLVEIC add fcf_solveic_granelsolido char(1) default 'N';
alter table T_FCF_SOLVEIC add fcf_solveic_retornovazio char(1) default 'N';
alter table T_FCF_SOLVEIC add slf_contrato_codigo varchar2(15) default 'N';
alter table T_FCF_SOLVEIC add fcf_solveic_valorparticilaridade number;
-- Add comments to the columns 
comment on column T_FCF_SOLVEIC.fcf_solveic_granelsolido
  is 'Se a carga sera de Granel Solido';
comment on column T_FCF_SOLVEIC.fcf_solveic_retornovazio
  is 'Se tera retorno Vazio';
comment on column T_FCF_SOLVEIC.slf_contrato_codigo
  is 'Codigo do Contrato';
comment on column T_FCF_SOLVEIC.fcf_solveic_container
  is 'Uso de Container para o transporte';
comment on column T_FCF_SOLVEIC.fcf_solveic_valorparticilaridade
  is 'Valor das particularidades';

/*       VEICULODISP      */
-- Add/modify columns 
alter table T_FCF_VEICULODISP add fcf_veiculodisp_particularidade number;
-- Add comments to the columns 
comment on column T_FCF_VEICULODISP.fcf_veiculodisp_particularidade
  is 'Valor das Particularidades';

-- Add/modify columns 
alter table T_FCF_FRETECARMEMO add fcf_fretecarmemo_eixos number;
alter table T_FCF_FRETECARMEMO add fcf_antt_valorf number;
alter table T_FCF_FRETECARMEMO add fcf_antt_valorkm number;
alter table T_FCF_FRETECARMEMO add fcf_antt_RetornoVazio char(1);
alter table T_FCF_FRETECARMEMO add glb_cep_codigoRetornoVazio char(8);
alter table T_FCF_FRETECARMEMO add fcf_antt_container char(8);
-- Add comments to the columns 
comment on column T_FCF_FRETECARMEMO.fcf_fretecarmemo_eixos
  is 'Numero de Eixos';
comment on column T_FCF_FRETECARMEMO.fcf_antt_valorf
  is 'Valor da Tabela ANTT FIXO';
comment on column T_FCF_FRETECARMEMO.fcf_antt_valorkm
  is 'Valor da tabela ANTT por KM';
comment on column T_FCF_FRETECARMEMO.fcf_antt_RetornoVazio
  is 'Indica se tera retorno Vazio';
comment on column T_FCF_FRETECARMEMO.glb_cep_codigoRetornoVazio
  is 'CEP do Retorno Vazio';
comment on column T_FCF_FRETECARMEMO.fcf_antt_container
  is 'Carga com Container';



/*            VALEFRETE           */
-- Add/modify columns 
alter table T_CON_VALEFRETE add con_valefrete_percparcfinal number;
alter table T_CON_VALEFRETE add con_valefrete_parcfinal number;
alter table T_CON_VALEFRETE add con_valefrete_retvazio number;
-- Add comments to the columns 
comment on column T_CON_VALEFRETE.con_valefrete_percparcfinal
  is 'Percentual para Calculo Parcela Final';
comment on column T_CON_VALEFRETE.con_valefrete_parcfinal
  is 'Valor da Parcela Final';
comment on column T_CON_VALEFRETE.con_valefrete_retvazio
  is 'Valor do Retorno Vazio';

--Depois copiar os dados
-- Add/modify columns 
alter table T_FCF_TPFANTT add fcf_tpfannt_codigoger char(2);
-- Add comments to the columns 
comment on column T_FCF_TPFANTT.fcf_tpfannt_codigoger
  is 'Codigo da Gerenciadora para a Carga';

-- Add/modify columns 
alter table T_FCF_TPFANTT add fcf_tpfannt_codigogerp char(2);
-- Add comments to the columns 
comment on column T_FCF_TPFANTT.fcf_tpfannt_codigogerp
  is 'Codigo da Gerenciadora para a Carga Perigoso';


select * from tdvadm.t_fcf_fretecarmemo


/* ANTT */

SELECT * FROM TDVADM.T_FCF_ANTT
SELECT * FROM TDVADM.T_FCF_TPFANTT;
SELECT * FROM TDVADM.T_GLB_TPMOTORISTA;
  

select * from tdvadm.t_slf_reccust r
where r.slf_reccust_codigo like 'S_CC%'

insert into tdvadm.t_slf_reccust r values ('S_CCD','Custo Carreteiro ANTT por KM','N','KM');
insert into tdvadm.t_slf_reccust r values ('S_CCF','Custo Carreteiro ANTT Fixo','N','VL');

select t.con_calcvalefretetp_codigo,
       t.con_calcvalefretetp_descricao,
       t.con_calcvalefretetp_codpamcary,
       t.con_calcvalefretetp_tplanc
from tdvadm.t_con_calcvalefretetp t


update tdvadm.t_fcf_antt t 
  set t.slf_reccust_codigo = 'S_CCF'
where t.slf_reccust_codigo = 'S_CC'

  
insert into tdvadm.t_fcf_antt
select * from tdvadm.t_fcf_antt@DATABASE_TDX
for update;



/**************************************************************************************************/



/**************************************************************************************************/
