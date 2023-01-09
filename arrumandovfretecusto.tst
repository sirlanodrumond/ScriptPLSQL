PL/SQL Developer Test script 3.0
138
-- Created on 25/09/2020 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  vOrigem  varchar2(50);
  vDestino varchar2(50);
  vVeicDisp  tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_codigo%type;
  vSequencia tdvadm.t_fcf_veiculodisp.fcf_veiculodisp_sequencia%type;
  vSolVeic  tdvadm.t_fcf_solveic.fcf_solveic_cod%type;
begin
  -- Test statements here
  for c_msg in (select vf.ipf_valefrete_codigo,
                       vf.ipf_valefrete_serie,
                       vf.ipf_valefrete_rota,
                       vf.ipf_valefrete_saque,
                       vf.con_catvalefrete_codigo,
                       vf.con_catvalefrete_descricao,
                       vf.fcf_veiculodisp_codigo,
                       vf.fcf_veiculodisp_sequencia,
                       vf.fcf_solveic_cod,
                       vf.ipf_valefrete_placa,
                       vf.frt_conjveiculo_codigo,
                       vf.rowid
                from tdvipf.t_ipf_valefrete vf
                where vf.ipf_valefrete_referencia >= '202001'
                  and ( vf.ipf_valefrete_origemcalc is null or vf.ipf_valefrete_destinocalc is null )
--                  and vf.ipf_valefrete_codigo in ('339816','318153','407923')
--                  and vf.ipf_valefrete_rota = '011'
                order by vf.ipf_valefrete_chave)
   Loop


      If c_msg.con_catvalefrete_codigo not in ('14','09') Then
         for c_msgI in (select distinct con_conhecimento_codigo VF,
                               con_conhecimento_serie SR,
                               con_valefrete_saque SQ,
                               con_catvalefrete_codigo CAT,
                               con_valefrete_placa PLACA,
                               fcf_veiculodisp_codigo disp,
                               fcf_veiculodisp_sequencia sequencia,
                               solveic,
                               (select trim(svt.ORIGEMIBGE)
                                from tdvadm.v_fcf_solveic svt
                                where svt.FCF_SOLVEIC_COD = solveic) origem,
                               (select trim(svt.DESTIONOIBGE) 
                                from tdvadm.v_fcf_solveic svt
                                where svt.FCF_SOLVEIC_COD = solveic) destino
                        from (select h.con_conhecimento_codigo,
                                     h.con_conhecimento_serie, 
                                     h.glb_rota_codigo,
                                     h.con_valefrete_saque,
                                     h.arm_valefretehist_gravacao,
                                     h.con_catvalefrete_codigo,
                                     h.con_valefrete_placa,
                                     h.frt_conjveiculo_codigo,  
                                     h.fcf_veiculodisp_codigo,
                                     h.fcf_veiculodisp_sequencia,
                                     (select distinct sv.fcf_solveic_cod
                                      from tdvadm.t_fcf_solveic sv
                                      where sv.fcf_veiculodisp_codigo = h.fcf_veiculodisp_codigo
                                        and sv.fcf_veiculodisp_sequencia = h.fcf_veiculodisp_sequencia) solveic
                              from tdvadm.t_con_valefretehist h
                              where 0 = 0
                              --  and h.con_catvalefrete_codigo <> '14'
                                and 0 < (select count(*)
                                         from tdvadm.t_con_valefrete vf
                                         where vf.con_conhecimento_codigo = h.con_conhecimento_codigo
                                           and vf.con_conhecimento_serie = h.con_conhecimento_serie
                                           and vf.glb_rota_codigo = h.glb_rota_codigo
                                           and vf.con_valefrete_saque = h.con_valefrete_saque
                                           and vf.con_valefrete_placa = h.con_valefrete_placa
                                           and h.arm_valefretehist_gravacao between vf.con_valefrete_datacadastro - 2 and vf.con_valefrete_datacadastro) 
                              order by h.arm_valefretehist_gravacao
                             )
                       where con_conhecimento_codigo = c_msg.ipf_valefrete_codigo
                         and glb_rota_codigo = c_msg.ipf_valefrete_rota
                         and con_valefrete_saque = c_msg.ipf_valefrete_saque
                       )
              Loop
                 vOrigem   := substr(trim(c_msgI.Origem),1,50);
                 vDestino  := substr(trim(c_msgI.Destino),1,50);
                 vVeicDisp := c_msgI.disp;
                 vSequencia := c_msgI.sequencia;
                 vSolVeic  := c_msgI.solveic;
             
              End Loop;
       Else

          Begin
              Select VF.IPF_VALEFRETE_ORIGEMCALC,
                     VF.IPF_VALEFRETE_DESTINOCALC,
                     VF.FCF_VEICULODISP_CODIGO,
                     vf.fcf_veiculodisp_sequencia,
                     VF.FCF_SOLVEIC_COD
                 into vOrigem,
                      vDestino,
                      vVeicDisp,
                      vSequencia,
                      vSolVeic
              from tdvipf.t_ipf_valefrete vf
              where vf.ipf_valefrete_codigo = c_msg.ipf_valefrete_codigo
                and vf.ipf_valefrete_rota   = c_msg.ipf_valefrete_rota
                and ( vf.ipf_valefrete_placa = c_msg.ipf_valefrete_placa or vf.frt_conjveiculo_codigo = c_msg.frt_conjveiculo_codigo )
                and vf.ipf_valefrete_saque  = (select max(vf1.ipf_valefrete_saque)
                                               from tdvipf.t_ipf_valefrete vf1
                                               where vf1.ipf_valefrete_codigo = vf.ipf_valefrete_codigo
                                                 and vf1.ipf_valefrete_serie  = vf.ipf_valefrete_serie
                                                 and vf1.ipf_valefrete_rota   = vf.ipf_valefrete_rota
                                                 and vf1.ipf_valefrete_placa  = vf.ipf_valefrete_placa
                                                 and vf1.ipf_valefrete_saque < c_msg.ipf_valefrete_saque);
          exception
            when NO_DATA_FOUND Then
               vOrigem    := null;
               vDestino   := null;
               vVeicDisp  := null;
               vSequencia := null;
               vSolVeic   := null;
            when TOO_MANY_ROWS then
               dbms_output.put_line('Ver ROWID ' || c_msg.rowid);
            End;

          update tdvipf.t_ipf_valefrete vf
            set vf.ipf_valefrete_origemcalc = vOrigem,
                vf.ipf_valefrete_destinocalc = vDestino,
                vf.fcf_veiculodisp_codigo = vVeicDisp,
                vf.fcf_veiculodisp_sequencia = vSequencia,
                vf.fcf_solveic_cod = vSolVeic
          where vf.rowid = c_msg.rowid
            and ( vf.ipf_valefrete_origemcalc is null or vf.ipf_valefrete_destinocalc is null );
         
       End If;
      
       commit;
   
   End Loop;    
  

end;
0
10
c_msg.ipf_valefrete_codigo
c_msg.ipf_valefrete_rota
c_msg.ipf_valefrete_saque
vOrigem
vDestino
vVeicDisp
vSolVeic
c_msg.con_catvalefrete_descricao
c_msg.frt_conjveiculo_codigo
c_msg.ipf_valefrete_placa
