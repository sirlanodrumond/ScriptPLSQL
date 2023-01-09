-- Cadastro de Frete na MESA

-- Add/modify columns 
alter table TDVADM.T_CAD_FRETE add SLF_CONTRATO_CODIGO varchar2(15);
alter table TDVADM.T_CAD_FRETE add CAD_FRETE_PESOESTIMADO number;
alter table TDVADM.T_CAD_FRETE add CAD_FRETE_TIPOCARGAANTT varchar2(15);
alter table TDVADM.T_CAD_FRETE add FCF_FRETECAR_ROWID number;
-- Add comments to the columns 
comment on column TDVADM.T_CAD_FRETE.SLF_CONTRATO_CODIGO
  is 'Codigo do Contrato';
comment on column TDVADM.T_CAD_FRETE.CAD_FRETE_PESOESTIMADO
  is 'Peso estimado para calculo';
comment on column TDVADM.T_CAD_FRETE.CAD_FRETE_TIPOCARGAANTT
  is 'Tipo de Carga para tabela ANTT';
comment on column TDVADM.T_CAD_FRETE.FCF_FRETECAR_ROWID
  is 'rowid usado da tabela de frete ';
    select * from tdvadm.t_cad_frete;
  select * from tdvadm.t_cad_infofrete;
  select * from tdvadm.t_cad_usuespecial;
  select * from tdvadm.t_cad_email;



select * from tdvadm.t_fcf_veiculodisp;
select * from tdvadm.t_fcf_solveic;


<Parametros>
   <Inputs>
      <Input>
         <rota>021</rota>
         <usuario>aejaraujo</usuario>
         <armazem>06</armazem>
         <contrato>C2018010119</contrato>
         <cargatdv>36</cargatdv>
         <cargaantt>PERIGOSO</cargaantt>
         <idsimulador>4148</idsimulador>
         <idsolicitacao>4148</idsolicitacao>
         <valoracrescimo>1500.00</valoracrescimo>
         <valorajudante>300.00</valorajudante>
      </Input>
      <Tables>
         <table name="infofrete" tipo="P">
            <Rowset>
               <row num="1">
                  <data>20/07/2018</data>
                  <fonte>CARRETEIRO AMIGO</fonte>
                  <valor>1400.00</valor>
                  <nome>nome teste</nome>
                  <telefone>(11)97099-9803</telefone>
               </row>
            </Rowset>
         </table>
      </Tables>
   </Inputs>
</Parametros>





select V.CON_CONHECIMENTO_CODIGO VF,
       V.GLB_ROTA_CODIGO RT,
       V.GLB_LOCALIDADE_CODIGOORI,
       V.GLB_LOCALIDADE_CODIGODES,
       V.CON_VALEFRETE_KMPREVISTA,
       (SELECT MAX(P.SLF_PERCURSO_KM)
        FROM TDVADM.T_SLF_PERCURSO P
        WHERE P.GLB_LOCALIDADE_CODIGOORIGEM = V.GLB_LOCALIDADE_CODIGOORI
          AND P.GLB_LOCALIDADE_CODIGODESTINO = V.GLB_LOCALIDADE_CODIGODES) KMPERC
from tdvadm.t_con_valefrete v
where v.con_conhecimento_codigo = '082061'
  and v.glb_rota_codigo = '036';

SELECT IP.CON_VALEFRETE_CODIGO VF,
       IP.GLB_ROTA_CODIGO_VALEFRETE RT,
       IP.CON_CONHECIMENTO_SACADO,
       IP.GLB_LOCALIDADE_CODIGO_VLFORI ,
       IP.GLB_LOCALIDADE_CODIGO_VLFDES,
       IP.CON_CONHECIMENTO_KILOMETRAGEM,
       IP.CON_VALEFRETE_KMPREVISTA,
       IP.CON_VALEFRETE_KMPERCURSO,
       IP.CON_VALEFRETE_KMCALCULO,
       IP.CON_VALEFRETE_KMCALCULO_SOMA,
       IP.CON_VALEFRETE_KMCALCULO_SOMA2
FROM TDVIPF.T_IPF_RECCUST_DIRETOS IP
WHERE 0 = 0
  and nvl(IP.CON_VALEFRETE_KMCALCULO,0) = 0
  and IP.CON_VALEFRETE_CODIGO = '082061'
  AND IP.GLB_ROTA_CODIGO_VALEFRETE = '036';
  
select * from tdvadm.t_slf_percurso p
where p.slf_percurso_codigo in ('3200137100')
 for update;
select *
from tdvadm.t_glb_localidade l
where l.glb_localidade_codigo in ('32001','37100') ;
   
  
  select * from tdvadm.t_slf_percurso p
  where p.glb_localidade_codigoorigem = '20000'
    and p.glb_localidade_codigodestino = '86968'
    
  
UPDATE TDVIPF.T_IPF_RECCUST_DIRETOS IP  
  SET IP.CON_VALEFRETE_KMCALCULO = TDVADM.PKG_FIFO_CARREGCTRC.fn_ConsultaKM(IP.GLB_LOCALIDADE_CODIGO_VLFORI,IP.GLB_LOCALIDADE_CODIGO_VLFDES)
WHERE NVL(IP.CON_VALEFRETE_KMCALCULO,0) = 0;
COMMIT;

UPDATE TDVIPF.T_IPF_RECCUST_DIRETOS IP  
  SET IP.CON_VALEFRETE_KMPREVISTA = IP.CON_VALEFRETE_KMCALCULO,
      IP.CON_VALEFRETE_KMPERCURSO = IP.CON_VALEFRETE_KMCALCULO
WHERE NVL(IP.CON_VALEFRETE_KMPERCURSO,0) = 0;
COMMIT;

SELECT COUNT(*)
FROM TDVIPF.T_IPF_RECCUST_DIRETOS IP 
WHERE NVL(IP.CON_VALEFRETE_KMCALCULO,0) <> 0;

35869

  SELECT * FROM TDVADM.T_FCF_TPCARGA
  

Select  d.con_conhecimento_referencia referencia,
        d.con_valefrete_cadastro cadastroVF,
        d.con_valefrete_codigo vfrete,
        d.glb_rota_codigo_valefrete rtvfrete,
        d.con_valefrete_saque sq,
        d.con_conhecimento_data_emissao emissao,
        d.con_conhecimento_codigo cte,
        d.glb_rota_codigo_conhecimento rt,
        d.ipf_vfrete_rat_fretesp ratrio
from tdvipf.t_ipf_reccust_diretos d
where 0 =0
--  and d.con_conhecimento_codigo >= '088906'
--  and d.con_conhecimento_codigo <= '088907'
--  and d.glb_rota_codigo_conhecimento = '157'
  and d.con_valefrete_codigo = '861397'
  and d.glb_rota_codigo_valefrete = '021'
--  and d.con_valefrete_codigo = '075616'
--  and d.glb_rota_codigo_valefrete = '036'

for update
    
  and d.con_valefrete_saque = '1';
  
  
exec tdvipf.pkg_reccust_diretos.SP_AJUSTA_RECCUST('201802');
exec tdvipf.pkg_reccust_diretos.SP_AJUSTA_RECCUST('201803');



select last_day('01/01/2018') FROM DUAL;


exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/06/2018',last_day('01/06/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/05/2018',last_day('01/05/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/04/2018',last_day('01/04/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/03/2018',last_day('01/03/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/02/2018',last_day('01/02/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/01/2018',last_day('01/01/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/12/2017',last_day('01/12/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/11/2017',last_day('01/11/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/10/2017',last_day('01/10/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/09/2017',last_day('01/09/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/08/2017',last_day('01/08/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/07/2017',last_day('01/07/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/06/2017',last_day('01/06/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/05/2017',last_day('01/05/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/04/2017',last_day('01/04/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/03/2017',last_day('01/03/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/02/2017',last_day('01/02/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCAR('01/01/2017',last_day('01/01/2017'));



exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/06/2018',last_day('01/06/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/05/2018',last_day('01/05/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/04/2018',last_day('01/04/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/03/2018',last_day('01/03/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/02/2018',last_day('01/02/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/01/2018',last_day('01/01/2018'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/12/2017',last_day('01/12/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/11/2017',last_day('01/11/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/10/2017',last_day('01/10/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/09/2017',last_day('01/09/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/08/2017',last_day('01/08/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/07/2017',last_day('01/07/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/06/2017',last_day('01/06/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/05/2017',last_day('01/05/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/04/2017',last_day('01/04/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/03/2017',last_day('01/03/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/02/2017',last_day('01/02/2017'));
exec tdvipf.pkg_reccust_diretos.SP_ATUALIZA_CUSTOCARFROTA('01/01/2017',last_day('01/01/2017'));
