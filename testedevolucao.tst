PL/SQL Developer Test script 3.0
28
begin
  -- Call the procedure
  :pXmlIn := '<Parametros>
                 <Input>
                    <Nota>9093</Nota>
                    <CNPJ>19291268000158</CNPJ>
                    <Sequencia>4918102</Sequencia>
                    <Chave>31200719291268000158550010000090931068947417</Chave>
                    <TipoDevolucao>D</TipoDevolucao>
                    <Coleta_Original>491810</Coleta_Original>
                    <Usuario>jsantos</Usuario>
                    <Rota>160</Rota>
                    <Aplicacao>carreg</Aplicacao>
                    <Versao>20.3.2.0</Versao>
                    <ConheciementoCodigo>236634</ConheciementoCodigo>
                    <ConheciementoSerie>A1</ConheciementoSerie>
                    <ConheciementoRota>187</ConheciementoRota>
                    <PagtoFrete>S</PagtoFrete>
                    <IDOcorrencia>8</IDOcorrencia>
                    <Coleta>491367</Coleta>
                    <Acao>D</Acao>
                 </Input>
              </Parametros>';

  PKG_ARM_EMBALAGEM.Sp_Devolver_EmbalagemNF(pXmlIn => :pXmlIn,
                                            pStatus => :pStatus,
                                            pMessage => :pMessage);
end;
3
pXmlIn
21
<Parametros>
                 <Input>
                    <Nota>9093</Nota>
                    <CNPJ>19291268000158</CNPJ>
                    <Sequencia>4918102</Sequencia>
                    <Chave>31200719291268000158550010000090931068947417</Chave>
                    <TipoDevolucao>D</TipoDevolucao>
                    <Coleta_Original>491810</Coleta_Original>
                    <Usuario>jsantos</Usuario>
                    <Rota>160</Rota>
                    <Aplicacao>carreg</Aplicacao>
                    <Versao>20.3.2.0</Versao>
                    <ConheciementoCodigo>236634</ConheciementoCodigo>
                    <ConheciementoSerie>A1</ConheciementoSerie>
                    <ConheciementoRota>187</ConheciementoRota>
                    <PagtoFrete>S</PagtoFrete>
                    <IDOcorrencia>8</IDOcorrencia>
                    <Coleta>491367</Coleta>
                    <Acao>D</Acao>
                 </Input>
              </Parametros>
5
pStatus
0
5
pMessage
0
5
1
tpRegNotaCte.Arm_Nota_Chavenfe
