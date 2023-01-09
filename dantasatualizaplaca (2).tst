PL/SQL Developer Test script 3.0
267
-- Created on 14/09/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  tpReccust tdvipf.v_ipf_reccust%rowtype;
  
begin

dbms_output.put_line('INICIO DELETANDO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));
DELETE TDVIPF.V_IPF_RECCUST t WHERE T.IPF_RECCUST_REFERENCIA >= trim(to_char(add_months(sysdate,-3),'YYYYMM'));
dbms_output.put_line('FIM DELETANDO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI') || ' - ' || sql%rowcount || ' Registros');

dbms_output.put_line('INICIO INSERINDO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));
INSERT INTO TDVIPF.V_IPF_RECCUST 
SELECT NM.*,
       NULL ANOVEIC,
       NULL chassisveic,
       NULL ANOVEICCAR1,
       NULL chassisveicCAR1  ,
       NULL ANOVEICCAR2,
       NULL chassisveicCAR2
FROM TDVIPF.V_IPF_RECCUSTNMAT NM
WHERE NM.ipf_reccust_referencia >= trim(to_char(add_months(sysdate,-3),'YYYYMM'))
  AND 0 = (SELECT COUNT(*)
           FROM TDVIPF.V_IPF_RECCUST T
           WHERE T.IPF_RECCUST_REFERENCIA = NM.ipf_reccust_referencia
             AND T.IPF_VALEFRETE_CHAVE = NM.ipf_valefrete_chave
             AND T.IPF_CONHEC_CHAVE = NM.ipf_conhec_chave);
dbms_output.put_line('FIM INSERINDO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI') || ' - ' || sql%rowcount || ' Registros');
COMMIT;
   
   -- Atualizando Placas

dbms_output.put_line('INICIO ATUALIZANDO PLACA CAVALO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));
   
   UPDATE TDVIPF.V_IPF_RECCUST R
     SET (R.ANOVEIC,
          R.CHASSISVEIC) = (SELECT max(R1.ANOVEIC),
                                   max(R1.CHASSISVEIC)
                             FROM TDVIPF.V_IPF_RECCUST R1
                             WHERE R1.IPF_VALEFRETE_PLACA = R.IPF_VALEFRETE_PLACA
                               AND R1.ANOVEIC IS NOT NULL)
   WHERE R.ANOVEIC IS NULL;                             
   commit;
dbms_output.put_line('FIM ATUALIZANDO PLACA CAVALO - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI') || ' - ' || sql%rowcount || ' Registros');


dbms_output.put_line('INICIO ATUALIZANDO PLACA CARRETA - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));
   UPDATE TDVIPF.V_IPF_RECCUST R
     SET (R.ANOVEICCAR1,
          R.CHASSISVEICCAR1) = (SELECT max(R1.ANOVEICCAR1),
                                       max(R1.CHASSISVEICCAR1)
                                FROM TDVIPF.V_IPF_RECCUST R1
                                WHERE R1.PLACACAR1 = R.PLACACAR1
                                  AND R1.ANOVEICCAR1 IS NOT NULL)
   WHERE R.ANOVEICCAR1 IS NULL;                             
   commit;
dbms_output.put_line('FIM ATUALIZANDO PLACA CARRETA - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI') || ' - ' || sql%rowcount || ' Registros');



dbms_output.put_line('INICIO OUTRAS ATUALIZACOES - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));
   for c_msg in (select distinct x.ipf_valefrete_placa,
                        x.ipf_valefrete_placasaque,
                        x.ipf_valefrete_placaunificada,
                        x.fcf_tpveiculo_descricao
                 from tdvipf.v_ipf_reccust x
                 where x.anoveic is null
                   and x.glb_tpmotorista_codigo Not in ('F')
                 )
   loop
      Begin
         select v.car_veiculo_anofabric,
                v.car_veiculo_chassis
            into tpReccust.Anoveic,
                 tpReccust.Chassisveic
         from tdvadm.t_car_veiculo v
         where v.car_veiculo_placa = c_msg.ipf_valefrete_placa
           and v.car_veiculo_saque = c_msg.ipf_valefrete_placasaque;
      exception
         When OTHERS Then
            tpReccust.Anoveic := null;
            tpReccust.Chassisveic := null;
      End;
        
      If tpReccust.Anoveic is null Then
          Begin
         select max(v.car_veiculo_anofabric),
                max(v.car_veiculo_chassis)
            into tpReccust.Anoveic,
                 tpReccust.Chassisveic
         from tdvadm.t_car_veiculo v
         where v.car_veiculo_placaunificada = c_msg.ipf_valefrete_placaunificada;
          Exception
            When NO_DATA_FOUND Then
               dbms_output.put_line('PLACA ' || c_msg.ipf_valefrete_placa || '/' || c_msg.ipf_valefrete_placasaque || ' - ' || c_msg.fcf_tpveiculo_descricao);
               tpReccust.Anoveic := null;
               tpReccust.Chassisveic := null;
         End ;
         Update tdvipf.v_ipf_reccust x
           set x.anoveic = tpReccust.Anoveic,
               x.chassisveic = tpReccust.Chassisveic
         where x.ipf_valefrete_placaunificada = c_msg.ipf_valefrete_placaunificada
           and x.anoveic is null;       
     Else
         Update tdvipf.v_ipf_reccust x
           set x.anoveic = tpReccust.Anoveic,
               x.chassisveic = tpReccust.Chassisveic
        where x.ipf_valefrete_placa = c_msg.ipf_valefrete_placa
          and x.ipf_valefrete_placasaque = c_msg.ipf_valefrete_placasaque;       
     End If;  


        
        commit;     
     
   End Loop;

   for c_msg in (select distinct x.ipf_valefrete_placa,
                        x.ipf_valefrete_placasaque,
                        x.ipf_valefrete_placaunificada,
                        x.fcf_tpveiculo_descricao
                 from tdvipf.v_ipf_reccust x
                 where x.placacar1 is null
                   and x.glb_tpmotorista_codigo Not in ('F')
                   --and x.ipf_valefrete_placa = 'LPY9F04'
                   and x.fcf_tpveiculo_codigo not in ('3','4','5','7','8','10','16','18','19','22','29','NE')
                 )
   loop
      Begin
         select v.car_veiculo_carreta_placa,
                v.car_veiculo_carreta_anofabric,
                v.car_veiculo_carreta_chassis
            into tpReccust.Placacar1,
                 tpReccust.Anoveiccar1,
                 tpReccust.Chassisveiccar1
         from tdvadm.t_car_veiculo v
         where v.car_veiculo_placa = c_msg.ipf_valefrete_placa
           and v.car_veiculo_saque = c_msg.ipf_valefrete_placasaque;
      exception
         When OTHERS Then
            tpReccust.Placacar1 := null;
            tpReccust.Anoveiccar1 := null;
            tpReccust.Chassisveiccar1 := null;
      End;
        
      If tpReccust.Placacar1 is null Then
          Begin
         select max(v.car_veiculo_carreta_placa),
                max(v.car_veiculo_carreta_anofabric),
                max(v.car_veiculo_carreta_chassis)
            into tpReccust.Placacar1,
                 tpReccust.Anoveiccar1,
                 tpReccust.Chassisveiccar1
         from tdvadm.t_car_veiculo v
         where v.car_veiculo_placaunificada = c_msg.ipf_valefrete_placaunificada
           and v.car_veiculo_carreta_placa is not null;
          Exception
            When NO_DATA_FOUND Then
               dbms_output.put_line('PLACA ' || c_msg.ipf_valefrete_placa || '/' || c_msg.ipf_valefrete_placasaque || ' - ' || c_msg.fcf_tpveiculo_descricao);
               tpReccust.Placacar1 := null;
               tpReccust.Anoveiccar1 := null;
               tpReccust.Chassisveiccar1 := null;
         End ;
         Update tdvipf.v_ipf_reccust x
           set x.placacar1 = tpReccust.Placacar1,
               x.anoveiccar1 = tpReccust.Anoveiccar1,
               x.chassisveiccar1 = tpReccust.Chassisveiccar1
         where x.ipf_valefrete_placaunificada = c_msg.ipf_valefrete_placaunificada
           and x.placacar1 is null;       
     Else
        Update tdvipf.v_ipf_reccust x
          set x.placacar1 = tpReccust.Placacar1,
              x.anoveiccar1 = tpReccust.Anoveiccar1,
              x.chassisveiccar1 = tpReccust.Chassisveiccar1
        where x.ipf_valefrete_placa = c_msg.ipf_valefrete_placa
          and x.ipf_valefrete_placasaque = c_msg.ipf_valefrete_placasaque;       
     End If;  


        
        commit;     
     
   End Loop;

   i := 0;
   for c_msg in (select distinct x.ipf_valefrete_placaunificada
                 from tdvipf.v_ipf_reccust x
                 where ( x.anoveic is null or x.chassisveic is null )
                   and x.glb_tpmotorista_codigo in ('F')
                 )
   loop
     
      tpReccust.Anoveic     := rpad(trim(tdvadm.fn_get_anoveiculo(c_msg.ipf_valefrete_placaUNIFICADA)),4);
      tpReccust.Chassisveic := rpad(tdvadm.fn_get_chassisveiculo(c_msg.ipf_valefrete_placaUNIFICADA),25);
      update tdvipf.v_ipf_reccust x
        set x.anoveic = nvl(x.anoveic,tpReccust.Anoveic),
            x.Chassisveic = nvl(x.Chassisveic,tpReccust.Chassisveic)
      where x.ipf_valefrete_placaunificada = c_msg.ipf_valefrete_placaunificada;
      i:= i + 1;
      commit;      
        
   End Loop;
   

   i := 0;
   for c_msg in (select distinct x.ipf_valefrete_placaunificada
                 from tdvipf.v_ipf_reccust x
                 where ( x.anoveic is null or x.chassisveic is null )
                   and x.glb_tpmotorista_codigo in ('F')
                 )
   loop
     
      tpReccust.Anoveic     := rpad(trim(tdvadm.fn_get_anoveiculo(c_msg.ipf_valefrete_placaUNIFICADA)),4);
      tpReccust.Chassisveic := rpad(tdvadm.fn_get_chassisveiculo(c_msg.ipf_valefrete_placaUNIFICADA),25);
      update tdvipf.v_ipf_reccust x
        set x.anoveic = nvl(x.anoveic,tpReccust.Anoveic),
            x.Chassisveic = nvl(x.Chassisveic,tpReccust.Chassisveic)
      where x.ipf_valefrete_placaunificada = c_msg.ipf_valefrete_placaunificada;
      i:= i + 1;
      commit;      
        
   End Loop;

   


   
   for c_msg in (select distinct x.placacar1
                 from tdvipf.v_ipf_reccust x
                 where ( x.anoveiccar1 is null or x.chassisveiccar1 is null )
                   and x.glb_tpmotorista_codigo Not in ('F')
                   and x.fcf_tpveiculo_codigo not in ('3','4','5','7','8','10','16','18','19','22','29','NE')
                 )
   loop
     
      Begin
        Select max(v.car_veiculo_carreta_anofabric)
          into tpReccust.anoveiccar1     
        From tdvadm.t_car_veiculo v
        where v.car_veiculo_carreta_placa = c_msg.placacar1;
      Exception
        When NO_DATA_FOUND Then
          tpReccust.anoveiccar1 := null;
        End;
          
      Begin
        Select max(v.car_veiculo_carreta_chassis)
          into tpReccust.chassisveiccar1     
        From tdvadm.t_car_veiculo v
        where v.car_veiculo_carreta_placa = c_msg.placacar1;
      Exception
        When NO_DATA_FOUND Then
          tpReccust.chassisveiccar1 := null;
        End;
        
      update tdvipf.v_ipf_reccust x
        set x.anoveiccar1     = nvl(x.anoveiccar1,tpReccust.Anoveiccar1),
            x.Chassisveiccar1 = nvl(x.Chassisveiccar1,tpReccust.Chassisveiccar1)
      where x.placacar1 = c_msg.placacar1;
      commit;      
        
   End Loop;

dbms_output.put_line('FIM OUTRAS ATUALIZACOES - ' || TO_CHAR(SYSDATE,'DD/MM/YYYY HH24:MI'));

end;
0
3
tpReccust.Placacar1
c_msg.fcf_tpveiculo_descricao
c_msg.ipf_valefrete_placa
