select x.*
from (
select pd.slf_percursoped_codigo,
       tdvadm.fn_busca_codigoibge(p.glb_localidade_codigoorigem,'IBD') origem,
       tdvadm.fn_busca_codigoibge(p.glb_localidade_codigodestino,'IBD') destino,
       pd.glb_localidade_codigopasspor passandopor,
       pd.slf_percursoped_km km,
       pd.slf_percursoped_valoreixo valoreixo,
       (select max(fc.pedporeixo)
        from tdvadm.v_fcf_fretecar fc
        where fc.fcf_fretecar_origem = p.glb_localidade_codigoorigem
          and fc.fcf_fretecar_destino = p.glb_localidade_codigodestino) maiormesa,
       (select min(fc.pedporeixo)
        from tdvadm.v_fcf_fretecar fc
        where fc.fcf_fretecar_origem = p.glb_localidade_codigoorigem
          and fc.fcf_fretecar_destino = p.glb_localidade_codigodestino) menormesa,

/*       (select max(fc.pedporeixo)
        from tdvadm.v_fcf_fretecar fc
        where tdvadm.fn_busca_codigoibge(fc.FCF_FRETECAR_ORIGEM,'IBD') = tdvadm.fn_busca_codigoibge(p.glb_localidade_codigoorigem,'IBD')
          and tdvadm.fn_busca_codigoibge(fc.FCF_FRETECAR_DESTINO,'IBD') = tdvadm.fn_busca_codigoibge(p.glb_localidade_codigodestino,'IBD')) maiormesaIB,

       (select min(fc.pedporeixo)
        from tdvadm.v_fcf_fretecar fc
        where tdvadm.fn_busca_codigoibge(fc.FCF_FRETECAR_ORIGEM,'IBD') = tdvadm.fn_busca_codigoibge(p.glb_localidade_codigoorigem,'IBD')
          and tdvadm.fn_busca_codigoibge(fc.FCF_FRETECAR_DESTINO,'IBD') = tdvadm.fn_busca_codigoibge(p.glb_localidade_codigodestino,'IBD')) menormesaIB,
*/
       pd.slf_percursoped_reprocessa reprocessa,
       pd.slf_percursoped_datacadastro dtcadastro,
       pd.slf_percursoped_atualizacao dtatulizacao,
       pd.slf_percursoped_qtdeuso qtdeuso,
       pd.slf_percursoped_dtultuso dtultuso,
       pd.slf_percursoped_flagr flagr,
       pd.con_freteoper_id fid,
       (select count(vf.con_conhecimento_codigo || vf.con_conhecimento_serie || vf.glb_rota_codigo)
        from tdvadm.t_con_valefrete vf
        where vf.cax_boletim_data is not null
          and vf.glb_localidade_codigoori = p.glb_localidade_codigoorigem
          and vf.glb_localidade_codigodes = p.glb_localidade_codigodestino
--          and lpad(nvl(vf.glb_localidade_codigopasspor,'0'),8,'0') = lpad(nvl(pd.glb_localidade_codigopasspor,'0'),8,'0')
          and vf.con_valefrete_datacadastro >= add_months(sysdate,-3)) qtdevf
from tdvadm.t_slf_percursoped pd,
     tdvadm.t_slf_percurso p
where pd.slf_percursoped_atualizacao <= add_months(sysdate,-3)
  and pd.slf_percursoped_codigo = p.slf_percurso_codigo
) x
where x.qtdevf > 0;
