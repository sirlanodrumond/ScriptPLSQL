SELECT F.NRINSCRICAOFORN "N� sistema externo",
       F.RSOCIALFORN  "Raz�o social",
       F.NFANTASIAFORN "Termo de pesquisa 1",
       NULL "Termo de pesquisa 2",
       F.ENDERECOFORN "Endere�o",
       F.NR_ENDERECO "N�  do endere�o",
       F.COMPLFORN "Complemento",
       F.BAIRROFORN "Bairro",
       F.CIDADEFORN "Cidade",
       F.CODIGOUF "Estado",  
       F.SIGLA_PAIS "Pa�s",
       F.CEPFORN "C�digo Postal (CEP)",
       NULL "Zona de Transporte",
       NULL "Caixa postal",
       NULL "C�digo Postal",
       F.TELEFONEFORN "Telefone Fixo",
       NULL "Telefone Celular",
       F.FAXFORN "Fax",
       F.EMAILFORN "E-mail",
       DECODE(F.TPINSCRICAOFORN,'CNPJ',F.NRINSCRICAOFORN,NULL) "CNPJ",
       DECODE(F.TPINSCRICAOFORN,'CNPJ',NULL,F.NRINSCRICAOFORN) "CPF",
       F.INSCESTADUALFORN "Inscri��o Estadual",
       F.INSCMUNICIPALFORN "Inscri��o Municipal",
       NULL "Tipo de parceiro de neg�cio",
       'GLOBUS' "Origem dos dados"
FROM BGM.BGM_FORNECEDOR F
;
SELECT * FROM BGM.BGM_FORNECEDOR F;



                                              
