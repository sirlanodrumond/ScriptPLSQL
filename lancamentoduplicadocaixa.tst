PL/SQL Developer Test script 3.0
59
-- Created on 09/11/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
begin
  -- Test statements here
  for c_msg in (select --m.cax_boletim_data,
                       m.glb_rota_codigo,
                       --  m.cax_movimento_sequencia,
                       m.cax_movimento_documentoref,
                       m.cax_operacao_codigo,
                       m.cax_movimento_valor,
                       count(*)
                from tdvadm.t_cax_movimento m
                where m.cax_boletim_data >= to_date('01/11/2021','DD/MM/YYYY')
                  and m.glb_tpdoc_codigo = 'VFP'
                  and m.cax_movimento_documentoref in (select m1.cax_movimento_documentoref
                                                       from tdvadm.t_cax_movimento m1
                                                       where 0 = 0
                                                         and m1.cax_boletim_data >= to_date('01/11/2021','DD/MM/YYYY')
                                                        -- and m.cax_movimento_documentoref = '036973A12611'
                                                         and m1.glb_tpdoc_codigo = 'VFP'
                                                       group by m1.cax_movimento_documentoref
                                                       having count(m1.cax_movimento_documentoref || m1.cax_operacao_codigo || m1.cax_movimento_valor) > 2)
                group by --m.cax_boletim_data,
                         m.glb_rota_codigo,
                         --m.cax_movimento_sequencia,
                         m.cax_movimento_documentoref,
                         m.cax_operacao_codigo,
                         m.cax_movimento_valor
                having count(*) > 1
                order by --m.cax_boletim_data, 
                         m.cax_movimento_documentoref,
                         m.cax_operacao_codigo)
  Loop
     Begin
     delete tdvadm.t_cax_movimento m
     where 0 = 0
--       and m.cax_boletim_data           = c_msg.cax_boletim_data
       and m.glb_rota_codigo            = c_msg.glb_rota_codigo
       and m.cax_movimento_documentoref = c_msg.cax_movimento_documentoref
       and m.cax_operacao_codigo        = c_msg.cax_operacao_codigo
       and m.cax_movimento_valor        = c_msg.cax_movimento_valor
       and m.glb_tpdoc_codigo           = 'VFP'
       and m.cax_movimento_sequencia    = (select min(m1.cax_movimento_sequencia)
                                           from tdvadm.t_cax_movimento m1
                                           where m1.cax_boletim_data           = m.cax_boletim_data          
                                             and m1.glb_rota_codigo            = m.glb_rota_codigo           
                                             and m1.cax_movimento_documentoref = m.cax_movimento_documentoref
                                             and m1.cax_operacao_codigo        = m.cax_operacao_codigo       
                                             and m1.cax_movimento_valor        = m.cax_movimento_valor       
                                             and m1.glb_tpdoc_codigo           = m.glb_tpdoc_codigo);
      exception
         When OTHERS Then
            dbms_output.put_line(/*c_msg.cax_boletim_data || '-' ||*/ c_msg.glb_rota_codigo  || '-' || c_msg.cax_movimento_documentoref || '-' || c_msg.cax_operacao_codigo|| '- erro:' || sqlerrm);
         End;
  End Loop;

end;
1
retorno
1
<Cursor>
-116
0
