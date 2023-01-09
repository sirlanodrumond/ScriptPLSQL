PL/SQL Developer Test script 3.0
89
-- Created on 09/05/2022 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer := 0;
begin
  -- Test statements here
   for c_msg in (select m.glb_rota_codigo rota,
                        m.cax_boletim_data data,
                        m.glb_rota_codigo_operacao rtop,
                        m.cax_operacao_codigo oper,
                --       m.cax_movimento_cgccpf cnpj,
                        m.cax_movimento_documento documento,
                 --       m.cax_movimento_favorecido  favorecido,
                        m.glb_tpdoc_codigo tpdoc,
                        m.cax_movimento_documentoref docref,
                        substr(m.cax_movimento_documentoref,1,6) VFCodigo,
                        substr(m.cax_movimento_documentoref,7,2) VFSerie,
                        substr(m.cax_movimento_documentoref,9,3) VFRota,
                        substr(m.cax_movimento_documentoref,12,1) VFSaque,
                        m.cax_movimento_origem origem,
                        m.cax_movimento_valor valor,
                        m.cax_movimento_historico historico,
                        (select count(*)
                         from tdvadm.t_con_calcvalefrete vf
                         where vf.con_conhecimento_codigo = substr(m.cax_movimento_documentoref,1,6)
                           and vf.con_conhecimento_serie  = substr(m.cax_movimento_documentoref,7,2)
                           and vf.glb_rota_codigo         = substr(m.cax_movimento_documentoref,9,3)
                           and vf.con_valefrete_saque     = substr(m.cax_movimento_documentoref,12,1)
                           --and vf.con_calcvalefrete_valor = m.cax_movimento_valor
                 --          and vf.con_calcvalefrete_cnpjcpf = m.cax_movimento_cgccpf
                           and vf.cax_boletim_data <> m.cax_boletim_data) pagou,
                        (select sum(m1.cax_movimento_valor)
                         from tdvadm.t_cax_movimento m1
                         where m1.cax_movimento_documentoref = m.cax_movimento_documentoref
                           and m1.cax_movimento_historico not like '%,PED,%'
                           and m1.cax_operacao_codigo in ('1200','2001')) outrolanc,
                        (select sum(m1.cax_movimento_valor * decode(m1.cax_operacao_codigo,'1200',-1,1))
                         from tdvadm.t_cax_movimento m1
                         where m1.cax_movimento_documentoref = m.cax_movimento_documentoref
                           and m1.cax_boletim_data > m.cax_boletim_data
                           and m1.cax_operacao_codigo in ('1200','2001')
                           /*and m1.cax_movimento_historico not like '%,PED,%'*/) outrolanc2,
                         (select nvl(vf1.con_valefrete_frete,0) - nvl(vf1.con_valefrete_inss,0) - nvl(vf1.con_valefrete_sestsenat,0) - nvl(vf1.con_valefrete_irrf,0)
                         from tdvadm.t_con_valefrete vf1
                         where vf1.con_conhecimento_codigo = substr(m.cax_movimento_documentoref,1,6)
                           and vf1.con_conhecimento_serie  = substr(m.cax_movimento_documentoref,7,2)
                           and vf1.glb_rota_codigo         = substr(m.cax_movimento_documentoref,9,3)
                           and vf1.con_valefrete_saque     = substr(m.cax_movimento_documentoref,12,1)) ValorVF          
                 from tdvadm.t_cax_movimento m
                 where 0 = 0
                   and m.cax_boletim_data >= to_date('01/01/2015','DD/MM/YYYY')
                   and m.cax_movimento_cgccpf = '61139432000172'
                   and m.cax_movimento_documentoref is not null
                   and substr(m.cax_movimento_documentoref,7,2) in ('A1','A0')
                   and m.cax_operacao_codigo not in ('2054','1303','1200','2203','2487','2488')
                   and m.cax_movimento_documentoref not in  ('046430A10791','034844A10231','051156A10793','585398A10111')
                   and 0 < (select count(*)
                            from tdvadm.t_con_calcvalefrete vf
                            where vf.con_conhecimento_codigo = substr(m.cax_movimento_documentoref,1,6)
                              and vf.con_conhecimento_serie  = substr(m.cax_movimento_documentoref,7,2)
                              and vf.glb_rota_codigo         = substr(m.cax_movimento_documentoref,9,3)
                              and vf.con_valefrete_saque     = substr(m.cax_movimento_documentoref,12,1)
                              and vf.con_calcvalefrete_valor <> 0
                              --and vf.con_calcvalefrete_valor = m.cax_movimento_valor
                 --             and vf.con_calcvalefrete_cnpjcpf = m.cax_movimento_cgccpf
                              and vf.con_calcvalefrete_dtpgto is null
                              and vf.con_calcvalefrete_dtbloqueio is null) 
           ) 
   Loop    
      i := i + 1;
      update tdvadm.t_con_calcvalefrete cvf
         set cvf.usu_usuario_bloqueou = 'sistema',
             cvf.con_calcvalefrete_dtbloqueio = sysdate
      where cvf.con_conhecimento_codigo = c_msg.vfcodigo
        and cvf.con_conhecimento_serie  = c_msg.vfserie
        and cvf.glb_rota_codigo         = c_msg.vfrota
        and cvf.con_valefrete_saque     = c_msg.vfsaque
        and cvf.con_calcvalefrete_valor <> 0
        and cvf.con_calcvalefrete_dtpgto is null
        and cvf.con_calcvalefrete_dtbloqueio is null;
      If sql%rowcount <> 0 Then
         dbms_output.put_line( c_msg.docref || ' - ' || sql%rowcount || ' Registros Bloqueados');
      Else
         dbms_output.put_line( c_msg.docref || ' Não localizou lancamento');
      End If;        

   End Loop; 
    dbms_output.put_line( i || ' -  Registros Verificados');          
end;
0
0
