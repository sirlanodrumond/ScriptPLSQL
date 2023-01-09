PL/SQL Developer Test script 3.0
50
Declare 
  vRetorno varchar2(20);
  vclassantt tdvadm.t_car_proprietario.car_proprietario_classantt%type;
  vclasseqp  tdvadm.t_car_proprietario.car_proprietario_classeqp%type;
begin
  -- Call the function
  vRetorno := FN_RETTP_MOTORISTA(P_PLACA => :P_PLACA,
                                 P_SAQUE => :P_SAQUE,
                                 P_DATA => :P_DATA);
  If vRetorno not in ('NI') Then
     vclassantt := '';
     vclasseqp  := '';
     Begin
        select p.car_proprietario_classantt,
               p.car_proprietario_classeqp
          into vclassantt,
               vclasseqp
        from tdvadm.t_car_proprietario p,
             tdvadm.t_car_veiculo v
        where p.car_proprietario_cgccpfcodigo = v.car_proprietario_cgccpfcodigo
          and v.car_veiculo_placa = :P_PLACA
          and v.car_veiculo_saque = (select max(v1.car_veiculo_saque)
                                     from tdvadm.t_car_veiculo v1
                                     where v1.car_veiculo_placa = v.car_veiculo_placa);
     exception
       When NO_DATA_FOUND Then
          vclassantt := '';
          vclasseqp  := '';
       End;
  End If;                                  
    
  :result := vRetorno || '-' || vclassantt || '-' || vclasseqp;
  
end;

/*
BWZ5845;C
JLO9611;NI
BTS7413;A
IFG3475;A
GPN4357;NI
JML0056;NI
OCW6353;NI
HMV3951;C
HMV3952;NI
NRZ2600;C
NRZ2412;NI
NRZ0502;NI
*/
  
4
result
1
CARRETEIRO-TAC-S
5
P_PLACA
1
BWZ5845
5
P_SAQUE
0
5
P_DATA
1
20/03/2020
12
3
V_FROTA
V_CARR
