PL/SQL Developer Test script 3.0
65
begin
  For c_msg_bol in (select distinct x.glb_rota_codigo rota,to_char(x.cax_boletim_data,'YYYY') ano
                    from (select m.glb_rota_codigo,
                                 m.cax_boletim_data,
                                 count(distinct to_char(m.cax_boletim_data,'YYYYMMDD')) qtde,
                                 max((select max(bo.cax_boletim_codigo)
                                      from tdvadm.t_cax_boletim bo
                                      where bo.glb_rota_codigo = m.glb_rota_codigo
                                        and bo.cax_boletim_data = m.cax_boletim_data)) qtdebol
                          from tdvadm.t_cax_movimento m
                          where 0 = 0
                            and m.glb_rota_codigo <> '999'
                            and m.cax_boletim_data >= to_date('01/01/2007','dd/mm/yyyy')
                            and m.cax_boletim_data <= to_date('31/12/2022','dd/mm/yyyy')
                          group by m.glb_rota_codigo,
                                   m.cax_boletim_data) x
                    where x.qtde > 0 and x.qtdebol is null
                    order by 1,2)
  Loop
     tpBoletim.Glb_Rota_Codigo := 'XXX';
     delete tdvadm.t_cax_boletim bo where bo.glb_rota_codigo = c_msg_bol.rota and to_char(bo.cax_boletim_data,'YYYY') = c_msg_bol.ano;
     for c_msg in (select m.glb_rota_codigo,
                          m.cax_boletim_data,
                          sum(decode(op.cax_operacao_tipo,'E',m.cax_movimento_valor,0)) valorE,
                          sum(decode(op.cax_operacao_tipo,'S',m.cax_movimento_valor,0)) valorS
                   from tdvadm.t_cax_movimento m,
                        tdvadm.t_cax_operacao op
                   where to_char(m.cax_boletim_data,'YYYY') = c_msg_bol.ano
                     and m.glb_rota_codigo c_msg_bol.rota
                     and m.glb_rota_codigo_operacao = op.glb_rota_codigo_operacao
                     and m.cax_operacao_codigo = op.cax_operacao_codigo
                   group by m.glb_rota_codigo,m.cax_boletim_data
                   order by m.glb_rota_codigo,m.cax_boletim_data)
     loop
       
        if nvl(tpBoletim.Glb_Rota_Codigo,'XXX') <> c_msg.glb_rota_codigo Then
           tpBoletim.Cax_Boletim_Codigo := '001';
           tpBoletim.Glb_Rota_Codigo := c_msg.glb_rota_codigo;
           select b.cax_boletim_satual
             into vSaldoAnt
           from tdvadm.t_cax_boletim b
           where b.glb_rota_codigo = c_msg.glb_rota_codigo
             and b.cax_boletim_data = (select max(bo1.cax_boletim_data)
                                       from tdvadm.t_cax_boletim bo1
                                       where bo1.glb_rota_codigo = c_msg.glb_rota_codigo
                                         and bo1.cax_boletim_data < c_msg.cax_boletim_data);
        Else
           tpBoletim.Cax_Boletim_Codigo := lpad(to_number(tpBoletim.Cax_Boletim_Codigo)+1,3,'0');
        End If;

        tpBoletim.Cax_Boletim_Data      := c_msg.cax_boletim_data;
        tpBoletim.Cax_Boletim_Tentradas := c_msg.valore;
        tpBoletim.Cax_Boletim_Tsaidas   := c_msg.valors;
        tpBoletim.Cax_Boletim_Santerior := vSaldoAnt;
        tpBoletim.Cax_Boletim_Satual    := vSaldoAnt + c_msg.valore - c_msg.valors;
        tpBoletim.Cax_Boletim_Status    := 'F';
           
        vSaldoAnt := tpBoletim.Cax_Boletim_Satual;
           
        insert into tdvadm.t_cax_boletim values tpBoletim; 

     End Loop;
  End Loop;
                
end;
0
0
