1. GRUPO DE DADOS EQUIPAMENTO (Objeto EQUIPMENT)

1.1  EQUIPENT_S_EQUI

1.1.1 Nome do Equipamento parece estar truncado em 19 posições desnecessariamente, pois o campo tem 80 posições. Sugerimos também rever se realmente é necessário continuar com o tipo do equipamento no nome, considerando que existe um campo somente para esta informação. Segue exemplos abaixo:
SQL TESTE
Select e.EQKTX,e.EQTYP,m.dsc_dominio
from migdv.equipment_s_equi e,
     migdv.meta_dominio_coluna m
where m.nom_view = 'EQUIPMENT_S_EQUI'
  and e.EQTYP = m.nom_dominio
  and m.nom_coluna = 'EQTYP'
RESPOSTA
Corrigido, mais a coluna EQKTX - Descrição do equipamento só tem 40 posicoes, a coluna EQTYP - Categoria de equipamento, que tem 80 posicoes 
  #ANA
  
1.1.2 Tipo de Equipamento preenchido com “NAO SEI”, quando existe domínio para o dado, conforme abaixo:
Exemplos de Dados          Domínio EQTYP (conforme meta_dominio_coluna)
SQL TESTE
select *
From migdv.meta_dominio_coluna m 
where m.nom_coluna = 'EQTYP';
Select distinct e.EQKTX,e.EQTYP
from migdv.equipment_s_equi e
where 0 = (select count(*) from migdv.meta_dominio_coluna m where m.nom_dominio = e.EQTYP and m.nom_coluna = 'EQTYP');

 - MOTOCICLETA - HONDA - BIZ 125 ES
 - CARRO DE PASSEIO / DIRETORIA - LEXUS 
 - TRATOR ESCAVO CARREGADOR - VOLVO - L 
 - MOTOCICLETA - HONDA - SOLMAK CG 150 C
 - CAMINHÃO TOCO - VOLKSWAGEM - 17.230 C
 - MICROONIBUS - FORD - TRANSIT REVES
 - CAMINHONETE - FORD - TRANSIT 350 L
 - CARRO DE PASSEIO / DIRETORIA - I/LEXU
 - CARRO DE PASSEIO / TDV - FIAT - DOBLO
 - CARRO DE PASSEIO / TDV - CHEVROLET - 
 - GUINCHO F14000  (FORD)        
 - CARRO DE PASSEIO / TDV - VOLKSWAGEN -


RESPOSTA

1.1.3 Tipo de Objeto Técnico (campo “EQART”) preenchido com “NAO SEI”. Este campo não estava na lista de dúvidas enviada anteriormente. Ele deve ser preenchido conforme o seguinte domínio:
SQL TESTE
RESPOSTA

1.1.4 Grupo de Autorização do Objeto Técnico (campo “BEGRU”) preenchido com “NAO SEI”. Este campo não estava , na lista de dúvidas enviada anteriormente. Estamos verificando a configuração e obrigatoriedade este campo com o consultor. Atualmente os seguintes grupos estão disponíveis:
SQL TESTE
RESPOSTA

1.1.5 Data de Início da Validade (campo DATAB) não preenchido em todas as ocorrências, conforme imagem abaixo. Deve ser informada a data em que o equipamento passou a ser “válido”. Favor confirmar se não existe mesmo a informação.
SQL TESTE
RESPOSTA

1.1.6 Peso do equipamento preenchido de forma aparentemente inconsistente, conforme exemplos da imgem abaixo. Quando não tiver a informação, não preencher.
SQL TESTE
RESPOSTA

1.1.7 Data de Início do Objeto Técnico (campo INBDT) não preenchido em todas as ocorrências, conforme imagem abaixo. Deve ser informada a data em que o equipamento “entrou em serviço/operação” (normalmente é a mesma data do campo DATAB). Favor confirmar se não existe mesmo a informação.
SQL TESTE
RESPOSTA

1.1.8 Todos os registros estão com o Valor de Aquisição zerado (campo ANSWT), conforme imagem abaixo. Se não possuir a informação, enviar em branco.
SQL TESTE
RESPOSTA

1.1.9 Grupo de Identificador da Moeda (campo “WAERS”) preenchido com “NAO SEI”. Este campo não estava na lista de dúvidas enviada anteriormente. Informar a moeda do valor informado no campo Valor de Aquisição (ANSWT).
SQL TESTE
RESPOSTA

1.1.10 País de fabricação do Equipamento (campo HERLD) não preenchido para todos os registros, conforme imagem abaixo. Confirmar que não existe mesmo esta informação, pois entendemos que a mesma poderia ser derivada do fabricante, por exemplo.
SQL TESTE
RESPOSTA

1.1.11 Mês de Fabricação (campo BAUMM) em branco para todos os registros, conforme imagem abaixo. Favor confirmar se realmente não possui esta informação.
SQL TESTE
RESPOSTA

1.1.12 Número de Série do Fabricante (campo SERGE) preenchido com zeros, conforme abaixo:
SQL TESTE
RESPOSTA

1.1.13 Campo de classificação (campo “SORTFIELD”) preenchido com “NAO SEI”. Este campo não estava na lista de dúvidas enviada anteriormente. Informar um valor para determinar ordenação e pesquisa.
SQL TESTE
RESPOSTA

1.1.14 Identificador do Ativo (campo ANLNR) em Branco para todos os registros. Acredito que seja porque o objeto FIXED_ASSET não foi gerado. Mas não esquecer de preencher este campo sempre que houver um ativo fixo representado como equipamento.
SQL TESTE
RESPOSTA
 
1.1.15 Centro de Custo (campo KOSTL) preenchido com “NAO SEI”. Este campo não estava na lista de dúvidas enviada anteriormente. Informar qual o centro de custo associado ao equipamento. Deve ser igual ao centro de custo informado no Ativo equivalente (objeto FIXED_ASSET). No arquivo anexo, lista dos Centros de Custo. 
SQL TESTE
RESPOSTA

1.1.16 Local de Instalação (campo TPLNR) em branco para a maioria dos equipamentos, sendo que os mesmos deveriam ter esta informação preenchida, conforme exemplos de cavalo listados abaixo:
SQL TESTESQL TESTE
RESPOSTA

RESPOSTA

1.1.17 Número de Série do Equipamento (campo GERNR) preenchido com zeros, conforme abaixo:
SQL TESTE
RESPOSTA
 
1.1.18 Identificador do Material (campo MATNR) preenchido com o ID do Equipamento, quando deveria estar apontando para o MATNR (identificador) de material correspondente do objeto MATERIAL. Esta situação pode ser observada nos exemplos abaixo, e acontece para todos os registros.
SQL TESTE
RESPOSTA

 




 



RESPOSTA
SQL TESTE
RESPOSTA
SQL TESTE
RESPOSTA
SQL TESTE
RESPOSTA
SQL TESTE
RESPOSTA
SQL TESTE
RESPOSTA
SQL TESTE
RESPOSTA




                 
