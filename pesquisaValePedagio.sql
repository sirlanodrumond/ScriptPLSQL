tdvadm.sp_gera_valefretecoleta

-- Vale de Frete
select d.vFrete,
       d.Rota,
       d.saque,
       d.sacado,
       --d.cte,
       d.pedagio,
       d.tipomot,
       d.placa,
       d.cliente,
       d.grupo,
       d.contrato,
       d.peso,
       d.qtde,
       tdvadm.pkg_slf_contrato.FN_VALIDAVALEPEDAGIO(d.sacado,d.CONTRATO,d.grupo) ValePed
from (select a.con_conhecimento_codigo vfrete,
             a.glb_rota_codigo rota,
             a.con_valefrete_saque saque,
             c.glb_cliente_cgccpfsacado sacado,
            -- c.con_conhecimento_codigo || '-' ||c.con_conhecimento_serie || '-' || c.glb_rota_codigo cte,
             a.con_valefrete_pedagio pedagio,
             a.glb_tpmotorista_codigo tipomot,
             a.con_valefrete_placa placa,
             cLSac.Glb_Cliente_Razaosocial cliente,
             CLSac.Glb_Grupoeconomico_Codigo grupo,
             tdvadm.pkg_slf_utilitarios.fn_retorna_contratocod(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO) CONTRATO,
             SUM(a.con_valefrete_pesocobrado) peso,
             count(*) qtde
      From tdvadm.t_con_valefrete a,
           tdvadm.t_con_vfreteconhec vfc,
           tdvadm.t_con_conhecimento c,
           tdvadm.T_GLB_CLIENTE CLSac
      where 0 = 0
        and a.con_valefrete_datacadastro >= '01/01/2022'
        and nvl(a.con_valefrete_status,'N') = 'N'
        and vfc.arm_armazem_codigo is null
        and a.con_conhecimento_codigo = '697011'
        and a.con_conhecimento_serie  = 'A1'
        and a.glb_rota_codigo         = '011'
        AND A.CON_VALEFRETE_Saque     = '1'
        and a.con_valefrete_pedagio > 0
        and a.con_conhecimento_codigo = vfc.con_valefrete_codigo
        and a.con_conhecimento_serie  = vfc.con_valefrete_serie
        and a.glb_rota_codigo         = vfc.glb_rota_codigovalefrete
        and a.con_valefrete_saque     = vfc.con_valefrete_saque
        and vfc.con_conhecimento_codigo = c.con_conhecimento_codigo
        and vfc.con_conhecimento_serie  = c.con_conhecimento_serie
        and vfc.glb_rota_codigo         = c.glb_rota_codigo
        and c.glb_cliente_cgccpfsacado  = CLSac.Glb_Cliente_Cgccpfcodigo
      group by a.con_conhecimento_codigo,
               a.glb_rota_codigo,
               a.con_valefrete_saque,
               c.glb_cliente_cgccpfsacado,
               a.glb_tpmotorista_codigo,
               cLSac.Glb_Cliente_Razaosocial,
               CLSac.Glb_Grupoeconomico_Codigo,
               a.con_valefrete_pedagio,
               a.con_valefrete_placa,
               --c.con_conhecimento_codigo || '-' ||c.con_conhecimento_serie || '-' || c.glb_rota_codigo,
               tdvadm.pkg_slf_utilitarios.fn_retorna_contratocod(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO)) d
                                     
-- 697011/011
-- 774925/011         
-- 776075/011
-- 772106/011         


select * from tdvadm.v_kill_sessoes k
where lower(k.OSUSER) like '%sirlano%';


select sacado,
from (Select c.glb_cliente_cgccpfsacado sacado,
       cl.glb_grupoeconomico_codigo grupo,
       tdvadm.pkg_slf_utilitarios.fn_retorna_contrato(C.CON_CONHECIMENTO_CODIGO,C.CON_CONHECIMENTO_SERIE,C.GLB_ROTA_CODIGO) CONTRATO
from tdvadm.t_con_conhecimento c,
       tdvadm.t_glb_cliente cl
  where c.con_conhecimento_codigo = '696302'
    and c.con_conhecimento_serie = 'A1'
    and c.glb_rota_codigo = '011'
    and c.glb_cliente_cgccpfsacado = cl.glb_cliente_cgccpfcodigo;
    
    


select v.frt_veiculo_placa placa,
       v.frt_veiculo_placaunificada unificada,
       v.frt_veiculo_codigo codigo,
       v.frt_veiculo_dataquisicao aquisicao,
       v.frt_veiculo_valoraquisicao valor,
       v.frt_tpveiculosap_codpatrimonio patrimonio,
       v.frt_veiculo_datavenda
from tdvadm.t_frt_veiculo v
--where v.frt_veiculo_datavenda is null
order by 1;





         
