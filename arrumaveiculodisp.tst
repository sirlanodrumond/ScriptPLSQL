PL/SQL Developer Test script 3.0
109
-- Created on 21/09/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i            integer;
  vVeicDisp    tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_codigo%type;
  vVeicDispSeq tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_sequencia%type;
  vSolveic     tdvadm.t_fcf_solveic.fcf_solveic_cod%type;
  vFreteRowid  tdvadm.t_fcf_fretecar.fcf_fretecar_rowid%type;
begin
  
  -- Test statements here
  
  for c_msg in (select distinct ipvf.ipf_valefrete_codigo,
                                ipvf.ipf_valefrete_serie,
                                ipvf.ipf_valefrete_rota,
                                ipvf.ipf_valefrete_saque,
                                ipvf.ipf_valefrete_cadastro,
                                ipvf.ipf_valefrete_placa,
                                ipvf.frt_conjveiculo_codigo,
                                ipvf.rowid
                from tdvipf.t_ipf_valefrete ipvf
                where ipvf.ipf_valefrete_referencia >= '201901'
                  and ipvf.fcf_veiculodisp_codigo is not null
                  and 0 = ( select count(*)
                            from tdvadm.t_fcf_veiculodisp vd
                            where vd.fcf_veiculodisp_codigo = ipvf.fcf_veiculodisp_codigo
                              and vd.fcf_veiculodisp_sequencia = ipvf.fcf_veiculodisp_sequencia 
                              and ( vd.car_veiculo_placa = ipvf.ipf_valefrete_placa or vd.frt_conjveiculo_codigo = ipvf.frt_conjveiculo_codigo) )
               )
   Loop
     i := i +1;
     Begin
        select min(vh.fcf_veiculodisp_codigo),
               0
          into vVeicDisp,
               vVeicDispSeq
        from tdvadm.t_con_valefretehist vh
        where vh.con_conhecimento_codigo = c_msg.ipf_valefrete_codigo
          and vh.con_conhecimento_serie  = c_msg.ipf_valefrete_serie
          and vh.glb_rota_codigo         = c_msg.ipf_valefrete_rota
          and vh.con_valefrete_saque     = c_msg.ipf_valefrete_saque
          and ( vh.con_valefrete_placa     = c_msg.ipf_valefrete_placa or vh.con_valefrete_placa = c_msg.frt_conjveiculo_codigo )
          and vh.con_valefrete_datacadastro <= c_msg.ipf_valefrete_cadastro;
     exception
       When NO_DATA_FOUND Then
           vVeicDisp   := null;
           vVeicDispSeq := null;
       End;  
     
     If vVeicDisp is not null Then
        Begin
           select max(sv.fcf_solveic_cod)
              into vSolveic
           from tdvadm.t_fcf_solveic sv 
           where sv.fcf_veiculodisp_codigo = vVeicDisp
             and sv.fcf_veiculodisp_sequencia = vVeicDispSeq
             and sv.fcf_solveic_dtcontr <= nvl(c_msg.ipf_valefrete_cadastro,sv.fcf_solveic_dtcontr);
        Exception
          When NO_DATA_FOUND Then
             vSolveic := null;    
          End;
     End If;
     
     If vVeicDisp is not null Then
        i := i + 1;
        
        update tdvadm.t_con_valefrete vf
          set vf.fcf_veiculodisp_codigo = vVeicDisp,
              vf.fcf_veiculodisp_sequencia = vVeicDispSeq
        where vf.con_conhecimento_codigo = c_msg.ipf_valefrete_codigo
          and vf.con_conhecimento_serie  = c_msg.ipf_valefrete_serie
          and vf.glb_rota_codigo         = c_msg.ipf_valefrete_rota
          and vf.con_valefrete_saque     = c_msg.ipf_valefrete_saque;

        update tdvipf.t_ipf_valefrete vf
          set vf.fcf_veiculodisp_codigo = vVeicDisp,
              vf.fcf_veiculodisp_sequencia = vVeicDispSeq,
              vf.fcf_solveic_cod = vSolveic
        where vf.ipf_valefrete_codigo = c_msg.ipf_valefrete_codigo
          and vf.ipf_valefrete_serie  = c_msg.ipf_valefrete_serie
          and vf.ipf_valefrete_rota   = c_msg.ipf_valefrete_rota
          and vf.ipf_valefrete_saque  = c_msg.ipf_valefrete_saque;

        update tdvipf.t_ipf_valefrete vf
          set vf.fcf_veiculodisp_codigo = vVeicDisp,
              vf.fcf_veiculodisp_sequencia = vVeicDispSeq,
              vf.fcf_solveic_cod = vSolveic
        where vf.ipf_valefrete_codigo = c_msg.ipf_valefrete_codigo
          and vf.ipf_valefrete_serie  = c_msg.ipf_valefrete_serie
          and vf.ipf_valefrete_rota   = c_msg.ipf_valefrete_rota
          and vf.con_catvalefrete_codigo = '14'
          and vf.ipf_valefrete_placa = c_msg.ipf_valefrete_placa
          and vf.frt_conjveiculo_codigo = c_msg.frt_conjveiculo_codigo;
          commit;
     End IF;
       
     
     If i = 1000 Then
        return;
     End If;
     
     
   End Loop; 

  
  
  
  
end;
0
4
c_msg.ipf_valefrete_placa
c_msg.frt_conjveiculo_codigo
vVeicDisp
vSolveic
