PL/SQL Developer Test script 3.0
48
-- Created on 04/04/2017 by DESENV 
declare 
  -- Local variables here
  i integer;
  vBoletim char(3);
  vAno   char(4) := '2017';
begin
  -- Test statements here

  FOR C_MSG IN (SELECT B.GLB_ROTA_CODIGO,
                       MIN(B.CAX_BOLETIM_DATA) DATA
                FROM TDVADM.T_CAX_BOLETIM B
                WHERE 0 = 0
--                  AND B.CAX_BOLETIM_CODIGO IS NULL
                  AND TO_DATE(B.CAX_BOLETIM_DATA,'DD/MM/YYYY') >= sysdate - 5
--                  and to_char(b.cax_boletim_data,'YYYY') = vAno
                GROUP BY B.GLB_ROTA_CODIGO)
   loop
      select max(b.cax_boletim_codigo)
         into vBoletim
      from  TDVADM.T_CAX_BOLETIM B
      where b.glb_rota_codigo = c_msg.glb_rota_codigo
        and b.cax_boletim_data < c_msg.data
        and b.cax_boletim_codigo is not null;  
     
--      vBoletim := '000';
      for c_msg1 in (select bo.glb_rota_codigo,
                            bo.cax_boletim_data
                     from tdvadm.t_cax_boletim bo
                     where bo.glb_rota_codigo = c_msg.glb_rota_codigo
--                       and to_char(bo.cax_boletim_data,'YYYY') = vAno
                       and bo.cax_boletim_data >= c_msg.data
                     order by 2)
      loop
        
        vBoletim := lpad(to_number(vBoletim) + 1,3,'0');
      
        update tdvadm.t_cax_boletim b1
          set b1.cax_boletim_codigo = vBoletim
        where b1.glb_rota_codigo = c_msg1.glb_rota_codigo
          and b1.cax_boletim_data = c_msg1.cax_boletim_data;

      End Loop; 
   
   
   End Loop;
   commit;
end;
0
4
vBoletim
c_msg.data
c_msg1.cax_boletim_data
c_msg.glb_rota_codigo
