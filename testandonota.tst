PL/SQL Developer Test script 3.0
77
Declare
  x varchar2(32000);
begin

  x := '<Parametros><Inputs><Input><usuario>bbernardo</usuario><aplicacao>carreg</aplicacao><rota>160</rota><acao>E</acao><finaliza_coleta>S</finaliza_coleta><criar_coleta>N</criar_coleta>
<Tables><Table name="dadosNota"><Rowset><Row num="1">
<notaStatus>S</notaStatus>
<coleta_Codigo>281698</coleta_Codigo>
<coleta_Tipo>E</coleta_Tipo>
<coleta_pedido></coleta_pedido>
<nota_Sequencia>2466528</nota_Sequencia>
<nota_numero>64673</nota_numero>
<nota_serie>001</nota_serie>
<nota_dtEmissao>01/03/2017</nota_dtEmissao>
<nota_dtSaida>01/03/2017</nota_dtSaida>
<nota_dtEntrada></nota_dtEntrada>
<nota_chaveNFE>35170361535381000106550010000646731111757842</nota_chaveNFE>
<nota_pesoNota>5</nota_pesoNota>
<nota_pesoBalanca>5</nota_pesoBalanca>
<nota_altura>0</nota_altura>
<nota_largura>0</nota_largura>
<nota_comprimento>0</nota_comprimento>
<nota_cubagem>0</nota_cubagem>
<nota_EmpilhamentoFlag>N</nota_EmpilhamentoFlag>
<nota_EmpilhamentoQtde>0</nota_EmpilhamentoQtde>
<nota_descricao>(0051) - Peca: 58623 - H757200MEI84223FTB23 - IT.1</nota_descricao>
<nota_qtdeVolume>1</nota_qtdeVolume>
<nota_ValorMerc>882.3</nota_ValorMerc>
<nota_RequisTp>S</nota_RequisTp>
<nota_RequisCodigo>00015111</nota_RequisCodigo>
<nota_RequisSaque>0006</nota_RequisSaque>
<nota_Contrato>S2016019999</nota_Contrato>
<nota_PO></nota_PO>
<nota_Di></nota_Di>
<nota_Vide>0</nota_Vide>
<nota_flagPgto>R</nota_flagPgto>
<carga_Codigo>2498744</carga_Codigo>
<carga_Tipo>CA</carga_Tipo>
<vide_Sequencia>0</vide_Sequencia>
<vide_Numero>0</vide_Numero>
<vide_Cnpj></vide_Cnpj>
<vide_Serie></vide_Serie>
<mercadoria_codigo>54</mercadoria_codigo>
<mercadoria_descricao>PECAS/FERRAMENTAS/ACESS</mercadoria_descricao>
<cfop_Codigo>5101</cfop_Codigo>
<cfop_Descricao>Venda de Producao do Estabelecimento</cfop_Descricao>
<embalagem_numero>1455838</embalagem_numero>
<embalagem_flag>A</embalagem_flag>
<embalagem_sequencia>2484888</embalagem_sequencia>
<rota_Codigo>160</rota_Codigo>
<rota_Descricao></rota_Descricao>
<armazem_Codigo>06</armazem_Codigo>
<armazem_Descricao></armazem_Descricao>
<Remetente_CNPJ>61535381000106</Remetente_CNPJ>
<Remetente_RSocial>ITALBRONZE LTDA.</Remetente_RSocial>
<Remetente_tpCliente>X</Remetente_tpCliente>
<Remetente_CodCliente></Remetente_CodCliente>
<Remetente_Endereco>X -  - RUA TAMOTSU IWASSE, 1415 ROD  PRES  DUTRA,</Remetente_Endereco>
<Remetente_LocalCodigo>05571</Remetente_LocalCodigo>
<Remetente_LocalDesc>SP - ARMAZEM SAO PAULO-SP</Remetente_LocalDesc>
<Destino_CNPJ>17692901000437</Destino_CNPJ>
<Destino_RSocial>ALSTOM ENERGIAS RENOVAVEIS LTDA.</Destino_RSocial>
<Destino_tpCliente>X</Destino_tpCliente>
<Destino_CodCliente></Destino_CodCliente>
<Destino_Endereco>X - ALSTOM - AV  CHARLES SCHNEIDER, SN</Destino_Endereco>
<Destino_LocalCodigo>12100</Destino_LocalCodigo>
<Destino_LocalDesc>SP - TAUBATE</Destino_LocalDesc>
<Sacado_CNPJ></Sacado_CNPJ>
<Sacado_RSocial></Sacado_RSocial>
<nota_tpDoc_codigo>55</nota_tpDoc_codigo>
</Row></Rowset></Table></Tables></Input></Inputs></Parametros>';

  tdvadm.pkg_fifo_recebimento.sp_insertnota(x,
                                                pstatus => :pstatus,
                                                pmessage => :pmessage,
                                                pparamssaida => :pparamssaida);
end;
4
pparamsentrada
1
<Parametros><Inputs><Input><usuario>bbernardo</usuario><aplicacao>carreg</aplicacao><rota>021</rota><acao>E</acao><finaliza_coleta>S</finaliza_coleta><criar_coleta>N</criar_coleta><Tables><Table name="dadosNota"><Rowset><Row num="1"><notaStatus>S</notaStatus><coleta_Codigo>299913</coleta_Codigo><coleta_Tipo>E</coleta_Tipo><coleta_pedido>4509875994</coleta_pedido><nota_Sequencia>2486015</nota_Sequencia><nota_numero>322332</nota_numero><nota_serie>012</nota_serie><nota_dtEmissao>14/03/2017</nota_dtEmissao><nota_dtSaida>14/03/2017</nota_dtSaida><nota_dtEntrada></nota_dtEntrada><nota_chaveNFE>43170354823455001450550120003223321002486000</nota_chaveNFE><nota_pesoNota>2</nota_pesoNota><nota_pesoBalanca>2</nota_pesoBalanca><nota_altura>0</nota_altura><nota_largura>0</nota_largura><nota_comprimento>0</nota_comprimento><nota_cubagem>0</nota_cubagem><nota_EmpilhamentoFlag>N</nota_EmpilhamentoFlag><nota_EmpilhamentoQtde>0</nota_EmpilhamentoQtde><nota_descricao>VALVULA HIDR DIR SOLENOIDE 91</nota_descricao><nota_qtdeVolume>1</nota_qtdeVolume><nota_ValorMerc>631.63</nota_ValorMerc><nota_RequisTp></nota_RequisTp><nota_RequisCodigo></nota_RequisCodigo><nota_RequisSaque></nota_RequisSaque><nota_Contrato>C2015120020</nota_Contrato><nota_PO>4509875994</nota_PO><nota_Di></nota_Di><nota_Vide>0</nota_Vide><nota_flagPgto>D</nota_flagPgto><carga_Codigo>2518229</carga_Codigo><carga_Tipo>CA</carga_Tipo><vide_Sequencia>0</vide_Sequencia><vide_Numero>0</vide_Numero><vide_Cnpj></vide_Cnpj><vide_Serie></vide_Serie><mercadoria_codigo>54</mercadoria_codigo><mercadoria_descricao>PECAS/FERRAMENTAS/ACESS</mercadoria_descricao><cfop_Codigo>6102</cfop_Codigo><cfop_Descricao>Venda de Mercadoria Adquirida ou Recebida de Terceiros</cfop_Descricao><embalagem_numero>1475323</embalagem_numero><embalagem_flag>A</embalagem_flag><embalagem_sequencia>2504374</embalagem_sequencia><rota_Codigo>021</rota_Codigo><rota_Descricao></rota_Descricao><armazem_Codigo>06</armazem_Codigo><armazem_Descricao></armazem_Descricao><Remetente_CNPJ>54823455001450</Remetente_CNPJ><Remetente_RSocial>PARKER HANNIFIN IND. E COM. LTDA.</Remetente_RSocial><Remetente_tpCliente>X</Remetente_tpCliente><Remetente_CodCliente></Remetente_CodCliente><Remetente_Endereco>X - PARKER-RS - AVENIDA FREDERICO RITTER 1100</Remetente_Endereco><Remetente_LocalCodigo>05571</Remetente_LocalCodigo><Remetente_LocalDesc>SP - ARMAZEM SAO PAULO-SP</Remetente_LocalDesc><Destino_CNPJ>61409892000335</Destino_CNPJ><Destino_RSocial>CIA. BRAS. DE ALUMINIO</Destino_RSocial><Destino_tpCliente>X</Destino_tpCliente><Destino_CodCliente></Destino_CodCliente><Destino_Endereco>X - ALUMINIO - R MORAES DO REGO 347 - CP  38</Destino_Endereco><Destino_LocalCodigo>18125</Destino_LocalCodigo><Destino_LocalDesc>SP - ALUMINIO</Destino_LocalDesc><Sacado_CNPJ></Sacado_CNPJ><Sacado_RSocial></Sacado_RSocial><nota_tpDoc_codigo>55</nota_tpDoc_codigo></Row></Rowset></Table></Tables></Input></Inputs></Parametros>
-5
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessage
5
CNPJ do Remetente difere do da Solicitação! [S]-[15141799000294      ] [N]-[61535381000106      ]
CNPJ do Destinatario difere do da Solicitação! [S]-[01603447000118      ] [N]-[17692901000437      ]
CNPJ do Sacado difere do da Solicitação! [S]-[01603447000118      ] [N]-[61535381000106      ]

Obrigatorio ter um CONTRATO VALIDO Solicitacao - 00645589-
5
pparamssaida
1
<CLOB>
112
3
vColetaNumero
x
vTabSolCod
