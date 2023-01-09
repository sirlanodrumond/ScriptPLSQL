-- Mudanca de Senha do Banco
 
/*select tdvadm.pkg_glb_menutdv.fn_DesencriptaSenha('•.%\#‹"[‚‚ww_:') from dual;
select tdvadm.pkg_glb_menutdv.fn_EncriptaSenha('skas12','skas12') from dual;

select tdvadm.pkg_glb_menutdv.fn_DesencriptaSenha(u.usu_usuario_senha) 
from tdvadm.t_usu_usuario u
where u.usu_usuario_codigo = 'jsantos'


alter table tdvadm.t_usu_usuario modify (usu_usuario_senha char(30)); 

update tdvadm.t_usu_usuario u
  set u.usu_usuario_senha = tdvadm.pkg_glb_menutdv.fn_EncriptaSenha(tdvadm.pkg_glb_menutdv.fn_DesencriptaSenha(u.usu_usuario_senha),'skas12');
commit;
  
 alter user TDVADM identified by skas12;
 

*/


