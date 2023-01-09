-- Verifica e Gera Script para arrumar a matricula do Frota no Vale
select distinct --x.frt_motorista_dtdesligamento, 
       x.frt_motorista_codigo,
       x.ultcod,
       (select m.frt_motorista_matricula from tdvadm.t_frt_motorista m where m.frt_motorista_codigo = x.ultcod) matricula,
       'update tdvadm.t_acc_vales v3 set v3.frt_motorista_codigo = ''' || ultcod || ''' where v3.rowid = ''' || rowid || ''';' script
from (select v.acc_vales_data,
             v.acc_vales_numero,
             v.glb_rota_codigo,
             v.acc_vales_valor,
             v.frt_motorista_codigo,
             (select max(m2.frt_motorista_codigo)
              from tdvadm.t_frt_motorista m2
              where m2.frt_motorista_cpf = m.frt_motorista_cpf
                and m2.frt_motorista_dtdesligamento is null) ultcod,
             m.frt_motorista_nome,
             m.frt_motorista_dtdesligamento ,
             m.frt_motorista_matricula,
             v.rowid      
      from tdvadm.t_acc_vales v,
           tdvadm.t_frt_motorista m
      where v.acc_acontas_numero is null
        and v.frt_motorista_codigo = m.frt_motorista_codigo ) x
where x.frt_motorista_codigo <>  x.ultcod   ;

update tdvadm.t_acc_vales v3 set v3.frt_motorista_codigo = '0550' where v3.rowid = 'AAA/FrAB8AACNttAAS';


select *
from fpw.situacao s
where s.stcodsitu in (9,16);
select f.fucodsitu,f.*
from fpw.funciona f
where f.funomfunc = 'JOSE CLAUDIO MONTEIRO';
select *
from tdvadm.t_frt_motorista m
where m.frt_motorista_nome = 'JOSE CLAUDIO MONTEIRO';



-- Verificando saldo
SELECT * FROM TDVADM.V_JOB_TODOS T WHERE UPPER(T.WHAT) LIKE '%SALDO%';

select * from dba_source s where upper(s.TEXT) like '%CONTARA%';


  SELECT VF.CON_VALEFRETE_DATACADASTRO cadastro,
         VF.CON_CONHECIMENTO_CODIGO vfrete,
         VF.CON_CONHECIMENTO_SERIE sr,
         VF.GLB_ROTA_CODIGO rota,
         VF.CON_VALEFRETE_SAQUE sq,
         vf.con_valefrete_placa placa,
         vf.con_valefrete_placasaque psaque,
         VF.GLB_TPMOTORISTA_CODIGO tpmot,
         VF.CON_VALEFRETE_PEDAGIOORIGINAL pedori,
         VF.CON_VALEFRETE_PEDAGIO pedi,
         VF.CON_VALEFRETE_PEDPGCLI PEDPGCLI,
         VF.CON_VALEFRETE_PGVPEDAGIO PGVPEDAGIO,
         VF.CAX_BOLETIM_DATA,
         VF.CON_VALEFRETE_STATUS,
         tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'ANTT') tipo,
         tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'CNPJ') CPFCNPJ,
         tdvadm.Pkg_Car_Proprietario.fn_RetornaSaldocc(tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'CNPJ')) Saldo  
  FROM TDVADM.T_CON_VALEFRETE VF
  WHERE VF.CON_VALEFRETE_DATACADASTRO >= '01/01/2022'
    AND VF.CON_VALEFRETE_PEDAGIOORIGINAL > 0
    AND VF.CON_VALEFRETE_PEDAGIO = 0
    and VF.GLB_TPMOTORISTA_CODIGO not in ('F')
    AND VF.CAX_BOLETIM_DATA IS NOT NULL
    AND NVL(VF.CON_VALEFRETE_STATUS,'X') = 'X'
    AND NVL(VF.CON_VALEFRETE_PEDPGCLI,'N') = 'N';
    



tdvadm.pkg_fifo_carregctrc;

select *
from tdvadm.t_con_loggeracao lg
where lg.arm_carregamento_codigo = '4169507'
order by 1


 SELECT nvl(SUM(NVL(N.ARM_NOTA_PESO, 0)), 0) +
        nvl(max(NVL(CI.arm_coletaimpexp_contara, 0)), 0) peso,
        nvl(SUM(NVL(N.ARM_NOTA_PESO, 0)), 0) sonota,
        nvl(max(NVL(CI.arm_coletaimpexp_contara, 0)), 0) sotara, 
        nvl(SUM(NVL(N.ARM_NOTA_VALORMERC, 0)), 0) VlrMerc
   FROM TDVADM.T_ARM_CARREGAMENTODET CD,
        TDVADM.T_ARM_CARREGAMENTO    CA,
        TDVADM.T_FCF_VEICULODISP     VD,
        TDVADM.T_ARM_EMBALAGEM       E,
        TDVADM.T_ARM_CARGADET        CCD,
        TDVADM.T_ARM_NOTA            N,
        TDVADM.T_GLB_CLIEND          ECR,
        TDVADM.T_GLB_CLIEND          ECD,
        TDVADM.T_GLB_CLIENTE         CLS,
        TDVADM.T_GLB_CLIENTE         CLR,
        TDVADM.T_GLB_CLIENTE         CLD,
        TDVADM.T_GLB_ONU             O,
        TDVADM.T_ARM_COLETA          C,
        TDVADM.T_ARM_COLETAIMPEXP    CI,
        TDVADM.T_ARM_COLETAPART      X,
        TDVADM.T_ARM_JANELACONS      JC
  WHERE CD.ARM_CARREGAMENTO_CODIGO = '4169507'
    AND CD.ARM_CARREGAMENTO_CODIGO = CA.ARM_CARREGAMENTO_CODIGO
    AND CA.ARM_ARMAZEM_CODIGO = '42'
    AND CA.FCF_VEICULODISP_CODIGO = VD.FCF_VEICULODISP_CODIGO
    AND CA.FCF_VEICULODISP_SEQUENCIA = VD.FCF_VEICULODISP_SEQUENCIA
    AND VD.FCF_VEICULODISP_DATA >= SYSDATE - 30
    AND N.ARM_COLETA_NCOMPRA = C.ARM_COLETA_NCOMPRA
    AND N.ARM_COLETA_CICLO = C.ARM_COLETA_CICLO
    AND N.ARM_COLETA_NCOMPRA = CI.ARM_COLETA_NCOMPRA(+)
    AND N.ARM_COLETA_CICLO = CI.ARM_COLETA_CICLO(+)
    AND N.ARM_COLETA_NCOMPRA = X.ARM_COLETA_NCOMPRA(+)
    AND N.ARM_COLETA_CICLO = X.ARM_COLETA_CICLO(+)
    AND N.ARM_JANELACONS_SEQUENCIA = JC.ARM_JANELACONS_SEQUENCIA(+)
    AND CD.ARM_EMBALAGEM_NUMERO = E.ARM_EMBALAGEM_NUMERO
    AND CD.ARM_EMBALAGEM_FLAG = E.ARM_EMBALAGEM_FLAG
    AND CD.ARM_EMBALAGEM_SEQUENCIA = E.ARM_EMBALAGEM_SEQUENCIA
    AND CCD.ARM_EMBALAGEM_NUMERO = E.ARM_EMBALAGEM_NUMERO
    AND CCD.ARM_EMBALAGEM_FLAG = E.ARM_EMBALAGEM_FLAG
    AND CCD.ARM_EMBALAGEM_SEQUENCIA = E.ARM_EMBALAGEM_SEQUENCIA
    AND CCD.ARM_NOTA_NUMERO = N.ARM_NOTA_NUMERO
    AND N.ARM_CARGA_CODIGO = CCD.ARM_CARGA_CODIGO
    AND CCD.ARM_CARGA_CODIGO IS NOT NULL
    AND trim(N.GLB_CLIENTE_CGCCPFREMETENTE) =
        trim(CCD.GLB_CLIENTE_CGCCPFREMETENTE(+))
    AND E.ARM_EMBALAGEM_DTFECHADO IS NOT NULL
    AND RPAD(N.GLB_CLIENTE_CGCCPFSACADO, 20) =
        CLS.GLB_CLIENTE_CGCCPFCODIGO(+)
    AND RPAD(N.GLB_CLIENTE_CGCCPFDESTINATARIO, 20) =
        CLD.GLB_CLIENTE_CGCCPFCODIGO(+)
    AND RPAD(N.GLB_CLIENTE_CGCCPFREMETENTE, 20) =
        CLR.GLB_CLIENTE_CGCCPFCODIGO(+)
    AND RPAD(N.GLB_CLIENTE_CGCCPFREMETENTE, 20) =
        ECR.GLB_CLIENTE_CGCCPFCODIGO
    AND N.GLB_TPCLIEND_CODREMETENTE = ECR.GLB_TPCLIEND_CODIGO
    AND RPAD(N.GLB_CLIENTE_CGCCPFDESTINATARIO, 20) =
        ECD.GLB_CLIENTE_CGCCPFCODIGO
    AND N.GLB_TPCLIEND_CODDESTINATARIO = ECD.GLB_TPCLIEND_CODIGO
    AND RPAD(E.GLB_CLIENTE_CGCCPFDESTINATARIO, 20) =
        ECD.GLB_CLIENTE_CGCCPFCODIGO
    AND N.ARM_NOTA_ONU = O.GLB_ONU_CODIGO(+)
    AND NVL(N.ARM_NOTA_GRPEMB, 'SE') = O.GLB_ONU_GRPEMB(+)
    AND N.ARM_NOTA_SEQUENCIA =
        (SELECT MAX(OO.ARM_NOTA_SEQUENCIA)
           FROM TDVADM.T_ARM_NOTA OO
          WHERE OO.ARM_NOTA_NUMERO = N.ARM_NOTA_NUMERO
            AND OO.GLB_CLIENTE_CGCCPFREMETENTE =
                N.GLB_CLIENTE_CGCCPFREMETENTE)
    AND (N.CON_CONHECIMENTO_CODIGO IS NULL AND
        0 =
        (SELECT COUNT(*)
            FROM TDVADM.T_ARM_NOTACTE NDOC
           WHERE NDOC.ARM_NOTA_NUMERO = N.ARM_NOTA_NUMERO
             AND NDOC.GLB_CLIENTE_CGCCPFREMETENTE =
                 RPAD(N.GLB_CLIENTE_CGCCPFREMETENTE, 20)
             AND NDOC.ARM_NOTA_SERIE = N.ARM_NOTA_SERIE
             AND NDOC.CON_CONHECIMENTO_CODIGO IS NULL
             AND NDOC.ARM_NOTACTE_CODIGO in ('DE', 'RE', 'CC', 'RR')))
    AND nvl(N.SLF_CONTRATO_CODIGO, '999999999999999') = 'C2013010022'
    AND N.GLB_CLIENTE_CGCCPFSACADO = '59104422009882'
    AND N.GLB_CLIENTE_CGCCPFDESTINATARIO = '59104422009882'
    AND C.ARM_COLETA_ENTCOLETA = 'C'
    AND N.ARM_NOTA_LOCALCOLETAL = '11400'
    AND N.ARM_NOTA_LOCALENTREGAL = '13560'
    AND C.FCF_TPCARGA_CODIGO = '24'

;



  

select *
from tdvadm.t_grd_parametrodet x
where upper(x.grd_parametrodet_textosql) like '%FRT%';



select m.frt_motorista_matricula,
       m.frt_motorista_codigo,
       m.frt_motorista_cpf,
       m.frt_motorista_nome,
       m.frt_motorista_dtdesligamento
from tdvadm.t_frt_motorista m
where m.frt_motorista_cpf <> '00000000000   '
  and 1 < (select count(*)
           from tdvadm.t_frt_motorista m1
           where m1.frt_motorista_cpf = m.frt_motorista_cpf)
order by m.frt_motorista_cpf,
         m.frt_motorista_codigo desc;
          
         

                 

Select sum(p.car_contacorrente_saldo)
 --       into tpVF.vAuxiliar
      FROM v_Car_Contacorrente P
      WHERE trim(p.cpncnpjprop) = trim('52706087820         ')
        and p.dtfecha is Null
        and trunc(p.dtvenc) <= trunc(sysdate)
        And p.car_contacorrente_saldo > 0
        And p.car_contacorrente_saldo = (Select Min(p1.car_contacorrente_saldo)
                                         From v_Car_Contacorrente P1
                                         WHERE trim(p1.cpncnpjprop) = trim(p.cpncnpjprop)
                                           And p1.documento = p.documento
                                           and trunc(p1.dtvenc) <= trunc(sysdate)
                                           and p.dtfecha is Null )
      Order By P.car_contacorrente_dtgravacao;
        
        select c.car_contacorrente_valor * (decode(c.car_contacorrente_tplanc,'D',1,-1))
        from v_car_contacorrente c
        where c.cpncnpjprop = rpad('52706087820',20) 
        -- 11/03/2022 - Sirlano
        -- Inclui o Vencimento
          and trunc(c.DTVENC) <= trunc(sysdate)  ;
          
          


select c.con_conhecimento_dtembarque embarque,
       c.con_conhecimento_codigo cte,
       c.con_conhecimento_serie sr,
       c.glb_rota_codigo rt,
       substr(tdvadm.fn_busca_codigoibge(r.glb_localidade_codigo,'IBD'),1,2) Rota,
       substr(tdvadm.fn_busca_codigoibge(c.glb_localidade_codigoorigem,'IBD'),1,2) origem,
       substr(tdvadm.fn_busca_codigoibge(c.glb_localidade_codigodestino,'IBD'),1,2) destino,
       c.con_conhecimento_cfo cfop,
       c.con_conhecimento_cst cst,
       c.con_conhecimento_tributacao trib,
       c.con_conhecimento_obslei obslei,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_BSCLICMS') Base,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'S_ALICMS') aliquota,
       tdvadm.fn_busca_conhec_verba(c.con_conhecimento_codigo,c.con_conhecimento_serie,c.glb_rota_codigo,'I_VLICMS') ValorICMS
from tdvadm.t_con_conhecimento c,
     tdvadm.t_glb_rota r
where 0 = 0
  and c.glb_rota_codigo = r.glb_rota_codigo
  and c.con_conhecimento_dtembarque >= '01/01/2021'
  and c.con_conhecimento_tributacao = 'F'
  and c.con_conhecimento_codigo = '233442'
  and c.glb_rota_codigo = '160';
  
  
  tdvadm.pkg_con_valefrete
  select *
  from tdvadm.t_con_calcvalefrete vf
  where vf.con_conhecimento_codigo = '089208'
    and vf.glb_rota_codigo = '060'
    and vf.con_calcvalefrete_valor <> 0
    for update
    
    


select n.*
  from tdvadm.t_arm_nota n,
       tdvadm.t_glb_cliente c,
       tdvadm.t_arm_notapesagemitem np
where 0=0
   and n.arm_nota_sequencia = np.arm_nota_sequencia                           
   and trim(n.glb_cliente_cgccpfsacado) = trim(c.glb_cliente_cgccpfcodigo)
   and c.glb_grupoeconomico_codigo = '0752'
  --and n.arm_nota_sequencia = '6710373'
   and n.arm_nota_dtinclusao >= sysdate - 3;
   
   select * from tdvadm.t_slf_clientecargas cc
   where cc.glb_grupoeconomico_codigo = '0752'
   for update
      
select *
from tdvadm.t_slf_contrato c
where c.slf_contrato_codigo in ('C2021112601','C2021120004');

select cc.fcf_tpcarga_codigo,cc.slf_clientecargas_procedure from tdvadm.t_slf_clientecargas cc
--where cc.slf_contrato_codigo = 'C2021112601'  -- MRO-BRASKEM-1121-XXX
where cc.slf_contrato_codigo = 'C2021120004'  -- MRO-MRV-1221-XXX
  and cc.slf_clientecargas_ativo = 'S'
  and cc.slf_clientecargas_vigencia = (select max(cc1.slf_clientecargas_vigencia)
                                       from tdvadm.t_slf_clientecargas cc1
                                       where cc1.glb_grupoeconomico_codigo = cc.glb_grupoeconomico_codigo
                                         and cc1.glb_cliente_cgccpfcodigo = cc.glb_cliente_cgccpfcodigo
                                         and cc1.slf_contrato_codigo = cc.slf_contrato_codigo
                                         and cc1.slf_clientecargas_ativo = 'S')
for update
   
select *
from tdvadm.v_slf_clientecargas2 c
where c.SLF_CONTRATO_CODIGO = 'C2021120004' 

tdvadm.pkg_fifo_carregctrc
    
    C2021120004 regra de MAIOR PESO, comparação tipos de carga 12 -FRACIONADO RE e 02 -FRACIONADO
  





select vf.con_valefrete_datacadastro dtcad,
       vf.con_conhecimento_codigo vfrete,
       vf.con_conhecimento_serie sr,
       vf.glb_rota_codigo rt,
       vf.con_valefrete_saque sq,
       vf.con_catvalefrete_codigo categ,
       vf.con_valefrete_placa placa,
       vf.con_valefrete_placasaque placasq,
       tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'CNPJ') PROP,
       tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'ANTT') ANTT,
       vf.con_valefrete_custocarreteiro custo,
       vf.con_valefrete_inss inss,
       vf.con_valefrete_sestsenat sestsenat,
       vf.con_valefrete_impresso impresso,
       vf.con_valefrete_status status,
       vf.cax_boletim_data caixa,
       vf.con_valefrete_fifo fifo
from tdvadm.t_con_valefrete vf
where 0 = 0
  and vf.con_valefrete_status is null
  and trunc(vf.con_valefrete_datacadastro) >= to_date('01/05/2022','dd/mm/yyyy')
  and length(trim((tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'CNPJ')))) <> 11
  and ( vf.con_valefrete_inss <> 0 or vf.con_valefrete_sestsenat <> 0 );
  
select vf.con_valefrete_datacadastro dtcad,
       vf.con_conhecimento_codigo vfrete,
       vf.con_conhecimento_serie sr,
       vf.glb_rota_codigo rt,
       vf.con_valefrete_saque sq,
       vf.con_catvalefrete_codigo categ,
       vf.con_valefrete_placa placa,
       vf.con_valefrete_placasaque placasq,
       tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'CNPJ') PROP,
       tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'ANTT') ANTT,
       vf.con_valefrete_custocarreteiro custo,
       vf.con_valefrete_inss inss,
       vf.con_valefrete_sestsenat sestsenat,
       vf.con_valefrete_impresso impresso,
       vf.con_valefrete_status status,
       vf.cax_boletim_data caixa,
       vf.con_valefrete_fifo fifo
from tdvadm.t_con_valefrete vf
where 0 = 0
  and vf.con_valefrete_status is null
  and trunc(vf.con_valefrete_datacadastro) >= to_date('01/05/2022','dd/mm/yyyy')
  and tdvadm.pkg_frtcar_veiculo.FN_GET_PROPRIETARIO(vf.con_valefrete_placa,vf.con_valefrete_placasaque,'ANTT') in ('TAC','EQP')
  and vf.con_valefrete_custocarreteiro > 1
  and vf.con_valefrete_sestsenat = 0 ;
  
  
select *
from tdvadm.t_usu_perfil ap
where ap.usu_perfil_codigo like '%PERCTADFROTA%'

select --m.FRT_MOTORISTA_CPF,
       m.CARGO2,
       count(*) Qtde,
       sum((select count(*)
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF)) qtfeVF,
       sum((select count(*)
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF
              and vf.acc_acontas_numero is not null)) qtfeVFACC,
       min((select min(trunc(vf.con_valefrete_datacadastro))
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF)) menordt,
       max((select max(trunc(vf.con_valefrete_datacadastro))
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF)) maiordt
  from TDVADM.V_FRT_MOTORISTA M
 where m.FRT_MOTORISTA_COMISSAO = 'S'
   and m.FRT_MOTORISTA_DTDESLIGAMENTO is null
   --and m.CARGO2 is null
 group by --m.FRT_MOTORISTA_CPF,
          m.CARGO2


select *
from tdvadm.t_frt_motorista m
where 0 = 0
  and m.FRT_MOTORISTA_NOME like '%DELLA VOLPE%'
  and m.FRT_MOTORISTA_CPF = '00404388809'
for update


select m.GLB_ROTA_CODIGO rota,
       m.CARGO2,
       m.FRT_MOTORISTA_CPF,
       m.FRT_MOTORISTA_CODIGO cod,
       m.FRT_MOTORISTA_MATRICULA matricula,
       m.FRT_MOTORISTA_NOME nome,
       (select count(*)
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF
              and vf.acc_acontas_numero is not null) qtfeVFACC,
       (select min(trunc(vf.con_valefrete_datacadastro))
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF) menordt,
       (select max(trunc(vf.con_valefrete_datacadastro))
             from tdvadm.t_con_Valefrete vf
            where vf.con_valefrete_datacadastro >=
                  to_date('01/01/2020', 'dd/mm/yyyy')
              and vf.con_valefrete_carreteiro = m.FRT_MOTORISTA_CPF) maiordt
from TDVADM.V_FRT_MOTORISTA M
where m.FRT_MOTORISTA_COMISSAO = 'S'
   and m.FRT_MOTORISTA_DTDESLIGAMENTO is null
   and trim(m.CARGO2) in ('223-MOTORISTA MANOBRISTA','472-MOTORISTA FOLGUISTA')
   
   
   select to_char(vf.con_valefrete_datacadastro,'YYYYMM') referencia,
--          vf.con_conhecimento_codigo vfrete,
--          vf.glb_rota_codigo rota,
          sum(vf.con_valefrete_custocarreteiro) custo,
          sum(vf.con_valefrete_pedagio) pedagio,
          sum(vf.con_valefrete_adiantamento) adiantamento
   from tdvadm.t_con_valefrete vf
   where vf.con_valefrete_carreteiro = '72865334600'
    -- and vf.cax_boletim_data is not null
   group by to_char(vf.con_valefrete_datacadastro,'YYYYMM') 
   
   
  and (select sum(m.cax_movimento_valor)
      from tdvadm.t_cax_movimento m
      where m.cax_movimento_documento = rpad(vf.con_conhecimento_codigo,10)
        and m.glb_rota_codigo_referencia = vf.glb_rota_codigo
        and trim(m.cax_movimento_doccomplemento) = vf.con_valefrete_saque
        and m.cax_operacao_codigo = '2948') <>  vf.con_valefrete_adiantamento
        
     


select *
from fpw.cargos c
where c.cacodcargo in (629,472,64);

tdvadm.pkg_con_valefrete;
tdvadm.SP_VALEFRETE_DADOSCONHEC;


select *
from tdvadm.t_con_vfreteconhec vf
where vf.con_conhecimento_codigo =  '089601'
  and vf.glb_rota_codigo = '060';

select *
from tdvadm.t_con_conhecimento vf
where vf.con_conhecimento_codigo =  '089601'
  and vf.glb_rota_codigo = '060';
  
  
  
  select ac.acc_acontas_data data,
         ac.acc_acontas_numero acerto,
         ac.acc_acontas_datainicial,
         ac.acc_acontas_datafinal,
         ac.acc_acontas_datatransf,
         ac.acc_acontas_valor_receita,
         ac.acc_acontas_valor_comissao,
         ac.acc_acontas_diferenca
  from tdvadm.t_acc_acontas ac
  where ac.frt_motorista_codigo = '0520'
  
  
  
select *
from dba_source s
where lower(s.TEXT) like '%sp_vinculacarregveicdisp%'

-- Funcoes usadas para vincular e desvincular um carregamento
tdvadm.PKG_FIFO_CTRC.Sp_VinculaCarregVeicDisp;
tdvadm.PKG_FIFO_CTRC.Sp_DesvinculaCarregVeicDisp;

tdvadm.pkg_fifo_carregamento

select *
from tdvadm.t_usu_aplicacao ap
where ap.usu_aplicacao_nomeprojeto like '%prj_impcheque%';

select *
from tdvadm.t_usu_usuarioperfil p
where p.usu_aplicacao_codigo = 'conimpcheq'



select * from tdvadm.v_job_rodando x;
select * from v$session s where s.SID in (3252,9187);

