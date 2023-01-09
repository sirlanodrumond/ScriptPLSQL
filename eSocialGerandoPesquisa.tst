PL/SQL Developer Test script 3.0
77
-- Created on 22/06/2018 by DESENV 
declare 
  -- Local variables here
  vQryStrConst varchar2(2000):= 'Proprietario=nome=Proprietario|tipo=String|valor=@*IntegraTdv_Cod=nome=IntegraTdv_Cod|tipo=String|valor=92*Usuario=nome=Usuario|tipo=String|valor=jsantos*Maquina=nome=Maquina|tipo=String|valor=VBox_TIKlayton*CodGerenciadora=nome=CodGerenciadora|tipo=String|valor=1*'; 
  vQryStr  varchar2(2000);
  vId      tdvadm.t_con_freteoper.con_freteoper_id%type;
  vAuxiliar integer;
  vStatus  char(1);
  vMessage varchar2(2000);
  
begin
  -- Test statements here
  
  for p_cursor in (select distinct e.cpf
                    from tdvadm.v_ctb_impostos_esocial e
                   where e.REF1 >= '201805'
                     and e.cpf in  ('02850430641',
                                    '05470894657',
                                    '07913063998',
                                    '12115629647',
                                    '57888477704',
                                    '62728350868',
                                    '72760524949',
                                    '01565814851',
                                    '01630751901',
                                    '02623613613',
                                    '03709526850',
                                    '04555407644',
                                    '04558140665',
                                    '07842172706',
                                    '07913063998',
                                    '10994279833',
                                    '14637093821',
                                    '32537018915',
                                    '35294183668',
                                    '37711466153',
                                    '40294749268',
                                    '47584076653',
                                    '52231461234',
                                    '56665830691',
                                    '57888477704',
                                    '67860800900',
                                    '75000474520',
                                    '88836606920',
                                    '94095469668',
                                    '23737328404',
                                    '37897049892') 
                  )
  loop
    
     
     select count(*)
       into vAuxiliar
     from tdvadm.t_car_esocial es
     where es.car_proprietario_cgccpfcodigo = trim(p_cursor.cpf)
       and es.car_esocial_status = '200';
       

    If vAuxiliar = 0 Then
       vQryStr := replace(vQryStrConst,'@',trim(p_cursor.cpf));
  
       tdvadm.pkg_cfe_frete.SP_GET_IDINTEGRACAO(vQryStr,
                                                '010',
                                                vId,
                                                vStatus,
                                                vMessage);
           

       If vStatus <> 'N' Then
          dbms_output.put_line(p_cursor.cpf||' - '||vId||'-'||vStatus||' = '||vMessage);
       End IF;   
    End If;                                          
  end loop;    

  
  
end;
0
0
