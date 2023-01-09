PL/SQL Developer Test script 3.0
12
declare
  -- Non-scalar parameters require additional processing 
  tprecebido rmadm.t_glb_benasseREC%Rowtype;
begin
  
  tprecebido.glb_benasserec_assunto := 'MSG=TICKET;EMISSAO=16/05/2018;PESO=30880;VALOR=7233,48;TPEND=X;CODIGOBARRA=15180533592510007590550030000186091356353371;REMETENTE=99999948006801;NMAE=17814;EMITENTE=33592510007590;SERIEMAE=3;RETVZ=S';
  tprecebido.glb_benasserec_origem := 'sdrumond@dellavolpe.com.br';
  -- Call the procedure
  tdvadm.pkg_edi_controle.spi_processa_notatcn(tprecebido => tprecebido,
                                               vstatus => :vstatus,
                                               vmessage => :vmessage);
end;
2
vstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
vmessage
1
<CLOB>
112
0
