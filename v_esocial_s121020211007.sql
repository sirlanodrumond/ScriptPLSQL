create or replace view v_esocial_s1210 as
select trim(
/*A*/  'A' || '|' || --identificador
         '1' || '|' || --finalidade,
         '1' || '|' || --indperiodoapuracao,
         i.REF1 || '|' || -- periodoapuracao,
         trim(i.CPF) || '|' || --CPF,
         '0.00' || chr(10) || --DeducaoDependente
/*B*/  'B' || '|' || --identificador
         to_char(last_day(to_date(i.REF1||'01','yyyymmdd')),'yyyymmdd') || '|' || --dtpagamento
         '1' || '|' || -- tppagamento
         'S' || chr(10) || -- Indicador de residencia
/*C*/  'C' || '|' || --identificador
         i.REF1 || '|' || --referencia da folha
         trim(i.CPF) || '|' || --Indicador do Recibo tem que ser igual ao S-1200 tipo C - Indicador de recebimento de pagamento
         'S' || '|' || --Pagamento Total ou Parcial
         trim(to_char(i.FRETESP - i.IR - i.INSS - i.SESTSENAT,'99999999990.99')) || decode(i.ir,0,'',chr(10)) ||-- vlr liquido
/*D*/  decode(i.ir,0,'',/* 'D' || '|' || --identificador
                        'LG' || '|' || --Identificador da Rubrica
                        decode(i.CBO,'782510','9903','9203') || '|' || --Codigo da Rubrica
                        '1' || '|' || -- Quantidade de referencia
                        '1.00' || '|' || --Fator
                        trim(to_char(i.FRETESP * 0.10,'99999999990.99')) || '|' || -- Valor unitario da Rubrica
                        trim(to_char(i.FRETESP * 0.10,'99999999990.99')) || chr(10)  || -- Valor da Rubrica*/
/*D*/  'D' || '|' || --identificador
                        'LG' || '|' || --Identificador da Rubrica
                        decode(i.CBO,'782510','9203','9203') || '|' || --Codigo da Rubrica
                        '1' || '|' || -- Quantidade de referencia
                        '1.00' || '|' || --Fator
                        trim(to_char(i.IR,'99999999990.99')) || '|'  || -- Valor unitario da Rubrica
                        trim(to_char(i.IR,'99999999990.99')))  -- Valor da Rubrica
/*\*D*\  'D' || '|' || --identificador
                          'Base de cálculo da INSS' || '|' || --Identificador da Rubrica
                          decode(i.CBO,'782510','9901','9901') || '|' || --Codigo da Rubrica
                          '1' || '|' || -- Quantidade de referencia
                          '1.00' || '|' || --Fator
                          trim(to_char(i.FRETESP * 0.20,'99999999990.99')) || '|'  || -- Valor unitario da Rubrica
                          trim(to_char(i.FRETESP * 0.20,'99999999990.99')) || chr(10)  || -- Valor da Rubrica
\*D*\  'D' || '|' || --identificador
                               'INSS' || '|' || --Identificador da Rubrica
                          decode(i.CBO,'782510','9201','9201') || '|' || --Codigo da Rubrica
                               '1' || '|' || -- Quantidade de referencia
                               '1.00' || '|' || --Fator
                               trim(to_char(i.INSS+i.SESTSENAT,'99999999990.99')) || '|' || -- Valor unitario da Rubrica
                               trim(to_char(i.INSS+i.SESTSENAT,'99999999990.99'))
*/                   ) linha, -- Valor da Rubrica


      i.CPF,
      i.matricula,
      i.REF1,
      'PAGRENDIMENTOS' arquivo
from tdvadm.V_CTB_IMPOSTOS_eSocial i
--where i.REF1 = '201805'
--  AND I.PEDAGIO = 0
/*  and i.CPF in ('00478909675',
                '24197769687',
                '29042868880',
                '03347526635',
                '81911130820',
                '07261000809',
                '02010566823',
                '31120688825',
                '67140556920',
                '62092472615',
                '18302431877',
                '41686136587',
                '51558769668',
                '32164238672');*/
;
