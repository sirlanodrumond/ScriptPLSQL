-- Z_OPEN_ITEM_AR_002
-- Z_OPEN_ITEM_AP_002
-- Z_GL_BALANCES_002
-- Z_FIXED_ASSET_002
-- Ver com Alexandre 

-- Solicitar um exemplo de cada Contas a Receber e Contas a Pagar

select * from migdv.open_item_ar_s_bsid; -- Documento a Receber
select * from migdv.open_item_ar_s_bset; -- Impostos do Conta a Receber
select * from migdv.open_item_ar_s_with_item; -- Imposto retido na Fonte
select * from migdv.gl_balances_s_bsis; -- Saldo


select * from migdv.open_item_ap_s_bsik; -- Documento a Pagar
select * from migdv.open_item_ap_s_bset; -- Impostos do Documento
select * from migdv.open_item_ap_s_with_item; -- Imposto retido na Fonte
select * from migdv.gl_balances_s_bsis; -- Saldo


-- Conversar com o Carlos

select * from migdv.fixed_asset_s_key; -- Cadastro do Ativo
select * from migdv.fixed_asset_s_networthvaluatio; -- Valoracao do Patrimonio
select * from migdv.fixed_asset_s_postinginformati;



select instr('000123456678','6') from dual




TDV
Cliente - Vale do Rio Doce
Codigo
SAP
Cliente - 
Titulo  - 343844 
