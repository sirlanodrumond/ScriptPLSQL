PL/SQL Developer Test script 3.0
63
-- Created on 30/05/2022 by SIRLANO.DRUMOND 
declare 
  i            integer;
  vValor       number;
begin
  -- Test statements here
  :vProcessados := 0;
  :vAlteradosFR := 0;
  :vAlteradosPD := 0;
  :vErro        := 0;
  vValor        := to_number('26.68');
  i := 0;
  for c_msg in (select trim(replace(i.edi_integra_col02,'.',''))                  nrrowid,
                       trim(replace(replace(i.edi_integra_col03,'.',''),',','.')) valorantigo,
                       trim(replace(replace(i.edi_integra_col04,'.',''),',','.')) valoratual,
                       i.edi_integra_col01                                        arquivo
                from tdvadm.t_edi_integracsv i
                where i.edi_integra_col01 in ('CARAIBA.csv','CARAIBA2.csv')
                  and trim(nvl(i.edi_integra_col02,'ROWID')) <> 'ROWID'
                  and i.edi_integra_col03 <> 'VALOR'
)
  loop
     Begin
        :vProcessados := :vProcessados + 1;
--        vValor := to_number(c_msg.valoratual);
        vValor := to_number(replace(tdvadm.fn_limpa_campo3(c_msg.valoratual),' ','.'));
        update tdvadm.t_slf_calcfretekm km
          set km.slf_calcfretekm_valor = vValor
        where km.rowid = c_msg.nrrowid
          and km.slf_calcfretekm_valor <> vValor;

        If sql%rowcount <> 0 Then
           :vAlteradosFR := :vAlteradosFR + 1;
        Else

           update tdvadm.t_slf_clienteped p
             set p.slf_clienteped_valor = vValor
           where p.rowid = c_msg.nrrowid
             and p.slf_clienteped_valor <> vValor;

           If sql%rowcount <> 0 Then
              :vAlteradosPD := :vAlteradosPD + 1;
           End If;
        End If;
     exception
       When OTHERS Then
          :vErro := :vErro + 1;
     End;
--     commit;
     i := i + 1;
  End Loop;
  wservice.pkg_glb_email.SP_ENVIAEMAIL(P_ASSUNTO => 'ATUALIZACAO ',
                                       P_TEXTO   => 'PROCESSADOS  ' || to_char(:vProcessados) || chr(10) ||
                                                    'ALTERADOS FR ' || to_char(:vAlteradosFR) || chr(10) ||
                                                    'ALTERADOS PD ' || to_char(:vAlteradosPD) || chr(10) ||
                                                    'ERROS        ' || to_char(:vErro) || chr(10),
                                       P_ORIGEM  => 'aut-e@dellavolpe.com.br',
                                       P_DESTINO => 'sirlanodrumond@gmail.com',
                                       P_COPIA   => null,
                                       P_COPIA2  => null) ;
  --commit;
  
end;
4
vProcessados
1
228420
3
vAlteradosFR
1
228420
3
vAlteradosPD
1
0
3
vErro
1
0
3
2
c_msg.valoratual
vValor
