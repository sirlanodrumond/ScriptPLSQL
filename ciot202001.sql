/*
TAC
NOME: FLORIVAL SOARES RUEDA 
CPF: 36310816853
RNTRC: 001377007
CARTÃO BRADESCO: 4417819800000859
PLACA: BWZ5845


TAC
NOME: ESMERALDO CHAGAS STRELLOW
CPF: 40367959020
RNTRC: 003236412
CARTÃO BRADESCO: 4417819800000889
PLACA: IFG3475



ETC
NOME EMPRESA: SOUSA E FILHOS TRANSPORTES E LOGÍSTICA LTDA
CNPJ: 06874740000133
RNTRC: 02003000
NOME PORTADOR: RAFAEL CANELOS
CPF: 119.777.887-00
CARTÃO BRADESCO: 4417810197771018
PLACA: HMV3951



ETC
NOME EMPRESA: IMPACTO TRANSPORTES LTDA
CNPJ: 00437992000119
RNTRC: 10337528
NOME PORTADOR: MAYCON MICHAEL
CPF: 878.337.730-18
CARTÃO BRADESCO: 4417810197772016
PLACA: NRZ2600
*/


SELECT V.CAR_VEICULO_PLACA,
       V.CAR_VEICULO_SAQUE,
       P.CAR_PROPRIETARIO_RAZAOSOCIAL,
       P.CAR_PROPRIETARIO_CLASSANTT,
       P.CAR_PROPRIETARIO_CLASSEQP
FROM TDVADM.T_CAR_VEICULO V,
     TDVADM.T_CAR_PROPRIETARIO P
WHERE V.CAR_PROPRIETARIO_CGCCPFCODIGO = P.CAR_PROPRIETARIO_CGCCPFCODIGO
  AND V.CAR_VEICULO_PLACA IN ('NRZ2600','HMV3951','IFG3475','BWZ5845')

select vf.glb_tpmotorista_codigo tpmot,
       trunc(vf.con_valefrete_datacadastro) dtcad,
       vf.con_conhecimento_codigo vfrete,
       vf.con_conhecimento_serie vfsr,
       vf.glb_rota_codigo vfrt,
       vf.con_valefrete_saque vfsq,
       vf.con_valefrete_placa placa,
       nvl(p.car_proprietario_classantt,'ETC') classantt,
       nvl(p.car_proprietario_classeqp,'N') classeqp,
       (select count(*)
        from tdvadm.t_con_vfreteconhec vfc
        where vfc.con_valefrete_codigo = vf.con_conhecimento_codigo
          and vfc.con_valefrete_serie = vf.con_conhecimento_serie
          and vfc.glb_rota_codigovalefrete = vf.glb_rota_codigo
          and vfc.con_valefrete_saque = vf.con_valefrete_saque) qtdecte,
      (select count(*)
       from tdvadm.t_con_vfreteciot vfc
       where vfc.con_conhecimento_codigo = vf.con_conhecimento_codigo
         and vfc.con_conhecimento_serie = vf.con_conhecimento_serie
         and vfc.glb_rota_codigo = vf.glb_rota_codigo
         and vfc.con_valefrete_saque = vf.con_valefrete_saque) qtdeciot
from tdvadm.t_Con_Valefrete vf,
     tdvadm.t_car_veiculo v,
     tdvadm.t_car_proprietario p
where vf.con_valefrete_datacadastro >= '01/06/2019'
  and vf.con_valefrete_placa = v.car_veiculo_placa (+)  
  and vf.con_valefrete_placasaque = v.car_veiculo_saque (+)
  and v.car_proprietario_cgccpfcodigo = p.car_proprietario_cgccpfcodigo (+)
  and ( vf.con_valefrete_status is null AND  vf.con_valefrete_placa in ('NRZ2600','HMV3951','IFG3475','BWZ5845','0004216','0003226') )
  
  update tdvadm.t_fcf_veiculodisp vd
     set vd.con_freteoper_id = null,
         vd.con_freteoper_rota = null
  where (vd.fcf_veiculodisp_codigo,
         vd.fcf_veiculodisp_sequencia) in (select vf.fcf_veiculodisp_codigo,
                                                  vf.fcf_veiculodisp_sequencia  
                                           from tdvadm.t_con_valefrete vf
                                           where vf.con_valefrete_datacadastro >= '01/06/2019'
                                             and vf.con_valefrete_status is null
                                             and vf.con_valefrete_placa in ('BWZ5845'))
                                             
  select *
  from tdvadm.t_fcf_veiculodisp vd
  where (vd.fcf_veiculodisp_codigo,
         vd.fcf_veiculodisp_sequencia) in (select vf.fcf_veiculodisp_codigo,
                                                  vf.fcf_veiculodisp_sequencia  
                                           from tdvadm.t_con_valefrete vf
                                           where vf.con_valefrete_datacadastro >= '01/06/2019'
                                             and vf.con_valefrete_status is null
                                             and vf.con_valefrete_placa in ('BWZ5845'))

delete from tdvadm.t_con_vfreteciot vfc
where (vfc.con_conhecimento_codigo ,
       vfc.con_conhecimento_serie ,
       vfc.glb_rota_codigo,
       vfc.con_valefrete_saque) in (select vf.con_conhecimento_codigo,
                                           vf.con_conhecimento_serie,
                                           vf.glb_rota_codigo,
                                           vf.con_valefrete_saque 
                                    from tdvadm.t_con_valefrete vf
                                    where vf.con_valefrete_datacadastro >= '01/06/2019'
                                      and vf.con_valefrete_status is null
                                      and vf.con_valefrete_placa in ('BWZ5845')) ;
                                        
-- 
update tdvadm.t_con_freteoper f
--select * from tdvadm.t_con_freteoper f
   set f.cfe_statusfreteoper_status = 'OK'
where 0 = 0
  and f.con_freteoper_id >= 19890

  and trunc(f.con_freteoper_dtcad) >= trunc(sysdate)
--  and f.cfe_operacoes_cod IN (1, 5,  20, 21, 25, 26, 27, 28,41, 81, 75, 70,17)
  and f.con_freteoper_rota IN ('011','160','187')
--  and f.cfe_statusfreteoper_status = 'OK'
  and f.con_freteoper_paramqrystr like '%BWZ5845%'
for update
  
-- Tirando a impressao
  update tdvadm.t_con_valefrete vf
     set vf.con_valefrete_impresso = null
  where vf.con_valefrete_datacadastro >= '01/06/2019'
  and ( vf.con_valefrete_status is null AND  vf.con_valefrete_placa in ('NRZ2600','HMV3951','IFG3475','BWZ5845','0004216','0003226') )



  SELECT VF.CON_CONHECIMENTO_CODIGO,
         VF.CON_VALEFRETE_PLACA,
         VF.CON_VALEFRETE_PLACASAQUE,
         VF.GLB_TPMOTORISTA_CODIGO
  FROM TDVADM.t_Con_Valefrete VF
  WHERE 0 = 0
--    AND VF.CON_CONHECIMENTO_CODIGO || VF.GLB_ROTA_CODIGO IN ('088447187','231435011','037098610')
    AND vf.con_valefrete_placa in ('NRZ2600','HMV3951','IFG3475','BWZ5845')
  FOR UPDATE;
  
  
  198.375 
  221.744
  
SELECT ORIGEM,
       DESTINO, 
       DESCORI,
       DESCDES,
       SUM(QTDECTE) QTDECTE,
       SUM(KM) KM
FROM (
SELECT P.GLB_LOCALIDADE_CODIGOORIGEMI ORIGEM,
       P.GLB_LOCALIDADE_CODIGODESTINOI DESTINO,
       TDVADM.FN_BUSCA_CODIGOIBGE(P.GLB_LOCALIDADE_CODIGOORIGEMI,'IBD') DESCORI,
       TDVADM.FN_BUSCA_CODIGOIBGE(P.GLB_LOCALIDADE_CODIGODESTINOI,'IBD') DESCDES,
       P.SLF_PERCURSO_KM KM ,     
      -- COUNT( *) QTDELOC,
       (SELECT COUNT(*)
        FROM TDVADM.T_CON_VALEFRETE VF
        WHERE VF.CON_VALEFRETE_DATACADASTRO >= '01/01/2018'
          AND VF.GLB_LOCALIDADE_CODIGOORI = P.GLB_LOCALIDADE_CODIGOORIGEM
          AND VF.GLB_LOCALIDADE_CODIGODES = P.GLB_LOCALIDADE_CODIGODESTINO
        GROUP BY VF.GLB_LOCALIDADE_CODIGOORI,VF.GLB_LOCALIDADE_CODIGODES
        ) QTDECTE
FROM TDVADM.T_SLF_PERCURSO P
WHERE P.GLB_LOCALIDADE_CODIGOORIGEM <> '00000'
  AND P.GLB_LOCALIDADE_CODIGODESTINO <> '00000'
  AND P.GLB_LOCALIDADE_CODIGOORIGEMI <> 'SIBGE'
  AND P.GLB_LOCALIDADE_CODIGODESTINOI <> 'SIBGE'
)
GROUP BY ORIGEM,
         DESTINO, 
         DESCORI,
         DESCDES
;

 
SELECT P.GLB_LOCALIDADE_CODIGOORIGEMI ORIGEM,
       P.GLB_LOCALIDADE_CODIGODESTINOI DESTINO,
       max(
      -- COUNT(*) QTDELOC,
       (SELECT COUNT(*)
        from tdvadm.t_con_valefrete vf
        where vf.con_valefrete_datacadastro >= '01/01/2018'
          and vf.glb_localidade_codigoori = p.glb_localidade_codigoorigem
          and vf.glb_localidade_codigodes = p.glb_localidade_codigodestino
        group by vf.glb_localidade_codigoori,vf.glb_localidade_codigodes
        ) QTDECTE
FROM TDVADM.T_SLF_PERCURSO P
WHERE P.GLB_LOCALIDADE_CODIGOORIGEM <> '00000'
  AND P.GLB_LOCALIDADE_CODIGODESTINO <> '00000'
  AND P.GLB_LOCALIDADE_CODIGOORIGEMI <> 'SIBGE'
  AND P.GLB_LOCALIDADE_CODIGODESTINOI <> 'SIBGE'
GROUP BY P.GLB_LOCALIDADE_CODIGOORIGEMI,
       P.GLB_LOCALIDADE_CODIGODESTINOI
       
       
       
SELECT P.GLB_LOCALIDADE_CODIGOORIGEMI ORIGEM,
       P.GLB_LOCALIDADE_CODIGODESTINOI DESTINO,
       max(P.SLF_PERCURSO_KM) KM
FROM TDVADM.T_SLF_PERCURSO P
WHERE P.GLB_LOCALIDADE_CODIGOORIGEM <> '00000'
  AND P.GLB_LOCALIDADE_CODIGODESTINO <> '00000'
  AND P.GLB_LOCALIDADE_CODIGOORIGEMI <> 'SIBGE'
  AND P.GLB_LOCALIDADE_CODIGODESTINOI <> 'SIBGE'
group by P.GLB_LOCALIDADE_CODIGOORIGEMI,
         P.GLB_LOCALIDADE_CODIGODESTINOI  
         

         
