PL/SQL Developer Test script 3.0
124
-- Created on 04/12/2018 by DESENV 
declare 
  -- Local variables here
  i integer;
  tpTabela TDVIPF.T_IPF_VALEFRETECTE%rowtype;
begin
  -- Test statements here
--  delete TDVIPF.T_IPF_VALEFRETECTE;
  commit;
  for c_msg in (select vfc.con_conhecimento_codigo,
                       vfc.con_conhecimento_serie,
                       vfc.glb_rota_codigo,
                       c.con_conhecimento_dtembarque,
                       vfc.con_valefrete_codigo,
                       vfc.con_valefrete_serie,
                       vfc.glb_rota_codigovalefrete,
                       vfc.con_valefrete_saque,
                       vf.con_catvalefrete_codigo,
                       vf.con_valefrete_datacadastro,
                       sysdate ipf_valefretecte_dtgravacao ,
                       null ipf_valefretecte_referencia  
                from tdvadm.t_con_vfreteconhec vfc,
                     tdvadm.t_con_valefrete vf,
                     tdvadm.t_con_conhecimento c
                where vfc.con_valefrete_codigo = vf.con_conhecimento_codigo (+)
                  and vfc.con_valefrete_serie = vf.con_conhecimento_serie (+)
                  and vfc.glb_rota_codigovalefrete = vf.glb_rota_codigo (+)
                  and vfc.con_valefrete_saque = vf.con_valefrete_saque (+)
                  and vfc.con_conhecimento_codigo = c.con_conhecimento_codigo
                  and vfc.con_conhecimento_serie = c.con_conhecimento_serie
                  and vfc.glb_rota_codigo = c.glb_rota_codigo
                  and nvl(c.con_conhecimento_flagcancelado,'N') = 'N'
                  and vf.con_valefrete_datacadastro >= to_date('01/07/2017','dd/mm/yyyy')
                  and vf.con_valefrete_datacadastro <= to_date('31/10/2018','dd/mm/yyyy')
--                  and vfc.con_conhecimento_codigo || vfc.glb_rota_codigo in ('993030197','964486021','000267072') 
                  and 0 < (select count(*)
                           FROM tdvipf.T_IPF_RECCUST_ROTA_CATEGORIA RRC 
                           WHERE RRC.IPF_RECCUST_ROTA_CATEGORIA_RAT = 'S' 
                             and rrc.con_catvalefrete_codigo = vf.con_catvalefrete_codigo
                             AND RRC.GLB_ROTA_CODIGO = vf.glb_rota_codigo)
                  and 0 = (select count(*)
                           from tdvipf.t_ipf_reccust_diretos cd
                           where cd.con_conhecimento_codigo = vfc.con_conhecimento_codigo
                             and cd.con_conhecimento_serie = vfc.con_conhecimento_serie
                             and cd.glb_rota_codigo_conhecimento = vfc.glb_rota_codigo
                             and cd.con_valefrete_codigo = vfc.con_valefrete_codigo
                             and cd.con_valefrete_serie = vfc.con_valefrete_serie
                             and cd.glb_rota_codigo_valefrete = vfc.glb_rota_codigovalefrete
                             and cd.con_valefrete_saque = vfc.con_valefrete_saque))
  Loop
     tpTabela.Con_Conhecimento_Codigo     := c_msg.con_conhecimento_codigo;
     tpTabela.Con_Conhecimento_Serie      := c_msg.con_conhecimento_serie;
     tpTabela.Glb_Rota_Codigo             := c_msg.glb_rota_codigo;
     tpTabela.Con_Conhecimento_Dtembarque := c_msg.con_conhecimento_dtembarque;
     tpTabela.Con_Valefrete_Codigo        := c_msg.con_valefrete_codigo;
     tpTabela.Con_Valefrete_Serie         := c_msg.con_valefrete_serie;
     tpTabela.Glb_Rota_Codigovfrete       := c_msg.glb_rota_codigovalefrete;
     tpTabela.Con_Valefrete_Saque         := c_msg.con_valefrete_saque;
     tpTabela.Con_Catvalefrete_Codigo     := c_msg.con_catvalefrete_codigo;
     tpTabela.Con_Valefrete_Datacadastro  := c_msg.con_valefrete_datacadastro;
     tpTabela.Ipf_Valefretecte_Dtgravacao := c_msg.ipf_valefretecte_dtgravacao;
     tpTabela.Ipf_Valefretecte_Referencia := c_msg.ipf_valefretecte_referencia;
     insert into TDVIPF.T_IPF_VALEFRETECTE values tpTabela;
  End Loop;
  commit;
  -- Lembrar o que fazer com os VFRETE saque 0
/*
   insert into TDVIPF.T_IPF_VALEFRETECTE
   select vfc.con_conhecimento_codigo,
          vfc.con_conhecimento_serie,
          vfc.glb_rota_codigo,
          c.con_conhecimento_dtembarque,
          vfc.con_valefrete_codigo,
          vfc.con_valefrete_serie,
          vfc.glb_rota_codigovalefrete,
          vfc.con_valefrete_saque,
          vf.con_catvalefrete_codigo,
          vf.con_valefrete_datacadastro,
          sysdate ipf_valefretecte_dtgravacao ,
          null ipf_valefretecte_referencia  
   from tdvadm.t_con_vfreteconhec vfc,
        tdvadm.t_con_valefrete vf,
        tdvadm.t_con_conhecimento c
   where vfc.con_valefrete_codigo = vf.con_conhecimento_codigo (+)
     and vfc.con_valefrete_serie = vf.con_conhecimento_serie (+)
     and vfc.glb_rota_codigovalefrete = vf.glb_rota_codigo (+)
     and vfc.con_valefrete_saque = vf.con_valefrete_saque (+)
     and vfc.con_conhecimento_codigo = c.con_conhecimento_codigo
     and vfc.con_conhecimento_serie = c.con_conhecimento_serie
     and vfc.glb_rota_codigo = c.glb_rota_codigo
     and nvl(c.con_conhecimento_flagcancelado,'N') = 'N'
     and vf.con_valefrete_datacadastro >= to_date('01/07/2017','dd/mm/yyyy')
     and vf.con_valefrete_datacadastro <= to_date('31/10/2018','dd/mm/yyyy')
     and vfc.con_conhecimento_codigo || vfc.glb_rota_codigo in ('993030197','964486021','000267072') 
     and (vfc.con_conhecimento_codigo,
          vfc.con_conhecimento_serie,
          vfc.glb_rota_codigo) in (select v.con_conhecimento_codigo,
                                          v.con_conhecimento_serie,
                                          v.glb_rota_codigo
                                   from TDVIPF.T_IPF_VALEFRETECTE v)
     and 0 = (select count(*)
              from TDVIPF.T_IPF_VALEFRETECTE cd
              where cd.con_conhecimento_codigo = vfc.con_conhecimento_codigo
                and cd.con_conhecimento_serie = vfc.con_conhecimento_serie
                and cd.glb_rota_codigo = vfc.glb_rota_codigo
                and cd.con_valefrete_codigo = vfc.con_valefrete_codigo
                and cd.con_valefrete_serie = vfc.con_valefrete_serie
                and cd.glb_rota_codigovfrete = vfc.glb_rota_codigovalefrete
                and cd.con_valefrete_saque = vfc.con_valefrete_saque);
   commit;
   delete tdvipf.t_ipf_reccust_diretos d
   where (d.con_conhecimento_codigo,
          d.con_conhecimento_serie,
          d.glb_rota_codigo_conhecimento) in (select x.con_conhecimento_codigo,
                                                     x.con_conhecimento_serie,
                                                     x.glb_rota_codigo
                                              from tdvipf.t_ipf_valefretecte x)   
*/                

  
  
  
  
end;
0
0
