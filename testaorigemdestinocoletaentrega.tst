PL/SQL Developer Test script 3.0
36
begin
  -- Call the function
  -- colocar o conceito se cobra coleta ou nao
  select 'C',
         an.arm_nota_numero,
         an.glb_cliente_cgccpfremetente,
         an.arm_nota_serie,
         an.arm_coleta_ncompra,
         an.arm_coleta_ciclo,
         an.arm_nota_chavenfe,
         90
    into :ptipo,
         :pnota,
         :pcnpj,
         :pserie,
         :pcoleta,
         :pcoletaciclo,
         :pchave,
         :pdiasdigitada
  from tdvadm.t_arm_nota an
  where an.arm_nota_numero = 3896422
    and an.glb_cliente_cgccpfremetente = '60894730002582';
    
    
  :result := tdvadm.pkg_fifo_carregctrc.fn_retorigdestnota(ptipo => :ptipo,
                                                           pnota => :pnota,
                                                           pcnpj => :pcnpj,
                                                           pserie => :pserie,
                                                           pcoleta => :pcoleta,
                                                           pcoletaciclo => :pcoletaciclo,
                                                           pchave => :pchave,
                                                           pdiasdigitada => :pdiasdigitada);
                                                           
  :pIBGE := tdvadm.fn_busca_codigoibge(:result,'IBC') ||'-'|| tdvadm.fn_busca_codigoibge(:result,'IBD');
                                                           
end;
10
result
1
35160   
5
ptipo
1
C
5
pnota
1
3896422
4
pcnpj
1
60894730002582
5
pserie
1
1  
5
pcoleta
1
698047
5
pcoletaciclo
1
002
5
pchave
1
31180360894730002582550010038964221261216811
5
pdiasdigitada
1
90
4
pIBGE
1
3131307-MG-IPATINGA
5
0
