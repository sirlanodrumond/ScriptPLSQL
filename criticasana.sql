asldfkkalskdfãs
update MIGDV.V_CONTROLE v
  set v.qtde = (select t.qtde
                from migdv.v_controle_v t
                where t.tabela = v.tabela)
where trunc(v.inicio) = trunc(sysdate)
;
commit;
select *
from tdvadm.t_glb_sql s    
where s.glb_sql_programa like 'PKG_MIGRACAO_SAP%';

select *
from migdv.v_controle v
where 0 = 0
--  and v.tabela like '%RECURSO%'
  AND v.qtde <> 0
  and trunc(v.inicio) = trunc(sysdate)
;

select v.tabela,
       v.qtde,
       vX.qtde qtdeTDX,
       v.descricao,
       v.grupo,
       v.inicio,
       v.termino,
       v.tempo
from migdv.v_controle v,
     migdv.v_controle@database_tdx vX
where 0 = 0
  AND v.tabela = vX.tabela
  and v.tabela like '%RECURSO%'
--  AND v.qtde <> 0  
  and v.qtde <> vX.qtde
  and trunc(v.inicio) = trunc(sysdate)



ORA-01400: cannot insert NULL into ("MIGDV"."VENDOR_S_SUPPL_GEN"."POST_CODE1")]
NOVO - 59584084100


select v.NOM_ESTRUTURA,
       V.IDT_REGRA,
       R.DSC_REGRA,
       R.DSC_QUERY,
       COUNT(*) QTDE,
       R.NOM_CAMPO_CHAVE
From migdv.diag_registro_erro_validacao@database_tdx v,
     migdv.meta_regra_validacao@database_tdx r
where v.IDT_REGRA = r.IDT_REGRA
  and r.IND_IMPEDITIVO = 'N'
  AND R.IND_ATIVO = 'S'
GROUP BY v.NOM_ESTRUTURA,
         V.IDT_REGRA,
         R.DSC_REGRA,
         R.DSC_QUERY,
         R.NOM_CAMPO_CHAVE
ORDER BY 1,2;           
         
select v.NOM_ESTRUTURA,
       V.IDT_REGRA,
       R.DSC_REGRA,
       R.DSC_QUERY,
       COUNT(*) QTDE,
       R.NOM_CAMPO_CHAVE
From migdv.diag_registro_erro_validacao@database_tdx v,
     migdv.meta_regra_validacao@database_tdx r
where v.IDT_REGRA = r.IDT_REGRA
  and r.IND_IMPEDITIVO = 'S'
  AND R.IND_ATIVO = 'S'
GROUP BY v.NOM_ESTRUTURA,
         V.IDT_REGRA,
         R.DSC_REGRA,
         R.DSC_QUERY,
         R.NOM_CAMPO_CHAVE
ORDER BY 1,2;          

----IMPEDITIVO = SIM  
-- 13-Estados brasileiros (campo REGION) preenchidos para registros de endereços de outros países  
select kunnr, country, region, STREET,CA.*  from migdv.CUSTOMER_S_ADDRESS ca where country <> 'BR'   and region in ('SP', 'MG', 'ES', 'RJ', 'PR', 'RS', 'SC', 'TO', 'GO', 'MT', 'MS', 'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'MA', 'PA', 'PB', 'PE', 'PI', 'RN', 'RO', 'RR', 'SE');
-- OCORRENCIAS = 69
-- ACAO onde for <> de BR colocar region EX e limpar Street, house_num1 e house_no2

-- 23  Contatos repetidos  
-- ORIGINAL
select kunnr, title, vname, lname, abtnr
  from migdv.CUSTOMER_S_CUST_CONT
 where title || vname || lname || abtnr in (   
select title || vname || lname || abtnr 
  from migdv.CUSTOMER_S_CUST_CONT 
 where lname <> ' ' 
 group by title, vname, lname, abtnr
having count(1) > 1);
-- OCORRENCIAS 16 mais na realidade sao 8 registros duplicados

--SIRLANO
select g.sortl,c.kunnr, c.title, c.vname, c.lname, c.abtnr,C.*
  from MIGDV.CUSTOMER_S_CUST_CONT c,
       migdv.customer_s_cust_gen g
 where c.kunnr = g.kunnr
   and c.lname <> ' '
   and g.sortl || c.title || c.vname || c.lname || abtnr in (select g1.sortl || c1.title || c1.vname || c1.lname || c1.abtnr 
                                                             from MIGDV.CUSTOMER_S_CUST_CONT c1,
                                                                  migdv.customer_s_cust_gen g1
                                                             where c1.kunnr = g1.kunnr
                                                               and c1.lname <> ' ' 
                                                             group by g1.sortl, c1.title, c1.vname, c1.lname, c1.abtnr
                                                             having count(1) > 1);
-- OCORRENCIAS 4 mais 2 registros dupkicados ,SENDO QUE O kunnr 5547 TEM TELEFONES DIFERENTES
-- ACAO 
-- OK

-- 27-Gerado um registro para cada cliente com o sobrenome (campo LNAME) e departamento (campo ABTNR) preenchidos com o valor ¿EMLCTE¿.
--    Sobre este item tivemos o seguinte retorno da Della Volpe:RESPOSTAO Contato EMLCTE e igual em todos os clientes que sao tomadores de frete, 
--    pois e o email para envio do XML do CTe.Esta opcao e valida para todos os clientes que querem receber o XML e PDF do CTEConforme alinhado com o funcional, 
--    esta informação do email do CTE não deve ser tratada nesta estrutura  
select kunnr, title, vname, lname, abtnr  from MIGDV.CUSTOMER_S_CUST_CONT c where vname like '%EMLCTE%';
--OCORRENCIAS 687 - sendo dois registros sem email
-- ACAO - retirar onde não tiver o email
-- OK

-- 28-Contatos criados sem nada ou somente com o nome e sem dados de contato para o cliente. Informado pela TDV como em Clean-up   
select *  from migdv.CUSTOMER_S_CUST_CONT where vname not like '%EMLCTE%'   and tel_no = ' '   and e_mail = ' ';
-- OCORRENCIAS = 14
-- Acao validar o telefone e e_mail em branco
-- OK

--CUSTOMER_S_CUST_GEN
-- 37-Logradouro (rua) do endereço em branco e o número preenchido  
select kunnr, street, house_num1, house_no2,country, region  from MIGDV.customer_s_cust_gen ca where street = ' '       and house_no2 <> ' ';
-- OCORRENCIAS 319
-- ACAO quando street em branco e limpar house_num1 e house_no2
-- OK

--39  Estados brasileiros (campo REGION) preenchidos para registros de endereços de outros países 
select kunnr, country, region  from MIGDV.customer_s_cust_gen ca where country <> 'BR'   and region in ('SP', 'MG', 'ES', 'RJ', 'PR', 'RS', 'SC', 'TO', 'GO', 'MT', 'MS', 'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'MA', 'PA', 'PB', 'PE', 'PI', 'RN', 'RO', 'RR', 'SE');
--OCORRENCIAS 315
-- ACAO onde for <> de BR colocar region EX e limpar Street, house_num1 e house_no2
-- OK

-- 40-Inscrição Municipal (TAXTYPE = `IM) zerada. Informado pela TDV como em Clean-up  
select DISTINCT taxnum,G.SORTL
  from MIGDV.CUSTOMER_S_CUST_TAXNUMBERS T,
       MIGDV.CUSTOMER_S_CUST_GEN G
 where T.KUNNR = G.KUNNR
   AND taxtype = 'IM'
   and taxnum <> 'ISENTO'
   and ((is_number(taxnum) = 1
   and   to_number(taxnum) = 0)
    or  is_number(taxnum) = 2);
--OCORRENCIAS 3
--PROBLEMAS O QUE FAZ A FUNCAO IS_NUMBER
-- ACAO - COLOCAR IM SO SE FOR NUMERICO <> 0 OU ISENTO
-- OK

-- 47-Peso do equipamento preenchido de forma inconsistente para veículos (ex: 0 Kg, veículo com peso 1,5 Kg). Quando não tiver a informação, não preencher. Verificar a unidade de medida. Impeditivo de carga quando a quantidade for 0 / brancos e a medida estiver preenchida 
select equnr, eqktx, brgew, gewei   from MIGDV.EQUIPMENT_S_EQUI where eqtyp in ('A', 'C', 'E', 'L', 'K', 'R', 'V')   and gewei = 'KG'   and brgew < 1000;
-- OCORRENCIAS 1357
-- ACAO NÃO MADAR O PESO DOS EQUIPAMENTOS gewei = 'KG'   and brgew
-- OK

--54-Número de Série do Fabricante (campo SERGE) preenchido com zeros  
select equnr, eqktx, SERGE  from (select equnr, eqktx, serge from MIGDV.EQUIPMENT_S_EQUI where is_number(serge) = 1) a where serge like '00%';
--OCORRENCIA 19
--ACAO ONDE O CAMPO serge FOR 0 OU NÃO NUMERICO MANDAR ' '  OU SE MENOR QUE 17 CARACTERES
-- OK
  
-- 56-Identificador do Ativo (campo ANLNR) em Branco para todos os registros. Preencher este campo sempre que houver um ativo fixo representado como equipamento  
select * from (select count(1) qtd_reg  from MIGDV.EQUIPMENT_S_EQUI where anlnr <> ' ') where qtd_reg = 0;
-- OCORRENCIAS 1 NÃO ACHEI REGISTRO
-- OK

--59-Número de Série do Equipamento (campo GERNR) preenchido com zeros 
select equnr, eqktx, gernr  from (select equnr, eqktx, gernr from migdv.EQUIPMENT_S_EQUI where is_number(gernr) = 1) a where gernr like '00%';
--OCORRENCIA 19
--ACAO ONDE O CAMPO gernr FOR 0 OU NÃO NUMERICO MANDAR ' '  OU SE MENOR QUE 17 CARACTERES
-- OK

--62-Grupo de Identificador da Moeda (campo WAERS) preenchido sem valor informado (campo ANSWT). Informar a moeda quando valor informado no campo Valor de Aquisição (ANSWT) 
select equnr, answt, WAERS  from MIGDV.EQUIPMENT_S_EQUI where (ANSWT is null    or  ANSWT = 0)   and WAERS <> ' ';
-- OCORRENCIA 886
-- ACAO QUANDO VALOR ANSWT FOR ZERO NAO INFORMAR A MOEDA WAERS
-- OK

--65-Grupo de Material (campo MATKL) preenchido com valores desconhecidos  
select matnr, matkl  from migdv.material_s_mara where matkl not like 'Z%';
-- OCORRENCIA 6 
-- ACAO ALTERAR PARA 'ZMANUT' ONDE ENCONTRAR 'YBFA10' -- Bens de baixo valor
-- OK

-- 68-O Volume do material (campo VOLUM) e sua unidade de medida do volume (campo VOLEH) estão preenchidos com zeros. 
--    Se não tiver a informação, não trazer nenhum destes campos preenchido (enviar branco).  
select MATNR, VOLUM, VOLEH  from MIGDV.MATERIAL_S_MARA where VOLUM = 0    or VOLEH = 0;
-- OCORRENCIA 5772
-- ACAO O CAMPO VOLUM E DO TIPO NUMERICO E NAO ACEITA BRANCOS O VOLEH, ALTERAR PARA BRANCOS
-- OK

--69-Comprimento, Largura e Altura (campos LAENG, BREIT e HOEHE) preenchidos com zeros. 
--   Se não tiver a informação, não trazer nenhum destes campos preenchido (enviar branco)  
select MATNR, LAENG, BREIT, HOEHE  from MIGDV.MATERIAL_S_MARA where LAENG  = 0     or BREIT  = 0    or HOEHE = 0;
-- OCORRENCIA 5772
-- ACAO QUANDO O CAMPO E NUMERO NÃO ACEITA BRANCOS E NEM NULOS
-- OK

--80-Nenhum dos endereços possui complemento no campo HOUSE_NO2 (Ex: bloco, sala, prédio, etc.). Verificar se o campo está sendo preenchido  
select * from (select count(1) qtd_reg  from MIGDV.vendor_s_suppl_addr ca where house_num1 is not null   and trim(house_num1) <> '0') where qtd_reg = 0;
-- OCORRENCIA 1 NÃO ENCONTREI 
-- ACAO 

--96-Logradouro (rua) do endereço em branco e o número preenchido  
select lifnr, street, house_num1, house_no2  from migdv.vendor_s_suppl_gen ca where street = ' '       and house_no2 <> ' ';
-- OCORRENCIA 5
-- ACAO NÃO SUBIR SE STREET E HOUSE_NO2 = ' '
-- OK

--101 Inscrição Estadual (TAXTYPE = `IE) zerada. Provavelmente problema de Clean-up  
select *   from MIGDV.vendor_s_suppl_TAXNUMBERS where taxtype = 'IE'   and taxnum <> 'ISENTO'   and ((is_number(taxnum) = 1   and   to_number(taxnum) = 0)    or  is_number(taxnum) = 2);
-- OCORRENCIA 1 
-- ACAO NÃO SUBIR IE ZERADO
-- OK

--108 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.VENDOR_S_SUPPL_ADDR) tab where tab.qtd_reg = 0;
-- OCORRENCIA 1 NÃO ENCONTREI 
-- ACAO 
--109-Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.VENDOR_S_SUPPL_WITH_TAX) tab where tab.qtd_reg = 0;
-- OCORRENCIA 0 
-- ACAO VERIFICAR PORQUE NAO SUBIU
--118-Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.MATERIAL_S_MBEW) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO 
--119-Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.MATERIAL_S_MARM) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO 
--123-Nenhum dos endereços possui complemento no campo HOUSE_NO2 (Ex: bloco, sala, prédio, etc.). Verificar se o campo está sendo preenchido  
select * from (select count(1) qtd_reg  from MIGDV.vend_ext_s_suppl_addr ca where house_num1 is not null   and trim(house_num1) <> '0') where qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA

--136 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_SUPPL_GEN) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA
--139 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_ROLES) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA
--140 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_SUPPL_ADDR) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA
--141 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_SUPPL_WITH_TAX) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA
--137 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_SUPPL_TAXNUMBERS) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA
--138 Estrutura Vazia. Objeto Não Pode ser Carregado  
select * from (select count(1) qtd_reg from MIGDV.vend_ext_S_SUPPL_IDENT) tab where tab.qtd_reg = 0;
-- OCORRENCIA 
-- ACAO ESTA TABELA NAO FOI CARREGADA

-- SQL USADO incluido o CNPJ que esta na coluna SORTL
select vsa.kunnr, cg.sortl,vsa.street, vsa.house_num1, vsa.house_no2,QTDE
  from MIGDV.customer_s_address vsa,
       MIGDV.Customer_s_Cust_Gen CG,
       (select CG1.sortl || '|' || ca.street || '|' || ca.house_num1 || '|' || ca.house_no2 chave, 
               CG1.sortl,
               COUNT(*) QTDE
          from MIGDV.customer_s_address ca,
               MIGDV.Customer_s_Cust_Gen CG1
         where CA.KUNNR = CG1.KUNNR
           AND CA.street <> ' '
           and CA.house_num1 not in (' ', '0')
         group by CG1.sortl,CA.street, CA.house_num1, CA.house_no2
        having count(1) > 1) e
 where vsa.kunnr = cg.kunnr
   and e.chave =  cg.SORTL || vsa.street || '|' || vsa.house_num1 || '|' || vsa.house_no2

select distinct ce.glb_cliend_endereco
from tdvadm.t_glb_cliend ce
where ( instr(ce.glb_cliend_endereco, 'ROD') > 0  or  instr(ce.glb_cliend_endereco, 'BR') > 0 ) and 
      ( ce.glb_cliend_endereco not like 'R %' ) and 
      ( ce.glb_cliend_endereco not like '%RUA %' ) and 
      ( ce.glb_cliend_endereco not like 'AV %' ) and 
      ( ce.glb_cliend_endereco not like '%KM%' )



  select kunnr, street, house_num1  from migdv.CUSTOMER_S_ADDRESS ca where house_num1 is null    or trim(house_num1) = '0';
  select distinct street, house_num1  from MIGDV.CUSTOMER_S_ADDRESS ca where (instr(street, 'ROD') > 0    or  instr(street, 'BR') > 0)   and street not like 'R %'   and street not like 'RUA %'   and street not like 'AV %'   and street not like '%KM%'   and length (street) < 10;


----IMPEDITIVO = NAO  
  
--CUSTOMER_S_ADDRESS  
--6-Número do endereço em branco ou zerado. Informado pela TDV como em Clean-up   
  select kunnr, house_num1  from migdv.CUSTOMER_S_ADDRESS ca where house_num1 is null    or trim(house_num1) = '0';
  --OCORRENCIA 68

--7-Número da Rodovia (ex: BR-101) sendo tratado como número do endereço no campo HOUSE_NUM1. Informado pela TDV como em Clean-up 
  select kunnr, street, house_num1  from MIGDV.CUSTOMER_S_ADDRESS ca where (instr(street, 'ROD') > 0    or  instr(street, 'BR') > 0)   and street not like 'R %'   and street not like 'RUA %'   and street not like 'AV %'   and street not like '%KM%'   and length (street) < 10;
  --OCORRENCIA 32
  
--8-Identificação da quilometragem do endereço (termo KM) dentro do campo do nome do logradouro (campo STREET). Informado pela TDV como em Clean-up   
  select kunnr, street, house_num1  from MIGDV.CUSTOMER_S_ADDRESS ca where instr(street, 'KM') > 0;
  --OCORRENCIA  59

--10-Mais de um cliente com o mesmo endereço. Observamos que alguns deles parecem ocorrer por problemas na ¿decomposição¿ do endereço entre logradouro, número e complemento.Alguns endereços deverão realmente estar duplicados, conforme informado pela DV no comentário abaixo:Para os endereços iguais temos Como tipos de endereços e codigo de Clientes diferentes.Exemplo : Almoxarifados da Vale que estão no mesmo endereço Portaria, mais são galpoes e CNPJ diferentes.Temos tambem o fator tipo de endereço, COBRANCA, UNIDADE, EXPEDICAO e etc¿;
   select kunnr, street, house_num1, house_no2  from MIGDV.customer_s_address vsa     , (select street || '|' || house_num1 || '|' || house_no2 chave          from MIGDV.customer_s_address ca         where street <> ' '           and house_num1 not in (' ', '0')         group by street, house_num1, house_no2        having count(1) > 1) e where e.chave = vsa.street || '|' || vsa.house_num1 || '|' || vsa.house_no2;
   --OCORRENCIA  78

--CUSTOMER_S_CUST_COMPANY 
  --21  Termo de Pagamento Não Preenchido 
  select kunnr, zterm  from MIGDV.customer_s_cust_company where zterm = ' ';
  --OCORRENCIA 10488

  --22  Forma de Pagamento Não Preenchida 
  select kunnr, zwels_01  from MIGDV.customer_s_cust_company where zwels_01 = ' ';
  --OCORRENCIA 10488

--CUSTOMER_S_CUST_CONT  
--25  Em alguns dos casos de preenchimento do primeiro nome (coluna VNAME) o dado informado é o título do contato, que deveria estar na coluna TITLE, que está em branco  
  select kunnr, title, vname, lname  from MIGDV.CUSTOMER_S_CUST_CONT where vname <> ' '   and length(vname) <= 3;
  --OCORRENCIA 7
  
--26  Primeiro nome do contato preenchido no sobrenome (campo LNAME)  
  select kunnr, title, vname, lname  from MIGDV.CUSTOMER_S_CUST_CONT where vname <> ' '   and length(vname) <= 3;
  --OCORRENCIA 7
  
--30  A segunda coluna do nome da Organização (NAMORG2) está repetindo o último caracter do primero campo de nome (NAMORG1) 
  select kunnr, namorg1, namorg2, substr(namorg1, -1, 1)  from MIGDV.CUSTOMER_S_CUST_GEN where namorg2 <> ' '   and substr(namorg1, -1, 1) =  substr(namorg2, 1, 1);
  --OCORRENCIA 46

--CUSTOMER_S_CUST_GEN 
--31  Quando houver necessidade de quebra pelo tamanho do nome da empresa, que a quebra seja feita sem ¿quebrar¿ palavras ao meio entre os dois campos. Por exemplo, se o LTDA for ficar quebrado (¿LT¿ em NAMORG1 e ¿DA¿ em NAMORG2), migrar toda a palavra em NAMORG2 (¿LTDA¿), sem deixar parte dela em NAMEORG1 
  select kunnr, namorg1, namorg2  from MIGDV.CUSTOMER_S_CUST_GEN where namorg2 <> ' ';
  --OCORRENCIA 2474

--33  Número do endereço em branco ou zerado. Informado pela TDV como em Clean-up   
  select kunnr, house_num1  from MIGDV.customer_s_cust_gen ca where house_num1 is null    or trim(house_num1) = '0';
  --OCORRENCIA 92
  
--34  Número da Rodovia (ex: BR-101) sendo tratado como número do endereço no campo HOUSE_NUM1. Informado pela TDV como em Clean-up 
  select kunnr, street, house_num1  from MIGDV.customer_s_cust_gen ca where (instr(street, 'ROD') > 0    or  instr(street, 'BR') > 0)   and street not like 'R %'   and street not like 'RUA %'   and street not like 'AV %'   and street not like '%KM%'   and length (street) < 10;
  --OCORRENCIA 308
  
--35  Identificação da quilometragem do endereço (termo KM) dentro do campo do nome do logradouro (campo STREET). Informado pela TDV como em Clean-up   
  select kunnr, street, house_num1  from MIGDV.customer_s_cust_gen ca where instr(street, 'KM') > 0;
  --OCORRENCIA 270
  
--36  Mais de um cliente com o mesmo endereço. Observamos que alguns deles parecem ocorrer por problemas na ¿decomposição¿ do endereço entre logradouro, número e complemento.Alguns endereços deverão realmente estar duplicados, conforme informado pela DV no comentário abaixo:Para os endereços iguais temos Como tipos de endereços e codigo de Clientes diferentes.Exemplo : Almoxarifados da Vale que estão no mesmo endereço Portaria, mais são galpoes e CNPJ diferentes.Temos tambem o fator tipo de endereço, COBRANCA, UNIDADE, EXPEDICAO e etc¿ 
  select kunnr, street, house_num1, house_no2  from MIGDV.customer_s_cust_gen vsa     , (select street || '|' || house_num1 || '|' || house_no2 chave          from MIGDV.customer_s_cust_gen ca         where street <> ' '           and house_num1 not in (' ', '0')         group by street, house_num1, house_no2        having count(1) > 1) e where e.chave = vsa.street || '|' || vsa.house_num1 || '|' || vsa.house_no2;
  --OCORRENCIA 148

--EQUIPMENT_S_EQUI  
--42  Nome do Equipamento parece estar truncado em 19 posições desnecessariamente, pois o campo tem 80 posições. Sugerimos também rever se realmente é necessário continuar com o tipo do equipamento no nome, considerando que existe um campo somente para esta informação  
  select e.equnr, e.eqktx, e.eqtyp, dc.dsc_dominio  from MIGDV.EQUIPMENT_S_EQUI e     , MIGDV.meta_dominio_coluna@DATABASE_TDX dc where dc.nom_coluna = 'EQTYP'   and e.eqtyp = dc.nom_dominio;
  --OCORRENCIA 1523

--VENDOR_S_SUPPL_GEN  
--89  A segunda coluna do nome  (NAME_LAST) está repetindo o último caracter do primero campo de nome (NAME_FIRST)  
  select lifnr, name_first, name_last  from MIGDV.vendor_s_suppl_gen where name_last <> ' '   and substr(name_first, -1, 1) =  substr(name_last, 1, 1);
  --OCORRENCIA 5
  
--90  Quando houver necessidade de quebra pelo tamanho do nome da empresa, que a quebra seja feita sem ¿quebrar¿ palavras ao meio entre os dois campos. Por exemplo, se o LTDA for ficar quebrado (¿LT¿ em NAME_FIRST e ¿DA¿ em NAME_LAST), migrar toda a palavra em NAME_LAST (¿LTDA¿), sem deixar parte dela em NAME_FIRST  
  select lifnr, name_first, name_last  from MIGDV.vendor_s_suppl_gen where name_last <> ' ';
  --OCORRENCIA 426
  
--92  Número do endereço em branco ou zerado. Informado pela TDV como em Clean-up   
  select lifnr, house_num1  from MIGDV.vendor_s_suppl_gen ca where house_num1 is null    or trim(house_num1) = '0';
  --OCORRENCIA 74
  
--93  Número da Rodovia (ex: BR-101) sendo tratado como número do endereço no campo HOUSE_NUM1. Informado pela TDV como em Clean-up 
  select lifnr, street, house_num1  from migdv.vendor_s_suppl_gen ca where (instr(street, 'ROD') > 0    or  instr(street, 'BR') > 0)   and street not like 'R %'   and street not like 'RUA %'   and street not like 'AV %'   and street not like '%KM%'   and length (street) < 10;
  --OCORRENCIA 102
  
--94  Identificação da quilometragem do endereço (termo KM) dentro do campo do nome do logradouro (campo STREET). Informado pela TDV como em Clean-up   
  select lifnr, street, house_num1  from migdv.vendor_s_suppl_gen ca where instr(street, 'KM') > 0;
  --OCORRENCIA 17
  
--95  Mais de um cliente com o mesmo endereço. 
--    Observamos que alguns deles parecem ocorrer por problemas na decomposição do endereço entre logradouro, número e complemento.  
  select lifnr, street, house_num1, house_no2  from migdv.vendor_s_suppl_gen vsa     , (select street || '|' || house_num1 || '|' || house_no2 chave          from migdv.vendor_s_suppl_gen ca         where street <> ' '           and house_num1 not in (' ', '0')         group by street, house_num1, house_no2        having count(1) > 1) e where e.chave = vsa.street || '|' || vsa.house_num1 || '|' || vsa.house_no2;
  --OCORRENCIA 72
  -- ESTA SENDO VISTO NA HIGIENIZAÇÃO
  
--VENDOR_S_SUPPL_IDENT  
--103 Documento preenchido com sequencia de caracteres idênticos (repetidos)  
  select *   from MIGDV.VENDOR_S_SUPPL_IDENT where length(trim(idnumber)) > 1   and MIGDV.fc_repeticao_verificar(trim(idnumber)) = 2;
  --OCORRENCIA 1


