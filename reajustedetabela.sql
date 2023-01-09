/*delete tdvadm.t_slf_calcfretekm k
where (k.slf_tabela_codigo,k.slf_tabela_saque ) in (select ta.slf_tabela_codigo,ta.slf_tabela_saque
                                                   from tdvadm.t_slf_tabela ta
                                                   where 0 = 0
--                                                     and ta.slf_tabela_contrato in ('&Contrato')
                                                     and nvl(ta.slf_tabela_status,'N') = 'S'
                                                     and ta.slf_tabela_vigencia = '30/07/2018')
--                                                     and ta.slf_tabela_saque in (select max(ta2.slf_tabela_saque) from tdvadm.t_slf_tabela ta2 where ta2.slf_tabela_codigo = ta.slf_tabela_codigo) )

select ta.slf_tabela_codigo,ta.slf_tabela_saque
from tdvadm.t_slf_tabela ta
where 0 = 0
--  and ta.slf_tabela_contrato in ('&Contrato')
  and nvl(ta.slf_tabela_status,'N') = 'S'
  and ta.slf_tabela_vigencia = '30/07/2018'
for update


  
select distinct k.slf_tabela_codigo,k.slf_tabela_saque
from tdvadm.t_slf_calcfretekm k
where (k.slf_tabela_codigo,
       k.slf_tabela_saque) in (select ta.slf_tabela_codigo,
                                      ta.slf_tabela_saque
                               from tdvadm.t_slf_tabela ta
                               where nvl(ta.slf_tabela_status,'N') = 'N'
                                 and ta.slf_tabela_contrato in (--'C2017010106',
                                                                --'C4600005946', 
                                                                'C4600006358'
                                                                --'C4600005947'
                                                               ));


select *
from tdvadm.t_slf_tabela ta
where ta.slf_tabela_contrato in ('C4600006358');

*/


select tk.tabela,
       tk.vigencia,
       tk.grupo,
       tk.cliente,
       tk.contrato,
       tk.carga,
       tk.veiculo,
       tk.kmde,
       tk.KMATE,
       tk.pesode,
       tk.pesoate, 
       tk.origem,
       tk.destino,
       tk.verbacod,
       tk.valor,
       (select km.slf_calcfretekm_valor
        from tdvadm.t_slf_calcfretekm km
        where km.slf_tabela_codigo = tk.tabela
          and km.slf_calcfretekm_kmde = tk.kmde
          and km.slf_calcfretekm_kmate = tk.KMATE
          and km.slf_calcfretekm_pesode = tk.pesode
          and km.slf_calcfretekm_pesoate = tk.pesoate
          and km.slf_reccust_codigo = tk.verbacod
          and km.slf_calcfretekm_origemi = tk.origemib
          and km.slf_calcfretekm_destinoi = tk.destinoib
          and km.slf_tabela_saque = (select max(ta.slf_tabela_saque) from tdvadm.t_slf_tabela ta where ta.slf_tabela_codigo = km.slf_tabela_codigo and ta.slf_tabela_vigencia = '26/11/2018')) novovlr
from tdvadm.v_slf_tabelakm tk
where tk.contrato in ('C2018010119')
                      



insert into tdvadm.t_slf_tabela
  select SLF_TABELA_CODIGO,
         GLB_ROTA_CODIGO,
         lpad(SLF_TABELA_SAQUE+1,4,'0') saque,
         GLB_CONDPAG_CODIGO,
         SLF_TABELA_TIPO,
         GLB_CLIENTE_CGCCPFCODIGO,
         GLB_MERCADORIA_CODIGO,
         to_date('&Vigencia','dd/mm/yyyy') SLF_TABELA_VIGENCIA,
         GLB_EMBALAGEM_CODIGO,
         sysdate SLF_TABELA_DTGRAVACAO,
         GLB_TPCARGA_CODIGO,
         GLB_LOCALIDADE_CODIGO,
         SLF_TABELA_CONTATO,
         SLF_TABELA_OBSTABELA,
         GLB_VENDFRETE_CODIGO,
         SLF_TABELA_OBSFATURAMENTO,
         SLF_TABELA_LOTACAOFLAG,
         SLF_TABELA_ISENTO,
         SLF_TABELA_DESCRICAO,
         SLF_TPCALCULO_CODIGO,
         SLF_TABELA_PEDREAJAUT,
         SLF_TABELA_PEDATUALIZA,
         SLF_TABELA_ORIGEMDESTINO,
         SLF_TABELA_STATUS,
         SLF_TABELA_VIAGEMMIN,
         SLF_TABELA_VIAGEMMAX,
         SLF_TABELA_VIAGEMIDENT,
         CON_FCOBPED_CODIGO,
         CON_MODALIDADEPED_CODIGO,
        SLF_TABELA_TPDESCONTO,
         SLF_TABELA_DESCONTO,
         SLF_TABELA_PERCLOTACAO,
         SLF_TABELA_MSGLOTACAO,
         SLF_TABELA_ABORTALOTACAO,
         SLF_TABELA_PESOMINIMO,
         SLF_TABELA_PESOMAXIMO,
         SLF_TABELA_OCUPACAO,
        SLF_TABELA_BASEOCUPACAO,
         SLF_TABELA_CONTRATO,
         SLF_TABELA_COMISSIONADO,
         FCF_TPVEICULO_CODIGO,
         FCF_TPCARGA_CODIGO,
         GLB_GRUPOECONOMICO_CODIGO,
         SLF_TABELA_IMPRIMEOBSCTRC,
         SLF_TABELA_IMPRIMEOBSVENC,
         SLF_TABELA_COLETAENTREGA
   from tdvadm.t_slf_tabela ta
  where ta.slf_tabela_contrato in ('&Contrato')
    and nvl(ta.slf_tabela_status,'N') = 'N'
    and ta.slf_tabela_saque in (select max(ta2.slf_tabela_saque) from tdvadm.t_slf_tabela ta2 where ta2.slf_tabela_codigo = ta.slf_tabela_codigo);


insert into tdvadm.t_slf_calcfretekm
select SLF_TABELA_CODIGO,
       lpad(SLF_TABELA_SAQUE+1,4,'0') SLF_TABELA_SAQUE,
       SLF_CALCFRETEKM_KMDE,
       SLF_CALCFRETEKM_KMATE,
       SLF_CALCFRETEKM_PESODE,
       SLF_CALCFRETEKM_PESOATE,
       SLF_TPCALCULO_CODIGO,
       SLF_RECCUST_CODIGO,
/*       round(SLF_CALCFRETEKM_VALOR * (decode(trim(SLF_RECCUST_CODIGO),'D_FRPSVO',1+(&Reajuste/100),
                                                                      'D_DP',1+(&Reajuste/100),1)
                                     ),decode(trim(SLF_RECCUST_CODIGO),'D_ADVL',3,2)) ,
*/       
       round(SLF_CALCFRETEKM_VALOR * (decode(trim(SLF_RECCUST_CODIGO),'D_FRPSVO',1+(&Reajuste/100),
                                                                      'D_DP',1+(&Reajuste/100),1)
                                     ),decode(trim(SLF_RECCUST_CODIGO),'D_ADVL',3,2)) ,

       SLF_CALCFRETEKM_DESINENCIA,
       SLF_CALCFRETEKM_CODCLI,
       SLF_CALCFRETEKM_TPFRETE,
       SLF_CALCFRETEKM_ORIGEM,
       SLF_CALCFRETEKM_DESTINO,
       SLF_CALCFRETEKM_ORIGEMI,
       SLF_CALCFRETEKM_DESTINOI,
       SLF_CALCFRETEKM_LIMITE,
       SLF_CALCFRETEKM_VALORE,
       SLF_CALCFRETEKM_DESINENCIAE,
       SLF_CALCFRETEKM_VALORF,
       SLF_CALCFRETEKM_DESINENCIAF,
       SLF_CALCFRETEKM_RAIOKMORIGEM,
       SLF_CALCFRETEKM_RAIOKMDESTINO,
       SLF_CALCFRETEKM_IMPEMBUTIDO,
       SLF_CALCFRETEKM_OUTRACOLETAI,
       SLF_CALCFRETEKM_OUTRAENTREGAI 
from tdvadm.t_slf_calcfretekm k
where (k.slf_tabela_codigo,k.slf_tabela_saque) in (select ta.slf_tabela_codigo,ta.slf_tabela_saque
                                                   from tdvadm.t_slf_tabela ta
                                                   where ta.slf_tabela_contrato in ('&Contrato')
                                                     and nvl(ta.slf_tabela_status,'N') = 'N'
                                                     and ta.slf_tabela_saque in (select max(lpad(ta2.slf_tabela_saque-1,4,'0')) from tdvadm.t_slf_tabela ta2 where ta2.slf_tabela_codigo = ta.slf_tabela_codigo) );
commit;

--rollback;


select * from tdvadm.t_slf_contrato c where c.slf_contrato_codigo in ('&Contrato');
