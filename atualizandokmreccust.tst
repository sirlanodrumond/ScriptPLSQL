PL/SQL Developer Test script 3.0
52
-- Created on 10/03/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
begin
  :vRegistros := 0;
  for c_msg in (select vf.ipf_valefrete_chave,
                       vf.con_catvalefrete_descricao,
                       vf.ipf_valefrete_origem,
                       vf.ipf_valefrete_destino,
                       RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_origem,'IBC'),8) origemib,
                       RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_destino,'IBC'),8) destinoib,
                       vf.ipf_valefrete_kmperc,
                       (select count(*)
                        from tdvadm.t_slf_percurso p
                        where p.glb_localidade_codigoorigemi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_origem,'IBC'),8)
                          and p.glb_localidade_codigodestinoi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_destino,'IBC'),8)) QTDEkmperc,
                       (select max(nvl(p.slf_percurso_km,0))
                        from tdvadm.t_slf_percurso p
                        where p.glb_localidade_codigoorigemi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_origem,'IBC'),8)
                          and p.glb_localidade_codigodestinoi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_destino,'IBC'),8)) kmperc,
                        (select vf1.con_valefrete_kmprevista
                         from tdvadm.t_con_valefrete vf1
                         where vf1.con_conhecimento_codigo = vf.ipf_valefrete_codigo
                           and vf1.con_conhecimento_serie = vf.ipf_valefrete_serie
                           and vf1.glb_rota_codigo = vf.ipf_valefrete_rota
                           and vf1.con_valefrete_saque = vf.ipf_valefrete_saque ) kmvfrete,
                        vf.rowid
                from tdvipf.t_ipf_valefrete vf
                where vf.ipf_valefrete_kmperc <> (select max(nvl(p.slf_percurso_km,0))
                                                  from tdvadm.t_slf_percurso p
                                                  where p.glb_localidade_codigoorigemi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_origem,'IBC'),8)
                                                    and p.glb_localidade_codigodestinoi = RPAD(tdvadm.fn_busca_codigoibge(vf.ipf_valefrete_destino,'IBC'),8))
                 -- and vf.ipf_valefrete_chave = '009422A10602'
                  and vf.con_catvalefrete_codigo not in ('02', --Várias Viagens
                                                         '08', --Avulso (Despesa TDV)
                                                         '14', --Bônus CTRC
                                                         '17', --Estadia
                                                         '18', -- Coleta
                                                         '10') --Serviço de Terceiro
                )
   Loop
     :vRegistros := :vRegistros + 1; 
     If nvl(c_msg.kmperc,0) > 0 Then
        update tdvipf.t_ipf_valefrete vv
          set vv.ipf_valefrete_kmperc = c_msg.kmperc
        where vv.rowid = c_msg.rowid;
        commit;
     End If;
      
   End loop;  
end;
1
vRegistros
0
3
0
