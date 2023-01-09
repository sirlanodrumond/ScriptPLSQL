SELECT CK.*,
       T.GLB_MERCADORIA_CODIGO,
       T.SLF_TABELA_COLETAENTREGA,
       T.SLF_TABELA_TIPO,
       T.FCF_TPVEICULO_CODIGO,
       T.FCF_TPCARGA_CODIGO,
       T.GLB_CLIENTE_CGCCPFCODIGO,
       T.GLB_GRUPOECONOMICO_CODIGO,
       T.SLF_TABELA_CONTRATO,
       1 vPESOCOBRADO,
       1 vFATORRATEIO,
       'OK' vRetorno,
       CK.ROWID
  FROM TDVADM.T_SLF_CALCFRETEKM CK, TDVADM.T_SLF_TABELA T
 WHERE 0 = 0
   AND CK.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
   AND CK.SLF_TABELA_SAQUE = T.SLF_TABELA_SAQUE
   AND NVL(T.SLF_TABELA_STATUS, 'N') = 'N'
   AND T.SLF_TABELA_CONTRATO = '5500058294-V-SP'
   AND T.GLB_GRUPOECONOMICO_CODIGO = '0020'
   AND CK.SLF_RECCUST_CODIGO = 'D_FRPSVO'
   AND T.SLF_TABELA_TIPO = 'FOB'
   AND nvl(T.SLF_TABELA_COLETAENTREGA, 'A') in ('N', 'A', 'E')
   AND round(11700, 0) BETWEEN CK.SLF_CALCFRETEKM_PESODE AND CK.SLF_CALCFRETEKM_PESOATE
   AND T.FCF_TPCARGA_CODIGO = '10'
   AND CK.SLF_CALCFRETEKM_ORIGEMI = '3550308'
   AND CK.SLF_CALCFRETEKM_DESTINOI = '2111300'
   AND T.SLF_TABELA_SAQUE =
       (SELECT MAX(T1.SLF_TABELA_SAQUE)
          FROM TDVADM.T_SLF_TABELA T1
         WHERE T1.SLF_TABELA_CODIGO = T.SLF_TABELA_CODIGO
           AND NVL(T1.SLF_TABELA_STATUS, 'N') = 'N'
           AND TO_DATE(T1.SLF_TABELA_VIGENCIA, 'DD/MM/YYYY') <=
               TO_DATE(SYSDATE, 'DD/MM/YYYY'))

select 11.700 *46.5 from dual

select cp.slf_contrato_codigo,
       cp.fcf_tpcarga_codigo,
       cp.fcf_tpveiculo_codigo,
       cp.slf_clienteped_vigencia,
       cp.glb_localidade_codigooriib,
       tdvadm.fn_busca_codigoibge(cp.glb_localidade_codigooriib,'IBD') origem,
       cp.glb_localidade_codigodesib,
       tdvadm.fn_busca_codigoibge(cp.glb_localidade_codigodesib,'IBD') destino,
       cp.slf_clienteped_valor,
       cp.slf_clienteped_desinencia,
       cp.glb_localidade_outracoletai,
       cp.glb_localidade_outraentregai
from tdvadm.t_slf_clienteped cp
where cp.slf_contrato_codigo = '5500058294-V-SP'
--  and cp.fcf_tpcarga_codigo = '10'
  and CP.GLB_LOCALIDADE_CODIGOORIIB = '3504107'
  AND CP.GLB_LOCALIDADE_CODIGODESIB = '3144805'
  
  SELECT * FROM TDVADM.T_ARM_CARREGAMENTODET CD
  WHERE CD.ARM_CARREGAMENTO_CODIGO = '2001936'
  
  
  
  update tdvadm.t_slf_clienteped cp
    set cp.glb_localidade_outracoletai = '99999'
  where nvl(trim(cp.glb_localidade_outracoletai),'99999') = '99999';
  
  update tdvadm.t_slf_clienteped cp
    set cp.glb_localidade_outraentregai = '99999'
  where nvl(trim(cp.glb_localidade_outraentregai),'99999') = '99999';
commit;

select * from tdvadm.t_slf_tpcalculo c
where c.slf_tpcalculo_calculomae = 'S'



select *
from tdvadm.t_slf_calcfretekm km
update tdvadm.t_slf_calcfretekm km
  set km.slf_tpcalculo_codigo = '315'
where 0 = 0
  and km.slf_tpcalculo_codigo <> '315'
--  and 18000 between km.slf_calcfretekm_pesode and km.slf_calcfretekm_pesoate
  and (km.slf_tabela_codigo,
       km.slf_tabela_saque) in (select ta.slf_tabela_codigo,
                                       ta.slf_tabela_saque
                                from tdvadm.t_slf_tabela ta
                                where ta.slf_tabela_contrato in ('5500057877-RMF', 
                                                                  '5500057880-INS', 
                                                                  '5500057902-DX',
                                                                  '5500057870-RT', 
                                                                  '5500057880-ISO', 
                                                                  '55000057895-BM',
                                                                  '55000057896-DOR',
                                                                  '5500057918-V-NN',
                                                                  '5500057918-V-EE',
                                                                  '5500057918-V-SS',
                                                                  '5500058294-V-NO',
                                                                  '5500058294-V-SP',
                                                                  '5500058294-V-MG'))


UPDATE TDVADM.T_SLF_CLIENTEPED CP
  SET CP.FCF_TPCARGA_CODIGO = '12'
WHERE CP.FCF_TPCARGA_CODIGO = '02'
  AND CP.SLF_CONTRATO_CODIGO IN ('5500057877-RMF', 
                                                                  '5500057880-INS', 
                                                                  '5500057902-DX',
                                                                  '5500057870-RT', 
                                                                  '5500057880-ISO', 
                                                                  '55000057895-BM',
                                                                  '55000057896-DOR',
                                                                  '5500057918-V-NN',
                                                                  '5500057918-V-EE',
                                                                  '5500057918-V-SS',
                                                                  '5500058294-V-NO',
                                                                  '5500058294-V-SP',
                                                                  '5500058294-V-MG')   
                                                                  
SELECT *
FROM TDVADM.T_SLF_CLIENTECARGAS CP
WHERE CP.SLF_CONTRATO_CODIGO IN (--'5500057877-RMF', 
                                   --                               '5500057880-INS', 
                                   --                               '5500057902-DX',
                                   --                               '5500057870-RT', 
                                   --                               '5500057880-ISO', 
                                   --                               '55000057895-BM',
                                   --                               '55000057896-DOR',
                                   --                               '5500057918-V-NN',
                                   --                               '5500057918-V-EE',
                                   --                               '5500057918-V-SS',
                                                                  '5500058294-V-NO',
                                                                  '5500058294-V-SP',
                                                                  '5500058294-V-MG',
                                                                  '5500058294-M-NO',
                                                                  '5500058294-M-SP',
                                                                  '5500058294-M-MG'                                                                                                                                    
                                   --                               '5500057918-M-NN',
                                   --                               '5500057918-M-EE',
                                   --                               '5500057918-M-SS'
                                )
FOR UPDATE
                                                                     
                                  
