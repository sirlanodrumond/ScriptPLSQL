PL/SQL Developer Test script 3.0
148
declare
  pArmazem       tdvadm.t_arm_carregamento.arm_armazem_codigo%Type := '06';
  pCarregamento  tdvadm.t_arm_carregamento.arm_carregamento_codigo%type := '3080216';

  V_VERTPCARGAS        CHAR(3);
  V_SACADOCARGA      TDVADM.T_GLB_CLIENTE.GLB_CLIENTE_CGCCPFCODIGO%TYPE;
  V_GRUPOCARGAS      TDVADM.T_GLB_GRUPOECONOMICO.GLB_GRUPOECONOMICO_CODIGO%TYPE;
  V_CONTRATOCARGAS   TDVADM.T_ARM_NOTA.SLF_CONTRATO_CODIGO%TYPE;


  type tpCurosr is REF CURSOR;
  cNOTAS  tpCurosr;
  cCARGAS tpCurosr;

  pListaNotas    PKG_FIFO_CARREGCTRC_TST.TPNOTA;
  pListaCargaCli PKG_FIFO_CARREGCTRC_TST.TPCARGACLI;
  pRetBuscaFrete PKG_FIFO_CARREGCTRC_TST.TPBUSCAVERBA;

begin
   For C_msg in (SELECT DISTINCT C.ARM_CARREGAMENTO_CODIGO,C.ARM_ARMAZEM_CODIGO
                 FROM TDVADM.T_ARM_CARREGAMENTO C,
                      TDVADM.T_ARM_CARREGAMENTODET CD
                 WHERE C.ARM_CARREGAMENTO_CODIGO = CD.ARM_CARREGAMENTO_CODIGO     
--                   AND C.ARM_CARREGAMENTO_DTFECHAMENTO IS NULL
                   AND C.ARM_CARREGAMENTO_CODIGO = PCARREGAMENTO
--                   AND TRUNC(C.ARM_CARREGAMENTO_DTCRIA) = '11/11/2020'
                   AND ROWNUM <= 10)
   Loop                
  
    pArmazem := c_msg.arm_armazem_codigo;
    pCarregamento := c_msg.arm_carregamento_codigo;
    tdvadm.pkg_fifo_carregctrc_tst.ListaVerbas('CARREGAMENTO').Value := c_msg.arm_carregamento_codigo;
    
    :Result := '';
    Pkg_Fifo_Carregctrc_Tst.spi_SqlArmazemCarreg(pArmazem,pCarregamento);
    Pkg_Fifo_Carregctrc_Tst.spi_SqlFixos;

    Pkg_Fifo_Carregctrc_Tst.ListaSQL.FINALNOTA := Pkg_Fifo_Carregctrc_Tst.ListaSQL.NOTAS || 
                                                  Pkg_Fifo_Carregctrc_Tst.ListaSQL.TABWHERE;

    OPEN cNOTAS FOR Pkg_Fifo_Carregctrc_Tst.ListaSQL.FINALNOTA;
    Loop
       fetch cNOTAS
         into pListaNotas;
       Exit When cnotas%Notfound;


        -- PEGA COMO SERA PESQUISADO O CLIENTE
        V_VERTPCARGAS := TDVADM.PKG_slf_contrato.FN_SLF_CLIENTEREGRACARGA(pListaNotas.cnCLISAC, pListaNotas.cnContrato);
        IF V_VERTPCARGAS = 'GCT' THEN -- ACHOU POR GRUPO/CNPJ/CONTRADO
          V_SACADOCARGA    := pListaNotas.cnCLISAC;
          V_GRUPOCARGAS    := pListaNotas.cnGRUPOECSAC;
          V_CONTRATOCARGAS := pListaNotas.cnContrato;
        ELSIF V_VERTPCARGAS = 'GC' THEN -- ACHOU POR GRUPO/CNPJ
          V_SACADOCARGA    := pListaNotas.cnCLISAC;
          V_GRUPOCARGAS    := pListaNotas.cnGRUPOECSAC;
          V_CONTRATOCARGAS := Pkg_Fifo_Carregctrc_Tst.QualquerContrato;
        ELSIF V_VERTPCARGAS = 'GT' THEN -- ACHOU GRUPO/CONTRATO
          V_SACADOCARGA    := Pkg_Fifo_Carregctrc_Tst.QualquerCliente;
          V_GRUPOCARGAS    := pListaNotas.cnGRUPOECSAC;
          V_CONTRATOCARGAS := pListaNotas.cnContrato;
        ELSIF V_VERTPCARGAS = 'G' THEN --ACHOU POR GRUPO
          V_SACADOCARGA    := Pkg_Fifo_Carregctrc_Tst.QualquerCliente;
          V_GRUPOCARGAS    := pListaNotas.cnGRUPOECSAC;
          V_CONTRATOCARGAS := Pkg_Fifo_Carregctrc_Tst.QualquerContrato;
        ELSIF V_VERTPCARGAS = 'C' THEN --ACHOU POR CLIENTE
          V_SACADOCARGA    := pListaNotas.cnCLISAC;
          V_GRUPOCARGAS    := Pkg_Fifo_Carregctrc_Tst.QualquerGrupo;
          V_CONTRATOCARGAS := Pkg_Fifo_Carregctrc_Tst.QualquerContrato;
        ELSIF V_VERTPCARGAS = 'T' THEN --ACHOU POR CONTRATO
          V_SACADOCARGA    := Pkg_Fifo_Carregctrc_Tst.QualquerCliente;
          V_GRUPOCARGAS    := Pkg_Fifo_Carregctrc_Tst.QualquerGrupo;
          V_CONTRATOCARGAS := pListaNotas.cnContrato;
        ELSIF V_VERTPCARGAS = 'QQQ' THEN --POR QUALQUER COISA
          V_SACADOCARGA    := Pkg_Fifo_Carregctrc_Tst.QualquerCliente;
          V_GRUPOCARGAS    := Pkg_Fifo_Carregctrc_Tst.QualquerGrupo;
          V_CONTRATOCARGAS := Pkg_Fifo_Carregctrc_Tst.QualquerContrato;
        ELSE
          V_SACADOCARGA    := Pkg_Fifo_Carregctrc_Tst.QualquerCliente;
          V_GRUPOCARGAS    := Pkg_Fifo_Carregctrc_Tst.QualquerGrupo;
          V_CONTRATOCARGAS := Pkg_Fifo_Carregctrc_Tst.QualquerContrato;
        END IF;
    



       Pkg_Fifo_Carregctrc_Tst.spi_SqlSacGrupoContrato(V_SACADOCARGA,
                                                       V_GRUPOCARGAS,
                                                       V_CONTRATOCARGAS);

       commit;
       OPEN cCARGAS FOR Pkg_Fifo_Carregctrc_Tst.ListaSQL.FINALCARG;
       Loop
          FETCH cCARGAS
           INTO pListaCargaCli;
       Exit When cCARGAS%Notfound;
 
            pRetBuscaFrete.SLF_TABELA_CODIGO              := pListaNotas.cnTABSOLCOD;
            pRetBuscaFrete.SLF_TABELA_SAQUE               := pListaNotas.cnTABSOLSQ;
            pRetBuscaFrete.SLF_CALCFRETEKM_KMDE           := 0;
            pRetBuscaFrete.SLF_CALCFRETEKM_KMATE          := 100;
            pRetBuscaFrete.SLF_CALCFRETEKM_PESODE         := 50;
            pRetBuscaFrete.SLF_CALCFRETEKM_PESOATE        := 100;
            pRetBuscaFrete.SLF_TPCALCULO_CODIGO           := '041';
            pRetBuscaFrete.SLF_RECCUST_CODIGO             := 'D_FPSVO';
            pRetBuscaFrete.SLF_CALCFRETEKM_VALOR          := 3400.00;
            pRetBuscaFrete.SLF_CALCFRETEKM_DESINENCIA     := 'VL';
            pRetBuscaFrete.SLF_CALCFRETEKM_CODCLI         := 'CODCLI';
            pRetBuscaFrete.SLF_CALCFRETEKM_TPFRETE        := 'IB';
            pRetBuscaFrete.SLF_CALCFRETEKM_ORIGEM         := '99999';
            pRetBuscaFrete.SLF_CALCFRETEKM_DESTINO        := '99999';
            pRetBuscaFrete.SLF_CALCFRETEKM_ORIGEMI        := '354008';
            pRetBuscaFrete.SLF_CALCFRETEKM_DESTINOI       := '453989';
            pRetBuscaFrete.SLF_CALCFRETEKM_LIMITE         := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_VALORE         := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_DESINENCIAE    := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_VALORF         := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_DESINENCIAF    := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_RAIOKMORIGEM   := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_RAIOKMDESTINO  := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_IMPEMBUTIDO    := 'N';
            pRetBuscaFrete.SLF_CALCFRETEKM_OUTRACOLETAI   := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_OUTRAENTREGAI  := NULL;
            pRetBuscaFrete.SLF_CALCFRETEKM_dtgravacao     := SYSDATE;
            pRetBuscaFrete.GLB_MERCADORIA_CODIGO          := '69';
            pRetBuscaFrete.SLF_TABELA_COLETAENTREGA       := 'E';
            pRetBuscaFrete.SLF_TABELA_TIPO                := 'CIF';
            pRetBuscaFrete.FCF_TPVEICULO_CODIGO           := '1  ';
            pRetBuscaFrete.FCF_TPCARGA_CODIGO             := pListaCargaCli.ccTPCARGACLI;
            pRetBuscaFrete.GLB_CLIENTE_CGCCPFCODIGO       := pListaNotas.cnCLISAC;
            pRetBuscaFrete.GLB_GRUPOECONOMICO_CODIGO      := pListaNotas.cnGRUPOECSAC;
            pRetBuscaFrete.SLF_TABELA_CONTRATO            := pListaNotas.cnContrato;
            pRetBuscaFrete.vPESOCOBRADO                   := 1234;
            pRetBuscaFrete.vFATORRATEIO                   := 0.1234;
            pRetBuscaFrete.vRetorno                       := 'S';
            pRetBuscaFrete.vRowId                         := 'asdfa42341304wwer';
               
            dbms_output.put_line('CHAVE         -> [' || V_SACADOCARGA || ']-[' || V_GRUPOCARGAS || ']-[' || V_CONTRATOCARGAS || ']');
            dbms_output.put_line('OBS ORIGINAL  -> ' || TRIM(pListaCargaCli.ccOBSCUST));
            dbms_output.put_line('OBS TRADUZIDA -> ' || TRIM(PKG_FIFO_CARREGCTRC_tst.fn_RetornaObservacao(pListaNotas => pListaNotas,
                                                                                                          pListaCargaCli => pListaCargaCli,
                                                                                                          pRetBuscaFrete => pRetBuscaFrete,
                                                                                                          pTpVeiculo => :pTpVeiculo)));
                                                    
       End Loop;
   End Loop;
   End Loop;
end;
2
result
0
5
pTpVeiculo
0
5
3
ListaVerbas('CONTRATO').Value
ListaVerbas('NRCOLETA').Value
vObs
