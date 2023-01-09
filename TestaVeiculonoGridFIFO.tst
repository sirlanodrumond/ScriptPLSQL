PL/SQL Developer Test script 3.0
20
begin

 :pxmlin := '<Parametros>
               <Input> 
                 <Armazem>06</Armazem>
                 <Carregamento>1199951</Carregamento>
               </Input>   
             </Parametros>';



  -- Call the procedure
  tdvadm.pkg_fifo_carregamento.sp_getall_veiculosdisp(pxmlin => :pxmlin,
                                                      pxmlout => :pxmlout,
                                                      pstatus => :pstatus,
                                                      pmessage => :pmessage);



end;
4
pxmlin
6
<Parametros>
   <Input>
       <Armazem>06</Armazem>
       <Carregamento>1199951</Carregamento>
   </Input>   
</Parametros>
5
pxmlout
1
<CLOB>
112
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessage
1
Veiculos Retornados com sucesso!!!
5
2
vSql
vContrato
