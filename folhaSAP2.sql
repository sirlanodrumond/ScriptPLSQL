-- FPW SAP

select * from fpwsap.CTBCONTAS c;
select * from fpwsap.CTBEVEATRIB c;
select * from fpwsap.cencusto;
update fpwsap.CTBCONTAS c
  set c.cccodcta = decode(c.cccodcta,'110505555010','11302006',
                                     '220404444020','21401012',
                                     '220606363010','21502002',
                                     '220606666010','21502001',
                                     '221011010010','21501001',
                                     '221014014010','21503001',
                                     '221014014011','21503002',
                                     '221014014012','21503003',
                                     '221014014020','21503021',
                                     '221014014021','21503022',
                                     '221014014022','21503023',
                                     '330505000450','31102001',
                                     '330505000500','31101007',
                                     '330505000600','31102002',
                                     '330505000700','31101006',
                                     '330505000900','31101001',
                                     '330506000130','31103004',
                                     '330507000111','31103005',
                                     '341021000450','31102001',
                                     '341021000500','31101007',
                                     '341021000600','31102002',
                                     '341021000700','31101006',
                                     '341021000900','31101001',
                                     '341023000111','31103005',
                                     c.cccodcta);


select 'matricula' || chr(9) || 'nome' || chr(9) || 'dt_admissao' || chr(9) || 'cargo' || chr(9) || 'cod_event' || chr(9) || 'desc_event' || chr(9) || 'referencia' || chr(9) || 'cc_rota' || chr(9) || 'valor' || chr(9) || 'NAT_PROFI' || chr(9) || 'DEB_CRED' || chr(9) || 'conta' || chr(9) || 'conta_partida' || chr(9) || 'cod_lotacao' || chr(9) || 'desc_lotacao' || chr(9) || 'cod_folha' 
 from dual
union       
 select x.tcmatfunc || chr(9) ||
        null /*x.tcnomfunc*/ || chr(9) ||
        (select to_char(to_date(f.fudtadmis,'yyyymmdd'),'dd/mm/yyyy')  from fpw.funciona f where f.fumatfunc = x.tcmatfunc)  || chr(9) ||
        (select c.cadescargo from fpw.funciona f,
                     fpw.cargos c 
         where f.fucodcargo = c.cacodcargo
           and f.fumatfunc = x.tcmatfunc)  || chr(9) ||
        x.tccodevent  || chr(9) ||
        x.tcdesevent  || chr(9) ||
        x.tcrefer  || chr(9) ||
        null  || chr(9) ||
        x.tcvalor  || chr(9) ||
        TDVADM.FN_RETORNACONTACC(x.tccentrcus,'CC')  || chr(9) ||
        decode(x.tcvariant1,'D','DEBITO','CREDITO')  || chr(9) ||
        decode(x.tcvariant1,'D',TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C'),TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C'))  || chr(9) ||
        decode(x.tcvariant1,'D',TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C'),TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C'))  || chr(9) ||
        x.tccodlot  || chr(9) ||
        x.tcdeslot  || chr(9) ||
        x.tccodfolha
from fpw.ctbtabtemp x
where x.tcempresa <> 100
   and x.tccentrcus = '4023'
ORDER BY 1 DESC

                                     

  select x.tcmatfunc matricula,
         x.tcnomfunc nome,
         (select to_char(to_date(f.fudtadmis,'yyyymmdd'),'dd/mm/yyyy')  from fpw.funciona f where f.fumatfunc = x.tcmatfunc) dt_admissao,
         (select c.cadescargo from fpw.funciona f,
                      fpw.cargos c 
          where f.fucodcargo = c.cacodcargo
            and f.fumatfunc = x.tcmatfunc)  cargo,
         x.tccodevent cod_event,
         x.tcdesevent desc_event,
         x.tcrefer referencia,
         null cc_rota,
         x.tcvalor valor,
         TDVADM.FN_RETORNACONTACC(x.tccentrcus,'CC') NAT_PROFI,
         decode(x.tcvariant1,'D','DEBITO','CREDITO') DEB_CRED,
         decode(x.tcvariant1,'D',TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C'),TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C')) conta,
         decode(x.tcvariant1,'D',TDVADM.FN_RETORNACONTACC(x.tccodctaCR,'C'),TDVADM.FN_RETORNACONTACC(x.tccodctadb,'C')) conta_partida,
         x.tccodlot cod_lotacao,
         x.tcdeslot desc_lotacao,
         x.tccodfolha cod_folha
  from fpw.ctbtabtemp x
  where x.tcempresa <> 100
    and x.tccentrcus = '4023';
                                     

select c.cccodcta hoje,TDVADM.FN_RETORNACONTACC(c.cccodcta,'C') SAP 
from fpwsap.CTBCONTAS c;
select c.cccodigo hoje,TDVADM.FN_RETORNACONTACC(c.cccodigo,'CC') SAP
from fpwsap.cencusto c;



-- ('PLACEHOLDER' = (':IP_CUSTOMER','9000000010'));
SELECT *
    FROM  "_SYS_BIC"."sap.hana.POC/ZTDV_CV_0001"@TDHDSAP 
WHERE CUSTOMER = '9000000010';



SP_VEICDISP_ADDSOLVEIC
