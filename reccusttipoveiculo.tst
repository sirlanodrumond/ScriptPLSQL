PL/SQL Developer Test script 3.0
57
-- Created on 03/09/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  tpVeiculo tdvadm.t_fcf_tpveiculo%rowtype;
begin
/*  -- Test statements here
  for c_msg in (select d.rowid,tv.fcf_tpveiculo_codigo,tv.fcf_tpveiculo_descricao,tv.fcf_tpveiculo_nreixos,d.con_valefrete_motorista_tipo,d.glb_localidade_codigo_vlfori,d.glb_localidade_codigo_vlfdes 
                from tdvadm.t_car_veiculo v,
                     tdvadm.t_car_tpveiculo tp,
                     tdvipf.t_ipf_reccust_diretos d,
                     tdvadm.t_fcf_tpveiculo tv
                where v.car_tpveiculo_codigo = tp.car_tpveiculo_codigo
                  and v.car_veiculo_placa = d.con_valefrete_placa
                  and v.car_veiculo_saque = d.con_valefrete_placa_saque
                  and tp.fcf_tpveiculo_codigo = tv.fcf_tpveiculo_codigo (+)
                  and d.con_valefrete_motorista_tipo <> 'F')
  loop
     update tdvipf.t_ipf_reccust_diretos d
       set d.fcf_tpveiculo_codigo = c_msg.fcf_tpveiculo_codigo,
           d.fcf_tpveiculo_descricao = c_msg.fcf_tpveiculo_descricao,
           d.fcf_tpveiculo_eixos = c_msg.fcf_tpveiculo_nreixos,
           d.glb_localidade_codigo_vlforin = to_number(d.glb_localidade_codigo_vlfori),
           d.glb_localidade_codigo_vlfdesin = to_number(d.glb_localidade_codigo_vlfdes)
     where d.rowid = c_msg.rowid;
     commit;
  end loop;
*/

  for c_msg in (select c.rowid,
                       c.con_valefrete_placa,
                       rpad(tdvadm.pkg_frtcar_veiculo.FN_RETFCFTPVEICULO(c.con_valefrete_placa,c.con_valefrete_dataemissao),3) codveic
                from tdvipf.t_ipf_reccust_diretos c 
                where c.con_valefrete_motorista_tipo = 'F')
  loop
      Begin
        select *
          into tpVeiculo
        from tdvadm.t_frt_tpveiculo tv
        where tv.frt_tpveiculo_codigo = c_msg.codveic;
      exception
        When NO_DATA_FOUND Then
           tpVeiculo.Fcf_Tpveiculo_Codigo := null;
           tpVeiculo.Fcf_Tpveiculo_Descricao := null;
           tpVeiculo.Fcf_Tpveiculo_Nreixos := 0;
        End;
        
        update tdvipf.t_ipf_reccust_diretos c
          set c.fcf_tpveiculo_codigo = tpVeiculo.Fcf_Tpveiculo_Codigo,
              c.fcf_tpveiculo_descricao = tpVeiculo.Fcf_Tpveiculo_Descricao,
              c.fcf_tpveiculo_eixos = tpVeiculo.Fcf_Tpveiculo_Nreixos
        where c.rowid = c_msg.rowid;
        commit;
  End Loop;
  
  
end;
0
1
c_msg.codveic
