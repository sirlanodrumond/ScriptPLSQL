PL/SQL Developer Test script 3.0
77
-- Created on 12/01/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  tpCarregamentoCalc tdvadm.t_arm_carregamemcalc%rowtype;
begin
  -- Test statements here
  for c_msg in (select c.arm_carregamemcalc_codigo     ARM_CARREGAMEMCALC_MEMOCALC,
                       c.arm_armazem_codigo            ARM_ARMAZEM_CODIGO,
                       c.arm_carregamento_dtfechamento ARM_CARREGAMEMCALC_DATA,
                       '11'                            FCF_TPCARGA_CODIGO,
                       '61139432000172'                ARM_CARREGAMEMCALC_CLISAC,
                       '61139432000172'                ARM_CARREGAMEMCALC_CNPJREM,
                       null                            ARM_CARREGAMEMCALC_CLIENDREM,
                       '05571'                         ARM_CARREGAMEMCALC_ORIGEMNOTA,
                       '61139432000172'                ARM_CARREGAMEMCALC_CNPJDES,
                       null                            ARM_CARREGAMEMCALC_CLIENDDES,
                       '05571'                         ARM_CARREGAMEMCALC_DESTINONOTA,
                       'C'                             ARM_CARREGAMEMCALC_ENTCOL,
                       '111111'                        ARM_CARREGAMEMCALC_CONTRATO,
                       null                            ARM_CARREGAMEMCALC_FLAGPGTO,
                       '0020'                          ARM_CARREGAMEMCALC_GRUPOEC,
                       'T'                             ARM_CARREGAMEMCALC_TPTABSOL,
                       '99'                            ARM_CARREGAMEMCALC_TABSOLCOD,
                       '99'                            ARM_CARREGAMEMCALC_TABSOLSQ,
                       null                            ARM_CARREGAMEMCALC_CCTPRATEIO,
                       null                            ARM_CARREGAMEMCALC_CONTAADOR,
                       null                            ARM_CARREGAMEMCALC_DOCCLIENTE,
                       null                            ARM_CARREGAMEMCALC_CRIOUCARREG,
                       c.arm_carregamento_dtfechamento ARM_CARREGAMEMCALC_FINALIZOU,
                       null                            ARM_CARREGAMEMCALC_SEQAGRUP
                from tdvadm.t_arm_carregamento c
                where c.arm_carregamento_dtfechamento >= '08/11/2017'
                and c.arm_carregamemcalc_codigo is not null
                and 0 = (select count(*)
                         from tdvadm.t_arm_carregamemcalc ca
                         where ca.arm_carregamemcalc_memocalc = c.arm_carregamemcalc_codigo))

  loop
     
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_MEMOCALC    := c_msg.ARM_CARREGAMEMCALC_MEMOCALC;
     tpCarregamentoCalc.ARM_ARMAZEM_CODIGO             := c_msg.ARM_ARMAZEM_CODIGO;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_DATA        := c_msg.ARM_CARREGAMEMCALC_DATA;
     tpCarregamentoCalc.FCF_TPCARGA_CODIGO             := c_msg.FCF_TPCARGA_CODIGO;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CLISAC      := c_msg.ARM_CARREGAMEMCALC_CLISAC;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CNPJREM     := c_msg.ARM_CARREGAMEMCALC_CNPJREM;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CLIENDREM   := c_msg.ARM_CARREGAMEMCALC_CLIENDREM;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_ORIGEMNOTA  := c_msg.ARM_CARREGAMEMCALC_ORIGEMNOTA;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CNPJDES     := c_msg.ARM_CARREGAMEMCALC_CNPJDES;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CLIENDDES   := c_msg.ARM_CARREGAMEMCALC_CLIENDDES;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_DESTINONOTA := c_msg.ARM_CARREGAMEMCALC_DESTINONOTA;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_ENTCOL      := c_msg.ARM_CARREGAMEMCALC_ENTCOL;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CONTRATO    := c_msg.ARM_CARREGAMEMCALC_CONTRATO;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_FLAGPGTO    := c_msg.ARM_CARREGAMEMCALC_FLAGPGTO;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_GRUPOEC     := c_msg.ARM_CARREGAMEMCALC_GRUPOEC;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_TPTABSOL    := c_msg.ARM_CARREGAMEMCALC_TPTABSOL;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_TABSOLCOD   := c_msg.ARM_CARREGAMEMCALC_TABSOLCOD;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_TABSOLSQ    := c_msg.ARM_CARREGAMEMCALC_TABSOLSQ;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CCTPRATEIO  := c_msg.ARM_CARREGAMEMCALC_CCTPRATEIO;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CONTAADOR   := c_msg.ARM_CARREGAMEMCALC_CONTAADOR;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_DOCCLIENTE  := c_msg.ARM_CARREGAMEMCALC_DOCCLIENTE;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_CRIOUCARREG := c_msg.ARM_CARREGAMEMCALC_CRIOUCARREG;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_FINALIZOU   := c_msg.ARM_CARREGAMEMCALC_FINALIZOU;
     tpCarregamentoCalc.ARM_CARREGAMEMCALC_SEQAGRUP    := c_msg.ARM_CARREGAMEMCALC_SEQAGRUP;

     Begin
        insert into tdvadm.t_arm_carregamemcalc
        values tpCarregamentoCalc;
     exception
       When OTHERS Then
         i := i + 1;
       End;
        
  End Loop;                         

  
end;
0
1
i
