-- IMPOSTOS SINTETICIO
select i.CPF,
       i.NOME,
       i.FRETE,
       i.PEDAGIO,
       i.FRETESP,
       i.INSS,
       i.IR,
       i.SESTSENAT2,
       ((i.FRETESP * 0.20 ) * 0.025) sestsenatcalc,
       i.QTDE
from tdvadm.v_ctb_impostos i
where i.REF1 = '202107'
  and length(trim(i.cpf)) = 11
--  and i.CPF = '03367232963'
  and ( i.INSS >= 671 );
  
-- IMPOSTOS ANALITICO 
select CADASTRO,
       DIGV,
       VF,
       ROTA  ,
       SQ  ,
       ia.con_catvalefrete_codigo categoria,
       ia.impresso,
       CPF ,
       NOME  ,
       DT,
       FRETEBRUTO,
       FRETE,
       PEDAGIO,
       FRETESP,
       IR, 
       INSS,
       (FRETESP * 0.005) SESTSENATCALC,
       SESTSENATRET
from tdvadm.v_ctb_impostosanalitico ia
where ia.REF1 = '202107'
  and trim(ia.cpf) in (select trim(i.CPF)
                 from tdvadm.v_ctb_impostos i
                 where i.REF1 = '202107'
                   and i.CPF = '13564903879'
                   --and length(trim(i.cpf)) = 11
                   and ( i.INSS >= 671 ))
order by ia.cpf,ia.cadastro  ;
 

select h.con_conhecimento_codigo,
       h.con_conhecimento_serie,
       h.con_viagem_numero,
       h.glb_rota_codigo,
       h.con_valefrete_saque,
       h.arm_valefretehist_gravacao,
       h.con_valefrete_frete,
       h.con_valefrete_pedagio,
       h.con_valefrete_irrf,
       h.con_valefrete_inss,
       h.con_valefrete_sestsenat,
       nvl(h.con_valefrete_impresso,'N') con_valefrete_impresso,
       h.arm_valefretehist_call_stack,


       h.con_valefrete_conhecimentos,
       h.con_valefrete_carreteiro,
       h.con_valefrete_nfs,
       h.con_valefrete_placasaque,
       h.con_valefrete_tipotransporte,
       h.con_valefrete_placa,
       h.con_valefrete_localcarreg,
       h.con_valefrete_localdescarga,
       h.con_valefrete_kmprevista,
       h.con_valefrete_pesoindicado,
       h.con_valefrete_pesocobrado,
       h.con_valefrete_entregas,
       h.con_valefrete_custocarreteiro,
       h.con_valefrete_tipocusto,
       h.con_valefrete_prazocontr,
       h.con_valefrete_obrigacoes,
       h.con_valefrete_dataprazomax,
       h.con_valefrete_horaprazomax,
       h.con_valefrete_percmulta,
       h.con_valefrete_condespeciais,
       h.con_valefrete_datacadastro,
       h.con_valefrete_emissor,
       h.con_valefrete_datachegada,
       h.con_valefrete_caixa,
       h.con_valefrete_horachegada,
       h.con_valefrete_reembolso,
       h.con_valefrete_adiantamento,
       h.con_valefrete_multa,
       h.con_valefrete_valorliquido,
       h.con_valefrete_datapagto,
       h.con_valefrete_berconf,
       h.con_valefrete_bercoqtde,
       h.con_valefrete_bercoqtdepino,
       h.con_valefrete_postorazaosocial,
       h.con_valefrete_comprovante,
       h.con_valefrete_status,
       h.glb_localidade_codigo,
       h.con_valefrete_obscaixa,
       h.pos_cadastro_cgc,
       h.glb_localidade_codigodes,
       h.acc_acontas_numero,
       h.acc_contas_ciclo,
       h.con_valefrete_datarecebimento,
       h.acc_acontas_tpdoc,
       h.con_valefrete_dataemissao,
       h.con_valefrete_valorestiva,
       h.con_valefrete_valorvazio,
       h.glb_localidade_origemvazio,
       h.glb_localidade_destinovazio,
       h.glb_localidade_codigoori,
       h.cax_boletim_data,
       h.cax_movimento_sequencia,
       h.glb_rota_codigocx,
       h.con_valefrete_valorrateio,
       h.con_valefrete_lotacao,
       h.con_valefrete_valorcomdesconto,
       h.con_catvalefrete_codigo,
       h.glb_tpmotorista_codigo,
       h.con_valefrete_enlonamento,
       h.con_valefrete_estadia,
       h.con_valefrete_outros,
       h.frt_conjveiculo_codigo,
       h.frt_movvazio_numero,
       h.glb_rota_codigovazio,
       h.usu_usuario_codigo,
       h.usu_usuario_codigovalidador,
       h.con_valefrete_pgvpedagio,
       h.con_valefrete_cofins,
       h.con_valefrete_csll,
       h.con_valefrete_pis,
       h.con_valefrete_avaria,
       h.usu_usuario_codigo_autoriza,
       h.con_valefrete_dtautoriza,
       h.con_valefrete_dtchegcelula,
       h.con_valefrete_adtanterior,
       h.con_conhecimento_codigoch,
       h.con_conhecimento_seriech,
       h.glb_rota_codigoch,
       h.con_valefrete_saquech,
       h.con_valefretedet_seq,
       h.usu_usuario_codalteracao,
       h.con_valefrete_pedpgcli,
       h.con_valefrete_dep,
       h.con_valefrete_dtcheckin,
       h.con_valefrete_dtgravcheckin,
       h.con_valefrete_dthoraimpressao,
       h.con_valefrete_fifo,
       h.con_valefrete_descbonus,
       h.con_valefrete_obs,
       h.glb_rota_codigoapresent,
       h.glb_rota_codigoapresentold,
       h.usu_usuario_codigortapresent,
       h.con_valefrete_percetdes,
       h.con_subcatvalefrete_codigo,
       h.fcf_fretecar_rowid,
       h.fcf_veiculodisp_codigo,
       h.fcf_veiculodisp_sequencia,
       h.glb_localidade_codigopasspor,
       h.glb_cliente_cgccpfcodigo,
       h.con_valefrete_diariobordo,
       h.con_valefrete_freteoriginal,
       h.con_valefrete_qtdereimp,
       h.con_valefrete_forcatarifa,
       h.con_valefrete_optsimples,
       h.con_valefrete_docref,
       h.arm_valefretehist_ip,
       h.arm_valefretehist_computador,
       h.arm_valefretehist_osuser,
       h.arm_valefretehist_program,
       h.con_valefrete_pedagiooriginal
from tdvadm.t_con_valefretehist h
where h.con_conhecimento_codigo = '649456'
  and h.glb_rota_codigo = '011'
  and h.con_valefrete_saque = '2'
order by h.arm_valefretehist_gravacao;


-- HISTORICO VALE FRETE
select distinct h.con_conhecimento_codigo vale,
       h.glb_rota_codigo rt,
       h.con_valefrete_saque sq,
       h.con_catvalefrete_codigo categ,
       h.arm_valefretehist_gravacao grav,
       h.con_valefrete_fifo fifo,
       h.con_valefrete_impresso imp
       --,h.arm_valefretehist_call_stack stack
from tdvadm.t_con_valefretehist h
where 0 = 0
--  and h.arm_valefretehist_gravacao >= to_date('21/07/2021 16:26:00','DD/MM/YYYY hh24:mi:ss')
  and h.arm_valefretehist_gravacao >= to_date('21/07/2021 17:20:00','DD/MM/YYYY hh24:mi:ss')
--  and h.con_conhecimento_codigo = '044646'
--  and h.glb_rota_codigo = '530'
  and upper(h.arm_valefretehist_call_stack) like '%SP_CON_CALCVALEFRETE%'
order by h.arm_valefretehist_gravacao desc
