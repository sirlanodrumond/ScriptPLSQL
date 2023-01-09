create or replace view v_esocial_s1200 as
select
/*A*/  trim('A' || '|' || -- Identificador
         '2' || '|' || -- Finalidade
         '1' || '|' || -- Indicativo de Periodo
         i.REF1 || '|' || -- periodo apuracao,
         trim(i.CPF) || '|' || -- CPF,
         trim(i.MATRICULA) || '|' || -- PIS
         '' || '|' || -- Indicador de Desconto
         TRIM(SUBSTR(i.NOME,1,70)) || '|' || -- Nome
         to_char(i.dtnascimento,'yyyymmdd') || '|' || -- Data Nascimento
         i.CBO || '||' || chr(13) || -- CBO Carreteiro
/*D*/  'D' || '|' || -- Identificador
         trim(i.CPF) || '|' || -- Indicador de recebimento de pagamento numerico, vou utilizar o CPF
         i.CODCAT || chr(13) || -- Codigo da Categoria do Trabalhador
/*E*/  'E' || '|' || -- Identificador
         '1' || '|' || -- Tipo da Incricao
         '61139432000172' || '|' || -- Numero da Incricao
         '10000000000L' || chr(13) || -- Codigo da Lotacao - SAO PAULO
/*F*/  'F' || '|' || -- Identificador
       '' || chr(13) || -- Indentificado do Simples
/*G*/  'G' || '|' || --identificador
         '2650|LG||||' ||
         trim(to_char(i.FRETESP,'99999999990.99')) || chr(13) ||  -- Valor Pago
/*G*/  'G' || '|' || --identificador
         '7140|LG||||' ||
         trim(to_char( tdvadm.FN_FPW_VALIDAINSS(i.ref1,i.FRETESP,i.CBO),'99999999990.99')) || chr(13) ||  -- Valor do INSS
/*G*/  decode(( i.FRETESP * decode(i.CBO,'782510',0.20,1) * decode(i.CBO,'782510',0.025,0) ),0,'',
                                                                                               'G' || '|' || --identificador
                                                                                               '7340|LG||||' ||
                                                                                               trim(to_char(( i.FRETESP * decode(i.CBO,'782510',0.20,1) * decode(i.CBO,'782510',0.025,0) ) ,'99999999990.99')) || chr(13)) ||  -- Valor do SestSenat
/*G*/  'G' || '|' || --identificador
         '12640|LG||||' ||
         trim(to_char(i.FRETESP * decode(i.CBO,'782510',0.20,1),'99999999990.99')) || chr(13) ||  -- Valor da Base do INSS
/*G*/  'G' || '|' || --identificador
         '10190|LG||||' ||
         trim(to_char(i.FRETESP * decode(i.CBO,'782510',0.10,1),'99999999990.99'))                -- Valor da Base IR
          ) linha, -- Valor da Rubrica
      i.CPF,
      i.MATRICULA,
      i.REF1,
      'REMUNERACAO' arquivo
from tdvadm.V_CTB_IMPOSTOS_eSocial i
;
