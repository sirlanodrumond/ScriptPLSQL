PL/SQL Developer Test script 3.0
349
-- Created on 19/12/2021 by SIRLANO.DRUMOND 
declare 
  -- Local variables here
  i integer;
  pProtocoloCli    tdvadm.t_edi_integra.edi_integra_protocolo%type := '1857424';
  pProtocoloCliEnd tdvadm.t_edi_integra.edi_integra_protocolo%type := '1857425';
  pTipoCli         tdvadm.t_glb_cliente%rowtype;
  pTipoCliEnd      tdvadm.t_glb_cliend%rowtype;
  vAchouCli        integer;
  vAchouCliEnd     integer;
  vErro            varchar2(500);
begin
/*
  -- Clientes Duplicados
select i.edi_integra_col02 GLB_CLIENTE_CGCCPFCODIGO,
       count(*) qtde
from tdvadm.t_edi_integra i
where i.edi_integra_protocolo = pProtocoloCli
  and i.edi_integra_col02 is not null
group by i.edi_integra_col02
having count(*) > 1;

-- Enderecos Duplicados
select i.edi_integra_col01 GLB_CLIENTE_CGCCPFCODIGO,
       i.edi_integra_col02 GLB_TPCLIEND_CODIGO,
       count(*) qtde
from tdvadm.t_edi_integra i
where i.edi_integra_protocolo = pProtocoloCliEnd
  and i.edi_integra_col01 is not null
group by i.edi_integra_col01,
         i.edi_integra_col02
having count(*) > 1;

-- Sem Endereço
select i.edi_integra_col01 GLB_CLIENTE_NACIONAL,
       i.edi_integra_col02 GLB_CLIENTE_CGCCPFCODIGO
from tdvadm.t_edi_integra i
where i.edi_integra_protocolo = pProtocoloCli
  and i.edi_integra_col01 is not null
  and 0 = (select count(*)
           from tdvadm.t_edi_integra i1
           where i1.edi_integra_protocolo = pProtocoloCliEnd
             and i1.edi_integra_col01 = i.edi_integra_col02);

-- Sem Clientes
select i.edi_integra_col01 GLB_CLIENTE_CGCCPFCODIGO,
       i.edi_integra_col02 GLB_TPCLIEND_CODIGO
from tdvadm.t_edi_integra i
where i.edi_integra_protocolo = pProtocoloCliEnd
  and i.edi_integra_col01 is not null
  and 0 = (select count(*)
           from tdvadm.t_edi_integra i1
           where i1.edi_integra_protocolo = pProtocoloCli
             and i1.edi_integra_col02 = i.edi_integra_col01);
*/     

  update  tdvadm.t_edi_integra i
     set i.edi_integra_critica = null,
         i.edi_integra_processado = null 
  where i.edi_integra_protocolo = pProtocoloCli;

  update  tdvadm.t_edi_integra i
     set i.edi_integra_critica = null,
         i.edi_integra_processado = null 
  where i.edi_integra_protocolo = pProtocoloCliEnd;


   for c_msg in (select i.edi_integra_col01 GLB_CLIENTE_NACIONAL,
                        i.edi_integra_col02 GLB_CLIENTE_CGCCPFCODIGO,
                        i.edi_integra_col03 GLB_CLIENTE_RAZAOSOCIAL,
                        i.edi_integra_col04 GLB_VENDFRETE_CODIGO,
                        i.edi_integra_col05 GLB_CLIENTE_TPPESSOA,
                        i.edi_integra_col06 GLB_CLIENTE_IE,
                        i.edi_integra_col07 GLB_CLIENTE_IM,
                        i.edi_integra_col08 GLB_ROTA_CODIGO,
                        i.edi_integra_col09 GLB_CLIENTE_SITUACAO,
                        i.edi_integra_col10 GLB_CLIENTE_QTDTITVENC,
                        i.edi_integra_col11 GLB_CLIENTE_VLTOTVENC,
                        i.edi_integra_col12 GLB_CLIENTE_PRAZOMEDVENC,
                        i.edi_integra_col13 GLB_CLIENTE_PRAZOMEDPAGTO,
                        i.edi_integra_col14 GLB_CLIENTE_DTUTLMOV,
                        i.edi_integra_col15 GLB_CLIENTE_DTCADASTRO,
                        i.edi_integra_col16 GLB_CLIENTE_OBS,
                        i.edi_integra_col17 GLB_CLIENTE_OPERCAD,
                        i.edi_integra_col18 GLB_CLIENTE_OPERALT,
                        i.edi_integra_col19 GLB_CLIENTE_TPBOLETO,
                        i.edi_integra_col20 CRP_TPCARTERIA_CODIGO,
                        i.edi_integra_col21 GLB_CLIENTE_DIAATRAZO,
                        i.edi_integra_col22 GLB_CLIENTE_CLASSSAC,
                        i.edi_integra_col23 GLB_CLIENTE_NFNAFATURA,
                        i.edi_integra_col24 GLB_BANCO_NUMERO,
                        i.edi_integra_col25 GLB_CLIENTE_CONTROLANF,
                        i.edi_integra_col26 GLB_CLIENTE_TIPORATEIO,
                        i.edi_integra_col27 GLB_CLIENTE_DESCINSS,
                        i.edi_integra_col28 GLB_RAMOATIVIDADE_CODIGO,
                        i.edi_integra_col29 GLB_CLIENTE_IEISENTO,
                        i.edi_integra_col30 GLB_CLIENTE_DTULTMOVSAC,
                        i.edi_integra_col31 GLB_CLIENTE_DTULTMOVREM,
                        i.edi_integra_col32 GLB_CLIENTE_DTULTMOVDEST,
                        i.edi_integra_col33 GLB_CLIENTE_TRIBISENTO,
                        i.edi_integra_col34 GLB_CLIENTE_REGIMEESPVP,
                        i.edi_integra_col35 GLB_CLIENTE_DTALTERACAO,
                        i.edi_integra_col36 GLB_CLIENTE_AGRUPASEPARA,
                        i.edi_integra_col37 GLB_GRUPOECONOMICO_CODIGOSEG,
                        i.edi_integra_col38 GLB_GRUPOECONOMICO_CODIGO,
                        i.edi_integra_col39 GLB_CLIENTE_TIPODESCONTO,
                        i.edi_integra_col40 GLB_CLIENTE_PERCDESCONTO,
                        i.edi_integra_col41 GLB_GRUPOECONOMICO_CODIGOCTB,
                        i.edi_integra_col42 GLB_CLIENTE_EMAILCONTROLE,
                        i.edi_integra_col43 ARM_ARMAZEM_CODIGO,
                        i.edi_integra_col44 GLB_CLIENTE_CTRCIMG,
                        i.edi_integra_col45 GLB_CLIENTE_NOTAIMG,
                        i.edi_integra_col46 GLB_CLIENTE_VLRLIMITE,
                        i.edi_integra_col47 GLB_CLIENTE_ESTIVA,
                        i.edi_integra_col48 GLB_CLIENTE_CNAE,
                        i.edi_integra_col49 GLB_CLIENTE_HIGIENIZADO,
                        i.edi_integra_col50 GLB_CLIENTE_EXIGECOMPROVANTE,
                        i.edi_integra_col51 GLB_CLIENTE_ISSRET,
                        i.edi_integra_col52 GLB_CLIENTE_FECHACOLETA,
                        i.edi_integra_col53 GLB_CLIENTE_VIGENCIA,
                        i.edi_integra_col54 GLB_CLIENTE_FLAGVERIFICAEND,
                        i.edi_integra_col55 GLB_CLIENTE_ESTADIA,
                        i.edi_integra_col56 GLB_CLIENTE_COLREQAUT,
                        i.edi_integra_col57 CODIGO_USUAL,
                        i.edi_integra_col58 ARM_ARMAZEM_CODIGOFCA,
                        i.edi_integra_col59 GLB_CLIENTE_NAOCONT,
                        i.edi_integra_col60 GLB_CLIENTE_OPTSIMPLES,
                        i.rowid
                 from tdvadm.t_edi_integra i
                 where i.edi_integra_protocolo = pProtocoloCli
                   and i.edi_integra_col01 is not null
                   and i.edi_integra_processado is null
                   --and i.edi_integra_col02 = '30493807000174'
                   )
   Loop

      Begin
            pTipoCli.GLB_CLIENTE_NACIONAL         := c_msg.GLB_CLIENTE_NACIONAL;
            pTipoCli.GLB_CLIENTE_CGCCPFCODIGO     := c_msg.GLB_CLIENTE_CGCCPFCODIGO;
            pTipoCli.GLB_CLIENTE_RAZAOSOCIAL      := substr(c_msg.GLB_CLIENTE_RAZAOSOCIAL,1,60);
            pTipoCli.GLB_VENDFRETE_CODIGO         := c_msg.GLB_VENDFRETE_CODIGO;
            pTipoCli.GLB_CLIENTE_TPPESSOA         := c_msg.GLB_CLIENTE_TPPESSOA;
            pTipoCli.GLB_CLIENTE_IE               := c_msg.GLB_CLIENTE_IE;
            pTipoCli.GLB_CLIENTE_IM               := c_msg.GLB_CLIENTE_IM;
            pTipoCli.GLB_ROTA_CODIGO              := c_msg.GLB_ROTA_CODIGO;
            pTipoCli.GLB_CLIENTE_SITUACAO         := c_msg.GLB_CLIENTE_SITUACAO;
            pTipoCli.GLB_CLIENTE_QTDTITVENC       := c_msg.GLB_CLIENTE_QTDTITVENC;
            pTipoCli.GLB_CLIENTE_VLTOTVENC        := c_msg.GLB_CLIENTE_VLTOTVENC;
            pTipoCli.GLB_CLIENTE_PRAZOMEDVENC     := c_msg.GLB_CLIENTE_PRAZOMEDVENC;
            pTipoCli.GLB_CLIENTE_PRAZOMEDPAGTO    := c_msg.GLB_CLIENTE_PRAZOMEDPAGTO;
            pTipoCli.GLB_CLIENTE_DTUTLMOV         := null; --c_msg.GLB_CLIENTE_DTUTLMOV;
            pTipoCli.GLB_CLIENTE_DTCADASTRO       := sysdate; --c_msg.GLB_CLIENTE_DTCADASTRO;
            pTipoCli.GLB_CLIENTE_OBS              := c_msg.GLB_CLIENTE_OBS;
            pTipoCli.GLB_CLIENTE_OPERCAD          := c_msg.GLB_CLIENTE_OPERCAD;
            pTipoCli.GLB_CLIENTE_OPERALT          := c_msg.GLB_CLIENTE_OPERALT;
            pTipoCli.GLB_CLIENTE_TPBOLETO         := c_msg.GLB_CLIENTE_TPBOLETO;
            pTipoCli.CRP_TPCARTERIA_CODIGO        := c_msg.CRP_TPCARTERIA_CODIGO;
            pTipoCli.GLB_CLIENTE_DIAATRAZO        := c_msg.GLB_CLIENTE_DIAATRAZO;
            pTipoCli.GLB_CLIENTE_CLASSSAC         := c_msg.GLB_CLIENTE_CLASSSAC;
            pTipoCli.GLB_CLIENTE_NFNAFATURA       := c_msg.GLB_CLIENTE_NFNAFATURA;
            pTipoCli.GLB_BANCO_NUMERO             := c_msg.GLB_BANCO_NUMERO;
            pTipoCli.GLB_CLIENTE_CONTROLANF       := c_msg.GLB_CLIENTE_CONTROLANF;
            pTipoCli.GLB_CLIENTE_TIPORATEIO       := c_msg.GLB_CLIENTE_TIPORATEIO;
            pTipoCli.GLB_CLIENTE_DESCINSS         := c_msg.GLB_CLIENTE_DESCINSS;
            pTipoCli.GLB_RAMOATIVIDADE_CODIGO     := c_msg.GLB_RAMOATIVIDADE_CODIGO;
            pTipoCli.GLB_CLIENTE_IEISENTO         := c_msg.GLB_CLIENTE_IEISENTO;
            pTipoCli.GLB_CLIENTE_DTULTMOVSAC      := null; --c_msg.GLB_CLIENTE_DTULTMOVSAC;
            pTipoCli.GLB_CLIENTE_DTULTMOVREM      := null; --c_msg.GLB_CLIENTE_DTULTMOVREM;
            pTipoCli.GLB_CLIENTE_DTULTMOVDEST     := null; --c_msg.GLB_CLIENTE_DTULTMOVDEST;
            pTipoCli.GLB_CLIENTE_TRIBISENTO       := c_msg.GLB_CLIENTE_TRIBISENTO;
            pTipoCli.GLB_CLIENTE_REGIMEESPVP      := c_msg.GLB_CLIENTE_REGIMEESPVP;
            pTipoCli.GLB_CLIENTE_DTALTERACAO      := null; --c_msg.GLB_CLIENTE_DTALTERACAO;
            pTipoCli.GLB_CLIENTE_AGRUPASEPARA     := c_msg.GLB_CLIENTE_AGRUPASEPARA;
            pTipoCli.GLB_GRUPOECONOMICO_CODIGOSEG := c_msg.GLB_GRUPOECONOMICO_CODIGOSEG;
            pTipoCli.GLB_GRUPOECONOMICO_CODIGO    := c_msg.GLB_GRUPOECONOMICO_CODIGO;
            pTipoCli.GLB_CLIENTE_TIPODESCONTO     := c_msg.GLB_CLIENTE_TIPODESCONTO;
            pTipoCli.GLB_CLIENTE_PERCDESCONTO     := c_msg.GLB_CLIENTE_PERCDESCONTO;
            pTipoCli.GLB_GRUPOECONOMICO_CODIGOCTB := c_msg.GLB_GRUPOECONOMICO_CODIGOCTB;
            pTipoCli.GLB_CLIENTE_EMAILCONTROLE    := c_msg.GLB_CLIENTE_EMAILCONTROLE;
            pTipoCli.ARM_ARMAZEM_CODIGO           := c_msg.ARM_ARMAZEM_CODIGO;
            pTipoCli.GLB_CLIENTE_CTRCIMG          := c_msg.GLB_CLIENTE_CTRCIMG;
            pTipoCli.GLB_CLIENTE_NOTAIMG          := c_msg.GLB_CLIENTE_NOTAIMG;
            pTipoCli.GLB_CLIENTE_VLRLIMITE        := 0; --c_msg.GLB_CLIENTE_VLRLIMITE;
            pTipoCli.GLB_CLIENTE_ESTIVA           := c_msg.GLB_CLIENTE_ESTIVA;
            pTipoCli.GLB_CLIENTE_CNAE             := c_msg.GLB_CLIENTE_CNAE;
            pTipoCli.GLB_CLIENTE_HIGIENIZADO      := null; --c_msg.GLB_CLIENTE_HIGIENIZADO;
            pTipoCli.GLB_CLIENTE_EXIGECOMPROVANTE := c_msg.GLB_CLIENTE_EXIGECOMPROVANTE;
            pTipoCli.GLB_CLIENTE_ISSRET           := c_msg.GLB_CLIENTE_ISSRET;
            pTipoCli.GLB_CLIENTE_FECHACOLETA      := c_msg.GLB_CLIENTE_FECHACOLETA;
            pTipoCli.GLB_CLIENTE_VIGENCIA         := c_msg.GLB_CLIENTE_VIGENCIA;
            pTipoCli.GLB_CLIENTE_FLAGVERIFICAEND  := c_msg.GLB_CLIENTE_FLAGVERIFICAEND;
            pTipoCli.GLB_CLIENTE_ESTADIA          := c_msg.GLB_CLIENTE_ESTADIA;
            pTipoCli.GLB_CLIENTE_COLREQAUT        := c_msg.GLB_CLIENTE_COLREQAUT;
            pTipoCli.CODIGO_USUAL                 := c_msg.CODIGO_USUAL;
            pTipoCli.ARM_ARMAZEM_CODIGOFCA        := c_msg.ARM_ARMAZEM_CODIGOFCA;
            pTipoCli.GLB_CLIENTE_NAOCONT          := c_msg.GLB_CLIENTE_NAOCONT;
            pTipoCli.GLB_CLIENTE_OPTSIMPLES       := c_msg.GLB_CLIENTE_OPTSIMPLES;
            
            select count(*)
              into vAchouCli
            from tdvadm.t_glb_cliente cl
            where cl.glb_cliente_cgccpfcodigo = pTipoCli.Glb_Cliente_Cgccpfcodigo;
            If vAchouCli <> 0 Then
               vErro := 'Cliente Ja Existe';
            Else   
              insert into tdvadm.t_glb_cliente cl values pTipoCli; 
              vErro := 'OK';
            End If;
            If length(trim(c_msg.GLB_CLIENTE_RAZAOSOCIAL)) > 60 Then
               vErro := vErro || ' Nome do Cliente com mais de 60 LETRAS';
            End If;
            update tdvadm.t_edi_integra i
              set i.edi_integra_processado = sysdate,
                  i.edi_integra_critica = vErro
            Where i.rowid = c_msg.rowid;
            Commit;


            for c_msg1 in (select i.edi_integra_col01 GLB_CLIENTE_CGCCPFCODIGO,
                                  i.edi_integra_col02 GLB_TPCLIEND_CODIGO,
                                  i.edi_integra_col03 GLB_PAIS_CODIGO,
                                  i.edi_integra_col04 GLB_ESTADO_CODIGO,
                                  i.edi_integra_col05 GLB_CLIEND_ENDERECO,
                                  i.edi_integra_col06 GLB_CLIEND_COMPLEMENTO,
                                  i.edi_integra_col07 GLB_CLIEND_CIDADE,
                                  i.edi_integra_col08 GLB_CEP_CODIGO,
                                  i.edi_integra_col09 GLB_LOCALIDADE_CODIGO,
                                  i.edi_integra_col10 GLB_CLIEND_CODCLIENTE,
                                  i.edi_integra_col11 ARM_REGIAO_CODIGO,
                                  i.edi_integra_col12 ARM_REGIAO_METROPOLITANA,
                                  i.edi_integra_col13 ARM_SUBREGIAO_CODIGO,
                                  i.edi_integra_col14 XML_CEP_CVRD,
                                  i.edi_integra_col15 GLB_CLIEND_EMAIL,
                                  i.edi_integra_col16 GLB_CLIEND_LATITUDE,
                                  i.edi_integra_col17 GLB_CLIEND_LONGITUDE,
                                  i.edi_integra_col18 GLB_CLIEND_LOGO,
                                  i.edi_integra_col19 GLB_PORTARIA_ID,
                                  i.edi_integra_col20 GLB_CLIEND_IE,
                                  i.edi_integra_col21 GLB_CLIEND_IM,
                                  i.edi_integra_col22 GLB_CLIEND_HIGIENIZADO,
                                  i.edi_integra_col23 USU_USUARIO_CRIOU,
                                  i.edi_integra_col24 USU_USUARIO_ALTEROU,
                                  i.edi_integra_col25 GLB_CLIEND_DTCRIACAO,
                                  i.edi_integra_col26 GLB_CLIEND_DTALTERACAO,
                                  i.edi_integra_col27 GLB_LOCALIDADE_CODIGOIE,
                                  i.edi_integra_col28 GLB_CLIEND_NUMERO,
                                  i.edi_integra_col29 GLB_CLIENTE_CNPJAUX,
                                  i.rowid
                           from tdvadm.t_edi_integra i
                           where i.edi_integra_protocolo = pProtocoloCliEnd
                             and rpad(i.edi_integra_col01,20) = pTipoCli.Glb_Cliente_Cgccpfcodigo
                             and i.edi_integra_col01 is not null)

            Loop
               Begin
                     pTipoCliEnd.GLB_CLIENTE_CGCCPFCODIGO := c_msg1.GLB_CLIENTE_CGCCPFCODIGO;
                     pTipoCliEnd.GLB_TPCLIEND_CODIGO      := c_msg1.GLB_TPCLIEND_CODIGO;
                     pTipoCliEnd.GLB_PAIS_CODIGO          := c_msg1.GLB_PAIS_CODIGO;
                     pTipoCliEnd.GLB_ESTADO_CODIGO        := c_msg1.GLB_ESTADO_CODIGO;
                     pTipoCliEnd.GLB_CLIEND_ENDERECO      := substr(c_msg1.GLB_CLIEND_ENDERECO,1,50);
                     pTipoCliEnd.GLB_CLIEND_COMPLEMENTO   := c_msg1.GLB_CLIEND_COMPLEMENTO;
                     pTipoCliEnd.GLB_CLIEND_CIDADE        := c_msg1.GLB_CLIEND_CIDADE;
                     pTipoCliEnd.GLB_CEP_CODIGO           := c_msg1.GLB_CEP_CODIGO;
                     pTipoCliEnd.GLB_LOCALIDADE_CODIGO    := c_msg1.GLB_LOCALIDADE_CODIGO;
                     pTipoCliEnd.GLB_CLIEND_CODCLIENTE    := c_msg1.GLB_CLIEND_CODCLIENTE;
                     pTipoCliEnd.ARM_REGIAO_CODIGO        := c_msg1.ARM_REGIAO_CODIGO;
                     pTipoCliEnd.ARM_REGIAO_METROPOLITANA := c_msg1.ARM_REGIAO_METROPOLITANA;
                     pTipoCliEnd.ARM_SUBREGIAO_CODIGO     := c_msg1.ARM_SUBREGIAO_CODIGO;
                     pTipoCliEnd.XML_CEP_CVRD             := c_msg1.XML_CEP_CVRD;
                     pTipoCliEnd.GLB_CLIEND_EMAIL         := c_msg1.GLB_CLIEND_EMAIL;
                     pTipoCliEnd.GLB_CLIEND_LATITUDE      := c_msg1.GLB_CLIEND_LATITUDE;
                     pTipoCliEnd.GLB_CLIEND_LONGITUDE     := c_msg1.GLB_CLIEND_LONGITUDE;
                     pTipoCliEnd.GLB_CLIEND_LOGO          := c_msg1.GLB_CLIEND_LOGO;
                     pTipoCliEnd.GLB_PORTARIA_ID          := c_msg1.GLB_PORTARIA_ID;
                     pTipoCliEnd.GLB_CLIEND_IE            := c_msg1.GLB_CLIEND_IE;
                     pTipoCliEnd.GLB_CLIEND_IM            := c_msg1.GLB_CLIEND_IM;
                     pTipoCliEnd.GLB_CLIEND_HIGIENIZADO   := null; --c_msg1.GLB_CLIEND_HIGIENIZADO;
                     pTipoCliEnd.USU_USUARIO_CRIOU        := c_msg1.USU_USUARIO_CRIOU;
                     pTipoCliEnd.USU_USUARIO_ALTEROU      := c_msg1.USU_USUARIO_ALTEROU;
                     pTipoCliEnd.GLB_CLIEND_DTCRIACAO     := c_msg1.GLB_CLIEND_DTCRIACAO;
                     pTipoCliEnd.GLB_CLIEND_DTALTERACAO   := c_msg1.GLB_CLIEND_DTALTERACAO;
                     pTipoCliEnd.GLB_LOCALIDADE_CODIGOIE  := c_msg1.GLB_LOCALIDADE_CODIGOIE;
                     pTipoCliEnd.GLB_CLIEND_NUMERO        := c_msg1.GLB_CLIEND_NUMERO;
                     pTipoCliEnd.GLB_CLIENTE_CNPJAUX      := c_msg1.GLB_CLIENTE_CNPJAUX;
                     
                     select count(*)
                       into vAchouCliEnd
                     from tdvadm.t_glb_cliend ce
                     where ce.glb_cliente_cgccpfcodigo = pTipoCliEnd.Glb_Cliente_Cgccpfcodigo
                       and ce.glb_tpcliend_codigo = pTipoCliEnd.Glb_Tpcliend_Codigo;
                     If vAchouCliEnd <> 0 Then
                        vErro := 'Endereco do Cliente Ja Existe';
                     Else
                        insert into tdvadm.t_glb_cliend values pTipoCliEnd;
                        vErro := 'OK';
                     End If;
                     If length(trim(c_msg1.GLB_CLIEND_ENDERECO)) > 50 Then
                        vErro := vErro || ' Rua com mais de 50 letras';
                     end If;
                     update tdvadm.t_edi_integra i
                       set i.edi_integra_processado = sysdate,
                           i.edi_integra_critica = vErro
                     Where i.rowid = c_msg1.rowid;     
                     commit;       
                  
            Exception
               When OTHERS Then
                  vErro := sqlerrm;
                  update tdvadm.t_edi_integra i
                    set i.edi_integra_processado = sysdate,
                        i.edi_integra_critica = vErro
                  Where i.rowid = c_msg1.rowid;     
               End;
            End Loop;     
      Exception
         When OTHERS Then
            vErro := sqlerrm;
            update tdvadm.t_edi_integra i
              set i.edi_integra_processado = sysdate,
                  i.edi_integra_critica = vErro
            Where i.rowid = c_msg.rowid;     
         End;


   End Loop; 

/*   
   -- Critica
      select i.edi_integra_protocolo protocolo,
             'CLiente' tipo ,
             i.edi_integra_col02 GLB_CLIENTE_CGCCPFCODIGO,
             i.edi_integra_col03 GLB_CLIENTE_RAZAOSOCIAL,
             i.edi_integra_critica   
      from tdvadm.t_edi_integra i
      where i.edi_integra_protocolo = 1839062
        and i.edi_integra_critica <> 'OK'
      union
      select i.edi_integra_protocolo protocolo,
             'Endereco' tipo ,
             i.edi_integra_col01 || '-' || i.edi_integra_col02 GLB_CLIENTE_CGCCPFCODIGO,
             i.edi_integra_col03 GLB_CLIENTE_RAZAOSOCIAL,
             i.edi_integra_critica   
      from tdvadm.t_edi_integra i
      where i.edi_integra_protocolo = 1839063
        and i.edi_integra_critica <> 'OK';
*/      


end;
0
0
