-- TABELAS DE DOMINIO DA MIGRACAO
select * from migdv.meta_dominio_coluna@database_tdx

migdv.pkg_migracao_sap

PONTOS DE ATENCAO
       Endereços da VLI pois cada Endereço novo pode significar um BP diferente
       
       

(TPSAP) TIPO CRIADO PARA SAP - Tipos definidos para migracao do SAP
                               PRO - Proprietario
                               CAR - Carreteiro
                               FPW - Motorista Folha
                               CLI - Clientes (Remtentes, Destinatarios e Sacados)
                               BGM - Fornecedores do Globlus
                               FOR - Fornecedores do Contas a pagar
(IDP) ID DA PORTARIA - codigo Criado para identificar as portarias do Cliente (Estao em nossa tabela de Endereços)
 
(CCLI) CODIGO CLIENTE - Outro codigo para definir a portaria, este e usando para definir as quantidade de entregas para os Vales de Frete.
                        (Estao em nossa tabela de Endereços)

(TPEND) TIPO DE ENDERECO - São os tipos usados hoje pela TDV para classificar o tipo do endereço.
                           Exemplo - E - Endereco do unidade
                                     C - Endereço de Cobranca
                                     X - Endereço da Expedição
                           Para a VLI Temos mais de 30 endereços pois cada ponto da FERROVIA e um Endereço.
                                                   

MIGDV.CUSTOMER_S_CUST_GEN - Tabela destinada para os Clientes e todos aqueles que podem entrar no "Contas a Receber"
                            Tipo - PRO / CLI
                            Coloquei os PRO, por causa do Conta corrente dos CARRETEIRO/AGREGADOS

Colunas 
NAMORG4 - TPEND + CCLI + IDP + TPSAP
                            
                          
MIGDV.VENDOR_S_SUPPL_GEN - Tabela destinada aos fornecedores de servicos que podem entrar no "Contas a Pagar"
                           Tipos - FPW / CAR / BGM

MIGDV.VEND_EXT_S_SUPPL_GEN - Todos os BP que podem estar no Contas a pagar e tambem no Contas a Receber, tem que estar nesta tabela.
                             Exemplo os Proprietarios, que temos que pagar os Vales de Frete (Contas a Pagar) e temos que Receber deles
                                        no Conta Corrente (Contas a Receber)


 
SELECT 

select * from migdv.customer_s_cust_gen g;
select distinct substr(g.NAMORG4,-3,3) tipo from migdv.customer_s_cust_gen g;

select distinct substr(v.name4,-3,3) tipo from migdv.vendor_s_suppl_gen v;

select distinct substr(v.name4,-3,3) tipo from migdv.vend_ext_s_suppl_gen v;
