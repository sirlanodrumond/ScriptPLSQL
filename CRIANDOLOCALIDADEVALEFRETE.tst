PL/SQL Developer Test script 3.0
86
-- Created on 18/07/2018 by DESENV 
declare
  vIbgeOrigem    tdvadm.t_glb_localidade.glb_localidade_codigo%type;
  vUfOrigem      tdvadm.t_glb_estado.glb_estado_codigo%type;
  vCidadeOrigem  ibge.v_glb_ibge.nomeex%type;
  vIbgeDestino   tdvadm.t_glb_localidade.glb_localidade_codigo%type;
  vUfDestino     tdvadm.t_glb_estado.glb_estado_codigo%type;
  vCidadeDestino ibge.v_glb_ibge.nomeex%type;
  vStatus        char(1);
  vMessage       varchar2(4000);
begin
  for p_cursor in (select distinct VF.glb_localidade_codigoori,
                                   VF.glb_localidade_codigodes,
                                   VF.con_conhecimento_codigo  vFrete,
                                   vf.glb_rota_codigo          rota
                     from tdvadm.t_Con_Valefrete VF
                    where VF.con_valefrete_datacadastro >= TO_DATE('01/01/2017', 'DD/MM/YYYY')
                      and length(trim(nvl(VF.glb_localidade_codigoori,'000000'))) = 5
                      and length(trim(nvl(VF.glb_localidade_codigodes,'000000'))) = 5
                      AND (select count(*)
                             from tdvadm.t_slf_percurso pp
                            where pp.glb_localidade_codigoorigem = VF.glb_localidade_codigoori
                              and pp.glb_localidade_codigodestino = VF.glb_localidade_codigodes) = 0) loop
    begin
      -- Busca de informações da localidade de Origem
      select lo.glb_localidade_codigoibge, ib.ufsigla, ib.nomeex
        into vIbgeOrigem, vUfOrigem, vCidadeOrigem
        from tdvadm.t_glb_localidade lo, ibge.v_glb_ibge ib
       where lo.glb_localidade_codigo = p_cursor.glb_localidade_codigoori
         and lo.glb_localidade_codigoibge = ib.codmun;
      -- Busca de informações da localidade de Destino
      select lo.glb_localidade_codigoibge, ib.ufsigla, ib.nomeex
        into vIbgeDestino, vUfDestino, vCidadeDestino
        from tdvadm.t_glb_localidade lo, ibge.v_glb_ibge ib
       where lo.glb_localidade_codigo = p_cursor.glb_localidade_codigodes
         and lo.glb_localidade_codigoibge = ib.codmun;
      -- inclusão do percurso
      insert into tdvadm.t_slf_percurso
        (slf_percurso_codigo,
         slf_percuso_descricao,
         glb_localidade_codigoorigem,
         glb_localidade_codigodestino,
         slf_percurso_km,
         usu_usuario_codigo,
         slf_percurso_datacadastro,
         slf_percurso_kmtdv,
         glb_localidade_codigoorigemi,
         glb_localidade_codigodestinoi,
         slf_percurso_flagcons)
      values
        (trim(p_cursor.glb_localidade_codigoori) ||
         trim(p_cursor.glb_localidade_codigodes),
         substr(vUfOrigem || '-' || vCidadeOrigem || ' | ' || vUfDestino || '-' ||
                vCidadeDestino,
                1,
                50),
         p_cursor.glb_localidade_codigoori,
         p_cursor.glb_localidade_codigodes,
         null,
         'jsantos',
         sysdate,
         null,
         vIbgeOrigem,
         vIbgeDestino,
         'N');
    exception
      when others then
        vStatus  := 'E';
        vMessage := sqlerrm;
        wservice.pkg_glb_email.SP_ENVIAEMAIL('Erro ao cadastrar percurso ORIGEM VALE FRETE. As.: ' ||
                                             to_char(sysdate,
                                                     'dd/mm/yyyy hh24:mi:ss'),
                                             'Percurso.: ' ||
                                             trim(p_cursor.glb_localidade_codigoori) ||
                                             trim(p_cursor.glb_localidade_codigodes) ||
                                             ' Erro.: ' || vMessage,
                                             'analisedb@dellavolpe.com.br',
                                             'ksouza@dellavolpe.com.br;grp.hd@dellavolpe.com.br',
                                             'klaytonhpr@gmail.com;brunokiko91@gmail.com',
                                             'sirlanodrumond@gmail.com');
    end;
  end loop;
  vStatus  := 'N';
  vMessage := 'Processamento Normal!';
  commit;
end;
0
0
