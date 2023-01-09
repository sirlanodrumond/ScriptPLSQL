PL/SQL Developer Test script 3.0
236
Declare
  TempoI Date;
  TempoF Date;
begin
   :TempoCli := '';
   :TempoEqp := ''; 
   :TempoMat := '';
   :PMENSAGEMCli := '';
   :PMENSAGEMEqp := '';
   :PMENSAGEMMat := '';
   delete tdvadm.t_glb_sql s
   where s.glb_sql_programa like 'PKG_MIGRACAO_SAP%';
   commit;

   If nvl(substr(nvl(:pRodaBanco,'NN'),2,1),'N') = 'S' Then
      TempoI := sysdate;
      delete FROM MIGDV.BANK_MASTER_S_BNKA; 
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null where c.tabela like 'BANK_MASTER_S_%';
      commit;
   End If;

   If nvl(substr(nvl(:pRodaCli,'NN'),2,1),'N') = 'S' Then
      TempoI := sysdate;
      DELETE FROM MIGDV.CUSTOMER_S_CUST_GEN;
      DELETE FROM MIGDV.CUSTOMER_S_CUST_TAXNUMBERS;
      DELETE FROM MIGDV.CUSTOMER_S_CUST_CONT; 
      DELETE FROM MIGDV.CUSTOMER_S_ADDRESS;        
      DELETE FROM MIGDV.CUSTOMER_S_ROLES; 
      DELETE FROM MIGDV.CUSTOMER_S_CUST_COMPANY;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null where c.tabela like 'CUSTOMER_S_%' and trim(c.tabela) <> 'CUSTOMER_S_CUST_SALES_DATA';
      commit;
   End If;

   If nvl(substr(nvl(:pRodaCliVendor,'NN'),2,1),'N') = 'S' Then
      DELETE FROM MIGDV.VENDOR_S_SUPPL_GEN;
      DELETE FROM MIGDV.VENDOR_S_SUPPL_TAXNUMBERS;
      DELETE FROM MIGDV.VENDOR_S_SUPPL_ADDR;        
      DELETE FROM MIGDV.VENDOR_S_ROLES; 
      DELETE FROM MIGDV.VENDOR_S_SUPPL_WITH_TAX;
      DELETE FROM MIGDV.VENDOR_S_SUPP_BANK;
      DELETE FROM MIGDV.VENDOR_S_SUPPL_IDENT;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE c.tabela like 'VENDOR_S_%';
      commit;
   End If;


   If nvl(substr(nvl(:pRodaCliVend,'NN'),2,1),'N') = 'S' Then
      DELETE FROM MIGDV.VEND_EXT_S_SUPPL_GEN;
      DELETE FROM MIGDV.VEND_EXT_S_SUPPL_TAXNUMBERS;
      DELETE FROM MIGDV.VEND_EXT_S_SUPPL_ADDR;
      DELETE FROM MIGDV.VEND_EXT_S_ROLES;
      DELETE FROM MIGDV.VEND_EXT_S_SUPPL_BANK;
      DELETE FROM MIGDV.VEND_EXT_S_SUPPL_WITH_TAX;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE c.tabela like 'VEND_EXT_S_%';

      commit;
   End If;

   If nvl(substr(nvl(:pRodaCliSD,'NN'),2,1),'N') = 'S' Then
      DELETE FROM MIGDV.CUSTOMER_S_CUST_SALES_DATA;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE trim(c.tabela) in ('CUSTOMER_S_CUST_SALES_DATA');
      commit;
   End If;
   
   If nvl(substr(nvl(:pRodaEqp,'NN'),2,1),'N') = 'S' Then
      TempoI := sysdate;
      DELETE FROM MIGDV.EQUIPMENT_S_EQUI;
      DELETE FROM MIGDV.FUNC_LOC_S_FUN_LOCATION;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE trim(c.tabela) in ('EQUIPMENT_S_EQUI',
                                                                                                                        'FUNC_LOC_S_FUN_LOCATION');
      commit;
   End If;
         
   If nvl(substr(nvl(:pRodaMat,'NN'),2,1),'N') = 'S' Then
      TempoI := sysdate;
      DELETE FROM MIGDV.MATERIAL_S_MARA;
      DELETE FROM MIGDV.MATERIAL_S_MARM;
      DELETE FROM MIGDV.MATERIAL_S_MARD;
      DELETE FROM MIGDV.MATERIAL_S_MLAN;
      DELETE FROM MIGDV.MATERIAL_S_MAKT;
      DELETE FROM MIGDV.MATERIAL_S_MBEW;      
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE c.tabela like 'MATERIAL_S_%';
      commit;
   End If;


   
   If nvl(substr(nvl(:pRodaZLMTransp,'NN'),2,1),'N') = 'S' Then
      DELETE FROM MIGDV.ZONA_TRANSPORTE;
      DELETE FROM MIGDV.LINHA_TRANSPORTE;
      DELETE FROM MIGDV.LINHA_MEIO_TRANSP;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE trim(c.tabela) in ('ZONA_TRANSPORTE',
                                                                                                                        'LINHA_TRANSPORTE',
                                                                                                                        'LINHA_MEIO_TRANSP');
      commit;
   End If;


   If nvl(substr(nvl(:pRodaContaPagar,'NN'),2,1),'N') = 'S' Then
      DELETE FROM MIGDV.OPEN_ITEM_AP_S_BSET;
      DELETE FROM MIGDV.OPEN_ITEM_AP_S_BSIK;
      DELETE FROM MIGDV.OPEN_ITEM_AP_S_WITH_ITEM;
      update migdv.v_controle c set c.qtde = 0,c.inicio = null,c.termino = null,c.tempo = null WHERE trim(c.tabela) like 'OPEN_ITEM_AP_S_%';
      commit;
      
   End If;


  
   If nvl(substr(nvl(:pRodaBanco,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = SYSDATE,c.termino = null,c.tempo = null where c.tabela like 'BANK_MASTER_S_%';
      TempoI := SYSDATE;
      commit;
      migdv.pkg_migracao_sap.SP_SAP_BANCO_TODOS(PRESULTADO => :PRESULTADO,
                                                PMENSAGEM => :PMENSAGEM);
      TempoF := SYSDATE;
      :TempoBco := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoBco where c.tabela like 'BANK_MASTER_S_%';
      commit;
   End If;



   If nvl(substr(nvl(:pRodaCli,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = SYSDATE,c.termino = null,c.tempo = null where c.tabela like 'CUSTOMER_S_%' and trim(c.tabela) <> 'CUSTOMER_S_CUST_SALES_DATA';
   End If;
   If nvl(substr(nvl(:pRodaCliVendor,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = SYSDATE,c.termino = null,c.tempo = null WHERE c.tabela like 'VENDOR_S_%';
   End If;
   If nvl(substr(nvl(:pRodaCliVend,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = SYSDATE,c.termino = null,c.tempo = null WHERE c.tabela like 'VEND_EXT_S_%';
   End If;
   commit;

   If nvl(substr(nvl(:pRodaCli,'NN'),1,1),'N') = 'S' or 
      nvl(substr(nvl(:pRodaCliVendor,'NN'),1,1),'N') = 'S' or
      nvl(substr(nvl(:pRodaCliVend,'NN'),1,1),'N') = 'S' Then
      TempoI := SYSDATE;
      migdv.pkg_migracao_sap.SP_SAP_INSERECLIENTE(PDATA_CORTE => :PDATA_CORTE,
                                                  PTIPO_ENDERECO => :PTIPO_ENDERECO,
                                                  PRESULTADO => :PRESULTADO,
                                                  PMENSAGEM => :PMENSAGEMCli);
      TempoF := sysdate;
      :TempoCli := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
   End If;

   If nvl(substr(nvl(:pRodaCli,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoCli where c.tabela like 'CUSTOMER_S_%' and trim(c.tabela) <> 'CUSTOMER_S_CUST_SALES_DATA';
   End If;
   If nvl(substr(nvl(:pRodaCliVendor,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoCli WHERE c.tabela like 'VENDOR_S_%';
   End If;
   If nvl(substr(nvl(:pRodaCliVend,'NN'),1,1),'N') = 'S' Then
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoCli WHERE c.tabela like 'VEND_EXT_S_%';
   End If;
   commit;



   If nvl(substr(nvl(:pRodaCliSD,'NN'),1,1),'N') = 'S' Then

      TempoI := sysdate;
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = null,c.tempo = null WHERE trim(c.tabela) in ('CUSTOMER_S_CUST_SALES_DATA');
      commit;
      migdv.pkg_migracao_sap.SP_CUSTOMER_S_CUST_SALES_DATA;
      TempoF := sysdate;
      :TempoCliSD := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoCliSD WHERE trim(c.tabela) in ('CUSTOMER_S_CUST_SALES_DATA');
      commit;
   End If;



   If nvl(substr(nvl(:pRodaEqp,'NN'),1,1),'N') = 'S' Then
      TempoI := sysdate;
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = null,c.tempo = null WHERE trim(c.tabela) in ('EQUIPMENT_S_EQUI',
                                                                                                                          'FUNC_LOC_S_FUN_LOCATION');
      commit;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_EQUIPAMENTO(PRESULTADO => :PRESULTADO,
                                                       PMENSAGEM => :PMENSAGEMEqp);
      TempoF := sysdate;
      :TempoEqp := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoEqp WHERE trim(c.tabela) in ('EQUIPMENT_S_EQUI',
                                                                                                                                 'FUNC_LOC_S_FUN_LOCATION');
      commit;
   End If;

   If nvl(substr(nvl(:pRodaMat,'NN'),1,1),'N') = 'S' Then
      TempoI := sysdate;
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = null,c.tempo = null WHERE c.tabela like 'MATERIAL_S_%';
      commit;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_MATERIAL(PIDMATERIAL => :PIDMATERIAL,
                                                    PRESULTADO => :PRESULTADO,
                                                    PMENSAGEM => :PMENSAGEMMat);
      TempoF := sysdate;
      :TempoMat := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoMat WHERE c.tabela like 'MATERIAL_S_%';
      commit;
   End If;

   If nvl(substr(nvl(:pRodaZLMTransp,'NN'),1,1),'N') = 'S' Then
      TempoI := sysdate;
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = null WHERE trim(c.tabela) in ('ZONA_TRANSPORTE',
                                                                                                                            'LINHA_TRANSPORTE',
                                                                                                                            'LINHA_MEIO_TRANSP');
      commit;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_ZONATRANSPORTE;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_LINHATRANSPORTE;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_LINHA_MEIO_TRANSPORTE;
      
      TempoF := sysdate;
      :TempoZLMTransp := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoZLMTransp WHERE trim(c.tabela) in ('ZONA_TRANSPORTE',
                                                                                                                                       'LINHA_TRANSPORTE',
                                                                                                                                       'LINHA_MEIO_TRANSP');
      commit;
   End If;

   If nvl(substr(nvl(:pRodaContaPagar,'NN'),1,1),'N') = 'S' Then
      TempoI := sysdate;
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = null,c.tempo = null WHERE c.tabela like 'OPEN_ITEM_AP%';
      commit;
      migdv.pkg_migracao_sap.SP_SAP_INSERE_CONTAS_PAGAR_DOCUMENTOS(PIDCOMPANHIA => :PIDMATERIAL,
                                                                   PRESULTADO => :PRESULTADO,
                                                                   PMENSAGEM => :PMENSAGEMCtsPagar);
      TempoF := sysdate;
      :TempoContaPagar := tdvadm.fn_calcula_tempodecorrido(TempoI,TempoF,'H');
      update migdv.v_controle c set c.qtde = 0,c.inicio = TempoI,c.termino = TempoF,c.tempo = :TempoMat WHERE c.tabela like 'OPEN_ITEM_AP%';
      commit;
   End If;





end;
25
pRodaBanco
1
NN
5
pRodaCli
1
SS
5
pRodaCliVendor
1
SS
5
pRodaCliVend
1
SS
5
pRodaCliSD
1
NN
5
pRodaEqp
1
NN
5
pRodaMat
1
NN
5
pRodaZLMTransp
1
NN
5
pRodaContaPagar
1
NN
5
tempoBco
0
5
TempoCli
0
5
TempoCliSD
0
5
TempoEqp
0
5
TempoMat
0
5
TempoZLMTransp
0
5
TempoContaPagar
0
5
PDATA_CORTE
1
01/01/2019
5
PTIPO_ENDERECO
1
E
5
PIDMATERIAL
0
5
PRESULTADO
0
5
PMENSAGEMCli
0
5
PMENSAGEMEqp
0
5
PMENSAGEMMat
0
5
PMENSAGEMCtsPagar
0
5
PMENSAGEM
0
5
9
vCursor.Tipo
vIdentificadorCli
tpVEND_EXT_S_SUPPL_GEN.LIFNR
vCursor.TRACAO
vCursor.EQTYP
vErro
tpEQUIPMENT_S_EQUI2
vCursor.PLACA
vTAXNUM
