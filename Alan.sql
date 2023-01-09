select * from tdvadm.t_arm_notatransf
select an.arm_nota_dtinclusao dtinc,
       an.arm_nota_numero nota,
       an.glb_cliente_cgccpfremetente remetente,
       an.slf_contrato_codigo contrato,
       an.arm_nota_peso peso,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD') coleta,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') entrega,
       tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(an.arm_nota_localcoletal,an.arm_nota_localentregal) KMviagem,
       an.arm_armazem_codigo armnota,
       ca.arm_carregamento_dtcria criacao,
       ca.arm_carregamento_dtfechamento dtfechamento,
       ca.arm_armazem_codigo armcarreg,
       cd.arm_carregamento_codigo carregamento,
       cd.arm_armazem_codigo_transf armtransf,
       atr.glb_rota_codigo rtarmtransf,
       vf.glb_rota_codigo || '-' || vf.con_conhecimento_codigo || '-' || vf.con_valefrete_saque valefrete,
       tdvadm.fn_busca_codigoibge(vf.glb_localidade_codigoori,'IBD') || '-' || tdvadm.fn_busca_codigoibge(vf.glb_localidade_codigodes,'IBD') origdestVFRETE,
       tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(vf.glb_localidade_codigoori,vf.glb_localidade_codigodes) KMpernada,
       cd.arm_carregamentodet_dcheckin dtcheckin,
       cd.usu_usuario_codigocheckin uscheckin,
       an.con_conhecimento_codigo || an.con_conhecimento_serie || an.glb_rota_codigo cte,
       vf.con_valefrete_obrigacoes,
       vf.con_valefrete_obscaixa
from tdvadm.t_arm_nota an,
     tdvadm.t_arm_carregamentodet cd,
     tdvadm.t_arm_carregamento ca,
     tdvadm.t_con_valefrete vf,
     tdvadm.t_Arm_Armazem atr
where an.arm_nota_dtinclusao >= '01/01/2017'
  and an.arm_embalagem_numero = cd.arm_embalagem_numero
  and an.arm_embalagem_flag = cd.arm_embalagem_flag
  and an.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
  and cd.arm_carregamento_codigo = ca.arm_carregamento_codigo
  and cd.arm_armazem_codigo_transf = atr.arm_armazem_codigo (+)
--  and cd.arm_armazem_codigo_transf is not null
--  and ca.arm_carregamento_dtfechamento is not null
  and ca.fcf_veiculodisp_codigo = vf.fcf_veiculodisp_codigo
  and ca.fcf_veiculodisp_sequencia = vf.fcf_veiculodisp_sequencia
  and vf.con_conhecimento_codigo = '116899'
  and vf.glb_rota_codigo = '160'
--  and an.arm_nota_numero = 27243
--  and an.glb_cliente_cgccpfremetente = '03327988000439'
  ;
  select vf.glb_rota_codigo || '-' || vf.con_conhecimento_codigo || '-' || vf.con_valefrete_saque valefrete,
         tdvadm.fn_busca_codigoibge(vf.glb_localidade_codigoori,'IBD') || '-' || tdvadm.fn_busca_codigoibge(vf.glb_localidade_codigodes,'IBD') origdestVFRETE,
        tdvadm.pkg_fifo_carregctrc.fn_ConsultaKM(vf.glb_localidade_codigoori,vf.glb_localidade_codigodes) KMpernada,
        vf.con_valefrete_fifo
  from tdvadm.t_con_valefrete vf,
       tdvadm.t_con_vfreteconhec vfc
  where vf.con_conhecimento_codigo = vfc.con_valefrete_codigo
    and vf.con_conhecimento_serie = vfc.con_valefrete_serie
    and vf.glb_rota_codigo = vfc.glb_rota_codigovalefrete
    and vf.con_valefrete_saque = vfc.con_valefrete_saque
--    and vf.con_valefrete_fifo = 'N'
    and vfc.con_conhecimento_codigo || vfc.con_conhecimento_serie || vfc.glb_rota_codigo = '750426A1021'
    and vfc.glb_rota_codigovalefrete || vfc.con_valefrete_codigo not in ('021750426','197854064','021754155','160116899');
    




select an.arm_nota_dtinclusao dtinc,
       an.arm_nota_numero nota,
       an.glb_cliente_cgccpfremetente remetente,
       an.slf_contrato_codigo contrato,
       an.arm_nota_peso peso,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD') coleta,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') entrega,
       count(*) qtde
from tdvadm.t_arm_nota an,
     tdvadm.t_arm_carregamentodet cd
where an.arm_nota_dtinclusao >= '01/01/2017'
  and an.arm_embalagem_numero = cd.arm_embalagem_numero
  and an.arm_embalagem_flag = cd.arm_embalagem_flag
  and an.arm_embalagem_sequencia = cd.arm_embalagem_sequencia
  and cd.arm_armazem_codigo_transf is not null
group by an.arm_nota_dtinclusao,
       an.arm_nota_numero,
       an.glb_cliente_cgccpfremetente,
       an.slf_contrato_codigo,
       an.arm_nota_peso,
       tdvadm.fn_busca_codigoibge(an.arm_nota_localcoletal,'IBD'),
       tdvadm.fn_busca_codigoibge(an.arm_nota_localentregal,'IBD') 
having count(*) > 1;


