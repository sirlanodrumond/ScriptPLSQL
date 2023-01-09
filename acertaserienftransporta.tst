PL/SQL Developer Test script 3.0
85
-- Created on 08/09/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
begin
  -- Test statements here
  execute immediate ('alter trigger TG_BDIU_TRAVACTRCNF_DATALIVRO disable');

   update tdvadm.t_con_nftransporta nf
     set nf.glb_cliente_cgccpfcodigo = (select c.glb_cliente_cgccpfremetente
                                        from tdvadm.t_con_conhecimento c
                                        where nf.con_conhecimento_codigo = c.con_conhecimento_codigo
                                          and nf.con_conhecimento_serie = c.con_conhecimento_serie
                                          and nf.glb_rota_codigo = c.glb_rota_codigo)
   where nf.glb_cliente_cgccpfcodigo is null
     and nf.con_nftransportada_chavenfe is null
     and nf.con_nftransportada_serienf is null;

   update T_CON_NFTRANSPORTA nf
     set nf.glb_cliente_cgccpfcodigo = substr(nf.con_nftransportada_chavenfe,7,14)
   where nf.con_nftransportada_chavenfe is not null
     and nf.glb_cliente_cgccpfcodigo is null;

   update T_CON_NFTRANSPORTA nf
     set nf.con_nftransportada_serienf = substr(nf.con_nftransportada_chavenfe,23,3)
   where nf.con_nftransportada_chavenfe is not null
     and nf.con_nftransportada_serienf is null;

   update T_CON_NFTRANSPORTA nf
     set nf.con_nftransportada_serienf = '1'
   where nf.con_nftransportada_serienf is null;


  for c_msg in (select nf.glb_rota_codigo,
                       nf.con_conhecimento_codigo,
                       nf.con_conhecimento_serie,
                       nf.con_nftransportada_numnfiscal,
                       nf.glb_cliente_cgccpfcodigo,
                       nf.con_nftransportada_serienf,
                       count(*)
                from tdvadm.t_con_nftransporta nf
                where 0 = 0
                group by nf.glb_rota_codigo,
                         nf.con_conhecimento_codigo,
                         nf.con_conhecimento_serie,
                         nf.con_nftransportada_numnfiscal,
                         nf.glb_cliente_cgccpfcodigo,
                         nf.con_nftransportada_serienf
                having count(*) > 1)
  Loop
     i := null;
     If tdvadm.f_enumerico(c_msg.con_nftransportada_serienf) = 'S' Then
        for c_msg1 in (select nf.glb_rota_codigo,
                              nf.con_conhecimento_codigo,
                              nf.con_conhecimento_serie,
                              nf.con_nftransportada_numnfiscal,
                              nf.glb_cliente_cgccpfcodigo,
                              nf.con_nftransportada_serienf,
                              nf.rowid
                       from tdvadm.t_con_nftransporta nf
                       where 0 = 0
                         and nf.glb_rota_codigo               = c_msg.glb_rota_codigo
                         and nf.con_conhecimento_codigo       = c_msg.con_conhecimento_codigo
                         and nf.con_conhecimento_serie        = c_msg.con_conhecimento_serie
                         and nf.con_nftransportada_numnfiscal = c_msg.con_nftransportada_numnfiscal
                         and nf.glb_cliente_cgccpfcodigo      = c_msg.glb_cliente_cgccpfcodigo
                       order by nf.con_nftransportada_serienf)
         Loop
            If i is null Then
               i := c_msg1.con_nftransportada_serienf;
            Else
               i := i + 1;
               update tdvadm.t_con_nftransporta nf
                  set nf.con_nftransportada_serienf = i
               where 0 = 0
                 and nf.rowid = c_msg1.rowid;
            End If;   
         End Loop;
         commit;
      End If;
  End Loop;
  commit;
  execute immediate ('alter trigger TG_BDIU_TRAVACTRCNF_DATALIVRO enable');

end;
0
3
i
c_msg.con_nftransportada_serienf
c_msg1.con_nftransportada_serienf
