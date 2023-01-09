PL/SQL Developer Test script 3.0
80
-- Created on 28/10/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vusuario tdvadm.v_arm_coletaocorhist.usuario%type;
begin
  -- Test statements here
  delete tdvadm.v_arm_coletas c
  where (c.coleta,
         c.coletaciclo) in (select h.arm_coleta_ncompra,
                                   h.arm_coleta_ciclo
                            from tdvadm.t_arm_coletahist h
                            where h.arm_coletahist_gravacao >= sysdate - (24/12));
                            
  insert into tdvadm.v_arm_coletas
  select *
  from tdvadm.v_arm_coletas_online o
  where 0 = (select count(*)
             from tdvadm.v_arm_coletas c
             where c.coleta = o.coleta
               and c.coletaciclo = o.coletaciclo);
  commit;
  for c_msg in (select o.coleta,
                       o.coletaciclo,
                       o.rowid
                from tdvadm.v_arm_coletas o
                where o.usualterou is null)
  Loop
    i := i + 1;

    begin
        select h.usuario
          into vusuario
        from tdvadm.v_arm_coletaocorhist h
        where h.coleta = c_msg.coleta
          and h.ciclo = c_msg.coletaciclo
          and h.sequencia = (select nvl(min(h1.sequencia),99999999)
                             from tdvadm.v_arm_coletaocorhist h1
                             where h1.coleta = h.coleta
                               and h1.ciclo = h.ciclo
                               and h1.ocorrencia = (select h2.arm_coletaocor_codigo
                                                    from tdvadm.t_arm_coleta h2
                                                    where h2.arm_coleta_ncompra = h1.coleta
                                                      and h2.arm_coleta_ciclo = h1.ciclo));
    exception
      when OTHERS then
        vusuario := null;
    End;
    
    if vusuario is not null then
       update tdvadm.v_arm_coletas u
         set u.usualterou = vusuario
       where u.rowid = c_msg.rowid;
    End If;
    
    If mod(i,100) = 0 then
       commit;
    end If;
    
  end Loop;
  commit;
End;                           




         
         
insert into tdvadm.v_arm_coletas
select *
from tdvadm.v_arm_coletas_online o
where 0 = (select count(*)
           from tdvadm.v_arm_coletas c
           where c.coleta = o.coleta
             and c.coletaciclo = o.coletaciclo)         
  
  
  select *
from tdvadm.v_arm_coletas_online;
end;
0
0
