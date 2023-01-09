\\TDVFPW\SAP-FPW$


select 'matricula' || ';' || 'nome' || ';' || 'dt_admissao' || ';' || 'cargo' || ';' || 'cod_event' || ';' || 'desc_event' || ';' || 'referencia' || ';' || 'cc_rota' || ';' || 'valor' || ';' || 'NAT_PROFI' || ';' || 'DEB_CRED' || ';' || 'conta' || ';' || 'conta_partida' || ';' || 'cod_lotacao' || ';' || 'desc_lotacao' || ';' || 'cod_folha' 
 from dual
union       
 select x.tcmatfunc || ';' ||
        null /*x.tcnomfunc*/ || ';' ||
        (select to_char(to_date(f.fudtadmis,'yyyymmdd'),'dd/mm/yyyy')  from fpw.funciona f where f.fumatfunc = x.tcmatfunc)  || ';' ||
        (select c.cadescargo from fpw.funciona f,
                     fpw.cargos c 
         where f.fucodcargo = c.cacodcargo
           and f.fumatfunc = x.tcmatfunc)  || ';' ||
        x.tccodevent  || ';' ||
        x.tcdesevent  || ';' ||
        x.tcrefer  || ';' ||
        null  || ';' ||
        trim(to_char(x.tcvalor,999990.99))  || ';' ||
        TDVADM.FN_RETORNACONTACC(x.tccentrcus,'CC')  || ';' ||
        decode(x.tcvariant1,'D','DEBITO','CREDITO')  || ';' ||
        TDVADM.FN_RETORNACONTACC(decode(x.tcvariant1,'D',x.tccodctadb,x.tccodctaCR),'C')  || ';' ||
        TDVADM.FN_RETORNACONTACC(decode(x.tcvariant1,'D',x.tccodctaCR,x.tccodctadb),'C')   || ';' ||
        x.tccodlot  || ';' ||
        x.tcdeslot  || ';' ||
        x.tccodfolha
from fpw.ctbtabtemp x
where x.tcempresa <> 100
   and x.tccentrcus = '4023'
order by 1 desc;

select x.tcempresa,
       x.tccentrcus,
       x.tccodctadb,
       TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C') debsap,
       x.tccodctaCR,
       TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C') credsap
from fpw.ctbtabtemp x
where x.tccentrcus = '4023'
  and ( ( length(trim(TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C'))) = 12 ) or ( length(trim(TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C'))) = 12 ) )
--  and x.tccodctadb like '22%4022%'
;
select pc.ctb_pconta_codigo contatdv,
       TDVADM.FN_RETORNACONTACC(pc.ctb_pconta_codigo,'C') contaSAP,
       pc.ctb_pconta_descricao descricao
from tdvadm.t_ctb_pconta pc
where length(trim(TDVADM.FN_RETORNACONTACC(pc.ctb_pconta_codigo,'C'))) = 12
  and substr(pc.ctb_pconta_codigo,1,1) <> '8'
;

select distinct x.tcempresa,
       x.tccentrcus,
       x.tccodctadb,
       TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C') debsap,
       pc.ctb_pconta_descricao descricao
from fpw.ctbtabtemp x,
     tdvadm.t_ctb_pconta pc
where x.tccentrcus = '4023'
  and x.tccodctadb = pc.ctb_pconta_codigo (+)
  and TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C') = x.tccodctadb 
union
select distinct x.tcempresa,
       x.tccentrcus,
       x.tccodctaCR,
       TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C') debsap,
       pc.ctb_pconta_descricao descricao
from fpw.ctbtabtemp x,
     tdvadm.t_ctb_pconta pc
where x.tccentrcus = '4023'
  and x.tccodctaCR = pc.ctb_pconta_codigo (+)
  and TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C') = x.tccodctaCR
;  
    

select distinct 
--       x.tcempresa,
--       x.tccentrcus,
       x.tccodctadb,
       TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C') debsap,
       pc.ctb_pconta_descricao descricao
from fpw.ctbtabtemp x,
     tdvadm.t_ctb_pconta pc
where 0 = 0
--  and x.tccentrcus = '4023'
  and x.tccodctadb = pc.ctb_pconta_codigo (+)
  and TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C') = x.tccodctadb 
union
select distinct 
--       x.tcempresa,
--       x.tccentrcus,
       x.tccodctaCR,
       TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C') debsap,
       pc.ctb_pconta_descricao descricao
from fpw.ctbtabtemp x,
     tdvadm.t_ctb_pconta pc
where 0 = 0
--  and x.tccentrcus = '4023'
  and x.tccodctaCR = pc.ctb_pconta_codigo (+)
  and TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C') = x.tccodctaCR
; 
 
