PL/SQL Developer Test script 3.0
79
-- Created on 18/05/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  Chave integer;
  
begin
  -- Test statements here
  Chave := 0;
/*  for c_msg in (select *
                from (select fc.*,'N' origem from tdvadm.t_fcf_fretecar fc
                      union all
                      select fch.*,'H' origem from tdvadm.t_fcf_fretecarhist fch
                     ) x
                order by 19)
   loop
     Chave := Chave + 1;
     If c_msg.origem = 'N' Then
        update tdvadm.t_fcf_fretecar fc
          set fc.fcf_fretecar_rowid = Chave
        where fcf_fretecar_origem = c_msg.fcf_fretecar_origem
          and fcf_fretecar_destino = c_msg.fcf_fretecar_destino
          and fcf_fretecar_tpfrete = c_msg.fcf_fretecar_tpfrete
          and fcf_tpveiculo_codigo = c_msg.fcf_tpveiculo_codigo
          and fcf_tpcarga_codigo = c_msg.fcf_tpcarga_codigo
          and fcf_fretecar_vigencia = c_msg.fcf_fretecar_vigencia
          and fcf_fretecar_dtcadastro = c_msg.fcf_fretecar_dtcadastro;
     Else
        update tdvadm.t_fcf_fretecarhist fc
          set fc.fcf_fretecar_rowid = Chave
        where fcf_fretecar_origem = c_msg.fcf_fretecar_origem
          and fcf_fretecar_destino = c_msg.fcf_fretecar_destino
          and fcf_fretecar_tpfrete = c_msg.fcf_fretecar_tpfrete
          and fcf_tpveiculo_codigo = c_msg.fcf_tpveiculo_codigo
          and fcf_tpcarga_codigo = c_msg.fcf_tpcarga_codigo
          and fcf_fretecar_vigencia = c_msg.fcf_fretecar_vigencia
          and fcf_fretecar_dtcadastro = c_msg.fcf_fretecar_dtcadastro;
     End If;
     i := sql%rowcount;
     If i > 1 Then
        dbms_output.put_line(lpad(Chave,11,'0'));
     End if;
     
   End Loop;
   commit; 
*/
     for c_msg in (select *
                   from tdvadm.v_fcf_solveic sv
                   where sv.FCF_SOLVEIC_DTCONTR >= '01/05/2010'
                     and sv.chave is null)
     Loop
       Begin
       select f.chave
         into Chave
       from tdvadm.v_fcf_fretecarhist f
       where f.codorig = c_msg.origemloso
         and f.coddest = c_msg.destinoloso
         and f.codveic = c_msg.fcf_tpveiculo_codigo
         and f.vigencia = (select max(f1.vigencia)
                           from tdvadm.v_fcf_fretecarhist f1
                           where f1.codorig = f.codorig
                             and f1.coddest = f.coddest
                             and f1.codveic = f.codveic
                             and f1.vigencia <= c_msg.fcf_solveic_dtcontr);
       exception
         When NO_DATA_FOUND Then
            Chave := -1;
         When TOO_MANY_ROWS Then
            Chave := -2;
         End;

       update tdvadm.t_fcf_solveic sv
          set sv.fcf_fretecar_rowid = Chave
       where sv.fcf_solveic_cod = c_msg.fcf_solveic_cod; 
       commit;     
     End Loop;
     commit;

end;
0
2
Chave
i
