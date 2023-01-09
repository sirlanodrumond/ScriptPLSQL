select * from tdvadm.t_arm_carregamento ca
where ca.arm_carregamemcalc_codigo = '1305910';
select *
from tdvadm.t_arm_carregamentodet cd
where cd.arm_carregamento_codigo = '1305910';


select c.arm_carregamemcalc_finalizou
from tdvadm.t_arm_carregamemcalc c
where c.arm_carregamemcalc_clisac = '61139432000172'
  and c.arm_carregamemcalc_cnpjrem = '61139432000172'
  and c.arm_carregamemcalc_finalizou is null
  and c.arm_carregamemcalc_data >= '08/11/2017'
for update;
    
 select * from glbadm.v_job_rodando
 
select * from tdvadm.v_lock_tables



insert into tdvadm.t_arm_carregamemcalc
select c.arm_carregamemcalc_codigo,
       c.arm_armazem_codigo,
       c.arm_carregamento_dtfechamento,
       '11',
       '61139432000172',
       '61139432000172',
       null,
       '05571',
       '61139432000172',
       null,
       '05571',
       'C',
       '111111',
       null,
       '0020',
       'T',
       '99',
       '99',
       null,
       null,
       null,
       null,
       c.arm_carregamento_dtfechamento,
       null
from tdvadm.t_arm_carregamento c
where c.arm_carregamento_dtfechamento >= '08/11/2017'
  and 0 = (select count(*)
           from tdvadm.t_arm_carregamemcalc ca
           where ca.arm_carregamemcalc_memocalc = c.arm_carregamemcalc_codigo)
;


           Select Distinct a.arm_armazem_infomail, 
                  car.arm_carregamento_codigo, 
                  a.arm_armazem_codigo || '-' || a.arm_armazem_descricao 
           from TDVADM.T_arm_carregamemcalc calc,
                TDVADM.T_arm_carregamento car
                ,TDVADM.T_fcf_veiculodisp vd
                ,TDVADM.T_arm_armazem a 
           where 0 = 0 
             and trunc(calc.arm_carregamemcalc_finalizou) >= '15/04/2014'
            and calc.arm_armazem_codigo in (select a.arm_armazem_codigo from TDVADM.T_arm_armazem a where a.arm_armazem_ativo = 'S' and a.arm_armazem_divcarreg = 'S')
             and vd.car_veiculo_placa is null 
--             and car.arm_carregamento_codigo = '1305910'
             and car.fcf_veiculodisp_codigo = vd.fcf_veiculodisp_codigo (+)
             and car.fcf_veiculodisp_sequencia = vd.fcf_veiculodisp_sequencia (+) 
             and calc.arm_carregamemcalc_memocalc = car.arm_carregamemcalc_codigo 
             and car.arm_carregamento_codigo = car.arm_carregamemcalc_codigo 
             and car.arm_armazem_codigo = a.arm_armazem_codigo 
             and 0 = (Select Count(*) 
                      From TDVADM.T_con_docmdfe m 
                      Where m.arm_carregamento_codigo = car.arm_carregamento_codigo) 
             and car.arm_carregamento_qtdctrc > 1 
             and car.arm_carregamento_qtdctrc = (select count(*) 
                                                 from TDVADM.T_con_conhecimento ct, 
                                                      TDVADM.T_con_controlectrce cte 
                                                 where  0 = 0      
                                                   and ct.arm_carregamento_codigo = calc.arm_carregamemcalc_memocalc 
                                                   and ct.con_conhecimento_codigo = cte.con_conhecimento_codigo (+) 
                                                   and ct.con_conhecimento_serie  = cte.con_conhecimento_serie (+) 
                                                   and ct.glb_rota_codigo         = cte.glb_rota_codigo (+) 
                                                   and ct.con_conhecimento_digitado = 'I'
                                                   and ct.con_conhecimento_serie <> 'XXX'
                                                   and ( instr('100',trim(cte.con_controlectrce_codstenv)) > 0 
                                                    OR TDVADM.PKG_SLF_CALCULOS.F_BUSCA_CONHEC_TPFORMULARIO(CT.CON_CONHECIMENTO_CODIGO,CT.CON_CONHECIMENTO_SERIE,CT.GLB_ROTA_CODIGO) = 'NF') 
                                                   and 0 = (select count(*) 
                                                            from TDVADM.T_con_vfreteconhec vfc 
                                                            where vfc.con_conhecimento_codigo = ct.con_conhecimento_codigo 
                                                              and vfc.con_conhecimento_serie  = ct.con_conhecimento_serie 
                                                              and vfc.glb_rota_codigo = ct.glb_rota_codigo)) 




select * from tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo in ('020256','020258')
  and vf.glb_rota_codigo = '175'
for update;
  

delete tdvadm.t_con_calcvalefrete vf
where vf.con_conhecimento_codigo in ('020256','020258')
  and vf.glb_rota_codigo = '175';
delete tdvadm.t_con_valefrete vf
where vf.con_conhecimento_codigo in ('020256','020258')
  and vf.glb_rota_codigo = '175';
  
  select *
  from tdvadm.t_con_vfreteconhec vfc
  where vfc.con_valefrete_codigo = '020259'
    and vfc.glb_rota_codigovalefrete = '175'
    for update
      

select * from glbadm.v_job_parados;


114467 185
114469 185

select calc.glb_rota_codigocx
                                   from tdvadm.t_con_calcvalefrete calc
--                                        ,tdvadm.t_glb_rota rt
--                                        ,tdvadm.t_usu_usuario u
                                   where calc.con_conhecimento_codigo = '114469'
                                     and calc.con_conhecimento_serie = 'A1'
                                     and calc.glb_rota_codigo = '185'
                                     and calc.con_valefrete_saque = '1'
                                     and calc.con_calcvalefretetp_codigo =  '20'
--                                     and u.usu_usuario_codigo = ca.usu_usuario_codigopgto
--                                     and rt.glb_rota_codigo = u.glb_rota_codigo








                         Select c.con_conhecimento_codigo        vf,
                                c.glb_rota_codigo                rt,
                                c.con_conhecimento_serie         serie,
                                c.con_valefrete_saque            saque,
                                c.glb_rota_codigocx              rtcx,
                                c.con_calcvalefrete_valor        valor,
                                c.con_calcvalefrete_tipo         tipopgto,
                                c.con_calcvalefrete_seq          seq,
                                c.con_calcvalefrete_codparoper   codpar,
                                tp.con_calcvalefretetp_codigo    cod,
                                tp.con_calcvalefretetp_descricao Descri,
                                c.usu_usuario_codigoliberou      usulib,
                                c.glb_rota_codigolib             rtlib,
                                c.usu_usuario_codigopgto         usupgto,
                                c.con_calcvalefrete_dtpgto       dtpgto,
                                c.glb_rota_codigopgto            rtpgto,
                                c.usu_usuario_bloqueou           usublq,
                                c.glb_rota_codigobloqueou        rtblq,
                                c.con_calcvalefrete_cnpjcpf      quemrecebeu,
                                c.con_calcvalefrete_cartao       cartao,
                                vf.con_valefrete_placa           placa,
                                vf.glb_tpmotorista_codigo        tp_motorista,
                                VF.CON_VALEFRETE_CARRETEIRO      quemrecebeu_frota,
                                c.GLB_ROTA_CODIGOCX              rota_pgto
                           From tdvadm.t_con_valefrete vf,
                                tdvadm.t_con_calcvalefrete c,
                                tdvadm.t_con_calcvalefretetp tp
                          Where 0 = 0
                            And vf.con_conhecimento_codigo     = c.con_conhecimento_codigo
                            And vf.con_conhecimento_serie      = c.con_conhecimento_serie
                            And vf.glb_rota_codigo             = c.glb_rota_codigo
                            And vf.con_valefrete_saque         = c.con_valefrete_saque
                            And c.con_calcvalefretetp_codigo   = tp.con_calcvalefretetp_codigo
                            And tp.con_calcvalefretetp_codigo in ('01','06','07','20')
                            and nvl(vf.con_valefrete_status,'N') <> 'C'
                            And c.con_calcvalefrete_valor      > 0
                            And C.CON_CALCVALEFRETE_TIPO       = 'C'
                            And nvl(C.GLB_ROTA_CODIGOCX,'999') <> '999'
                            AND C.con_calcvalefrete_dtpgto     IS NOT NULL
                            And c.con_conhecimento_codigo || c.con_conhecimento_serie || c.glb_rota_codigo ||  c.con_valefrete_saque <> '01702710231'
                            And C.GLB_ROTA_CODIGOCX           = '180'
                            and c.cax_boletim_data is null
                            and vf.con_valefrete_datacadastro >= sysdate - 10
                            and trunc(c.con_calcvalefrete_dtpgto) >= to_date('01/01/2016','dd/mm/yyyy')
                            And to_char(c.con_calcvalefrete_dtpgto,'yyyymmddhh24miss') <= '20171112153000'
                            
/*                            And 0 = (SELECT COUNT(*)
                                       FROM T_CAX_MOVIMENTO M
                                      WHERE M.CAX_MOVIMENTO_DOCUMENTO            = RPAD(C.CON_CONHECIMENTO_CODIGO,10)
                                        AND trim(M.CAX_MOVIMENTO_SERIE)          = TRIM(C.CON_CONHECIMENTO_SERIE)
                                        AND M.GLB_ROTA_CODIGO_REFERENCIA         = C.GLB_ROTA_CODIGO
                                        AND TRIM(M.CAX_MOVIMENTO_DOCCOMPLEMENTO) = C.CON_VALEFRETE_SAQUE
                                        AND M.CAX_OPERACAO_CODIGO                = PKG_CON_VALEFRETE.Fn_RetornaOperacao(vf.con_conhecimento_codigo, 
                                                                                                                        vf.con_conhecimento_serie, 
                                                                                                                        vf.glb_rota_codigo, 
                                                                                                                        vf.con_valefrete_saque, 
                                                                                                                        c.con_calcvalefretetp_codigo,
                                                                                                                        c.GLB_ROTA_CODIGOCX, 
                                                                                                                        'S'))
*/                           And 'S' = tdvadm.PKG_CON_VALEFRETE.Fn_VerificaProcessamento(vf.con_conhecimento_codigo, 
                                                                                  vf.con_conhecimento_serie, 
                                                                                  vf.glb_rota_codigo, 
                                                                                  vf.con_valefrete_saque, 
                                                                                  c.con_calcvalefretetp_codigo,
                                                                                  c.GLB_ROTA_CODIGOCX, 
                                                                                  'S')
                                                                                                                        


                       order by c.con_calcvalefrete_dtpgto,
                                tp.con_calcvalefretetp_codigo;



select *
from tdvadm.t_con_calcvalefretetp tp;
where tp.con_calcvalefretetp_codigo = '20'



     update tdvadm.t_con_calcvalefrete ca
       set ca.glb_rota_codigocx = (select calc.glb_rota_codigocx
                                   from tdvadm.t_con_calcvalefrete calc
--                                        ,tdvadm.t_glb_rota rt
--                                        ,tdvadm.t_usu_usuario u
                                   where calc.con_conhecimento_codigo = ca.con_conhecimento_codigo
                                     and calc.con_conhecimento_serie = ca.con_conhecimento_serie
                                     and calc.glb_rota_codigo = ca.glb_rota_codigo
                                     and calc.con_valefrete_saque = ca.con_valefrete_saque
                                     and calc.con_calcvalefretetp_codigo =  '01'
                                     and nvl(calc.glb_rota_codigocx,'999') <> '999'
--                                     and u.usu_usuario_codigo = ca.usu_usuario_codigopgto
--                                     and rt.glb_rota_codigo = u.glb_rota_codigo
                                  )
select ca.con_conhecimento_codigo,
       ca.con_conhecimento_serie,
       ca.glb_rota_codigo,
       ca.con_valefrete_saque,
       ca.con_calcvalefretetp_codigo,
       ca.glb_rota_codigocx,
       (select calc.glb_rota_codigocx
        from tdvadm.t_con_calcvalefrete calc
--                                        ,tdvadm.t_glb_rota rt
--                                        ,tdvadm.t_usu_usuario u
        where calc.con_conhecimento_codigo = ca.con_conhecimento_codigo
          and calc.con_conhecimento_serie = ca.con_conhecimento_serie
          and calc.glb_rota_codigo = ca.glb_rota_codigo
          and calc.con_valefrete_saque = ca.con_valefrete_saque
          and calc.con_calcvalefretetp_codigo =  '01'
          and nvl(calc.glb_rota_codigocx,'999') <> '999'
--                                     and u.usu_usuario_codigo = ca.usu_usuario_codigopgto
--                                     and rt.glb_rota_codigo = u.glb_rota_codigo
      ) subselect
from tdvadm.t_con_calcvalefrete ca
     where nvl(ca.glb_rota_codigocx,'999') = '999'
--       and ca.con_calcvalefrete_tipo = 'C'
       and ca.usu_usuario_bloqueou is null
       and ca.con_calcvalefretetp_codigo in ('06','07','01','20')
--       and ca.con_calcvalefrete_dtpgto is not null;
order by 1,2,3,4,5

;




Select c.con_conhecimento_codigo        vffrete,
                                c.glb_rota_codigo                rt,
                                c.con_conhecimento_serie         serie,
                                c.con_valefrete_saque            saque,
                                c.glb_rota_codigocx              rtcx,
                                c.con_calcvalefrete_valor        valor,
                                c.con_calcvalefrete_tipo         tipopgto,
                                c.con_calcvalefrete_seq          seq,
                                c.con_calcvalefrete_codparoper   codpar,
                                tp.con_calcvalefretetp_codigo    cod,
                                tp.con_calcvalefretetp_descricao Descri,
                                c.usu_usuario_codigoliberou      usulib,
                                c.glb_rota_codigolib             rtlib,
                                c.usu_usuario_codigopgto         usupgto,
                                c.con_calcvalefrete_dtpgto       dtpgto,
                                c.glb_rota_codigopgto            rtpgto,
                                c.usu_usuario_bloqueou           usublq,
                                c.glb_rota_codigobloqueou        rtblq,
                                c.con_calcvalefrete_cnpjcpf      quemrecebeu,
                                c.con_calcvalefrete_cartao       cartao,
                                vf.con_valefrete_placa           placa,
                                vf.glb_tpmotorista_codigo        tp_motorista,
                                VF.CON_VALEFRETE_CARRETEIRO      quemrecebeu_frota,
                                c.GLB_ROTA_CODIGOCX              rota_pgto
                           From tdvadm.t_con_valefrete vf,
                                tdvadm.t_con_calcvalefrete c,
                                tdvadm.t_con_calcvalefretetp tp
                          Where 0 = 0
                            And vf.con_conhecimento_codigo     = c.con_conhecimento_codigo
                            And vf.con_conhecimento_serie      = c.con_conhecimento_serie
                            And vf.glb_rota_codigo             = c.glb_rota_codigo
                            And vf.con_valefrete_saque         = c.con_valefrete_saque
                            And c.con_calcvalefretetp_codigo   = tp.con_calcvalefretetp_codigo
                            And tp.con_calcvalefretetp_codigo in ('01','06','07','20')
                            and nvl(vf.con_valefrete_status,'N') <> 'C'
                            And c.con_calcvalefrete_valor      > 0
                            And C.CON_CALCVALEFRETE_TIPO       = 'C'
                            And nvl(C.GLB_ROTA_CODIGOCX,'999') <> '999'
                            AND C.con_calcvalefrete_dtpgto     IS NOT NULL
                            And c.con_conhecimento_codigo || c.con_conhecimento_serie || c.glb_rota_codigo ||  c.con_valefrete_saque <> '01702710231'
                            And C.GLB_ROTA_CODIGOCX           = '180'
                            and vf.con_valefrete_datacadastro <= '11/11/2017'
                            and c.cax_boletim_data is null

select *
from tdvadm.t_con_calcvalefrete ca
where ca.con_conhecimento_codigo = '107686'
  and ca.glb_rota_codigo = '185'
  and ca.con_valefrete_saque = '1'
  and ca.con_calcvalefretetp_codigo in ('01','20','06','07')

select *
from tdvadm.t_con_VALEFRETE CA
where ca.con_conhecimento_codigo = '107686'
  and ca.glb_rota_codigo = '185'
  and ca.con_valefrete_saque = '1'

  
select ca.con_conhecimento_codigo,
       ca.con_conhecimento_serie,
       ca.glb_rota_codigo,
       ca.con_valefrete_saque,
       (select ca1.glb_rota_codigocx
        from tdvadm.t_con_calcvalefrete ca1
        where ca1.con_conhecimento_codigo = ca.con_conhecimento_codigo
          and ca1.con_conhecimento_serie = ca.con_conhecimento_serie
          and ca1.glb_rota_codigo = ca.glb_rota_codigo
          and ca1.con_valefrete_saque = ca.con_valefrete_saque
          and ca1.con_calcvalefretetp_codigo in ('06')) rotacx
from tdvadm.t_con_calcvalefrete ca
where 0 = 0
--   AND nvl(ca.glb_rota_codigocx,'999') = '999'
  --and ca.con_calcvalefretetp_codigo = '01'
  AND CA.CON_CONHECIMENTO_CODIGO = '086620'
  AND CA.GLB_ROTA_CODIGO = '185'
  and ca.con_calcvalefrete_valor = (select sum(ca1.con_calcvalefrete_valor)
                                    from tdvadm.t_con_calcvalefrete ca1
                                    where ca1.con_conhecimento_codigo = ca.con_conhecimento_codigo
                                      and ca1.con_conhecimento_serie = ca.con_conhecimento_serie
                                      and ca1.glb_rota_codigo =ca.glb_rota_codigo
                                      and ca1.con_valefrete_saque = ca.con_valefrete_saque
                                      and ca1.con_calcvalefretetp_codigo in ('06','07'))


update tdvadm.t_con_calcvalefrete ca
  set (ca.glb_rota_codigocx,CA.CAX_BOLETIM_DATA)  = (select ca1.glb_rota_codigocx,CA1.CAX_BOLETIM_DATA
                                                     from tdvadm.t_con_calcvalefrete ca1
                                                     where ca1.con_conhecimento_codigo = ca.con_conhecimento_codigo
                                                       and ca1.con_conhecimento_serie = ca.con_conhecimento_serie
                                                       and ca1.glb_rota_codigo = ca.glb_rota_codigo
                                                       and ca1.con_valefrete_saque = ca.con_valefrete_saque
                                                       and ca1.con_calcvalefretetp_codigo in ('06'))
where ca.Cax_Boletim_Data IS NULL 
  and ca.con_calcvalefretetp_codigo = '01'
  and ca.con_calcvalefrete_valor = (select sum(ca1.con_calcvalefrete_valor)
                                    from tdvadm.t_con_calcvalefrete ca1
                                    where ca1.con_conhecimento_codigo = ca.con_conhecimento_codigo
                                      and ca1.con_conhecimento_serie = ca.con_conhecimento_serie
                                      and ca1.glb_rota_codigo =ca.glb_rota_codigo
                                      and ca1.con_valefrete_saque = ca.con_valefrete_saque
                                      and ca1.con_calcvalefretetp_codigo in ('06','07'));
commit;
                                      
