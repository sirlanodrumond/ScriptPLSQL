  

select ENVIOVALE,asn,peso,balanca,/*cobrado,*/cte,rota,usuario,status,dtimprimiu,PESAGEMITEM,Usuarioitem
from (select en.NM_ASN asn,
             en.DT_GRAVACAO ENVIOVALE,
             (select max(it.arm_notapesagemitem_dtinclusao)
              from tdvadm.t_arm_notapesagemitem it
              where it.arm_nota_sequencia = np.arm_nota_sequencia) PESAGEMITEM,
             to_number(replace(tdvadm.fn_querystring(en.PAYLOAD_ENVIO,'"RealWeight"',':',','),'"','')) peso,
             an.arm_nota_pesobalanca balanca,
             an.arm_nota_peso,
             np.arm_notapesagem_pesototal,
             an.con_conhecimento_codigo cte,
             an.glb_rota_codigo rota,
             np.arm_notapesagem_status status,
             tdvadm.fn_busca_conhec_verba(an.con_conhecimento_codigo,an.con_conhecimento_serie,an.glb_rota_codigo,'I_PSCOBRAD') cobrado,
             np.usu_usuario_codigoimprimiu usuario,
             np.arm_notapesagem_dtimprimiu dtimprimiu,
             (select max(it1.usu_usuario_codigopesou)
              from tdvadm.t_arm_notapesagemitem it1
              where it1.arm_nota_sequencia = np.arm_nota_sequencia
                and it1.arm_notapesagemitem_dtinclusao = (select max(it.arm_notapesagemitem_dtinclusao)
                                                          from tdvadm.t_arm_notapesagemitem it
                                                          where it.arm_nota_sequencia = np.arm_nota_sequencia)) Usuarioitem

      from tdvadm.v_eventos_nimbi en,
           tdvadm.t_arm_nota an,
           tdvadm.t_arm_notapesagem np
      where en.DT_GRAVACAO >= '01/07/2017'
        and en.COD_EVENTO = 3  
        and en.arm_coleta_ncompra = an.arm_coleta_ncompra
        and en.arm_coleta_ciclo = an.arm_coleta_ciclo
        and an.arm_nota_sequencia = np.arm_nota_sequencia (+))
where  peso <> balanca
order by PESAGEMITEM desc,rota,status;


