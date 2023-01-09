-- select para verificar as estruturas que mudaram
Select * from tdvadm.v_comparativotabtdhtdp;
--select para contar os index hoje (02/09/2020) sao 8
select * from dba_indexes i where i.owner = 'MIGDV';


drop index MIGDV.ID_CUSTOMER_S_CUST_GEN;
create index MIGDV.ID_CUSTOMER_S_CUST_GEN on MIGDV.CUSTOMER_S_CUST_GEN (kunnr, street, house_num1);
drop index MIGDV.ID_CUSTOMER_S_CUST_GEN1;
create index MIGDV.ID_CUSTOMER_S_CUST_GEN1 on MIGDV.CUSTOMER_S_CUST_GEN (trim(SORTL));
drop index MIGDV.ID_CUSTOMER_S_ADDRESS;
create index MIGDV.ID_CUSTOMER_S_ADDRESS on MIGDV.CUSTOMER_S_ADDRESS (kunnr, street, house_num1 );
drop index MIGDV.ID_CUSTOMER_S_ADDRESS2;
create index MIGDV.ID_CUSTOMER_S_ADDRESS2 on MIGDV.CUSTOMER_S_ADDRESS (KUNNR);
drop index MIGDV.ID_VENDOR_S_SUPPL_GEN;
create index MIGDV.ID_VENDOR_S_SUPPL_GEN on MIGDV.VENDOR_S_SUPPL_GEN (lifnr, street, house_num1 );
drop index MIGDV.ID_VENDOR_S_SUPPL_GEN1;
create index MIGDV.ID_VENDOR_S_SUPPL_GEN1 on MIGDV.VENDOR_S_SUPPL_GEN (trim(SORTL));
drop index MIGDV.id_VENDOR_S_SUPPL_ADDR;
create index MIGDV.id_VENDOR_S_SUPPL_ADDR on MIGDV.VENDOR_S_SUPPL_ADDR (lifnr, street, house_num1 );
drop index MIGDV.ID_VENDOR_S_SUPPL_ADDR2;
create index MIGDV.ID_VENDOR_S_SUPPL_ADDR2 on MIGDV.VENDOR_S_SUPPL_ADDR (lifnr);

migdv.pkg_migracao_sap
/***********************************************/


