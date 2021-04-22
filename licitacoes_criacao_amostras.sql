/*
BI Master
Trabalho Final de Conclusão de Curso Bi- Master 
Consolidação das bases publicas de licitação e adicionanado dados de CNPJ
Glauco Pires Rabello       
Turma 2019.1
*/
use licitacao;

-- Selecionar uma amostra de CNPJ vencedores
drop table if exists amostra_cnpj_vencedor;
create table amostra_cnpj_vencedor as 
select distinct  
      itm.mesref
	, itm.num_licitacao
	, itm.cod_ug
    , itm.cnpj_vencedor
    , case length( itm.cnpj_vencedor )  
		when 11 then 'PF'
        when 14 then 'PJ'
        else 'ND'
		end as tipo_pessoa
	, nom_vencedor
	, descricao 
    , lic.dat_abertura
    , lic.dat_resultado
    , lic.modal_compra
    ,  trim(replace(lic.objeto, 'Objeto:', '')) Objeto
	, ini.tipo_sancao 		motiv_inidonea
    , pun.tipo_sancao 		motiv_punicao
    , pun.dat_fim_sancao    fim_punicao
    , lnc.dat_fim_acordo	
    , imp.motiv_impedimento
from tb_cgu_licitacao_item itm
	inner join tb_cgu_licitacao                lic on lic.num_licitacao=itm.num_licitacao and lic.cod_ug=itm.cod_ug
	left join tb_cgu_sancao_empresa_inidonea   ini on itm.cnpj_vencedor = ini.cpf_cnpj  and lic.dat_resultado between ini.dat_ini_sancao and ini.dat_fim_sancao
	left join tb_cgu_sancao_empresa_punida     pun on itm.cnpj_vencedor = pun.cpf_cnpj  and lic.dat_resultado between pun.dat_ini_sancao and pun.dat_fim_sancao
	left join tb_cgu_sancao_acordo_leniencia   lnc on itm.cnpj_vencedor = lnc.cpf_cnpj  and lic.dat_resultado between lnc.dat_fim_acordo and lnc.dat_fim_acordo
	left join tb_cgu_sancao_entidade_impedida  imp on itm.cnpj_vencedor = imp.cnpj
where itm.mesref='202001';

# Apenas PJ como vencedores
drop table if exists amostra_cnpj;
create table amostra_cnpj 
select
      v.mesref   
    , v.num_licitacao
	, v.cod_ug
    , v.dat_resultado
	, v.modal_compra
    , v.objeto
	, v.cnpj_vencedor cnpj 
    , v.tipo_pessoa
	, c.ind_matriz
    , c.razao_social 
    , c.situacao_cadastral
    , date(c.dat_sit_cadastral) dat_sit_cadastral, year(c.dat_sit_cadastral) ano_sit_cadastral
    , c.motiv_sit_cadastral
    , c.tipo_nat_juridica
    , date( c.dat_ini_ativ) dat_ini_ativ, year(c.dat_ini_ativ) ano_ini_ativ
    , c.qualif_resp
    , c.setor_cnae
    , c.porte_empr
    , c.opt_simples
    , v.motiv_impedimento  
    , v.motiv_punicao      
    , v.motiv_inidonea          
from amostra_cnpj_vencedor v
  inner join tb_pub_cnpj c on v.cnpj_vencedor = c.cnpj;

