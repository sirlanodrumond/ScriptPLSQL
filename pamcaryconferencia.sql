SELECT (SELECT MIN(TRUNC(VF.CON_VALEFRETE_DATACADASTRO)) - TO_DATE(PC.DATA,'DD/MM/YYYY')
        FROM TDVADM.T_CON_VALEFRETE VF
        WHERE VF.CON_VALEFRETE_DATACADASTRO >= TO_DATE(PC.DATA,'DD/MM/YYYY')
          AND VF.GLB_ROTA_CODIGO = PC.ROTA
          AND VF.CON_VALEFRETE_PLACA = PC.PLACA_VEIC) DIASRTPL,
       (SELECT MIN(TRUNC(VF.CON_VALEFRETE_DATACADASTRO)) - TO_DATE(PC.DATA,'DD/MM/YYYY')
        FROM TDVADM.T_CON_VALEFRETE VF
        WHERE VF.CON_VALEFRETE_DATACADASTRO >= TO_DATE(PC.DATA,'DD/MM/YYYY')
          AND VF.CON_VALEFRETE_PLACA = PC.PLACA_VEIC) DIASPL,
       (SELECT MIN(TRUNC(VF.CON_VALEFRETE_DATACADASTRO)) - TO_DATE(PC.DATA,'DD/MM/YYYY')
        FROM TDVADM.T_CON_VALEFRETE VF
        WHERE VF.CON_VALEFRETE_DATACADASTRO >= TO_DATE(PC.DATA,'DD/MM/YYYY')
          AND VF.CON_VALEFRETE_PLACA = PC.PLACA_VEIC
          AND TRIM(VF.CON_VALEFRETE_CARRETEIRO) = PC.CPF_MOTORIS ) DIASPLMOT,
       (SELECT MIN(TRUNC(VF.CON_VALEFRETE_DATACADASTRO))
        FROM TDVADM.T_CON_VALEFRETE VF
        WHERE VF.CON_VALEFRETE_DATACADASTRO >= TO_DATE(PC.DATA,'DD/MM/YYYY')
          AND VF.CON_VALEFRETE_PLACA = PC.PLACA_VEIC
          AND TRIM(VF.CON_VALEFRETE_CARRETEIRO) = PC.CPF_MOTORIS ) DIAVF,
       PC.*
FROM (select DECODE(x.edi_integra_col01,'BA-CAMACARI','057',
                                        'BA-FEIRA DE SANTANA','051',
                                        'CE-FORTALEZA','210',
                                        'ES-VIANA','185',
                                        'MA-ACAILANDIA','470',
                                        'MA-SAO LUIS','460',
                                        'MG-CONTAGEM','197',
                                        'SP-SAO PAULO','011',
                                        'SP-SANTOS','060',
                                        'SP-PIRACICABA','620',
                                        'SP-RIBEIRAO PRETO','610',
                                        'SP-PINDAMONHANGABA','421',
                                        'SP-MAUA','023',
                                        'SP-CUBATAO','232',
                                        'RS-CANOAS','430',
                                        'RJ-RIO DE JANEIRO','030',
                                        'PR-CURITIBA','263',
                                        'PE-JABOATAO DOS GUARARAPES','045',
                                        'PA-PARAUAPEBAS','160',
                                        'PA-OURILANDIA DO NORTE','175',
                                        'PA-MARABA','165',
                                        'MG-SETE LAGOAS','196',
                                        'MG-TIMOTEO','157',
                                        'MG-UBERLANDIA','198',
                                        'PA-ANANINDEUA','170',
                                        x.edi_integra_col01) ROTA,
             x.edi_integra_col01 LOCALIDADE,
             x.edi_integra_col02 EMBARCADOR,
             x.edi_integra_col03 DATA,
             x.edi_integra_col04 HORA,
             LPAD(REPLACE(REPLACE(x.edi_integra_col05,'.',''),'-',''),11,'0') CPF_MOTORIS,
             x.edi_integra_col06 NOME,
             LPAD(REPLACE(REPLACE(x.edi_integra_col07,'.',''),'-',''),14,'0') CPFCNPJ_PROPRIETARIO,
             x.edi_integra_col08 NOME_PROPRIETARIO,
             x.edi_integra_col09 TIPO_PROPRIETARIO,
             x.edi_integra_col10 PLACA_VEIC,
             x.edi_integra_col11 PLACA_CARRETA,
             x.edi_integra_col12 STAFAT_PROP,
             x.edi_integra_col13 LIB_EXCEPCIONAL,
             x.edi_integra_col14 CONSULTAS_COBRADAS
      from tdvadm.t_edi_integracsv x
      where x.edi_integra_col03 not in ('TIPO','FOB','CIF')) PC
WHERE PC.LOCALIDADE <> 'LOCALIDADE';

\\tdv_producao\backup\planilhas_in\csv\191018151633834.xlsx
\\tdvftp.tdv.lan\home\rmbenasse\191018151633834

select * from rmadm.t_glb_benasserec r
where trunc(r.glb_benasserec_gravacao) >= trunc(sysdate)
  and ( lower(r.glb_benasserec_origem) like '%sirlano.drumond@dellavolpe.com.br%' or lower(r.glb_benasserec_origem) like '%jessica%' )
  order by 1;
  
select * from tdvadm.t_edi_planilhacfg x
where x.edi_planilhacfg_codigo = 'INCTAB'







  
