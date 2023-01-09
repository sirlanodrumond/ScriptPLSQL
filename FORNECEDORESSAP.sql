SELECT F.NRINSCRICAOFORN "Nº sistema externo",
       F.RSOCIALFORN  "Razão social",
       F.NFANTASIAFORN "Termo de pesquisa 1",
       NULL "Termo de pesquisa 2",
       F.ENDERECOFORN "Endereço",
       F.NR_ENDERECO "Nº  do endereço",
       F.COMPLFORN "Complemento",
       F.BAIRROFORN "Bairro",
       F.CIDADEFORN "Cidade",
       F.CODIGOUF "Estado",  
       F.SIGLA_PAIS "País",
       F.CEPFORN "Código Postal (CEP)",
       NULL "Zona de Transporte",
       NULL "Caixa postal",
       NULL "Código Postal",
       F.TELEFONEFORN "Telefone Fixo",
       NULL "Telefone Celular",
       F.FAXFORN "Fax",
       F.EMAILFORN "E-mail",
       DECODE(F.TPINSCRICAOFORN,'CNPJ',F.NRINSCRICAOFORN,NULL) "CNPJ",
       DECODE(F.TPINSCRICAOFORN,'CNPJ',NULL,F.NRINSCRICAOFORN) "CPF",
       F.INSCESTADUALFORN "Inscrição Estadual",
       F.INSCMUNICIPALFORN "Inscrição Municipal",
       NULL "Tipo de parceiro de negócio",
       'GLOBUS' "Origem dos dados"
FROM BGM.BGM_FORNECEDOR F
;
SELECT * FROM BGM.BGM_FORNECEDOR F;



                                              
