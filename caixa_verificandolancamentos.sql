--tdvadm.pkg_con_valefrete


select *
from tdvadm.t_cax_movimento m
where m.cax_movimento_documentoref = '098423A10791';


select x.*,
       (select count(*)
        from tdvadm.t_cax_movimento m
        where 0 = 0
--          and m.glb_rota_codigo = x.rtcx
          and m.cax_movimento_documentoref = trim(x.vfrete || x.sr || x.rota || x.sq)
          and m.cax_operacao_codigo = x.opersaida
          and m.cax_movimento_valor = x.vlr) acheisaida,
       (select count(*)
        from tdvadm.t_cax_movimento m
        where 0 = 0
--          and m.glb_rota_codigo = x.rtcx
          and m.cax_movimento_documentoref = x.vfrete || x.sr || x.rota || x.sq
          and m.cax_operacao_codigo = x.operEntrada
          and m.cax_movimento_valor = x.vlr) acheientrada
        from (select vf.con_conhecimento_codigo vfrete,
             vf.con_conhecimento_serie sr,
             vf.glb_rota_codigo rota,
             vf.con_valefrete_saque sq,
             vf.glb_rota_codigocx rtcx,
             vf.con_calcvalefretetp_codigo tipo,
             tp.con_calcvalefretetp_descricao descricao,
             vf.cax_boletim_data dtcaixa,
             vf.con_calcvalefrete_valor vlr,
             tdvadm.pkg_con_valefrete.Fn_RetornaOperacao(pValeFreteCod   => vf.con_conhecimento_codigo,
                                                         pValeFrereSerie => vf.con_conhecimento_serie,
                                                         pValeFreteRota  => vf.glb_rota_codigo,
                                                         pValeFreteSaque => vf.con_valefrete_saque,
                                                         pCodParcelaPaga => vf.con_calcvalefretetp_codigo ,
                                                         pRotaCaixa      => vf.glb_rota_codigocx,
                                                         pTipo           => 'S') opersaida,
             tdvadm.pkg_con_valefrete.Fn_RetornaOperacao(pValeFreteCod   => vf.con_conhecimento_codigo,
                                                         pValeFrereSerie => vf.con_conhecimento_serie,
                                                         pValeFreteRota  => vf.glb_rota_codigo,
                                                         pValeFreteSaque => vf.con_valefrete_saque,
                                                         pCodParcelaPaga => vf.con_calcvalefretetp_codigo ,
                                                         pRotaCaixa      => vf.glb_rota_codigocx,
                                                         pTipo           => 'E') operEntrada
      from tdvadm.t_con_calcvalefrete vf,
           tdvadm.t_con_calcvalefretetp tp
      where vf.con_calcvalefrete_valor <> 0
        and vf.cax_boletim_data >= to_date('01/10/2021','DD/MM/YYYY')
        and vf.cax_boletim_data < sysdate -1 
        and vf.con_calcvalefretetp_codigo = tp.con_calcvalefretetp_codigo
/*        and vf.con_calcvalefretetp_codigo not in ('01', -- Adiantamento
                                                  '02', -- Pedagio
                                                  '20', -- Saldo
                                                  '06', --4 - Tarifa Saque
                                                  '07', --4 - Tarifa Transferencia
                                                  '00')
*/
/*        and 0 < (select count(*)
                 from tdvadm.t_con_vfreteciot c
                 where c.con_conhecimento_codigo = vf.con_conhecimento_codigo
                   and c.con_conhecimento_serie = vf.con_conhecimento_serie
                   and c.glb_rota_codigo = vf.glb_rota_codigo
                   and c.con_valefrete_saque = vf.con_valefrete_saque)
*/                   
                   ) x;     
  


