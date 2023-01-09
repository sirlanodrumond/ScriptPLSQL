PL/SQL Developer Test script 3.0
54
Declare
  i           integer;
  vNotaNumero tdvadm.t_Arm_Notapesagem_Sap.arm_nota_numero%type;
  vNotaCNPJ   tdvadm.t_Arm_Notapesagem_Sap.glb_cliente_cgccpfremetente%type;
  vNotaChave  tdvadm.t_Arm_Notapesagem_Sap.arm_nota_chavenfe%type;
begin
  -- Call the procedure
  
   If :pxmlin is not null Then
  
      Select extractvalue(Value(V), 'Input/NotaNumero'),
             extractvalue(Value(V), 'Input/NotaCGCCPFRemetente'),
             extractvalue(Value(V), 'Input/NotaChaveNFE')
            into vNotaNumero, 
                 vNotaCNPJ,  
                 vNotaChave 
           From  TABLE(XMLSequence(Extract(xmltype.createxml(:pxmlin), '/Parametros/Input '))) V;     
  
      delete tdvadm.t_arm_notapesagem_sap p
      where p.arm_nota_numero = vNotaNumero
        and p.glb_cliente_cgccpfremetente = vNotaCNPJ
        and nvl(p.arm_nota_chavenfe,'x') = nvl(vNotaChave,'x');
      i := sql%rowcount;
      If i > 0  Then
         delete tdvadm.t_arm_notapesagemitem_sap p
         where p.arm_nota_numero = vNotaNumero
           and p.glb_cliente_cgccpfremetente = vNotaCNPJ
           and nvl(p.arm_nota_chavenfe,'x') = nvl(vNotaChave,'x');
         i := sql%rowcount;
      End If;
  
      pkg_arm_notapesagem.Sp_Insert_NotaPesagem(pxmlin => :pxmlin,
                                                pstatus => :pstatus,
                                                pmessage => :pmessage);
   End If;

  
--  ARM_NOTA_NUMERO, GLB_CLIENTE_CGCCPFREMETENTE, ARM_NOTA_SERIE, ARM_NOTAPESAGEMITEM_SEQ
   If :pxmlinItem is not null Then

     pkg_arm_notapesagem.sp_insert_notapesagemitem(pxmlin => :pxmlinItem,
                                                   pstatus => :pstatusItem,
                                                   pmessage => :pmessageItem);
   End If;

   If :pxmlinItem2 is not null Then

     pkg_arm_notapesagem.sp_insert_notapesagemitem(pxmlin => :pxmlinItem2,
                                                   pstatus => :pstatusItem2,
                                                   pmessage => :pmessageItem2);
   End If;


end;
9
pxmlin
1
<Parametros><Input><NotaNumero>1424687</NotaNumero><Serie>1</Serie><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaQtdeVolume>1</NotaQtdeVolume><UsuarioImprimiu></UsuarioImprimiu><NotaPeso>0</NotaPeso><QtdeVolume>1</QtdeVolume><PesoTotal>0</PesoTotal><DataImprimiu>30/12/1899</DataImprimiu><Codigo>-1</Codigo><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE><ChaveEtiquetaSAP></ChaveEtiquetaSAP><OrigemNota>SAP</OrigemNota><Items></Items></Input></Parametros>
5
pstatus
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessage
1
Nota Pesagem inserido com sucesso!
5
pxmlinitem
1
<Parametros><Input><NotaPesagem><NotaNumero>1424687</NotaNumero><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE></NotaPesagem><ItemPeso>65</ItemPeso><UsuarioPesou>jsantos</UsuarioPesou><ItemSeq>0</ItemSeq><OrigemNota>SAP</OrigemNota></Input></Parametros>
5
pstatusitem
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessageItem
1
Item Adicionado com sucesso!!!
5
pxmlinitem2
1
<Parametros><Input><NotaPesagem><NotaNumero>1424687</NotaNumero><NotaCGCCPFRemetente>00162014030000</NotaCGCCPFRemetente><NotaSequencia>0</NotaSequencia><NotaChaveNFE></NotaChaveNFE></NotaPesagem><ItemPeso>65</ItemPeso><UsuarioPesou>jsantos</UsuarioPesou><ItemSeq>1</ItemSeq><OrigemNota>SAP</OrigemNota></Input></Parametros>
5
pstatusitem2
1
N                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
5
pmessageItem2
1
Item Adicionado com sucesso!!!
5
6
cAmbiente

vNotaChave
vNotaCNPJ
vNotaNumero
i
