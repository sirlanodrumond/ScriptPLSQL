select * from tdvadm.t_slf_calculo c where c.slf_tpcalculo_codigo = '041' and c.slf_reccust_codigo = 'S_ALICMS';
select * from tdvadm.t_slf_formula;
select * from tdvadm.t_slf_seqcalculo;
select * from tdvadm.t_slf_tpcalculo;
select * from tdvadm.t_slf_reccust rc where rc.slf_reccust_codigo = 'S_ALICMS'




I_BSCLICMS -- Base de Calculo do ICMS
S_ALICMS   -- Aliquota interestadual da viagem
S_ALINTUFF -- Aliquota interna do estado de Destino
S_BSPAICMS -- Base do Icms para a Partilha
S_PERUFINI -- 20% Aliquota da Partilha UF Origem
S_PARUFINI -- Valor da Partilha UF Origem
S_PERUFFIM -- 80% Aliquota da Partilha UF Destino
S_PARUFFIM -- Valor da Partilha UF Fim
S_PERPROB  -- Percentual da Pobreza por estado
S_PARPROB  -- Valor da Partilha da Pobreza

Calculo:
   S_ALINTUFF := -- Pesquisa na tabela t_slf_icms
   S_PERUFINI := 20;
   S_PERUFFIM := 80;
   S_PERPROB  := -- Pesquisa na tabela t_glb_estado
   S_BSPAICMS := round(I_BSCLICMS * ( S_ALINTUFF / 100) - I_BSCLICMS,2);
   S_PARUFINI := round(S_BSPAICMS * ( S_PERUFINI / 100),2);
   S_PARUFFIM := round(S_BSPAICMS * ( S_PERUFFIM / 100),2);
   S_PARPROB  := -- Não sei ainda
   

--Criar na tabela tdvadm.T_GLB_ESTADO coluna do Percentual da Pobreza
-- Add/modify columns 
alter table TDVADM.T_GLB_ESTADO add GLB_ESTADO_PERCTPOBREZA number;
-- Add comments to the columns 
comment on column TDVADM.T_GLB_ESTADO.GLB_ESTADO_PERCTPOBREZA
  is 'Percentual para a Partilha da Pobreza no Diferencial de Aliquota';
  
--Criar na tabela tdvadm.T_GLB_CLIENTE coluna OPTANTE DO SIMPLES
-- Add/modify columns 
alter table TDVADM.T_GLB_CLIENTE add GLB_CLIENTE_OPTSIMPLES char(1) default 'N';
-- Add comments to the columns 
comment on column TDVADM.T_GLB_CLIENTE.GLB_CLIENTE_OPTSIMPLES
  is 'Indica se o Cliente e ou nao Optante do Simples';

update tdvadm.t_glb_estado e set e.glb_estado_perctpobreza = 2 where e.glb_estado_codigo = 'RJ';  
update tdvadm.t_glb_estado e set e.glb_estado_perctpobreza = 1 where e.glb_estado_codigo = 'AL';  
commit;


Ordem de Consulta:
   Verificar IE do Destinatario é ISENTO
Se Nao
   Verificar de se Destinatario e Não Contribuinte
Se Nao
   Verificar se Destinatario e Optante do Simples   

criarei uma proc:
  tdvadm.Procedure sp_Partilha(pCte   in tdvadm.t_con_conhecimento.con_conhecimento_codigo%type,
                               pSerie in tdvadm.t_con_conhecimento.con_conhecimento_serie%type,
                               pRota  in tdvadm.t_con_conhecimento.glb_rota_codigo%type,
                               pStatus out char(1),
                               pMessage out varchar2);
                               

  

alter trigger tdvadm.TG_CALCCONHEC_DEDODURO

       Select c.con_conhecimento_dtembarque,
              c.con_conhecimento_codigo,
              c.con_conhecimento_serie,
              c.glb_rota_codigo,
              lo.glb_estado_codigo,
              ld.glb_estado_codigo,
              c.glb_cliente_cgccpfdestinatario,
              cs.glb_grupoeconomico_codigo gruposac,
              'exec tdvadm.pkg_fifo_carregctrc.sp_partilha(''' ||  c.con_conhecimento_codigo || ''',''' || c.con_conhecimento_serie || ''',''' || c.glb_rota_codigo || ''',pstatus => :pstatus,pmessage => :pmessage)' script             
--       select max(c.con_conhecimento_dtembarque)       
       from tdvadm.t_con_conhecimento c
            ,tdvadm.t_glb_localidade lo,
            tdvadm.t_glb_localidade ld,
            tdvadm.t_glb_cliend ce,
            tdvadm.t_glb_cliente cs
       where c.con_conhecimento_dtembarque >= '11/04/2018'
         and c.con_conhecimento_localcoleta = lo.glb_localidade_codigo
         and c.con_conhecimento_localentrega = ld.glb_localidade_codigo
         and c.glb_cliente_cgccpfdestinatario = ce.glb_cliente_cgccpfcodigo
         and c.glb_tpcliend_codigodestinatari = ce.glb_tpcliend_codigo
         and c.glb_cliente_cgccpfsacado = cs.glb_cliente_cgccpfcodigo
         and ce.glb_cliend_ie = 'ISENTO'
--         and cs.glb_grupoeconomico_codigo = '0020'
         and c.con_conhecimento_flagcancelado is null
         and lo.glb_estado_codigo <> ld.glb_estado_codigo
         and 0 < (select ca.con_calcviagem_valor
                  from tdvadm.t_con_calcconhecimento ca
                  where ca.con_conhecimento_codigo = c.con_conhecimento_codigo
                    and ca.con_conhecimento_serie = c.con_conhecimento_serie
                    and ca.glb_rota_codigo = c.glb_rota_codigo
                    and ca.slf_reccust_codigo = 'I_BSCLICMS');    

select *
from tdvadm.t_slf_icms i
where i.glb_estado_codigoorigem = 'SP'
  and i.glb_estado_codigodestino = 'SP'
  



select *
from tdvadm.t_con_calcconhecimento ca
where ca.con_conhecimento_codigo = '939603'
  and ca.glb_rota_codigo = '197'
  


select * from tdvadm.t_glb_centrocusto cc
where cc.glb_centrocusto_codigo = '4197'
for update;
select *
from tdvadm.t_glb_rota r
where r.glb_rota_codigo in ('197','187')
for update;
select *
from tdvadm.t_arm_armazem a
where a.arm_armazem_codigo = '07'
for update
  


select *
from tdvadm.t_slf_icms i
where i.glb_estado_codigoorigem = 'SP'
  and i.glb_estado_codigodestino = 'SP'
  
  



  
  and 0 = (select count(*)
           from tdvadm.t_con_conhecimento c
           where c.glb_rota_codigo = r.glb_rota_codigo)
           
