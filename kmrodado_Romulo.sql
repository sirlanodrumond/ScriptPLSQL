select substr(vf.ipf_valefrete_referencia,1,4) referencia,
       vf.glb_tpmotorista_codigo tpmot,
       vf.con_catvalefrete_descricao categoria,
       vf.fcf_tpveiculo_codigo || '-' || vf.fcf_tpveiculo_descricao veiculo,
       decode(trim(vf.fcf_tpveiculo_codigo),'1','CARRETA',
                                            '2','CARRETA',
                                            '3','TRUCK',
                                            '13','CARRETA',
                                            '14','CARRETA',
                                            '15','CARRETA',
                                            '16','CARRETA',
                                            '20','CARRETA',
                                            '21','CARRETA',
                                            '32','CARRETA',
                                            '36','CARRETA',
                                            '37','CARRETA','LEVE') TPVEICULO,
       sum(vf.ipf_valefrete_kmperc) kmperc,
       sum(vf.ipf_valefrete_kmvazio) kmvazio,
       sum(vf.ipf_valefrete_mixkm) KMMIX,
       sum(vf.ipf_valefrete_mixqueima) KMMIXQUEIMA,
       sum(vf.ipf_valefrete_ctepesototal) ctepesototal
  from tdvipf.t_ipf_valefrete vf
 where substr(vf.ipf_valefrete_referencia, 1, 4) in ('2020','2021')
      -- and vf.con_catvalefrete_codigo not in ('01')
   and vf.con_catvalefrete_codigo not in
       ('08', -- 08-Avulso (Despesa TDV)
        --'10', -- 10-Servico de Terceiro
        '14', -- 14-Bonus CTRC
        '17' -- 17-Estadia
        --'18' -- 18-Coleta
        )
 group by substr(vf.ipf_valefrete_referencia,1,4),
          vf.glb_tpmotorista_codigo,
          vf.con_catvalefrete_descricao,
          vf.fcf_tpveiculo_codigo || '-' || vf.fcf_tpveiculo_descricao,
          decode(trim(vf.fcf_tpveiculo_codigo),'1','CARRETA',
                                               '2','CARRETA',
                                               '3','TRUCK',
                                               '13','CARRETA',
                                               '14','CARRETA',
                                               '15','CARRETA',
                                               '16','CARRETA',
                                               '20','CARRETA',
                                               '21','CARRETA',
                                               '32','CARRETA',
                                               '36','CARRETA',
                                               '37','CARRETA','LEVE')




