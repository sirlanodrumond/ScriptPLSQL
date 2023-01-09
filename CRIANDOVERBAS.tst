PL/SQL Developer Test script 3.0
97
-- Created on 27/09/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  tpReccust tdvadm.t_slf_reccust%rowtype;
  tpCalculo tdvadm.t_slf_calculo%rowtype;
  
begin

  -- Test statements here
/*  tpReccust.Slf_Reccust_Codigo := 'S_ALINTUFF';
  tpReccust.Slf_Reccust_Descricao := 'Aliquota interna do estado de Destino';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := '%';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_BSPAICMS';
  tpReccust.Slf_Reccust_Descricao := 'Base do Icms para a Partilha';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := 'VL';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PERUFINI';
  tpReccust.Slf_Reccust_Descricao := '20% Aliquota da Partilha UF Origem';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := '%';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PARUFINI';
  tpReccust.Slf_Reccust_Descricao := 'Valor da Partilha UF Origem';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := 'VL';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PERUFFIM';
  tpReccust.Slf_Reccust_Descricao := '80% Aliquota da Partilha UF Destino';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := '%';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PARUFFIM';
  tpReccust.Slf_Reccust_Descricao := 'Valor da Partilha UF Fim';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := 'VL';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PERPROB';
  tpReccust.Slf_Reccust_Descricao := 'Percentual da Pobreza por estado';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := '%';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  

  tpReccust.Slf_Reccust_Codigo := 'S_PARPROB';
  tpReccust.Slf_Reccust_Descricao := 'Valor da Partilha da Pobreza';
  tpReccust.Slf_Reccust_Aliquota := 'N';
  tpReccust.Slf_Reccust_Desinecia := 'VL';  
  Insert into tdvadm.t_slf_reccust values tpReccust;  
*/
--'312'
--'314'
--'130'
--'315'
--'317'
--'319'
  select * 
    into tpCalculo
  from tdvadm.t_slf_calculo c 
  where c.slf_tpcalculo_codigo = '041' 
    and c.slf_reccust_codigo = 'S_ALICMS';
  
  tpCalculo.Slf_Reccust_Codigo := 'S_ALINTUFF';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_BSPAICMS';
  insert into tdvadm.t_slf_calculo values tpCalculo;

  tpCalculo.Slf_Reccust_Codigo := 'S_PERUFINI';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_PARUFINI';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_PERUFFIM';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_PARUFFIM';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_PERPROB';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  tpCalculo.Slf_Reccust_Codigo := 'S_PARPROB';
  insert into tdvadm.t_slf_calculo values tpCalculo;
  
  commit;
    
end;
0
0
