PL/SQL Developer Test script 3.0
80
-- Criado em 06/12/2020 por SIRLANO.DRUMOND 
-- Tste Criado para Baixar contra a TDV, os Vales de Frete não recebidos
-- Anualmente o Carlos Pede para fazer este operacao
declare 
  pProtocolo tdvadm.t_edi_integra.edi_integra_protocolo%type := '2703972';
  pData      date := '25/12/2022';
  vStatus    char(1);
  vMessage   varchar2(2000);
  i integer;

begin
  update tdvadm.t_con_valefrete vf
    set vf.cax_boletim_data = null,
        vf.glb_rota_codigocx = null,
        vf.cax_movimento_sequencia = null
    where (vf.cax_boletim_data,
           vf.glb_rota_codigocx,
           vf.cax_movimento_sequencia) in (select m.cax_boletim_data,
                                                  m.glb_rota_codigo,
                                                  m.cax_movimento_sequencia
                                           from t_cax_movimento m
                                           where m.glb_rota_codigo = '010'
                                             and m.cax_boletim_data = pData
                                             and m.cax_movimento_usuario = 'sistema'
                                             and m.cax_movimento_cgccpf = '61139432000172');

  delete tdvadm.t_cax_movimento m
  where m.glb_rota_codigo = '010'
    and m.cax_boletim_data = pData
    and m.cax_movimento_usuario = 'sistema'
    and m.cax_movimento_cgccpf = '61139432000172';
  i := sql%rowcount;
  commit;
  
  for c_msg in (select i.edi_integra_col02 ANO,
                       i.edi_integra_col03 DATA_EMISSAO,
                       i.edi_integra_col04 DATA_CADASTRO,
                       lpad(i.edi_integra_col05,6,'0') VFRETE,
                       i.edi_integra_col06 SERIE,
                       lpad(i.edi_integra_col07,3,'0') ROTA,
                       i.edi_integra_col08 SQ,
                       i.edi_integra_col09 "CPF/CNPJ",
                       i.edi_integra_col10 NOME,
                       i.edi_integra_col11 CANCELADO,
                       TO_NUMBER(NVL(replace(i.edi_integra_col12,',','.'),'0')) VALOR,
                       TO_NUMBER(NVL(replace(i.edi_integra_col13,',','.'),'0')) SALDO,
                       TO_DATE(i.edi_integra_col14,'DD/MM/YYYY') BLOQUEIO
                from tdvadm.t_edi_integra i
                where i.edi_integra_protocolo = pProtocolo
                  /*
                  and lpad(i.edi_integra_col05,6,'0') || lpad(i.edi_integra_col07,3,'0') || i.edi_integra_col08 in ('0094650601',
                                                                                                                    '7410080113',
                                                                                                                    '7603160112',
                                                                                                                    '0183312103')
                  */
                  and lpad(i.edi_integra_col05,6,'0') || lpad(i.edi_integra_col07,3,'0') || i.edi_integra_col08 not in ('1519570792',
                                                                                                                        '0404960791')
                  and i.edi_integra_col05 is not null
--                  and i.edi_integra_col14 is not null
                  )
  Loop
     vStatus := 'N';
     vMessage := '';
    
     tdvadm.pkg_ctb_caixa.Sp_Teste_Lancamentos(pValefrete => c_msg.VFRETE,
                                               pSerie     => c_msg.SERIE,
                                               pRota      => c_msg.ROTA,
                                               pSaque     => c_msg.SQ,
                                               pValor     => c_msg.SALDO,
                                               pBloqueio  => c_msg.BLOQUEIO,
                                               pData      => pData,
                                               pStatus    => vStatus,
                                               pMessage   => vMessage);


    -- Torcar depois para a rotina de LOG
    dbms_output.put_line(c_msg.vfrete||'-'||c_msg.serie||'-'||c_msg.rota||'-'||c_msg.sq||'- Status-'||vStatus||'- MSG - '||trim(Vmessage)); 
  End Loop; 

end;
0
4
i
c_msg.VFRETE
c_msg.ROTA
c_msg.SQ
