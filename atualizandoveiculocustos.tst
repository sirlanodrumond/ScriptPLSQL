PL/SQL Developer Test script 3.0
94
-- Created on 13/08/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vDescricao tdvadm.t_fcf_tpveiculo.fcf_tpveiculo_descricao%type;
  vEixo      tdvadm.t_fcf_tpveiculo.fcf_tpveiculo_nreixos%type;
begin
  -- Test statements here
  for c_msg in (select distinct r.ipf_reccust_referencia,
                       r.ipf_valefrete_chave,
                       vf.con_valefrete_datacadastro,
                       vf.con_valefrete_placa,
                       vf.glb_tpmotorista_codigo,
                       r.fcf_tpveiculo_codigocol,
                       r.fcf_tpveiculo_codigo,
                       r.fcf_tpveiculo_descricao,
                       r.ipf_valefrete_eixos,
                       (select v.car_tpveiculo_codigo
                        from tdvadm.t_car_veiculo v
                        where v.car_veiculo_placa = r.ipf_valefrete_placa
                          and v.car_veiculo_saque = (select max(v1.car_veiculo_saque)
                                                     from tdvadm.t_car_veiculo v1
                                                     where v1.car_veiculo_placa = v.car_veiculo_placa)) tpveicarveic,
                       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CAV'),'C') cavalo,
                       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CAR'),'C') carreta1,
                       pkg_frtcar_veiculo.FN_RETAPELIDOVEIC(pkg_frtcar_veiculo.fn_get_placa(vf.con_valefrete_placa,vf.con_valefrete_datacadastro,'CA2'),'C') carreta2,
                       tdvadm.pkg_frtcar_veiculo.FN_RETFCFTPVEICULO(vf.con_valefrete_placa,vf.con_valefrete_datacadastro) funcao
                from tdvipf.v_ipf_reccust r,
                     tdvadm.t_con_valefrete vf
                where 0 = 0
--                  and r.ipf_valefrete_chave = '626049A10112'
--                  and vf.con_valefrete_placa = '0002210'
                /*  
                  and SUBSTR(r.ipf_valefrete_chave,1,11) in ('000002A1770','000003A1770','000005A1770','000015A1761','000016A1760','000025A1760','000036A1760',
                                                             '000037A1760','000039A1760','000039A1761','000041A1760','000044A1760','000063A1760','000067A1760',
                                                             '000071A1760','000072A1760','000075A1760','000077A1760','000087A1760','000096A1760','000108A1760')
                */  
                  and ( r.fcf_tpveiculo_descricao is null or trim(nvl(r.fcf_tpveiculo_codigo,'NE')) = 'NE' )
                  and r.ipf_valefrete_codigo = vf.con_conhecimento_codigo
                  and r.ipf_valefrete_serie = vf.con_conhecimento_serie
                  and r.ipf_valefrete_rota = vf.glb_rota_codigo
                  and r.ipf_valefrete_saque = vf.con_valefrete_saque
               order by vf.con_valefrete_placa,r.ipf_reccust_referencia)
  Loop
     If trim(c_msg.funcao) <> 'NE' Then
        select v.fcf_tpveiculo_descricao,
               v.fcf_tpveiculo_nreixos
          into vDescricao,
               vEixo
        From tdvadm.t_fcf_tpveiculo v
        where v.fcf_tpveiculo_codigo = rpad(c_msg.funcao,3);
        i := sql%rowcount;
        If substr(c_msg.con_valefrete_placa,2,2) = '00' Then
            update tdvipf.t_ipf_valefrete vf
              set vf.fcf_tpveiculo_codigo = c_msg.funcao,
                  vf.fcf_tpveiculo_descricao = vDescricao,
                  vf.ipf_valefrete_eixos = vEixo
            where vf.ipf_valefrete_chave = trim(c_msg.ipf_valefrete_chave)
              and vf.frt_conjveiculo_codigo = c_msg.con_valefrete_placa;
        Else
            update tdvipf.t_ipf_valefrete vf
              set vf.fcf_tpveiculo_codigo = c_msg.funcao,
                  vf.fcf_tpveiculo_descricao = vDescricao,
                  vf.ipf_valefrete_eixos = vEixo
            where vf.ipf_valefrete_chave = trim(c_msg.ipf_valefrete_chave)
              and vf.ipf_valefrete_placaunificada = tdvadm.fn_mudaplaca(c_msg.con_valefrete_placa,'MS');
        End If;
        i := sql%rowcount;
        If i > 0 Then
          dbms_output.put_line(c_msg.ipf_reccust_referencia || ';' || 
                               c_msg.ipf_valefrete_chave    || ';' || 
                               c_msg.con_valefrete_placa    || ';' || 
                               c_msg.tpveicarveic           || ';' || 
                               c_msg.cavalo                 || ';' || 
                               c_msg.carreta1               || ';' || 
                               c_msg.carreta2               || ';' ||
                               c_msg.funcao);
        End If;
     Else
          dbms_output.put_line(c_msg.ipf_reccust_referencia || ';' || 
                               c_msg.ipf_valefrete_chave    || ';' || 
                               c_msg.con_valefrete_placa    || ';' || 
                               c_msg.tpveicarveic           || ';' || 
                               c_msg.cavalo                 || ';' || 
                               c_msg.carreta1               || ';' || 
                               c_msg.carreta2               || ';' ||
                               c_msg.funcao);
       
     End If;
     
  End Loop;
  commit;
                  
end;
0
6
vPlaca
vData
c_msg.funcao
i
c_msg.ipf_valefrete_chave
c_msg.con_valefrete_placa
