-- Etiqueta - 001424687001620140300001040021000027440010001001
-- Nota 1   - 35190759609123001220550010006359541002857171
-- Nota 2   - 35190762014030000104550010011543551143975240

/* 1424687
<Parametros><Input><NotaNumero>1424687</NotaNumero><Serie>1</Serie><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaQtdeVolume>1</NotaQtdeVolume><UsuarioImprimiu></UsuarioImprimiu><NotaPeso>0</NotaPeso><QtdeVolume>1</QtdeVolume><PesoTotal>0</PesoTotal><DataImprimiu>30/12/1899</DataImprimiu><Codigo>-1</Codigo><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE><ChaveEtiquetaSAP></ChaveEtiquetaSAP><OrigemNota>SAP</OrigemNota><Items></Items></Input></Parametros>
<Parametros><Input><NotaPesagem><NotaNumero>1424687</NotaNumero><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE></NotaPesagem><ItemPeso>65</ItemPeso><UsuarioPesou>jsantos</UsuarioPesou><ItemSeq>0</ItemSeq><OrigemNota>SAP</OrigemNota></Input></Parametros>
<Parametros><Input><NotaPesagem><NotaNumero>1424687</NotaNumero><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE></NotaPesagem><ItemPeso>65</ItemPeso><UsuarioPesou>jsantos</UsuarioPesou><ItemSeq>1</ItemSeq><OrigemNota>SAP</OrigemNota></Input></Parametros>
*/



select p.usu_perfil_codigo,
       p.usu_perfil_descricao,
       p.usu_perfil_parat,
       p.usu_perfil_paran1,
       p.usu_perfil_paran2,
       p.usu_perfil_parad1,
       p.usu_perfil_parad2,
       p.usu_perfil_horario
from tdvadm.t_usu_perfil p
where p.usu_aplicacao_codigo = 'pesonota'
--  and p.usu_perfil_codigo = 'AMBIENTE'
for update;

select * from tdvadm.t_arm_notapesagem;
select * from tdvadm.t_arm_notapesagem_sap x 
where 0 = 0
  --AND x.arm_nota_numero = 1424687
  --AND X.GLB_CLIENTE_CGCCPFREMETENTE = 00162014030000'
for update
;
select * from tdvadm.t_arm_notapesagem_sap x ;
SELECT * FROM TDVADM.T_ARM_NOTAPESAGEMITEM_SAP
;
delete tdvadm.t_glb_sql x where x.glb_sql_programa = 'testemenu';
select * from tdvadm.t_glb_sql order by 2
for update

;
tdvadm.pkg_arm_notapesagem





