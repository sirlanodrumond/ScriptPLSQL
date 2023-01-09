select *
from tdvadm.t_arm_coleta co
where co.xml_coleta_numero = 'N000467711';

select * 
from tdvadm.t_arm_nota an
where (an.arm_coleta_ncompra,
       an.arm_coleta_ciclo) in (select co.arm_coleta_ncompra,co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where co.xml_coleta_numero = 'N000467711');
select *
  from tdvadm.t_arm_notadeletada k
  where k.arm_nota_sequencia = '3807896'  ;                              


select *
  from tdvadm.t_arm_notapesagem l
  where l.arm_nota_sequencia = '3807896'   ;

select *
  from tdvadm.t_arm_notapesagemitem l
  where l.arm_notapessagem_numero = '175149'
    and l.glb_cliente_cgccpfremetente = '17155342001155'
  

select *
  from tdvadm.v_arm_coletahist k
  where (k.COLETA, k.CICLO) in (select co.arm_coleta_ncompra,co.arm_coleta_ciclo
                                from tdvadm.t_arm_coleta co
                                where co.xml_coleta_numero = 'N000467711')  ;


select k.arm_nota_gravacao,
      /* k.arm_nota_acao,
       k.arm_nota_osuser,
       k.arm_nota_maquina,*/
       k.arm_nota_programa,
       k.arm_nota_sequencia,
       k.arm_nota_peso,
       k.arm_nota_pesobalanca,
       k.arm_notahist_call_stack
  from tdvadm.t_arm_notahist k
  where k.arm_nota_sequencia = '3807896'        
  order by k.arm_nota_gravacao;    
