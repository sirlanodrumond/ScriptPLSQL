Select *
from dba_views v
where lower(v.TEXT_VC) like '%@tdhdsaps4%'
--
tdvadm.V_SAP_IMAGENS;
tdvadm.V_SAP_CTE;

-- pegando a pesagem
select * from SAPHANADB.ZTMT0033@TDHDSAPS4DR
where ROOT_KEY = '3E40798706021EDAB1DA27FBA94E4DB9';

delete SAPHANADB.ZTMT0033@TDHDSAPS4DR
where mandt = 120
  and ROOT_KEY = '525400D3DC011ED9A5EED3CCA9B786B4' or DB_KEY = '3E40798706021EEA8391A9F673D2D10B';

-- Buscando a TRQ pela chave da nota
select x.* from SAPHANADB."/SCMTMS/D_TRQITM"@TDHDSAPS4DR x
where ZENH_CHAVE = '31200607858230000135550010000159001015900436';

select * from migdv.V_TESTE;



select x.*,x.Rowid
from tdvadm.t_arm_notapesagem_sap x
--for update
;
select x.*,x.Rowid from tdvadm.t_arm_notapesagemitem_sap x
--for update
;



select * from tdvadm.t_Arm_Notapesagem_sap where arm_nota_numero =  '15900' and glb_cliente_cgccpfremetente = '07858230000135'


Tdvadm.pkg_arm_NotaPesagem.Sp_Insert_NotaPesagem


select *
from tdvadm.t_usu_varsis
for update
  
PEDAGIO MR na mesma view do DAntas
Pedagio da Mesa


select count(*)
from tdvadm.t_con_valefrete vf
where 0 = 0
  and to_char(vf.con_valefrete_datacadastro,'YYYY') = '2020'
  and vf.con_valefrete_status is null

select *
from tdvadm.t_arm_notacte c


select f.fcf_tpfantt_codigo,count(*),sum(decode(f.fcf_fretecarmemo_particularidade,0,0,1)) part
from tdvadm.t_fcf_fretecarmemo f
group by f.fcf_tpfantt_codigo


