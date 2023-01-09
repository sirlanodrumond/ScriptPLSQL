-- Estrutura das Tabaelas


select * from dba_directories;


-- Tabela inicial para receber os dados do CSV
select * from tdvadm.t_edi_integracsv;
-- Conversao da Integra para o perfil da calc
select * from tdvadm.v_slf_calcfretekmpreimpcsv;
-- Visao que esta na Proc
select * from tdvadm.v_slf_tabelanovacarga;
-- Testando praca.





-- EXCLUINDO 
  alter table tdvadm.t_edi_integracsv location (PLANS:'FRACIONADOSP.csv',
                                                PLANS:'FRACIONADOMG.csv',
                                                PLANS:'FRACIONADONO.csv',
                                                PLANS:'LOTACAOSS.csv',
                                                PLANS:'LOTACAOEE.csv',
                                                PLANS:'LOTACAONN.csv');

  alter table tdvadm.t_edi_integracsv location (PLANS:'FRACIONADOSP.csv');

  alter table tdvadm.t_edi_integracsv location (PLANS:'FRACIONADOMG.csv');
  alter table tdvadm.t_edi_integracsv location (PLANS:'FRACIONADONO.csv');
  alter table tdvadm.t_edi_integracsv location (PLANS:'LOTACAOSS.csv');
  alter table tdvadm.t_edi_integracsv location (PLANS:'LOTACAOEE.csv');
  alter table tdvadm.t_edi_integracsv location (PLANS:'LOTACAONN.csv');



 alter table tdvadm.t_edi_integracsv location (PLANS:'FRACIONADOSP.csv');

DELETE TDVADM.T_SLF_CALCFRETEKM KM
WHERE (KM.SLF_TABELA_CODIGO,
       KM.SLF_TABELA_SAQUE,
       KM.SLF_CALCFRETEKM_KMDE,
       KM.SLF_CALCFRETEKM_KMATE,
       KM.SLF_CALCFRETEKM_PESODE,
       KM.SLF_CALCFRETEKM_PESOATE,
       KM.SLF_CALCFRETEKM_ORIGEMI,
       KM.SLF_CALCFRETEKM_DESTINOI) IN (select TK.tabela,
                                               TK.saque,
                                               TK.kmde,
                                               TK.KMATE,
                                               TK.pesode,
                                               TK.pesoate,
                                               TK.origemib,
                                               TK.destinoib
                                        from tdvadm.v_slf_tabelakm tk
                                        where (TRIM(tk.contrato),
                                               tk.cliente,
                                               tK.grupo,
                                               tk.codcarga,
                                               tk.kmde,
                                               tk.KMATE,
                                               tk.pesode,
                                               tk.pesoate,
                                               tk.origemib,
                                               tk.destinoib) in (select TRIM(v.CONTRATO),
                                                                        RPAD(TRIM(v.CLIENTE),20),
                                                                        RPAD(TRIM(v.GRUPO),4),
                                                                        RPAD(TRIM(v.CODCARGA),3),
                                                                        TO_NUMBER(v.KMDE),
                                                                        TO_NUMBER(v.KMATE),
                                                                        TO_NUMBER(v.PESODE),
                                                                        TO_NUMBER(v.PESOATE),
                                                                        RPAD(TRIM(v.ORIGEM),8),
                                                                        RPAD(TRIM(v.DESTINO),8)
                                                                 from tdvadm.v_slf_calcfretekmpreimpcsv v
                                                                 WHERE V.CONTRATO <> 'CONTRATO'));
                                                                 


