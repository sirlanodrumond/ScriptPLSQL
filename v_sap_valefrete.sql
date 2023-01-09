select x.CON_VALEFRETE_CODIGO  ,
       x.GLB_ROTA_CODIGO   ,
       x.CENTROCUSTO  ,
       x.DATA_CRIACAO   ,
       x.DATA_MODIF ,
       x.DATA_IMPRESSAO  ,
       x.FIMVIAGEM   ,
       x.COD_PROPRIETARIO ,
       migdv.pkg_migracao_saptdv.Get_NOME_Parceiro(x.COD_PROPRIETARIO,'Proprietario') Proprietario,
       x.COD_MOTORISTA ,
       migdv.pkg_migracao_saptdv.Get_NOME_Parceiro(x.COD_MOTORISTA,'Motorista') Motorista,
       x.TPMOTORISTA  ,
       x.REMETENTE   ,
       x.DESTINATARIO   ,
       x.CIDADEORIGEM   ,
       x.CIDADEDESTINO ,
       x.CIDADEORIGEM_VAZIO   ,
       x.CIDADEDESTINO_VAZIO ,
       x.KM_FV  ,
       x.KM_PERCURSO  ,
       x.KMTOTAL ,
       x.VALOR_VF  ,
       x.VALOR_VF_SEM_PEGADIO  ,
       x.VALOR_PEDAGIO ,
       x.IRRF ,
       x.SESTSENAT   ,
       x.INSS ,
       x.PIS   ,
       x.COFIMS   ,
       x.CSLL ,
       x.USER_CRIACAO   ,
       x.COD_VEICULO  ,
       x.PLACA_CAVALO   ,
       x.DESCR_TIPO_VF ,
       x.BONUS  ,
       x.VALOR_BONUS  ,
       x.DATA_ENTRADA_SIMPLES 
from (Select vf.NUM_VALE_FRETE con_valefrete_codigo,
             vf.FILIAL glb_rota_codigo,
             vf.CENTRO_CUSTO Centrocusto,
             to_date(to_date(vf.DATA_CRIACAO  ,'yyyymmdd'),'dd/mm/yyyy') DATA_CRIACAO  ,
--             to_date(to_date(vf.DATA_CRIACAO  ,'yyyymmdd'),'dd/mm/yyyy') DATA_CRIACAO  ,
             to_date(to_date(vf.DATA_MODIF    ,'yyyymmdd'),'dd/mm/yyyy') DATA_MODIF    ,
             to_date(to_date(vf.DATA_IMPRESSAO,'yyyymmdd'),'dd/mm/yyyy') DATA_IMPRESSAO,
             (SELECT E.EVENTO
              FROM MIGDV.V_SAP_VALE_FRETE_OF VOF,
                   MIGDV.V_SAP_OF_EVENTOS E
              WHERE VOF.NUM_VALE_FRETE = VF.NUM_VALE_FRETE
                AND VOF.NUM_OF = E.NUM_OF 
                AND E.COD_EVENTO = 'ZV_02') FIMVIAGEM,
             (SELECT V.COD_PROPRIETARIO
              FROM MIGDV.V_SAP_VEICULOS V
              WHERE V.PLACA = vf.PLACA_CAVALO) COD_PROPRIETARIO,
             (SELECT V.COD_MOTORISTA
              FROM MIGDV.V_SAP_VEICULOS V
              WHERE V.PLACA = vf.PLACA_CAVALO) COD_MOTORISTA,
--              (SELECT M.TIPO_PARCEIRO
--               FROM MIGDV.V_SAP_MOTORISTA M
--               WHERE M.COD_PARCEIRO = VF.COD_MOTORISTA ) TPMOTORISTA,
             'VAZIO' TPMOTORISTA,
             migdv.pkg_migracao_saptdv.Get_NOME_Parceiro(VF.EXPEDIDOR,'Cliente') remetente,
             migdv.pkg_migracao_saptdv.Get_NOME_Parceiro(VF.DESTINATARIO,'Cliente') Destinatario,
             (SELECT BP.UF || '-' || BP.CIDADE
              FROM MIGDV.V_SAP_BP BP
              WHERE BP.COD_PARCEIRO = VF.EXPEDIDOR) CIDADEORIGEM,
             (SELECT BP.UF || '-' || BP.CIDADE
              FROM MIGDV.V_SAP_BP BP
              WHERE BP.COD_PARCEIRO = VF.DESTINATARIO) CIDADEDESTINO,
             (SELECT BP.UF || '-' || BP.CIDADE
              FROM MIGDV.V_SAP_BP BP
              WHERE BP.COD_PARCEIRO = VF.EXPEDIDOR_FV) CIDADEORIGEM_VAZIO,
             (SELECT BP.UF || '-' || BP.CIDADE
              FROM MIGDV.V_SAP_BP BP
              WHERE BP.COD_PARCEIRO = VF.DESTINATARIO_FV) CIDADEDESTINO_VAZIO,
             vf.KM_FV,
             vf.KM_PERCURSO,
--             vf.KM_PERCURSO,
             vf.KM_PERCURSO + KM_FV kmtotal,
             vf.VALOR_VF,
             vf.VALOR_VF_SEM_PEGADIO,
             vf.VALOR_PEDAGIO,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0011301005') IRRF,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0021401010') SESTSENAT,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0021401014') INSS,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0021401006') PIS,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0021401005') COFIMS,
             migdv.pkg_migracao_saptdv.Get_Valor_Contabil(pDocumento => VF.NUM_FATURA,PDataRefeencia => vf.DATA_CRIACAO,pConta => '0021401002') CSLL,
             vf.USER_CRIACAO,
             (SELECT V.COD_VEICULO
              FROM MIGDV.V_SAP_VEICULOS V
              WHERE V.PLACA = vf.PLACA_CAVALO) COD_VEICULO,
             vf.PLACA_CAVALO,
             vf.DESCR_TIPO_VF,
             vf.BONUS,
             vf.VALOR_BONUS,
             (SELECT B.DATA_ENTRADA_SIMPLES
              FROM MIGDV.V_SAP_BP B
              WHERE B.COD_PARCEIRO = VF.EXPEDIDOR) DATA_ENTRADA_SIMPLES
      from MIGDV.V_SAP_VALEFRETE vf
      order by 2,1,7) x




select *
from tdvadm.t_usu_usuarioperfil p
where p.usu_usuarioperfil_qtdeacess <> 0
 


SELECT x.TIPO_PARCEIRO,count(*)
                FROM MIGDV.V_SAP_BP x
                where x.NOME_PARCEIRO is not null
                  --and x.COD_PARCEIRO = '1000000162'
group by x.TIPO_PARCEIRO;
