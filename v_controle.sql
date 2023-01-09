create or replace view migdv.v_controle as
      select 'CUSTOMER_S_CUST_BANK_DATA'      tabela,count(*) qtde ,'CLIENTE - Dados Bancarios, conta corrente'   descricao,'Banco (FI - DM)' grupo from migdv.CUSTOMER_S_CUST_BANK_DATA
union select 'CUSTOMER_S_CUST_GEN'            tabela,count(*) qtde ,'CLIENTE - Dados Gerais'                      descricao,'' grupo from migdv.CUSTOMER_S_CUST_GEN
union select 'CUSTOMER_S_CUST_TAXNUMBERS'     tabela,count(*) qtde ,'CLIENTE - Documentos (CPF/CNPJ...)'          descricao,'' grupo from migdv.CUSTOMER_S_CUST_TAXNUMBERS
union select 'CUSTOMER_S_CUST_CONT'           tabela,count(*) qtde ,'CLIENTE - Contatos'                          descricao,'' grupo from migdv.CUSTOMER_S_CUST_CONT
union select 'CUSTOMER_S_ADDRESS'             tabela,count(*) qtde ,'CLIENTE - Endereços diferentes do principal' descricao,'' grupo from migdv.CUSTOMER_S_ADDRESS
union select 'CUSTOMER_S_ROLES'               tabela,count(*) qtde ,'CLIENTE - Regras habilitar abas no SAP'      descricao,'' grupo from migdv.CUSTOMER_S_ROLES
union select 'CUSTOMER_S_CUST_COMPANY'        tabela,count(*) qtde ,'DUVIDA - '                                   descricao,'' grupo from migdv.CUSTOMER_S_CUST_COMPANY
union select 'BANK_MASTER_S_BNKA'             tabela,count(*) qtde ,'BANCOS - Sera feito uma unica carga'         descricao,'' grupo from migdv.BANK_MASTER_S_BNKA
union select 'OPEN_ITEM_AR_S_BSID'            tabela,count(*) qtde ,'C RECEBER - Titulos'                         descricao,'' grupo from migdv.OPEN_ITEM_AR_S_BSID
union select 'OPEN_ITEM_AR_S_BSET'            tabela,count(*) qtde ,'C RECEBER - Impostos'                        descricao,'' grupo from migdv.OPEN_ITEM_AR_S_BSET
union select 'OPEN_ITEM_AR_S_WITH_ITEM'       tabela,count(*) qtde ,'C RECEBER - Imposto de Renda na Fonte '      descricao,'' grupo from migdv.OPEN_ITEM_AR_S_WITH_ITEM
union select 'GL_BALANCES_S_BSIS'             tabela,count(*) qtde ,'C RECEBER - Saldo'                           descricao,'' grupo from migdv.GL_BALANCES_S_BSIS
union select 'OPEN_ITEM_AP_S_BSIK'            tabela,count(*) qtde ,'C PAGAR - Titulos'                           descricao,'' grupo from migdv.OPEN_ITEM_AP_S_BSIK
union select 'OPEN_ITEM_AP_S_BSET'            tabela,count(*) qtde ,'C PAGAR - Impostos'                          descricao,'' grupo from migdv.OPEN_ITEM_AP_S_BSET
union select 'OPEN_ITEM_AP_S_WITH_ITEM'       tabela,count(*) qtde ,'C PAGAR - Imposto de Renda na Fonte'         descricao,'' grupo from migdv.OPEN_ITEM_AP_S_WITH_ITEM
union select 'GL_BALANCES_S_BSIS'             tabela,count(*) qtde ,'C PAGAR - Saldo'                             descricao,'' grupo from migdv.GL_BALANCES_S_BSIS
union select 'MATERIAL_S_MARA'                tabela,count(*) qtde ,'MATERIAIS'                                   descricao,'' grupo from migdv.MATERIAL_S_MARA
union select 'MATERIAL_S_MARM'                tabela,count(*) qtde ,'MATERIAIS'                                   descricao,'' grupo from migdv.MATERIAL_S_MARM
union select 'MATERIAL_S_MARD'                tabela,count(*) qtde ,'MATERIAIS'                                   descricao,'' grupo from migdv.MATERIAL_S_MARD
union select 'MATERIAL_S_MLAN'                tabela,count(*) qtde ,'MATERIAIS'                                   descricao,'' grupo from migdv.MATERIAL_S_MLAN
union select 'MATERIAL_S_MAKT'                tabela,count(*) qtde ,'MATERIAIS'                                   descricao,'' grupo from migdv.MATERIAL_S_MAKT
union select 'EQUIPMENT_S_EQUI'               tabela,count(*) qtde ,'EQUIPAMENTOS'                                descricao,'' grupo from migdv.EQUIPMENT_S_EQUI
union select 'FUNC_LOC_S_FUN_LOCATION'        tabela,count(*) qtde ,'EQUIPAMENTOS'                                descricao,'' grupo from migdv.FUNC_LOC_S_FUN_LOCATION
union select 'FIXED_ASSET_S_KEY'              tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_KEY
union select 'FIXED_ASSET_S_NETWORTHVALUATIO' tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_NETWORTHVALUATIO
union select 'FIXED_ASSET_S_POSTINGINFORMATI' tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_POSTINGINFORMATI
union select 'FIXED_ASSET_S_REALESTATE'       tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_REALESTATE
union select 'FIXED_ASSET_S_TIMEDEPENDENTDAT' tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_TIMEDEPENDENTDAT
union select 'FIXED_ASSET_S_DEPR'             tabela,count(*) qtde ,'ATIVO -  '                                   descricao,'' grupo from migdv.FIXED_ASSET_S_DEPR
union select 'VENDOR_S_SUPPL_GEN'             tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_SUPPL_GEN
union select 'VENDOR_S_SUPPL_ADDR'            tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_SUPPL_ADDR
union select 'VENDOR_S_ROLES'                 tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_ROLES
union select 'VENDOR_S_SUPP_BANK'             tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_SUPP_BANK
union select 'VENDOR_S_SUPPL_TAXNUMBERS'      tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_SUPPL_TAXNUMBERS
union select 'VENDOR_S_SUPPL_WITH_TAX'        tabela,count(*) qtde ,'FORNECEDOR - '                               descricao,'' grupo from migdv.VENDOR_S_SUPPL_WITH_TAX
union select 'VEND_EXT_S_SUPPL_GEN'           tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_SUPPL_GEN
union select 'VEND_EXT_S_SUPP_BANK'           tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_SUPPL_BANK
union select 'VEND_EXT_S_SUPPL_ADDR'          tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_SUPPL_ADDR
union select 'VEND_EXT_S_ROLES'               tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_ROLES
union select 'VEND_EXT_S_SUPPL_TAXNUMBERS'    tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_SUPPL_TAXNUMBERS
union select 'VEND_EXT_S_SUPPL_WITH_TAX'      tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.VEND_EXT_S_SUPPL_WITH_TAX
union select 'OPEN_ITEM_AP_S_BSIK'            tabela,count(*) qtde ,'CLIENTE/FORNECEDOR - '                       descricao,'' grupo from migdv.OPEN_ITEM_AP_S_BSIK
;
