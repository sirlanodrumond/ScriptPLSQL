PL/SQL Developer Test script 3.0
6
begin
  -- Call the function
  :result := tdvipf.PKG_RECCUST_DIRETOS2019.fn_retornavaloresFrota(pQual => :pQual,
                                                                   pReferencia => :pReferencia,
                                                                   pPlaca => :pPlaca);
end;
4
result
1
38983,679279943
4
pQual
1
C
5
pReferencia
1
202011
5
pPlaca
1
FXT3213
5
0
