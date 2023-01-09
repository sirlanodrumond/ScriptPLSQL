

--Libera as rotas por usuario
select *
from tdvadm.t_usu_perfil ap
where ap.usu_perfil_codigo = 'ROTASCONSULTA'
for update;

select *
from tdvadm.t_usu_aplicacaoperfil ap
where upper(ap.usu_aplicacaoperfil_descricao) like '%ROTA%'
for update;
-- Libera a rota 001 para consulta
select *
from tdvadm.t_glb_rota rt
where rt.glb_rota_codigo in ('001','070')
for update;


select *
from migdv.v_sap_


select * from migdv.v_sap_viewsTDVHANA;
select * from migdv.v_sap_viewsCOLTDVHANA;

migdv.V_SAP_CTEOBS;

select *
from tdvadm.v_kill_sessoes k
where lower(k.OSUSER) like '%sirlano%';

ALTER SYSTEM DISCONNECT SESSION '94,37277' IMMEDIATE;
ALTER SYSTEM DISCONNECT SESSION '2786,52119' IMMEDIATE;



DBLINK      - USUARIO    -               - DataBase  - Hana
QASBW       - SVCORAUSER - ORCL!n3$@2022 - qasbw     - qasbwhana:63
QASS4       - MIGDV      - ATO$mcDV20!   - qass4     - qasbshana:53
TDHDSAP     - MIGDV      - ATO$mcDV20!   - dg4odbc   - devbshana:35015
TDHDSAPBW   - SVCORAUSER - ORCL!n3$@2022 - dg4odbc   - devbwhana:36015
TDHDSAPS4   - MIGDV      - ATO$mcDV20!   - dg4odbc2
TDHDSAPS4DR - SDRUMOND   -               - dg4odbc2
TDVADM.PK_CAR_PROPRIETARIO


SELECT * FROM MIGDV.V_SAP_FILIAL;
SELECT * FROM MIGDV.V_SAP_BP x where x.COD_PARCEIRO = '1000000033' NOME_PARCEIRO is not null;
SELECT * FROM MIGDV.V_SAP_TPPARCEIROS;

SELECT * FROM MIGDV.V_SAP_CTE X WHERE X.DOCNUM = '0000000007';
SELECT * FROM MIGDV.V_SAP_CTEPARCEIRO;
SELECT * FROM MIGDV.V_SAP_CTEDFEF; -- Carregamento
select * from migdv.V_SAP_OEF where num_cte = '000016401'; -- solicitcao
SELECT * FROM MIGDV.V_SAP_CTENF;
SELECT * FROM MIGDV.V_SAP_CTEOEF x WHERE X.NUM_OEF is not null;
SELECT * FROM MIGDV.V_SAP_CTEOF x where x.NUM_OF is not null;
SELECT * FROM MIGDV.V_SAP_CTETRIBUT X WHERE X.DOCNUM = '0000000007';

SELECT * FROM MIGDV.V_SAP_CTEVALEFRETE

SELECT * FROM MIGDV.V_SAP_VALEFRETE x where x.USER_CRIACAO = 'RCARVALHO'or x.NUM_VALE_FRETE = '6000000016' order by 3;
SELECT * FROM MIGDV.V_SAP_VALE_FRETE_OF;
SELECT * FROM MIGDV.V_SAP_OF_EVENTOS;

SELECT * FROM MIGDV.V_SAP_CONTABILIDADE;
select * from migdv.

SELECT * FROM  MIGDV.V_SAP_VEICULO_MOT_PROP;
SELECT * FROM MIGDV.V_SAP_VEICULOS
SELECT * FROM MIGDV.V_SAP_MOTORISTA;

select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/"@QASBW
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CONJUNTO"@QASBW
select distinct CONDICAO_COD,CONDICAO_TEXTO FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_CTE_VERBAS"@QASBW


select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_COLETA"@QASBW



-- Notas dos Clientes
select * FROM migdv.V_NFE_CLIENTES nf
where x.ACCESS_ID in (select nf.ACCESS_ID
                      from migdv.v_sap_ctenf ctenf
                      where ctenf.ACCESS_ID = nf.ACCESS_ID
                        and ctenf.DOCNUM = ?)

           

-- t_fcf_solveic
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_OF_ETAPAS"@QASBW x where num_of = '10000000000000000088'

-- Tabela de Eventos
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_OF_EVENTOS"@QASBW;

-- Tabela de Materiais Transportados
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/ATV_MATERIAL"@QASBW;
-- Tabela das Filiais
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/ATV_CENTRO"@QASBW;

select * migdv.v_sap_valefrete
select * FROM "_SYS_BIC"."TDV.TDV_ORACLE/CV_VALE_FRETE"@QASBW;
  






select * 
from migdv.V_SAP_CTEPARCEIRO ctep, -- CTE parceiros
     migdv.v_sap_bp bp             -- BP
where ctep.COD_PARCEIRO = bp.COD_PARCEIRO
  and num_cte = '000016401'; 





CV_BP
-- Coluna KF ????
-- Coluna PIS
-- Coluna CBO

CV_CTE
-- Tabela de Mercadoria - ok
-- Tabela de CFOP
-- Como posso ter um CTe Sem OEF
-- Codigo para a FILIAL - ok
-- Demais Verbas Valores Frete Aliquota ADVL 
-- Tipo do CTe
-- Codigo de BARRA DO CTe
-- Codigo de BARRA DA NF - ok
-- Data de envio SEFAZ
-- Data de Retorno SEFAZ
-- Cod SEFAZ



-- Tabela NOVA de Usuarios
   Codigo
   Nome
   Filial
   Tipo - (Funcionario/Contratado/Estagiario/Cliente)



