
Select f.fumatfunc Matricula,
       f.funomfunc Nome,
       f.fucodhorar,
       h.hodeshorar "Horário de trabalho",
       l.locodlot || '-' || l.lodesclot "Lotação",
       c.cacodcargo || '-' || c.cadescargo "Cargo",
       f.fucentrcus "Setor",
       s.sttipositu "Situação (ativo, afastado, etc)",
       s.stdescsitu "Descrição da situação (motivo). Ex:",
       -- RESC DEMIS COM JUSTA CAUSA
       -- RESC DEMIS S/ JC AVISO IND    
       -- RESC PEDIDO DEMISS AVISO IND  
       -- RESC PEDIDO DEMISS NA EXP    
       -- RESC ACORDO EMPRESA X EMPREGAD
       to_char(to_date(f.fudtadmis,'yyyymmdd'),'dd/mm/yyyy') "Contratação",
       to_char(to_date(f.fudtinisit,'yyyymmdd'),'dd/mm/yyyy') "Demissão",
       ev.evcodevent "CodEvento",
       ev.evdesresum "Eventos",
       va.vavalevent valorevento,
       null "AVISO PREVIO INDENIZADO",
       null "13 SALARIO PROPORCIONAL",
       null "13 SALARIO INDENIZADO AVISO PREVIO",
       null "BASE INSS MES (-)",
       null "BASE FGTS MÊS",
       null "LIQUIDO A RECEBER",
       null "FGTS SALDO CEF",
       null "QUANTIDADE DE HORAS EXTRAS",
       null "VALOR EM HORAS EXTRAS 50% (em reais)",
       null "VALOR EM HORAS EXTRAS 100% (em reais)"
from fpw.funciona f,
     fpw.situacao s,
     fpw.lotacoes l,
     fpw.cargos c,
     fpw.horarios h,
     fpw.eventos ev,
     fpw.valano va
where va.vadtrefer >= 201901
  and  f.fucodsitu = s.stcodsitu 
  and s.sttipositu = 'R'
  and f.fucodlot = l.locodlot
  and f.fucodcargo = c.cacodcargo
  and f.fucodhorar = h.hocodigo
  and f.fumatfunc = va.vamatfunc
  and f.fucentrcus in ('3069','3071')
-- Segundo o Ananias não será necessario pois estes eventos são de rescisao
--  and va.vacodfolha = ???
  and va.vacodevent = ev.evcodevent
  and va.vacodevent in (3350,3355,3360,3410,3415,3425,11520,11525,11645,11655)
  and va.vadtrefer >= to_number(substr(to_char(f.fudtinisit),1,6))
  
;
select distinct l.locodlot || '-' || l.lodesclot
from fpw.funciona f,
     fpw.situacao s,
     fpw.lotacoes l,
     fpw.cargos c,
     fpw.horarios h,
     fpw.eventos ev,
     fpw.valano va
where f.fucodsitu = s.stcodsitu 
  and s.sttipositu = 'R'
  and f.fucodlot = l.locodlot
  and f.fucodcargo = c.cacodcargo
  and f.fucodhorar = h.hocodigo
  and f.fumatfunc = va.vamatfunc
--  and va.vacodfolha = ???
  and va.vacodevent = ev.evcodevent
  and va.vacodevent in (3350,3355,3360,3410,3415,3425,11520,11525,11645,11655)
  and va.vadtrefer >= to_number(substr(to_char(f.fudtinisit),1,6));
  
  
