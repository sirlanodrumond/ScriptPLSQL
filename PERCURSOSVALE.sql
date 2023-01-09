
select p.slf_percurso_datacadastro cadastro,
       (select p1.slf_percurso_datacadastro
        from tdvadm.t_slf_percurso p1
        where p1.glb_localidade_codigoorigem = p.glb_localidade_codigoorigem
          and p1.glb_localidade_codigodestino = p.glb_localidade_codigodestino) cadastrotdv,
       p.glb_localidade_codigoorigemi ibgeori,
       p.glb_localidade_codigodestinoi ibgedest,
       p.slf_percuso_descricao percurso,
       p.slf_percurso_km km,
       (select p1.slf_percurso_km
        from tdvadm.t_slf_percurso p1
        where p1.glb_localidade_codigoorigem = p.glb_localidade_codigoorigem
          and p1.glb_localidade_codigodestino = p.glb_localidade_codigodestino) percursotdv,
       (select c.con_conhecimento_codigo || c.con_conhecimento_serie || c.glb_rota_codigo
        from tdvadm.t_con_conhecimento c,
             tdvadm.t_glb_cliente cl
        where c.con_conhecimento_dtembarque >= '08/08/2017'
          and c.glb_cliente_cgccpfsacado = cl.glb_cliente_cgccpfcodigo
          and cl.glb_grupoeconomico_codigo = '0020'
          and c.con_conhecimento_localcoleta = p.glb_localidade_codigoorigem
          and c.con_conhecimento_localentrega = p.glb_localidade_codigodestino
          and rownum = 1)       
from tdvadm.t_slf_percurso_2781910 p
where p.slf_percurso_datacadastro >= '08/08/2017'
  and (trim(p.glb_localidade_codigoorigemi),
       trim(p.glb_localidade_codigodestinoi)) in (select trim(tdvadm.fn_busca_codigoibge(c.con_conhecimento_localcoleta,'IBC')),
                                                   trim(tdvadm.fn_busca_codigoibge(c.con_conhecimento_localentrega,'IBC'))
                                            from tdvadm.t_con_conhecimento c,
                                                 tdvadm.t_glb_cliente cl
                                            where c.con_conhecimento_dtembarque >= '08/08/2017'
                                              and c.glb_cliente_cgccpfsacado = cl.glb_cliente_cgccpfcodigo
                                              and cl.glb_grupoeconomico_codigo = '0020'
                                              and c.con_conhecimento_localcoleta = p.glb_localidade_codigoorigem
                                              and c.con_conhecimento_localentrega = p.glb_localidade_codigodestino
                                              and rownum = 1)
order by 3,4;
