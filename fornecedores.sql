-- Pegando os Fornecedores da TDV
select t.glb_fornecedor_cgccpf cnpj,
       f.glb_fornecedor_nome fornecedor,
       tc.cpg_despesas_codigo coddesp,
       d.cpg_despesas_descricao despesa,  
       sum(t.cpg_titulos_vltotal) valor,
       count(*) qtde,
       min(t.cpg_titulos_dtemissao) menordt,
       max(t.cpg_titulos_dtemissao) maiordt
from tdvadm.t_cpg_titulos t,
     tdvadm.t_glb_fornecedor f,
     tdvadm.t_cpg_tituloccusto tc,
     tdvadm.t_cpg_despesas d
where t.glb_fornecedor_cgccpf = f.glb_fornecedor_cgccpf
  and t.cpg_titulos_numtit = tc.cpg_titulos_numtit
  and t.glb_fornecedor_cgccpf = tc.glb_fornecedor_cgccpf
  and tc.cpg_despesas_codigo = d.cpg_despesas_codigo
  and t.cpg_titulos_dtemissao >= sysdate - 400
group by t.glb_fornecedor_cgccpf,f.glb_fornecedor_nome,tc.cpg_despesas_codigo,d.cpg_despesas_descricao;
   
-- Buscando fornecedores da BGM   
select f.nrinscricaoforn cnpj,
       f.rsocialforn,
       x.codtpdoc,
       sum(x.valortotalnf) valor,
       count(*) qtde,
       min(x.dataemissaonf) menor,
       max(x.dataemissaonf) maior
from bgm.BGM_FORNECEDOR f,
     bgm.BGM_NOTAFISCAL x
where f.codigoforn = x.codigoforn
group by f.nrinscricaoforn,
         f.rsocialforn,
         x.codtpdoc     

