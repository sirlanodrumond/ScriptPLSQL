PL/SQL Developer Test script 3.0
213
declare 
  i integer;
  
begin
   
/*

truncate table FPWSAP.CTBCONTAS;
insert into FPWSAP.CTBCONTAS
select * from FPW.CTBCONTAS ;
commit;

truncate table FPWSAP.CTBCONTASHIST;
insert into FPWSAP.CTBCONTASHIST
select * from FPW.CTBCONTASHIST ;
commit;

truncate table FPWSAP.CTBEVEATRIB;
insert into FPWSAP.CTBEVEATRIB
select * from FPW.CTBEVEATRIB ;
commit;

truncate table FPWSAP.CTBEVEATRIBHIST;
insert into FPWSAP.CTBEVEATRIBHIST
select * from FPW.CTBEVEATRIBHIST ;
commit;



*/


      -- Desativo o relacionamento anteriores
      update FPWSAP.CTBEVEATRIBHIST x
        set x.cehdatavigenciafinal = 20210930
      where nvl(x.cehdatavigenciafinal,0) = 0 ;

      -- Crio o novo relacinamento sem as contas desativadas 
      insert into FPWSAP.CTBEVEATRIBHIST
      select x.cehcodemp,
             x.cehcodeve,
             x.cehindcontab,
             x.cehcodatrib,
             x.cehcodlancto,
             20211001 cehdatavigencia,
             x.cehindparametrizacao,
             x.cehparamtipoplanocontas,
             x.cehparamtipolancamentos,
             x.cehtplanc,
      --       x.cehctadb,
             (select dp.ctb_deparasap_conta
              from tdvadm.t_ctb_deparasap dp
              where dp.ctb_pconta_codigo = x.cehctadb) novadb,
             x.cehhistdb,
             x.cehchlandb,
             x.cehatrfixodb,
      --       x.cehctacr,
             (select dp.ctb_deparasap_conta
              from tdvadm.t_ctb_deparasap dp
              where dp.ctb_pconta_codigo = x.cehctacr) novaCR,
             x.cehhistcr,
             x.cehchlancr,
             x.cehatrfixocr,
             x.cehatribaux,
             x.cehindcontadepartida,
             0 cehdatavigenciafinal
      from FPWSAP.CTBEVEATRIBHIST x
      where x.cehdatavigenciafinal = 20210930
        and x.cehctadb is not null 
        and x.cehctacr is not null 
        -- Contas desativadas debito
        and x.cehctadb not in ('110505100015',
                               '110505555015',
                               '110505900001',
                               '110505900005',
                               '110505900028',
                               '221010200012',
                               '221010200600')
        -- Contas desativadas credito
        and x.cehctacr not in ('110505100015',
                               '110505555015',
                               '110505900001',
                               '110505900005',
                               '110505900028',
                               '221010200012',
                               '221010200600');
      commit;   
      
      delete FPWSAP.CTBEVEATRIB;
      
      insert into FPWSAP.CTBEVEATRIB
      select x.cehcodemp cecodemp,
             x.cehcodeve cecodeve,
             x.cehindcontab ceindcontab,
             x.cehcodatrib cecodatrib,
             x.cehcodlancto cecodlancto,
             x.cehtplanc cetplanc,
             x.cehctadb cectadb,
             x.cehhistdb cehistdb,
             x.cehchlandb cechlandb,
             x.cehatrfixodb ceatrfixodb,
             x.cehctacr cectacr,
             x.cehhistcr cehistcr,
             x.cehchlancr cechlancr,
             x.cehatrfixocr ceatrfixocr,
             x.cehatribaux ceatribaux,
             x.cehindcontadepartida ceindcontadepartida
      from FPWSAP.CTBEVEATRIBHIST x
      where x.cehdatavigencia = 20211001;



-- Mudo a tabela de contas para as novas

      for c_msg in (select distinct 
                           x.cchcodemp,
                  --       x.cchcodcta,
                          (select dp.ctb_deparasap_conta
                           from tdvadm.t_ctb_deparasap dp
                           where dp.ctb_pconta_codigo = x.cchcodcta) contanova,
                           20211001 cchdatavigencia,
                           x.cchindparametrizacao,
                           x.cchdesccta,
                           x.cchmascara,
                           x.cchindcomp,
                           x.cchindgeral,
                           x.cchtabelas
                    from fpwsap.ctbcontashist x
                    where length(trim(x.cchcodcta)) = 12
                      and x.cchcodcta not in ('110505100015',
                                              '110505555015',
                                              '110505900001',
                                              '110505900005',
                                              '110505900028',
                                              '221010200012',
                                              '221010200600'))
      Loop
         Begin
           insert into fpwsap.ctbcontashist x
           values (c_msg.cchcodemp,
                   c_msg.contanova,
                   c_msg.cchdatavigencia,
                   c_msg.cchindparametrizacao,
                   c_msg.cchdesccta,
                   c_msg.cchmascara,
                   c_msg.cchindcomp,
                   c_msg.cchindgeral,
                   c_msg.cchtabelas);
         exception
            When OTHERS Then
               i:= 0;
         End;
      End Loop;

      commit;     
      
      delete fpwsap.ctbcontas ;                   

      insert into fpwsap.ctbcontas
      select x.cchcodemp cccodemp,
             x.cchcodcta cccodcta,
             x.cchdesccta ccdesccta,
             x.cchindcomp ccindcomp,
             x.cchindgeral ccindgeral,
             x.cchtabelas cctabelas
      from fpwsap.ctbcontashist x
      where x.cchdatavigencia = 20211001;
     commit;


 -- Cria os novos Centro de Custo
   delete fpwsap.cencusto s
   where length(trim(s.cccodigo)) = 10;

   insert into fpwsap.cencusto
   select s.glb_centrocusto_codigoSap cccodigo,
          max(s.glb_centrocusto_descricaosap) ccdescric,
          null cccodsubdv,
          1 cccodemp,
          'S' ccindperm 
   from tdvadm.t_glb_centrocustoSAP s
   group by s.glb_centrocusto_codigoSap;

   commit;

    update fpwsap.funciona f
      set f.fucentrcus = (select f1.fucentrcus
                          from fpw.funciona f1
                          where f1.fucodemp = f.fucodemp
                            and f1.fumatfunc = f.fumatfunc)
    where length(trim(f.fucentrcus)) = 10
      and (f.fucodemp,
           f.fucodsitu) in (select s.stcodemp,
                                   s.stcodsitu
                            from fpwsap.situacao s
                            where s.sttipositu < 'R');  
    commit; 

   
    update fpwsap.funciona f
      set f.fucentrcus = (select ccs.glb_centrocusto_codigosap
                          from tdvadm.t_glb_centrocustosap ccs
                          where ccs.locodlot = f.fucodlot
                            and ccs.glb_centrocusto_codigo = f.fucentrcus)
    where length(trim(f.fucentrcus)) < 10
      and (f.fucodemp,
           f.fucodsitu) in (select s.stcodemp,
                                   s.stcodsitu
                            from fpwsap.situacao s
                            where s.sttipositu < 'R');  
    commit; 

end;
0
5
i
c_msg.cehctadb
vCtaDeb
c_msg.cehctacr
vCtaCred
