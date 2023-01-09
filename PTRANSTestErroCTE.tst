PL/SQL Developer Test script 3.0
786
-- Created on 03/03/2022 by BRUNO.MATTOS 
-- Teste Criado em 03/03/2022 para verificarmos o Erro de um Conhecimento.
--Testa cada variável para verificar aonde encontra se o erro.
declare 
      vAuxiliarT                    varchar2(500);
      vAuxiliarN                    number;
      vTMPVeiculo                    tdvadm.t_Fcf_Tpveiculo.fcf_tpveiculo_descricao%type;
      vTMPTpVeiculo                  tdvadm.t_Fcf_Tpveiculo.fcf_tpveiculo_codigo%type;
      vTMPCarga                      tdvadm.t_fcf_tpcarga.fcf_tpcargadescricao%type;
      vTMPTpCarga                    tdvadm.t_fcf_tpcarga.fcf_tpcarga_codigo%type;
        VI_ERRO                      VARCHAR2(200);
        VI_RESULTADO                 CHAR(100);
        VI_PESO                      NUMBER(15, 4);
        VI_PESO2                     NUMBER(15, 4);
        VI_VALOR                     NUMBER;
        VI_CUSTO                     NUMBER;
        VI_CUSTO_CX                  NUMBER;
        VI_CUSTO_VF                  NUMBER;
        VI_CUSTO_CT                  NUMBER;
        VI_CUSTOCODIGO               NUMBER;
        VI_DESINENCIACUSTOCODIGO     CHAR(3);
        VI_RECEITA                   NUMBER;
        VI_IMPOSTO                   NUMBER;
        VI_DATAEMBARQUE              CHAR(10);
        VI_HORAEMBARQUE              varCHAR(19);
        VI_TESTE                     CHAR(19);
        VI_DATAGRAVACAO              CHAR(10);
        VI_TERMINAL                  CHAR(15);
        VI_DTEMBARQUE2               NUMBER;
        VI_TPMOTORISTA               T_GLB_TPMOTORISTA.GLB_TPMOTORISTA_CODIGO%Type;
        VI_CONHECIMENTO              T_CON_CONHECIMENTO.CON_CONHECIMENTO_CODIGO%TYPE;
        VI_SERIE                     T_CON_CONHECIMENTO.CON_CONHECIMENTO_SERIE%TYPE;
        VI_VALEFRETE                 T_CON_CONHECIMENTO.CON_VALEFRETE_CODIGO%TYPE;
        VI_VALEFRETEROTA             T_CON_CONHECIMENTO.GLB_ROTA_CODIGOVALEFRETE%TYPE;
        VI_VALEFRETESAQUE            T_CON_CONHECIMENTO.CON_VALEFRETE_SAQUE%TYPE;
        VI_ROTA                      T_CON_CONHECIMENTO.GLB_ROTA_CODIGO%TYPE;
        VI_ROTARECEITA               T_CON_CONHECIMENTO.GLB_ROTA_CODIGORECEITA%TYPE;
        VI_ROTADESC                  tdvadm.t_glb_rota.glb_rota_descricao%type;
        VI_VIAGEM                    T_CON_CONHECIMENTO.CON_VIAGEM_NUMERO%TYPE;
        VI_ROTA_VIAGEM               T_CON_CONHECIMENTO.GLB_ROTA_CODIGOVIAGEM%TYPE;
        VI_ORIGEM                    T_CON_CONHECIMENTO.GLB_LOCALIDADE_CODIGOORIGEM%TYPE;
        VI_DESTINO                   T_CON_CONHECIMENTO.GLB_LOCALIDADE_CODIGODESTINO%TYPE;
        VI_LOCREMETENTE              T_GLB_LOCALIDADE.GLB_LOCALIDADE_CODIGO%TYPE;
        VI_LOCARMAZEM                T_GLB_LOCALIDADE.GLB_LOCALIDADE_CODIGO%TYPE;
        VI_CGC_SACADO                T_CON_CONHECIMENTO.GLB_CLIENTE_CGCCPFSACADO%TYPE;
        VI_CGC_REMETENTE             T_CON_CONHECIMENTO.GLB_CLIENTE_CGCCPFREMETENTE%TYPE;
        VI_CGC_DESTINATARIO          T_CON_CONHECIMENTO.GLB_CLIENTE_CGCCPFDESTINATARIO%TYPE;
        VI_EMBALAGEM_COD             T_CON_CONHECIMENTO.GLB_EMBALAGEM_CODIGO%TYPE;
        VI_MERCADORIA_COD            T_CON_CONHECIMENTO.GLB_MERCADORIA_CODIGO%TYPE;
        VI_EMBALAGEM_DESC            T_GLB_EMBALAGEM.GLB_EMBALAGEM_DESCRICAO%TYPE;
        VI_MERCADORIA_DESC           T_GLB_MERCADORIA.GLB_MERCADORIA_DESCRICAO%TYPE;
        VI_SOLFRETE_CODIGO           T_CON_CONHECIMENTO.SLF_SOLFRETE_CODIGO%TYPE;
        VI_SOLFRETE_SAQUEAT          T_CON_CONHECIMENTO.SLF_SOLFRETE_SAQUE%TYPE;
        VI_SOLFRETE_SAQUE            T_CON_CONHECIMENTO.SLF_SOLFRETE_SAQUE%TYPE;
        VI_TABELA_CODIGO             T_CON_CONHECIMENTO.SLF_TABELA_CODIGO%TYPE;
        VI_TABELA_SAQUEAT            T_CON_CONHECIMENTO.SLF_TABELA_SAQUE%TYPE;
        VI_TABELA_SAQUE              T_CON_CONHECIMENTO.SLF_TABELA_SAQUE%TYPE;
        VI_MOTORISTA                 T_CAR_CARRETEIRO.CAR_CARRETEIRO_NOME%TYPE;
        VI_PROPRIETARIO              T_CAR_PROPRIETARIO.CAR_PROPRIETARIO_RAZAOSOCIAL%TYPE;
        VI_VOLUMES                   NUMBER;
        VI_DATAICARGA                DATE;
        VI_DATAFCARGA                DATE;
        VI_DATASAIDA                 DATE;
        VI_DATAIDESCARGA             DATE;
        VI_DATAFDESCARGA             DATE;
        VI_DATACHEGADA               DATE;
        VI_DATAICELULA               DATE;
        VI_DATAFCELULA               DATE;
        VI_DATAINI                   DATE;
        VI_DATAFIM                   DATE;
        VI_DATAFAT                   CHAR(19);
        VI_DATANASCCARR              DATE;
        VI_CPFMOTORISTA              CHAR(20);
        VI_CPFPROPRIETARIO           CHAR(20);
        VI_PLACA                     VARCHAR2(20);
        VI_PLACACARRETA              VARCHAR2(20);
        VI_IBGEORIGEM                char(8);
        VI_ESTORIGEM                 CHAR(2);
        VI_LOCORIGEM                 VARCHAR2(50);
        VI_IBGEDESTINO               char(8);
        VI_ESTDESTINO                CHAR(2);
        VI_LOCDESTINO                VARCHAR2(50);
        vi_local                     varchar2(50);
        VI_OBSERVACAOENTREGA         t_con_conhecimento.con_conhecimento_obsdtentrega%type;
        V_FRASESQL                   clob := empty_clob();
        V_TEMPORARIA                 INTEGER;
        V_CONTADOR                   NUMBER;
--        V_CONTADOR2                  NUMBER;
        vProcessado                  number;
        vEstimado                    number;
        V_ROTAVFVIAGEM               T_GLB_ROTA.GLB_ROTA_CODIGO%TYPE;
        VI_CUSTORESULTADO            NUMBER;
        VI_OUTROSCUSTRESULTADO       NUMBER;
        VI_MARGEMMEDIA               NUMBER;
        VI_CUSTOCARRET               NUMBER;
        VI_CUSTOCARRETTOT            NUMBER;
        VI_TPCARGASOLTAB             CHAR(2);
        VI_LOTACAOSOLTAB             NUMBER;
        VI_FRETE                     NUMBER;
        VI_MARGEM                    NUMBER;
        VI_CARGA                     NUMBER;
        VI_DESCARGA                  NUMBER;
        VI_FRETEMG                   NUMBER;
        VI_PEDAGIO                   NUMBER;
        VI_PEDAGIOI                  NUMBER;
        VI_PEDAGIOPER                NUMBER;
        VI_TTPV                      NUMBER;
        VI_ALIQUOTA                  NUMBER;
        VI_ICMS                      NUMBER;
        VI_ADVL                      NUMBER;
        VI_ADVLI                     NUMBER;
        VI_VLMERC                    NUMBER;
        VI_VLMERCSEG                 NUMBER;
        VI_NRCLIENTE                 VARCHAR2(100);
        VI_TAXASEG                   NUMBER;
        VI_SEGURO                    NUMBER;
        VI_SEGUROIMP                 NUMBER;
        VI_SEGUROSEMIMP              NUMBER;
        VI_TAXASEGRCFDC              NUMBER;
        VI_SEGURORCFDC               NUMBER;
        VI_SEC                       NUMBER;
        VI_SECI                      NUMBER;
        VI_CAT                       NUMBER;
        VI_CATI                      NUMBER;
        VI_OUTROS                    NUMBER;
        VI_OUTROSI                   NUMBER;
        VI_NOTAS                     VARCHAR2(100);
        VI_FATURA                    CHAR(10);
        VI_TPSACADO                  CHAR(1);
        VI_CLIENTEDEST               VARCHAR2(100);
        VI_CLIENTEREM                VARCHAR2(100);
        VI_CLIENTESAC                VARCHAR2(100);
        VI_IEDEST                    VARCHAR2(100);
        VI_IEREM                     VARCHAR2(100);
        VI_IESAC                     VARCHAR2(100);
        VI_DESINENCIA                CHAR(2);
        VI_DESINENCIAFRETE           CHAR(3);
        VI_NUMEIXOS                  NUMBER;
        VI_NUMEIXOS2                 NUMBER;
        VI_TPVEICULO                 VARCHAR2(10);
        VI_TPVEICULOSOL              varchar2(40);
--        VI_TIPOCARGAXML              T_XML_COLETA.XML_COLETA_TIPOCARGA%TYPE;
        VI_TIPOCARGAXML              TDVADM.T_ARM_COLETAPART.ARM_COLETAPART_TIPOCARGA%TYPE;
        VI_SEGUROREC                 NUMBER;
        VI_SEGURORECI                NUMBER;
        VI_TPTABELA                  CHAR(3);
        VI_GRUPOIMG                  VARCHAR2(100);
        VI_DATASCANERIMG             DATE;
        VI_USUCONFERIU               tdvadm.t_usu_usuario.usu_usuario_codigo%type;
        VI_USUBAIXOU                 tdvadm.t_usu_usuario.usu_usuario_codigo%type;
        VI_SOLFRETETABELA            VARCHAR2(100);
        VI_OBS                       tdvadm.t_con_conhecimento.con_conhecimento_obs%type;
        VI_CUSTOCARRETSOLTAB         NUMBER;
        VI_DESINENCIASOLTAB          CHAR(3);
        VI_ADVLSOLTAB                NUMBER;
        VI_ADVLDESSOLTAB             CHAR(3);
        VI_PEDAGIOSOLTAB             NUMBER;
        VI_PEDAGIODESSOLTAB          CHAR(3);
        VI_FRETESOLTAB               NUMBER;
        VI_FRETEDESSOLTAB            CHAR(3);
        VI_SEGUROSOLTAB              NUMBER;
        VI_SEGURODESSOLTAB           CHAR(3);
        VI_DESPACHO                  NUMBER;
        VI_DESPACHOI                 NUMBER;
        VI_DESPACHOSOLTAB            NUMBER;
        VI_DESPACHODESSOLTAB         CHAR(3);
        VI_CATSOLTAB                 NUMBER;
        VI_CATDESSOLTAB              CHAR(3);
        VI_SECSOLTAB                 NUMBER;
        VI_SECDESSOLTAB              CHAR(3);
        VI_OUTROSSOLTAB              NUMBER;
        VI_OUTROSDESSOLTAB           CHAR(3);
        V_NUMERADOR                  NUMBER;
        VI_VPEDREGESP                CHAR(10);
        VI_VPEDCODFPAGTO             CHAR(2);
        VI_VPEDFPAGTO                VARCHAR2(50);
        VI_VPEDCODFCOBR              CHAR(2);
        VI_VPEDFCOBR                 VARCHAR2(50);
--        VI_VPEDCODMODFIDADE         CHAR(2);
        VI_VPEDCODMODALIDADE         CHAR(2);
        VI_VPEDMODALIDADE            VARCHAR2(50);
        VI_VPEDVLR                   NUMBER;
        VI_VPEDTRANSACAO             CHAR(10);
        VI_CTRCCODANT                T_CON_CONHECIMENTO.CON_CONHECIMENTO_CODIGO%TYPE;
        VI_CTRCROTAANT               T_CON_CONHECIMENTO.GLB_ROTA_CODIGO%TYPE;
        VI_CTRCLOCORIANT             VARCHAR2(100);
        VI_CTRCLOCDESANT             VARCHAR2(100);
        VI_VFRETEPEDVAZIO            NUMBER;
        VI_DTEMBARQUEANT             DATE;
        VI_PLACAFROVF                CHAR(07);
        VI_PLACACARVF                CHAR(07);
        VI_TIPOFACVF                 CHAR(8);
        VI_ACONTAS                   CHAR(8);
        VI_TPDESCONTO                CHAR(1);
        VI_DESCONTO                  NUMBER;
        VI_ALIQDEVIDA                NUMBER;
        VI_FRPSVOTOTAL               NUMBER;
        VI_SMKDTEMB                  DATE;
        VI_SMKDTCONTAB               DATE;
        VI_SMKDTLIVRO                DATE;
        VI_SMKDTCANCEL               DATE;
        VI_SMKDTFATURA               DATE;
        VI_SMKFATURA                 CHAR(6);
        VI_SMKVALORCTRC              NUMBER;
        VI_KMSOLTAB                  NUMBER;
        VI_KMPERCURSO                NUMBER;
        VI_KMCOLETA                  number;
        VI_CFO                       CHAR(4);
        VI_PREVISAO                  DATE;
        VI_HRPREVISAO                CHAR(5);
        VI_COLETA                    CHAR(6);
        VI_COLETACICLO               char(3);
        VI_ORIGEMCOLETAWEB           CHAR(1);
        VI_QTDNOTAS                  NUMBER;
        VI_DTNFE                     T_CON_CONHECIMENTO.CON_CONHECIMENTO_DTNFE%TYPE;
        VI_NFE                       T_GLB_ROTA.GLB_ROTA_NFE%TYPE;
        VI_NOTA                      NUMBER;
        VI_NOTA2                     CHAR(1);
        VI_DATAVF                    char(20);
        vi_horaemi                   t_uti_controleenvio.arm_movimento_nfentrada%type;
        VI_BASECALCULO               NUMBER;
        VI_ATRASO                    NUMBER;
        VI_ATRASOENTREGA             CHAR(3);
        VI_TIPOCARROCERIA            VARCHAR2(20);
        VI_ANOVEICULO                VARCHAR2(25);
        VI_CAPACIDADE                NUMBER;
        VI_MERCADORIA_NF             VARCHAR2(100);
        VI_FRASE                     VARCHAR2(2000);
        VI_MANIFESTO                 T_CON_MANIFESTO.CON_MANIFESTO_CODIGO%TYPE;
        VI_MANIFESTOROTA             T_CON_MANIFESTO.CON_MANIFESTO_ROTA%TYPE;
        VI_CANCELADO                 CHAR(1);
        VI_CONTRATO                  T_SLF_contrato.Slf_Contrato_Codigo%TYPE;
        VI_UFROTA                    T_GLB_ROTA.GLB_ESTADO_CODIGO%TYPE;
        VI_OPERACAO                  CHAR(13);
        VI_GRUPOREM                  T_GLB_GRUPOECONOMICO.GLB_GRUPOECONOMICO_CODIGO%TYPE;
        VI_GRUPODEST                 T_GLB_GRUPOECONOMICO.GLB_GRUPOECONOMICO_CODIGO%TYPE;
        VI_GRUPOSAC                  T_GLB_GRUPOECONOMICO.GLB_GRUPOECONOMICO_CODIGO%TYPE;
        VI_CARREGAMENTO              T_ARM_CARREGAMENTO.ARM_CARREGAMENTO_CODIGO%TYPE;
        VI_CARREGAMENTOPR            varchar2(20);
        VI_CONTADOR                  NUMBER;
--        VI_TPCARGA                   CHAR;
        VI_COD1                      T_CON_NFTRANSPORTAEXTRA.CON_NFTRANSPORTA_STRING1%TYPE;
        VI_COD2                      T_CON_NFTRANSPORTAEXTRA.CON_NFTRANSPORTA_STRING2%TYPE;
        VI_COD3                      T_CON_NFTRANSPORTAEXTRA.CON_NFTRANSPORTA_STRING3%TYPE;
        VI_COD4                      T_CON_NFTRANSPORTAEXTRA.CON_NFTRANSPORTA_STRING4%TYPE;
        VI_NUMB1                     T_CON_NFTRANSPORTAEXTRA.CON_NFTRANSPORTA_NUMBER1%TYPE;
        VI_EXPNRFORM                 T_ARM_COLETA.ARM_COLETA_NRFORMULARIO%TYPE;
        VI_EXPNRFORMAdHoc            T_ARM_COLETA.ARM_COLETA_NRFORMULARIO%TYPE;
        VI_EXPNRFORMPQ               T_ARM_COLETA.ARM_COLETA_NRFORMULARIO%TYPE;
        VI_EXPSOLICITANTE            VARCHAR2(60);
        VI_EXPAUTORIZADOR            VARCHAR2(60);
        VI_EXPDTAUTORIZADOR          varchar2(19);
        VI_EXPSIGLACG                T_ARM_COLETAEXAP.ARM_COLETAEXAP_SIGLAGG%TYPE;
        VI_EXPSIGLAGA                T_ARM_COLETAEXAP.ARM_COLETAEXAP_SIGLAGA%TYPE;
        VI_COLETAENTREGA             V_XML_ACOMPANHA_NOTA.COLETA_LOCAL%TYPE;
        VI_INCOTERMS                 V_XML_ACOMPANHA_NOTA.XML_COLETA_INCOTERMS%TYPE;
        VI_PO                        V_XML_ACOMPANHA_NOTA.NOTA_PO%TYPE;
        vi_pocc                      t_arm_nota.xml_notalinha_numdoc%type;
        VI_ASN                       varchar2(20); --tdvadm.V_XML_ACOMPANHA_NOTA.COLETA_NUMERO%TYPE;
        VI_PEDIDO                    T_ARM_COLETA.ARM_COLETA_PEDIDO%TYPE;
        VI_CENTROCUSTO               T_ARM_COLETA.ARM_COLETA_CENTRODECUSTO%TYPE;
        VI_DTCOLETA                  CHAR(19);
        VI_DTPEDCOLETA               CHAR(19);
        l                            CHAR(19);
        VI_PROGRAMACAOCOLETA         CHAR(19);
        VI_SISTEMA                   CARRETEIROFRETE.SISTEMA%TYPE;
        VI_ORIGEMDESC                CARRETEIROFRETE.CIDADECHOR%TYPE;
        VI_DESTINODESC               CARRETEIROFRETE.CIDADECHDE%TYPE;
        VI_TIPOFRETE                 CARRETEIROFRETE.TIPOFRETE%TYPE;
        VI_VALORROTA                 CARRETEIROFRETE.FRETE%TYPE;
        VI_MESOORI                   CARRETEIROFRETE.CIDADECHOR%TYPE;
        VI_MESODES                   CARRETEIROFRETE.CIDADECHOR%TYPE;
        VI_PESOBALANCA               T_ARM_NOTA.ARM_NOTA_PESOBALANCA%TYPE;
        VI_TPCARGANOVA               VARCHAR2(80);
        vi_pesoid                    number;
        VI_PESOCOBRADO               NUMBER;
        VI_CFOP                      T_ARM_NOTA.GLB_CFOP_CODIGO%TYPE;
        VI_CFOPDESC                  T_GLB_CFOP.GLB_CFOP_DESCRICAO%TYPE;
        VI_ONU                       T_ARM_NOTA.ARM_NOTA_ONU%TYPE;
        vi_onuembalagem              t_arm_nota.arm_nota_grpemb%type;
        VI_ONUDESC                   T_GLB_ONU.GLB_ONU_PRODUTO%TYPE;
        VI_MesoOrig                  VARCHAR2(40);
        VI_MesoDest                  VARCHAR2(40);
        VI_axoDest                   VARCHAR2(15);
        VI_axoOrig                   VARCHAR2(15);
        VI_DtHrChegCli               CHAR(19);
        VI_DtHrSaidaCli              CHAR(19);
        VI_DtHrImpCol                CHAR(19);
        VI_PLACACOLETA               VARCHAR2(7);
        VI_TPVEICULOCOLETA           tdvadm.t_fcf_tpveiculo.fcf_tpveiculo_descricao%type;
        VI_ANOVEICULOCOLETA          VARCHAR2(4);
        VI_DTREALCOLETA              CHAR(19);
        VI_ATRASOENT                 NUMBER;
        VI_arm_nota_ri               T_ARM_NOTA.ARM_NOTA_RI%TYPE;
        VI_usuario_web_login_ri      T_ARM_NOTA.USUARIO_WEB_LOGIN_RI%TYPE;
        VI_arm_nota_chegadaportaria  T_ARM_NOTA.ARM_NOTA_CHEGADAPORTARIA%TYPE;
        VI_arm_nota_senhaportaria    T_ARM_NOTA.ARM_NOTA_SENHAPORTARIA%TYPE;
        VI_arm_nota_dtentregasenha   T_ARM_NOTA.ARM_NOTA_DTENTREGASENHA%TYPE;
        VI_arm_nota_di               T_ARM_NOTA.ARM_NOTA_DI%TYPE;
        VI_arm_nota_nf_e             T_ARM_NOTA.ARM_NOTA_NF_E%TYPE;
        VI_arm_nota_ctrc_e           T_ARM_NOTA.ARM_NOTA_CTRC_E%TYPE;
        VI_arm_nota_rictrc           T_ARM_NOTA.Arm_Nota_Rictrc%TYPE;
        VI_arm_nota_datarictrc       T_ARM_NOTA.ARM_NOTA_DATARICTRC%TYPE;
        VI_XML_NOTA_OBS              T_XML_NOTA.XML_NOTA_OBS%TYPE;
        VI_XML_NOTA_DTEXCLUSAO       T_XML_NOTA.XML_NOTA_DTEXCLUSAO%TYPE;
        VI_XML_NOTA_DTINCLUSAO       T_XML_NOTA.XML_NOTA_DTINCLUSAO%TYPE;
        VI_XML_NOTA_ENVIO            T_XML_NOTA.XML_NOTA_ENVIO%TYPE;
        VI_XML_NOTA_RETORNO          T_XML_NOTA.XML_NOTA_RETORNO%TYPE;
        VI_XML_STATUS_DESCRICAO      T_XML_STATUS.XML_STATUS_DESCRICAO%TYPE;
        VI_NFEXITXML                 CHAR(3);
        VI_XML_NOTA_TIPO             T_XML_NOTA.XML_NOTA_TIPO%TYPE;
        VI_XML_NOTA_RETORNO1         T_XML_NOTA.XML_NOTA_RETORNO%TYPE;
        VI_NF                        NUMBER;
        VI_CNPJ                      CHAR(20);
        VI_arm_coleta_ncompra        T_ARM_COLETA.ARM_COLETA_NCOMPRA%TYPE;
        VI_arm_coleta_CICLO          T_ARM_COLETA.ARM_COLETA_CICLO%TYPE;
        VI_XML_NOTA_CFOP             T_GLB_CFOP.GLB_CFOP_CODIGO%TYPE;
        VI_GLB_CFOP_CODIGO           T_GLB_CFOP.GLB_CFOP_CODIGO%TYPE;
        VI_ARM_NOTA_DTINCLUSAO       T_ARM_NOTA.ARM_NOTA_DTINCLUSAO%TYPE;
        vi_carregamento_dtfechamento t_arm_carregamento.arm_carregamento_dtfechamento%type;
        VI_DT_PROGRAMACAO_ENTREGA    VARCHAR(19);
        VI_TPCLIEND_DESTINATARIO     CHAR(1);
        VI_TPCLIEND_CODIGOREMETENTE  CHAR(1);
        VI_ARM_ARMAZEM_CODIGO        CHAR(2);
        VI_OCORRENCIA                VARCHAR2(50);
        VI_FLAGOCOR                  CHAR(3);
        vi_DTHRocor                  Char(19);
        vi_coletaemissao             Char(19);
        VI_PONOTA                    T_XML_NOTA.XML_NOTA_PO%TYPE;
        VI_COLETANOTA                T_XML_NOTA.XML_COLETA_NUMERO%TYPE;
        VI_XML_PO                    T_XML_NOTA.XML_NOTA_PO%TYPE;
        VI_XML_COLETA                T_XML_NOTA.XML_COLETA_NUMERO%TYPE;
--        VI_XML_COLETAEMISSAO         T_XML_COLETA.XML_COLETA_EMISSAO%TYPE;
--        VI_COLETAASN                 T_XML_NOTA.XML_COLETA_NUMERO%TYPE;
        VI_XML_COLETAEMISSAO         TDVADM.T_ARM_COLETAPART.ARM_COLETAPART_DTGRAVACAO%TYPE;
        VI_COLETAASN                 TDVADM.T_ARM_COLETAPART.ARM_COLETAPART_CODIGO%TYPE;
        v_notadigitalizada           char(1);
        v_notapesada                 char(1);
        VI_PGTOCAX                   Varchar2(20);
        VI_ARM_EMBALAGEM_NUMERO      T_ARM_EMBALAGEM.ARM_EMBALAGEM_NUMERO%TYPE;
        VI_ARM_EMBALAGEM_FLAG        T_ARM_EMBALAGEM.ARM_EMBALAGEM_FLAG%TYPE;
        VI_ARM_EMBALAGEM_SEQUENCIA   T_ARM_EMBALAGEM.ARM_EMBALAGEM_SEQUENCIA%TYPE;
        VI_ARMAZEMTRANSF             T_ARM_ARMAZEM.ARM_ARMAZEM_DESCRICAO%TYPE;
        vi_Message                   varchar2(100);
        vi_eAdHoc                    boolean;
        vErro                        number;      
        vUNIDADECONTROLE_TAREF       varchar2(100);
        vREGIAO                      varchar2(100);
        vSISTEMANC                   varchar2(100); 
        vTIPO_FRETE                  varchar2(100);
        vTIPOSOLICITACAO             varchar2(100);
        vTIPOCARGA                   varchar2(100);
        VI_SERIENOTA                 TDVADM.T_ARM_NOTA.ARM_NOTA_SERIE%TYPE;
        VI_DESCNOTA                  tdvadm.t_con_nftransporta.con_nfttransporta_mercadoria%type; 
--        VI_REMETENTEXMLCNPJ          TDVADM.T_XML_COLETA.GLB_CLIENTE_CGCCPFREMETENTE%TYPE;
        VI_REMETENTEXMLCNPJ          TDVADM.T_ARM_COLETAPART.ARM_COLETAPART_REMETENTE%TYPE;
        VI_REMTENDEXMLNOME           TDVADM.T_GLB_CLIENTE.GLB_CLIENTE_RAZAOSOCIAL%TYPE;
        VI_NFSE                      VARCHAR2(50); 
        VI_LINHAUSADA                TDVADM.T_CON_CALCCONHECIMENTO.CON_CALCCONHECIMENTO_COCLI%TYPE; 
        VI_CHAVENFE                  varchar2(100);
        VI_CHAVECTE                  VARCHAR2(100);
        VI_CTEANTRE                  VARCHAR2(20);
        VI_LINHAANTERIORRE           VARCHAR2(20);
        VI_CTEANTDE                  VARCHAR2(20);
        VI_LINHAANTERIORDE           VARCHAR2(20);
        VI_VEICPR                    VARCHAR2(100);
        VI_VEICULT                   VARCHAR2(100);
        VI_FrenteC                   VARCHAR2(100);
        VI_VersoC                    VARCHAR2(100);
        VI_FrenteT                   VARCHAR2(100);
        VI_VersoT                    VARCHAR2(100);
        VI_LOCALCOLETA               VARCHAR2(100);
        VI_LOCALENTREGA              VARCHAR2(100);

        VI_CTEVLRPAGO                NUMBER;
        VI_CTEVLRDESC                NUMBER;
        VI_CTEVLRACRES               NUMBER;
        VI_CTEVLRSALDO               NUMBER;
        VI_CTEDTULTEVENTO            DATE;
 
        VI_PRIORIDADECOL             VARCHAR2(100);
        VI_MODALIDADECOL             VARCHAR2(100);
        VI_ENTREGACONTAINER          VARCHAR2(100);
        VI_COLETACONTAINER           VARCHAR2(100);
        VI_IMPEXP                    VARCHAR2(100);  
        VI_TARA                      NUMBER;
        VI_EMAILSOL                  tdvadm.t_arm_coleta.arm_coleta_emailsolic%type;
        vContaCalc                   number;
        vOBSColeta                   tdvadm.t_arm_coleta.arm_coleta_obs%type;
        vOrigemColeta                tdvadm.t_arm_coleta.arm_coletaorigem_cod%type;

begin
  -- Test statements here
  FOR C_MSG IN (              SELECT C.CON_CONHECIMENTO_CODIGO VI_CONHECIMENTO,
                     C.CON_CONHECIMENTO_SERIE VI_SERIE,
                     C.GLB_ROTA_CODIGO VI_ROTA,
                     C.CON_VIAGEM_NUMERO VI_VIAGEM,
                     C.GLB_ROTA_CODIGOVIAGEM VI_ROTA_VIAGEM,
                     C.GLB_LOCALIDADE_CODIGOORIGEM VI_ORIGEM,
                     C.GLB_LOCALIDADE_CODIGODESTINO VI_DESTINO,
                     C.GLB_CLIENTE_CGCCPFSACADO VI_CGC_SACADO,
                     C.GLB_CLIENTE_CGCCPFREMETENTE VI_CGC_REMETENTE,
                     C.GLB_CLIENTE_CGCCPFDESTINATARIO VI_CGC_DESTINATARIO,
                     TO_CHAR(C.CON_CONHECIMENTO_DTEMBARQUE, 'DD/MM/YYYY') VI_DATAEMBARQUE,
                     A.GLB_ESTADO_CODIGO VI_ESTORIGEM,
                     A.GLB_LOCALIDADE_DESCRICAO VI_LOCORIGEM,
                     B.GLB_ESTADO_CODIGO VI_ESTDESTINO,
                     B.GLB_LOCALIDADE_DESCRICAO VI_LOCDESTINO,
                     C.CON_FATURA_CICLO || C.GLB_ROTA_CODIGOFILIALIMP ||
                     C.CON_FATURA_CODIGO VI_FATURA,
                     C.GLB_MERCADORIA_CODIGO VI_MERCADORIA_COD,
                     C.GLB_EMBALAGEM_CODIGO VI_EMBALAGEM_COD,
                     C.SLF_SOLFRETE_CODIGO VI_SOLFRETE_CODIGO,
                     C.SLF_SOLFRETE_SAQUE VI_SOLFRETE_SAQUEAT,
                     C.SLF_TABELA_CODIGO VI_TABELA_CODIGO,
                     C.SLF_TABELA_SAQUE VI_TABELA_SAQUEAT,
                     SUBSTR(REPLACE(REPLACE(C.CON_CONHECIMENTO_OBS,
                                            CHR(10),
                                            NULL),
                                    CHR(13),
                                    10),
                            1,
                            199) VI_OBS,
                     C.CON_VALEFRETE_CODIGO VI_VALEFRETE,
                     C.CON_VALEFRETE_SAQUE VI_VALEFRETESAQUE,
                     C.GLB_ROTA_CODIGOVALEFRETE VI_VALEFRETEROTA,
                     TO_CHAR(C.CON_CONHECIMENTO_DTGRAVACAO, 'DD/MM/YYYY') VI_DATAGRAVACAO,
                     NVL(NVL(CO.ARM_COLETA_NCOMPRA, C.ARM_COLETA_NCOMPRA),
                         COX.arm_coletapart_codigo) VI_COLETA,
                     C.GLB_ROTA_CODIGORECEITA VI_ROTARECEITA,
                     NVL(C.CON_CONHECIMENTO_FLAGCANCELADO, 'N') VI_CANCELADO,
                     REM.GLB_GRUPOECONOMICO_CODIGO VI_GRUPOREM,
                     DEST.GLB_GRUPOECONOMICO_CODIGO VI_GRUPODEST,
                     SAC.GLB_GRUPOECONOMICO_CODIGO VI_GRUPOSAC,
                     C.ARM_CARREGAMENTO_CODIGO VI_CARREGAMENTO,
                     substr(IBO.MESONOMEX, 1, 40) VI_MesoOrig,
                     substr(IBD.MESONOMEX, 1, 40) VI_MesoDest,
                     substr(NVL(DESTC.GLB_CLIEND_CODCLIENTE, ''), 1, 15) VI_axoDest,
                     substr(NVL(REMC.GLB_CLIEND_CODCLIENTE, ''), 1, 15) VI_axoOrig,
                     to_char(CO.ARM_COLETA_DTFECHAMENTO,
                             'DD/MM/YYYY HH24:MI:SS') VI_DtHrChegCli,
                     TRIM(CO.arm_coleta_datasaidacli || ' ' ||
                          CO.arm_coleta_horasaidacli) VI_DtHrSaidaCli,
                     CO.arm_coleta_dtimp VI_DtHrImpCol,
                     CO.ARM_COLETA_PLACA VI_PLACACOLETA,
                     TDVADM.FN_GET_TPVEICULO(CO.ARM_COLETA_PLACA, '') VI_TPVEICULOCOLETA,
                     TDVADM.FN_GET_ANOVEICULO(TRIM(CO.ARM_COLETA_PLACA)) VI_ANOVEICULOCOLETA,
                     nvl(DECODE(TDVADM.FN_VERIFICATPCOLETA(CO.ARM_COLETA_ENTCOLETA,
                                                           COX.arm_coletapart_tipofrete,
                                                           CO.USU_USUARIO_CODIGO_CAD),
                                'EXW',
                                'C',
                                'FCA',
                                'E'),
                         'FOB') VI_COLETAENTREGA,
                     trim(NVL(TDVADM.FN_VERIFICATPCOLETA(CO.ARM_COLETA_ENTCOLETA,
                                                         COX.arm_coletapart_tipofrete,
                                                         CO.USU_USUARIO_CODIGO_CAD),
                              ' -- ')) VI_INCOTERMS,
                     '0' VI_PO,
                     NVL(CO.XML_COLETA_NUMERO, COX.arm_coletapart_codigo) VI_ASN,
                     TDVADM.FN_CALCULA_DIASUTEIS_SLA(NVL(CO.ARM_COLETA_DTSOLICITACAO,
                                                         SYSDATE),
                                                     CO.ARM_COLETA_HRSOLICITACAO,
                                                     NVL(CO.ARM_COLETA_DTPROGRAMACAO,
                                                         SYSDATE),
                                                     CO.ARM_COLETA_HRPROGRAMACAO,
                                                     C.CON_CONHECIMENTO_ENTREGA,
                                                     C.GLB_LOCALIDADE_CODIGOORIGEM,
                                                     C.GLB_LOCALIDADE_CODIGODESTINO,
                                                     CO.GLB_TPCARGA_CODIGO,
                                                     TDVADM.FN_VERIFICATPCOLETA(CO.ARM_COLETA_TIPO,
                                                                                COX.arm_coletapart_tipofrete,
                                                                                CO.USU_USUARIO_CODIGO_CAD),
                                                     C.CON_CONHECIMENTO_ENTREGA,
                                                     CO.ARM_ARMAZEM_CODIGO,
                                                     '',
                                                     '',
                                                     C.CON_CONHECIMENTO_CODIGO ||
                                                     C.arm_coleta_ncompra,
                                                     C.CON_CONHECIMENTO_SERIE,
                                                     C.GLB_ROTA_CODIGO,
                                                     NVL(CO.ARM_COLETA_AUTEXPDATA,
                                                         SYSDATE),
                                                     CO.ARM_COLETA_AUTEXPHORA,
                                                     4) VI_DTCOLETA,
                     TRIM(CO.ARM_COLETA_DTSOLICITACAO || ' ' ||
                          CO.ARM_COLETA_HRSOLICITACAO) VI_DTPEDCOLETA,
                     TRIM(CO.ARM_COLETA_DTPROGRAMACAO || ' ' ||
                          CO.ARM_COLETA_HRPROGRAMACAO) VI_PROGRAMACAOCOLETA,
                     NVL(EMB.GLB_EMBALAGEM_DESCRICAO, '') VI_EMBALAGEM_DESC,
                     MER.GLB_MERCADORIA_DESCRICAO VI_MERCADORIA_DESC,
                     TO_CHAR(F.CON_FATURA_DATAEMISSAO) VI_DATAFAT,
                     TDVADM.FN_DADOSVEICULO(SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                                                      C.CON_CONHECIMENTO_SERIE,
                                                                      C.GLB_ROTA_CODIGO),
                                                   1,
                                                   20),
                                            C.CON_CONHECIMENTO_CODIGO,
                                            C.GLB_ROTA_CODIGO,
                                            C.CON_VIAGEM_NUMERO,
                                            C.GLB_ROTA_CODIGOVIAGEM,
                                            'MOT') VI_MOTORISTA,
                     TDVADM.FN_DADOSVEICULO(SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                                                      C.CON_CONHECIMENTO_SERIE,
                                                                      C.GLB_ROTA_CODIGO),
                                                   1,
                                                   20),
                                            C.CON_CONHECIMENTO_CODIGO,
                                            C.GLB_ROTA_CODIGO,
                                            C.CON_VIAGEM_NUMERO,
                                            C.GLB_ROTA_CODIGOVIAGEM,
                                            'PRO') VI_PROPRIETARIO,
                     TDVADM.FN_DADOSVEICULO(SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                                                      C.CON_CONHECIMENTO_SERIE,
                                                                      C.GLB_ROTA_CODIGO),
                                                   1,
                                                   20),
                                            C.CON_CONHECIMENTO_CODIGO,
                                            C.GLB_ROTA_CODIGO,
                                            C.CON_VIAGEM_NUMERO,
                                            C.GLB_ROTA_CODIGOVIAGEM,
                                            'DTA') VI_DATANASCCARR,
                     SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                               C.CON_CONHECIMENTO_SERIE,
                                               C.GLB_ROTA_CODIGO),
                            1,
                            7) VI_PLACACARRETA,
                     TDVADM.FN_DADOSVEICULO(SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                                                      C.CON_CONHECIMENTO_SERIE,
                                                                      C.GLB_ROTA_CODIGO),
                                                   1,
                                                   20),
                                            C.CON_CONHECIMENTO_CODIGO,
                                            C.GLB_ROTA_CODIGO,
                                            C.CON_VIAGEM_NUMERO,
                                            C.GLB_ROTA_CODIGOVIAGEM,
                                            'CPF') VI_CPFMOTORISTA,
                     CO.ARM_COLETA_DTCOLETA VI_DTREALCOLETA,
                     to_CHAR(co.ARM_COLETA_DTAUTORIZA,
                             'dd/mm/yyyy hh24:mi:ss') VI_EXPDTAUTORIZADOR,
                     to_CHAR(c.con_conhecimento_horasaida, 'hh24:mi:ss') VI_HORAEMBARQUE,
                     REM.GLB_CLIENTE_RAZAOSOCIAL VI_CLIENTEREM,
                     DEST.GLB_CLIENTE_RAZAOSOCIAL VI_CLIENTEDEST,
                     SAC.GLB_CLIENTE_RAZAOSOCIAL VI_CLIENTESAC,
                     C.CON_CONHECIMENTO_HORASAIDA VI_DATASAIDA,
                     C.CON_CONHECIMENTO_DTINICARGA VI_DATAICARGA,
                     C.CON_CONHECIMENTO_DTFIMCARGA VI_DATAFCARGA,
                     C.CON_CONHECIMENTO_DTCHEGALMOX VI_DATAIDESCARGA,
                     C.CON_CONHECIMENTO_DTRECEBIMENTO VI_DATAFDESCARGA,
                     C.CON_CONHECIMENTO_ENTREGA VI_DATACHEGADA,
                     C.CON_CONHECIMENTO_DTCHEGCELULA VI_DATAICELULA,
                     C.CON_CONHECIMENTO_DTSAIDACELULA VI_DATAFCELULA,
                     C.CON_CONHECIMENTO_CFO VI_CFO,
                     C.GLB_TPCLIEND_CODIGODESTINATARI VI_TPCLIEND_DESTINATARIO,
                     C.GLB_TPCLIEND_CODIGOREMETENTE VI_TPCLIEND_CODIGOREMETENTE,
                     CO.ARM_ARMAZEM_CODIGO VI_ARM_ARMAZEM_CODIGO,
                     decode(nvl(co.arm_coleta_dtsolicitacao, '01/01/1900'),
                            '01/01/1900',
                            null,
                            TO_DATE(TO_CHAR(co.arm_coleta_dtsolicitacao,
                                            'DD/MM/YYYY') || ' ' ||
                                    co.arm_coleta_hrsolicitacao,
                                    'DD/MM/YYYY HH24:MI')) vi_coletaemissao,
                     NVL(NVL(CO.ARM_COLETA_CICLO, C.ARM_COLETA_CICLO),
                         COX.ARM_COLETA_CICLO) VI_COLETACICLO,
                     C.USU_USUARIO_BAIXA VI_USUBAIXOU,
                     substr(TRIM(C.CON_CONHECIMENTO_LOCALCOLETA) || '-' ||
                            TRIM(COL.GLB_ESTADO_CODIGO || '-' ||
                                 COL.GLB_LOCALIDADE_DESCRICAO),
                            1,
                            100) VI_LOCALCOLETA,
                     substr(TRIM(C.CON_CONHECIMENTO_LOCALENTREGA) || '-' ||
                            TRIM(ENT.GLB_ESTADO_CODIGO || '-' ||
                                 ENT.GLB_LOCALIDADE_DESCRICAO),
                            1,
                            100) VI_LOCALENTREGA,
                     TDVADM.FN_DADOSVEICULO(SUBSTR(TDVADM.F_PLACACONJ(C.CON_CONHECIMENTO_CODIGO,
                                                                      C.CON_CONHECIMENTO_SERIE,
                                                                      C.GLB_ROTA_CODIGO),
                                                   1,
                                                   20),
                                            C.CON_CONHECIMENTO_CODIGO,
                                            C.GLB_ROTA_CODIGO,
                                            C.CON_VIAGEM_NUMERO,
                                            C.GLB_ROTA_CODIGOVIAGEM,
                                            'CPFP') VI_CPFPROPRIETARIO,
                     C.ARM_CARREGAMENTO_CODIGOPR VI_CARREGAMENTOPR,
                     CO.ARM_COLETA_PEDIDO VI_PEDIDO,
                     CO.ARM_COLETA_CENTRODECUSTO VI_CENTROCUSTO,
                     C.CON_CONHECIMENTO_OBSDTENTREGA VI_OBSERVACAOENTREGA,
                     CO.ARM_COLETAORIGEM_COD vOrigemColeta
                FROM TDVADM.T_CON_CONHECIMENTO C,
                     TDVADM.T_GLB_LOCALIDADE   A,
                     TDVADM.T_GLB_LOCALIDADE   B,
                     TDVADM.T_GLB_LOCALIDADE   COL,
                     TDVADM.T_GLB_LOCALIDADE   ENT,
                     TDVADM.T_GLB_CLIENTE      REM,
                     TDVADM.T_GLB_CLIENTE      DEST,
                     TDVADM.T_GLB_CLIENTE      SAC,
                     IBGE.v_glb_ibge           ibO,
                     IBGE.v_glb_ibge           ibD,
                     TDVADM.t_arm_coleta       co,
                     TDVADM.t_glb_cliend       RemC,
                     TDVADM.t_glb_cliend       destC,
                     TDVADM.T_ARM_COLETAPART   COX,
                     TDVADM.T_GLB_EMBALAGEM    emb,
                     TDVADM.T_GLB_MERCADORIA   mer,
                     TDVADM.T_CON_FATURA       F
               WHERE (0 = 0 AND
                     C.CON_CONHECIMENTO_DTEMBARQUE >= '01/02/2018' AND                     
                     C.CON_CONHECIMENTO_DTEMBARQUE <= '31/03/2022' and
                    (C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('003936750') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('000274079') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('076590079') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('084295079') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('697546011') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('042451161') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('042486161') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('090719079') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('150701620') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('124771079') or
                     C.CON_CONHECIMENTO_CODIGO || C.GLB_ROTA_CODIGO IN                     ('140681079')) AND 
                     C.CON_CONHECIMENTO_SERIE <> 'XXX' AND
                     C.CON_CONHECIMENTO_FLAGCANCELADO IS NULL AND
                     C.GLB_LOCALIDADE_CODIGOORIGEM =
                     A.GLB_LOCALIDADE_CODIGO(+) AND
                     C.GLB_LOCALIDADE_CODIGODESTINO =
                     B.GLB_LOCALIDADE_CODIGO(+) AND
                     C.CON_CONHECIMENTO_LOCALCOLETA =
                     COL.GLB_LOCALIDADE_CODIGO(+) AND
                     C.CON_CONHECIMENTO_LOCALENTREGA =
                     ENT.GLB_LOCALIDADE_CODIGO(+) AND
                     C.GLB_CLIENTE_CGCCPFREMETENTE =
                     REM.GLB_CLIENTE_CGCCPFCODIGO AND
                     C.GLB_CLIENTE_CGCCPFDESTINATARIO =
                     DEST.GLB_CLIENTE_CGCCPFCODIGO AND
                     C.GLB_CLIENTE_CGCCPFSACADO =
                     SAC.GLB_CLIENTE_CGCCPFCODIGO AND
                     SAC.GLB_GRUPOECONOMICO_CODIGO not in ('9999') and
                     A.glb_localidade_codigoibge = IBO.codmun and
                     B.glb_localidade_codigoibge = IBD.codmun and
                     dest.glb_cliente_cgccpfcodigo =
                     destc.glb_cliente_cgccpfcodigo and
                     c.glb_cliente_cgccpfdestinatario =
                     destc.glb_cliente_cgccpfcodigo and
                     c.glb_tpcliend_codigodestinatari =
                     destc.glb_tpcliend_codigo and
                     rem.glb_cliente_cgccpfcodigo =
                     Remc.glb_cliente_cgccpfcodigo and
                     c.glb_cliente_cgccpfremetente =
                     Remc.glb_cliente_cgccpfcodigo and
                     c.glb_tpcliend_codigoremetente =
                     Remc.glb_tpcliend_codigo and
                     trim(TDVADM.PKG_CON_CTE.FN_CTE_EELETRONICO(C.CON_CONHECIMENTO_CODIGO,
                                                                 C.CON_CONHECIMENTO_SERIE,
                                                                 C.GLB_ROTA_CODIGO)) = 'S' and
                     c.arm_coleta_ncompra = co.arm_coleta_ncompra(+) and
                     c.arm_coleta_ciclo = co.arm_coleta_ciclo(+) AND
                     C.ARM_COLETA_NCOMPRA = COX.ARM_COLETA_NCOMPRA(+) AND
                     C.ARM_COLETA_ciclo = COX.ARM_COLETA_ciclo(+) AND
                     C.GLB_CLIENTE_CGCCPFREMETENTE =
                     COX.arm_coletapart_remetente(+) and
                     C.GLB_EMBALAGEM_CODIGO = emb.glb_embalagem_codigo(+) and
                     c.GLB_MERCADORIA_CODIGO =
                     mer.glb_mercadoria_codigo(+) AND
                     C.CON_FATURA_CODIGO = F.CON_FATURA_CODIGO(+) AND
                     C.GLB_ROTA_CODIGOFILIALIMP =
                     F.GLB_ROTA_CODIGOFILIALIMP(+) AND
                     C.CON_FATURA_CICLO = F.CON_FATURA_CICLO(+))
                 AND 0 =
                     (SELECT COUNT(*)
                        FROM TDVADM.T_TMP_RPT2 RPT
                       WHERE RPT.CON_CONHECIMENTO_CODIGO =
                             C.CON_CONHECIMENTO_CODIGO
                         AND RPT.CON_CONHECIMENTO_SERIE =
                             C.CON_CONHECIMENTO_SERIE
                         AND RPT.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO)
                 AND 0 =
                     (SELECT COUNT(*)
                        FROM TDVADM.V_CON_CONHECANULA RPT
                       WHERE RPT.CON_CONHECIMENTO_CODIGO =
                             C.CON_CONHECIMENTO_CODIGO
                         AND RPT.CON_CONHECIMENTO_SERIE =
                             C.CON_CONHECIMENTO_SERIE
                         AND RPT.GLB_ROTA_CODIGO = C.GLB_ROTA_CODIGO)
)
    
  lOOP
    begin
  
      VI_CONHECIMENTO                     := C_MSG.VI_CONHECIMENTO;
      VI_SERIE                            := C_MSG.VI_SERIE;
      VI_ROTA                             := C_MSG.VI_ROTA;
      VI_VIAGEM                           := C_MSG.VI_VIAGEM;
      VI_ROTA_VIAGEM                      := C_MSG.VI_ROTA_VIAGEM;
      VI_ORIGEM                           := C_MSG.VI_ORIGEM;
      VI_DESTINO                          := C_MSG.VI_DESTINO;
      VI_CGC_SACADO                       := C_MSG.VI_CGC_SACADO;
      VI_CGC_REMETENTE                    := C_MSG.VI_CGC_REMETENTE;
      VI_CGC_DESTINATARIO                 := C_MSG.VI_CGC_DESTINATARIO;
      VI_DATAEMBARQUE                     := C_MSG.VI_DATAEMBARQUE;
      VI_ESTORIGEM                        := C_MSG.VI_ESTORIGEM;
      VI_LOCORIGEM                        := C_MSG.VI_LOCORIGEM;
      VI_ESTDESTINO                       := C_MSG.VI_ESTDESTINO;
      VI_LOCDESTINO                       := C_MSG.VI_LOCDESTINO;
      VI_FATURA                           := C_MSG.VI_FATURA;
      VI_MERCADORIA_COD                   := C_MSG.VI_MERCADORIA_COD;
      VI_EMBALAGEM_COD                    := C_MSG.VI_EMBALAGEM_COD;
      VI_SOLFRETE_CODIGO                  := C_MSG.VI_SOLFRETE_CODIGO;
      VI_SOLFRETE_SAQUEAT                 := C_MSG.VI_SOLFRETE_SAQUEAT;
      VI_TABELA_CODIGO                    := C_MSG.VI_TABELA_CODIGO;
      VI_TABELA_SAQUEAT                   := C_MSG.VI_TABELA_SAQUEAT;
      VI_OBS                              := C_MSG.VI_OBS;
      VI_VALEFRETE                        := C_MSG.VI_VALEFRETE;
      VI_VALEFRETESAQUE                   := C_MSG.VI_VALEFRETESAQUE;
      VI_VALEFRETEROTA                    := C_MSG.VI_VALEFRETEROTA;
      VI_DATAGRAVACAO                     := C_MSG.VI_DATAGRAVACAO;
      VI_COLETA                           := C_MSG.VI_COLETA;
      VI_ROTARECEITA                      := C_MSG.VI_ROTARECEITA;
      VI_CANCELADO                        := C_MSG.VI_CANCELADO;
      VI_GRUPOREM                         := C_MSG.VI_GRUPOREM;
      VI_GRUPODEST                        := C_MSG.VI_GRUPODEST;
      VI_GRUPOSAC                         := C_MSG.VI_GRUPOSAC;
      VI_CARREGAMENTO                     := C_MSG.VI_CARREGAMENTO;
      VI_MesoOrig                         := C_MSG.VI_MESOORIG;
      VI_MesoDest                         := C_MSG.VI_MESODEST;
      VI_axoDest                          := C_MSG.VI_AXODEST;
      VI_axoOrig                          := C_MSG.VI_AXOORIG;
      VI_DtHrChegCli                      := C_MSG.VI_DTHRCHEGCLI;
      VI_DtHrSaidaCli                     := C_MSG.VI_DTHRSAIDACLI;
      VI_DtHrImpCol                       := C_MSG.VI_DTHRIMPCOL;
      VI_PLACACOLETA                      := C_MSG.VI_PLACACOLETA;
      VI_TPVEICULOCOLETA                  := C_MSG.VI_TPVEICULOCOLETA;
      VI_ANOVEICULOCOLETA                 := C_MSG.VI_ANOVEICULOCOLETA;
      VI_COLETAENTREGA                    := C_MSG.VI_COLETAENTREGA;
      VI_INCOTERMS                        := C_MSG.VI_INCOTERMS;
      VI_PO                               := C_MSG.VI_PO;
      VI_ASN                              := C_MSG.VI_ASN;
      VI_DTCOLETA                         := C_MSG.VI_DTCOLETA;
      VI_DTPEDCOLETA                      := C_MSG.VI_DTPEDCOLETA;
      VI_PROGRAMACAOCOLETA                := C_MSG.VI_PROGRAMACAOCOLETA;
      VI_EMBALAGEM_DESC                   := C_MSG.VI_EMBALAGEM_DESC;
      VI_MERCADORIA_DESC                  := C_MSG.VI_MERCADORIA_DESC;
      VI_DATAFAT                          := C_MSG.VI_DATAFAT;
      VI_MOTORISTA                        := C_MSG.VI_MOTORISTA;
      VI_PROPRIETARIO                     := C_MSG.VI_PROPRIETARIO;
      VI_DATANASCCARR                     := C_MSG.VI_DATANASCCARR;
      VI_PLACACARRETA                     := C_MSG.VI_PLACACARRETA;
      VI_CPFMOTORISTA                     := C_MSG.VI_CPFMOTORISTA;
      VI_DTREALCOLETA                     := C_MSG.VI_DTREALCOLETA;
      VI_EXPDTAUTORIZADOR                 := C_MSG.VI_EXPDTAUTORIZADOR;
      VI_HORAEMBARQUE                     := C_MSG.VI_HORAEMBARQUE;
      VI_CLIENTEREM                       := C_MSG.VI_CLIENTEREM;
      VI_CLIENTEDEST                      := C_MSG.VI_CLIENTEDEST;
      VI_CLIENTESAC                       := C_MSG.VI_CLIENTESAC;
      VI_DATASAIDA                        := C_MSG.VI_DATASAIDA;
      VI_DATAICARGA                       := C_MSG.VI_DATAICARGA;
      VI_DATAFCARGA                       := C_MSG.VI_DATAFCARGA;
      VI_DATAIDESCARGA                    := C_MSG.VI_DATAIDESCARGA;
      VI_DATAFDESCARGA                    := C_MSG.VI_DATAFDESCARGA;
      VI_DATACHEGADA                      := C_MSG.VI_DATACHEGADA;
      VI_DATAICELULA                      := C_MSG.VI_DATAICELULA;
      VI_DATAFCELULA                      := C_MSG.VI_DATAFCELULA;
      VI_CFO                              := C_MSG.VI_CFO;
      VI_TPCLIEND_DESTINATARIO            := C_MSG.VI_TPCLIEND_DESTINATARIO;
      VI_TPCLIEND_CODIGOREMETENTE         := C_MSG.VI_TPCLIEND_CODIGOREMETENTE;
      VI_ARM_ARMAZEM_CODIGO               := C_MSG.VI_ARM_ARMAZEM_CODIGO;
      vi_coletaemissao                    := C_MSG.VI_COLETAEMISSAO;
      VI_COLETACICLO                      := C_MSG.VI_COLETACICLO;
      VI_USUBAIXOU                        := C_MSG.VI_USUBAIXOU;
      VI_LOCALCOLETA                      := C_MSG.VI_LOCALCOLETA;
      VI_LOCALENTREGA                     := C_MSG.VI_LOCALENTREGA;
      VI_CPFPROPRIETARIO                  := C_MSG.VI_CPFPROPRIETARIO;
      VI_CARREGAMENTOPR                   := C_MSG.VI_CARREGAMENTOPR;
      VI_PEDIDO                           := C_MSG.VI_PEDIDO;
      VI_CENTROCUSTO                      := C_MSG.VI_CENTROCUSTO;
      VI_OBSERVACAOENTREGA                := C_MSG.VI_OBSERVACAOENTREGA;
      vOrigemColeta                       := C_MSG.VORIGEMCOLETA;
      dbms_output.put_line('OK ' || VI_CONHECIMENTO || '-' || VI_SERIE || '-' || VI_ROTA);
     exception
       when others then
           dbms_output.put_line('ERRO ' || VI_CONHECIMENTO || '-' || VI_SERIE || '-' || VI_ROTA);
       end;                           
   END LOOP;                                
end;
0
3
VI_ANOVEICULOCOLETA 
C_MSG.VI_ANOVEICULOCOLETA
v_placa
