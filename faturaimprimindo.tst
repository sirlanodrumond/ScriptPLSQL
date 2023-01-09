PL/SQL Developer Test script 3.0
125
Declare 
  vAuxiliar integer;
begin
  :pCON_FATURA_CODIGO_NOVO   := trim(:pCON_FATURA_CODIGO_NOVO);
  :pGLB_ROTA_CODIGOFILIALIMP := trim(:pGLB_ROTA_CODIGOFILIALIMP);
  :pCON_FATURA_CICLO_NOVO    := trim(:pCON_FATURA_CICLO_NOVO);
  -- Call the procedure
  delete tdvadm.t_crp_titrecevento ev
  where ev.crp_titreceber_numtitulo = :pCON_FATURA_CODIGO_NOVO
    and ev.glb_rota_codigo = '028';
  vAuxiliar := sql%rowcount;

  
  delete tdvadm.t_con_conhecfaturado tr
  where tr.crp_titreceber_numtitulo = :pCON_FATURA_CODIGO_NOVO
    and tr.glb_rota_codigotitrec = '028';
  vAuxiliar := sql%rowcount;

  delete tdvadm.t_crp_conhecevento tr
  where tr.crp_titreceber_numtitulo = :pCON_FATURA_CODIGO_NOVO
    and tr.glb_rota_codigo = '028';
  vAuxiliar := sql%rowcount;


  delete tdvadm.t_crp_histtitreceber tr
  where tr.crp_titreceber_numtitulo = :pCON_FATURA_CODIGO_NOVO
    and tr.glb_rota_codigo = '028';
  vAuxiliar := sql%rowcount;

  
  delete tdvadm.t_crp_titreceber tr
  where tr.crp_titreceber_numtitulo = :pCON_FATURA_CODIGO_NOVO
    and tr.glb_rota_codigo = '028';
  vAuxiliar := sql%rowcount;
  

  insert into tdvadm.t_con_fatura 
  select :pCON_FATURA_CODIGO,
         'X',
         :pGLB_ROTA_CODIGOFILIALIMP,
         f.glb_cliente_cgccpfsacado,
         f.con_fatura_serie,
         f.con_fatura_datavenc,
         f.con_fatura_datapagto,
         f.con_fatura_dataemissao,
         f.con_fatura_datacanc,
         f.con_fatura_valorcobrado,
         f.con_fatura_valorrecebido,
         'A',
         f.glb_rota_codigo,
         f.glb_condpag_codigo,
         f.con_fatura_emissor,
         f.con_fatura_venccalc,
         f.con_fatura_criador,
         f.con_fatura_autorizador,
         f.con_fatura_desconto,
         f.con_fatura_dtlimtdesc,
         f.glb_formaenvio_codigo,
         f.con_fatura_dtenviodoc,
         f.con_fatura_tpdesconto,
         f.con_fatura_obsdesconto,
         f.con_fatura_obscancelamento,
         f.con_fatura_reversao,
         null,
         f.usu_usuario_codigo,
         f.con_fatura_obs,
         f.con_fatura_cabecalhofat
  from tdvadm.t_con_fatura f
  where f.con_fatura_codigo = :pCON_FATURA_CODIGO_NOVO
    and f.glb_rota_codigofilialimp = '028';
  vAuxiliar := sql%rowcount;

  execute immediate('alter trigger tg_con_conhecfatura disable');  
  update tdvadm.t_con_conhecimento c
    set c.con_fatura_codigo = :pCON_FATURA_CODIGO,
        c.con_fatura_ciclo = 'X',
        c.glb_rota_codigofilialimp = :pGLB_ROTA_CODIGOFILIALIMP
  where c.con_fatura_codigo = :pCON_FATURA_CODIGO_NOVO
    and c.glb_rota_codigofilialimp = '028';
  vAuxiliar := sql%rowcount;
  delete t_con_fatura f
  where f.con_fatura_codigo = :pCON_FATURA_CODIGO_NOVO
    and f.glb_rota_codigofilialimp = '028';
  vAuxiliar := sql%rowcount;
  execute immediate('alter trigger tg_con_conhecfatura enable');  
  

  PKG_CON_FATURA.SP_FAT_ATUALIZANUMEROFATURA(pCON_FATURA_CODIGO => :pCON_FATURA_CODIGO,
                                             pCON_FATURA_CICLO => :pCON_FATURA_CICLO,
                                             pGLB_ROTA_CODIGOFILIALIMP => :pGLB_ROTA_CODIGOFILIALIMP,
                                             pCON_FATURA_CODIGO_NOVO => :pCON_FATURA_CODIGO_NOVO,
                                             pCON_FATURA_CICLO_NOVO => :pCON_FATURA_CICLO_NOVO,
                                             pCON_FATURA_DATAEMISSAO => :pCON_FATURA_DATAEMISSAO,
                                             pStatus => :pStatus,
                                             pMessage => :pMessage);



:Desconto := 0;
Begin
   Select f.con_fatura_desconto
     into :Desconto
   from tdvadm.t_con_fatura f
   where f.con_fatura_codigo = trim(:pCON_FATURA_CODIGO_NOVO)
     and f.glb_rota_codigofilialimp = '028';
Exception
   When NO_DATA_FOUND Then
      :Desconto := -1;
   End;     

:Evento := 0;
Begin
   Select ev.crp_titrecevento_valor
     into :Evento
   from tdvadm.t_crp_titrecevento ev
   where ev.crp_titreceber_numtitulo = trim(:pCON_FATURA_CODIGO_NOVO)
     and ev.glb_rota_codigo = '028';
Exception
   When NO_DATA_FOUND Then
      :Evento := -1;
   End;     



end;
10
pCON_FATURA_CODIGO
1
433407
5
pCON_FATURA_CICLO
1
X
5
pGLB_ROTA_CODIGOFILIALIMP
1
028                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
5
pCON_FATURA_CODIGO_NOVO
1
030031                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
5
pCON_FATURA_CICLO_NOVO
1
1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pCON_FATURA_DATAEMISSAO
1
30/10/2021
5
pStatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pMessage
0
5
Desconto
1
.02
5
Evento
1
.02
5
3
vAuxiliar
pGLB_ROTA_CODIGOFILIALIMP
