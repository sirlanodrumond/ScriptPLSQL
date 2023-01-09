PL/SQL Developer Test script 3.0
136
-- Created on 08/08/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vUsado    integer := 0;
  vNaoUsado Integer := 0;
  
  vSolVeic      tdvadm.t_fcf_solveic.fcf_solveic_cod%type;
  vFretecarMemo Integer;
  vCarregamento Integer;
  vCarregVeic   Integer;
  vValeFrete    Integer;
  vManifesto    Integer;
  
  vAuxiliar Integer;
  vVeiculoDisp tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_codigo%type;
  vVeiculoDispSeq tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_sequencia%type := '0  ';
  tpFCF_Disponivel tdvadm.t_fcf_disponivel%rowtype;
begin
    execute immediate('truncate table tdvadm.t_fcf_disponivel');
    commit;
  -- Test statements here
     for i in 1..9999999
--     for i in 1008853..1008978
     loop
        vVeiculoDisp := i;
        tpFCF_Disponivel.Fcf_Veiculodisp_Codigo      := vVeiculoDisp;
        tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia   := '0  ';
        tpFCF_Disponivel.Fcf_Disponivel_Utilizado    := null;
        tpFCF_Disponivel.Fcf_Disponivel_Dtutilizacao := null;  
        tpFCF_Disponivel.Fcf_Disponivel_Tipo         := null;    
        -- se o numero existe
        select count(*)
          into vAuxiliar
        from tdvadm.t_fcf_veiculodisp vd
        where vd.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo;
    
        If vAuxiliar = 0 Then
           tpFCF_Disponivel.Fcf_Disponivel_Tipo := '1-PULO';
        ElsIf vAuxiliar > 1 Then
           -- Varias Sequencias
           tpFCF_Disponivel.Fcf_Disponivel_Tipo := '4-VARIAS SEQ'; 
        ElsIf vAuxiliar = 1 Then
           Begin
              vSolVeic := null;
              vFretecarMemo := 0;
              select ca.fcf_solveic_cod
                into vSolVeic
              from tdvadm.T_FCF_solveic ca
              where ca.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
                and ca.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia;

              select count(*)
                into vFretecarMemo
              from tdvadm.T_FCF_FRETECARMEMO FM
              where fm.fcf_solveic_cod = vSolVeic
                and FM.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
                and FM.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia
                and nvl(fm.fcf_fretecarmemo_frete,0) <> 0;
            
           Exception
              When NO_DATA_FOUND Then
                   vFretecarMemo := 0; 
              When TOO_MANY_ROWS Then
                   vSolVeic := 99999;
              End;
          
           select count(*)
             into vCarregamento
           from tdvadm.t_arm_carregamento ca
           where ca.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
             and ca.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia
             and ca.arm_carregamento_dtfechamento is null
             and ca.arm_carregamento_dtcria <= sysdate - 30;
       
           If vCarregamento <> 0 Then       
              select count(*)
                into vCarregVeic
              from tdvadm.t_arm_carregamentoVeic ca
              where ca.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
                and ca.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia;
           Else
              vCarregVeic := 0;
           End If;
       
           select count(*)
             into vValeFrete
           from tdvadm.t_con_valefrete vf
           where vf.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
             and vf.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia;


           select count(*)
             into vManifesto
           from tdvadm.t_con_veicdispmanif ma
           where ma.fcf_veiculodisp_codigo = tpFCF_Disponivel.Fcf_Veiculodisp_Codigo
             and ma.fcf_veiculodisp_sequencia = tpFCF_Disponivel.Fcf_Veiculodisp_Sequencia;

          
          
          If vManifesto <> 0 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '5-MANIFESTO';
          ElsIF vValeFrete <> 0 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '6-VALE FRETE';
          ElsIf vCarregamento <> 0 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '7-CARREGAMENTO';
          ElsIf vSolVeic = 99999 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '8-VSOLVEIC';
          ElsIf vFretecarMemo <> 0 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '9-FRETEMEMO';
          ElsIf vCarregVeic <> 0 Then
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '3-COLETOR';
          Else
             tpFCF_Disponivel.Fcf_Disponivel_Tipo := '2-NUTILIZADO';
          End If;
       
        End If;    

--        If tpFCF_Disponivel.Fcf_Disponivel_Tipo <> 'U' Then
           Insert into tdvadm.t_fcf_disponivel values tpFCF_Disponivel;
           commit;
--           vNaoUsado := vNaoUsado + 1;
--        Else
           vUsado := vUsado + 1;
--        End If;
          
         If mod(vUsado,1000) = 0 Then
            commit;
         End If;
 
     End Loop;
     commit;
     dbms_output.put_line('Usados     ' || vUsado);
     dbms_output.put_line('Nao Usados ' || vNaoUsado);
     
end;
0
1
vauxiliar
