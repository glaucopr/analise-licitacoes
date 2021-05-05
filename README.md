# Análise dos Vencedores de Licitações Públicas por Agrupamento

https://github.com/glaucopr/analise-licitacoes/

#### Aluno: Glauco Pires Rabello (glaucorabello@gmail.com) 
#### Orientador: Felipe Borges (felipe.borges@ele.puc-rio.br)

--------------

### BI MASTER - Business Inteligence Master - Projeto Final - Maio 2021
#### Pré-requisito para conclusão de curso e obtenção de crédito na disciplina "Projetos de Sistemas Inteligentes de Apoio à Decisão". (https://ica.puc-rio.ai/bi-master)

--------------

### Sumário
Estudar o comportamento e identificar padrões da base pública dos vencedores das licitações públicas, apontar suas similaridades e eventuais outliers.
Foi construída uma base informacional, carregando os arquivos disponibilizados nestas bases públicas, realizando mais tratamentos para transformações informacionais e utilizando em seguida para as devidas análises utilizando ferramentas de Data Mining.   


#### Arquivos Públicos
1. Portal da Transparência ( http://www.portaltransparencia.gov.br/download-de-dados )
2. Dados públicos de CNPJ ( https://www.receita.economia.gov.br/orientacao/tributaria/cadastros/cadastro-nacional-de-pessoas-juridicas-cnpj/dados-publicos-cnpj )
3. Dados Abertos ( https://dados.gov.br/ )


------------------------
### Estruturação Informacional
Foram baixados dos site mencionados e carregados os seguintes arquivos para construção de uma base de amostras para executar os testes.

#### Licitações 
    • ItemLicitação ; lista dos vencedores por licitação
    • Licitações  ; lista de participantes por licitação
      
#### Sanções
    • Empresas Inidoneas
    • Empresas Impedidas
    • Empresas Punidas
    • Acordo Leniencia

#### Receita Federal
    • Base completa de CNPJ – referencia nov/2020
    • Dominios: Motivo Situação Cadastral, CNAE e qualificação sócio representante

obs: O período de referencias das informações extraídas foi de janeiro/2020


------------------------------
### Preparação

Para este trabalho foram carregados bases grandes, eventualmente foi necessário reduzir o volume , retirando Pessoas Físicas da analise e reduzindo a mostra em apenas um unico mês de referência.

Foi criado um arquivo com estes dados tratados:  amostra_cnpj_202001.zip 

-----------------------------
### Análise Exploratória
Nesta etapa, já com os dados carregados no banco de dados, foi realizado fase uma análise inicial para identificar quais dados poderiam ser aproveitadas nas análises seguintes. 
- Códigos contidos no arquivo 1-licitacoes_cnpj_analise_exploratoria.ipynb

![AnlseExplor1](imagens/1.analise_exploratoria.png)
![AnlseExplor2](imagens/2.analise_exploratoria.png)

Com os dados disponíveis foi iniciada a modelagem  para a identificação de possíveis similaridades.

![Jupyter](imagens/3.AmostraJupyter.png)

----------------------------
#### Análise variável ‘Modalidade de Compras’
Como esta variável é a mais importantes do dataset, pois é a que define o motivo da licitação, foi realizado um teste no dataset mantendo esta informação para confirmação.

No processo de construção de modelo, para melhor a analise convertendo as váriaveis categóricas em numéricas por Encoding e depois aplicando o método de PCA.

Nesta etapa descobrimos algumas variáveis que deverão definir este modelo. ( foi escolhido 80% para explicar esses dados )

![VarianciasComPCA](imagens/4.VarianciasPCA.png)


####Teste com método K-Means
Este teste foi gerado para identificar se seria possível usá-lo, pois é um método de fácil implantação. Desta maneira verificamos o K através da inércia do modelo e analisando se o modelo gerado trará bons resultados.
Após a execução do K-Means, visualmente chegamos a este resultado que pode ser facilmente interpretado como um método ruim para este dataset.

![KMeans](imagens/5.KMeans.png)

####Algoritmo DBSCAN

Escolha deste método por não ter uma quantidade de clusters pré-definidos e encontrar quase toda as formas. 

Através de algumas inferências podemos escolher as parametrizações melhores.

Chegamos a um ótimo resultado desde já. 

![DBSCAN](imagens/6.DBSCAN.png)

Uma reparametrização no algoritmo pode melhorar este resultado para um ajuste fino. Observando que é necessário equilibrar a quantidade de clusters e outliers e as frequências individuais dos clusters.

Alguns outliers gerados foram identificados desta maneira, pois estavam contidos em uma faixa com poucas amostras. Estes outliers também poderiam ser identificados como um pequeno cluster rotulado. 


Conforme figura abaixo, podemos questionar a parametrização do modelo e realizar ajustes.

![SegAmostras](imagens/7.ClustersPoucasAmostras.png)

A variável ano_ini_atividade tambem ajudou na identificação de alguns outliers, mas pontos mais isolados.

![Outliers](imagens/8.Outliers.png)

Assim concluímos que os clusters identificados (Gráfico 8) se encaixam “exatamente” com as amostras de Modalidade de Compras. 

![Modalidades](imagens/9.Modalidades.png)

- Códigos disponíveis no arquivo 2-licitacoes_cnpj_agrupamento_todas_modalidades.ipynb

-----------------------

### Analise por Modalidade de Compra

Foi escolhido a modalidade com maior quantidade de amostras para prosseguimento das analise.

Após a execução do algoritmo DBSCAN foi encontrado este resultado.

![ResultadoPregao](imagens/10.ResultadoPorPregao.png)

Foram necessárias várias re-execuções deste algorimo, após a identificação de valores de eps e min amostras, reparametrizando-os, pois foi identificado uma possível melhoraria dos resultados ( menos clusters, menos outliers ) 
Inicialmente usamos um valor de eps muito baixo cujo resultado ficou bem ruim, com muitos clusters. 

####Análise Resultados
Após a execução esse resultado foi gerado
    
![TotalClusters](imagens/11.TotaisClusters.png)

No gráfico acima, ver no Jupyter, que os clusters ficaram bem definidos com estas duas variáveis. Como ainda pode-se identificar na tabela abaixo que as segmentações foram criadas.

![TabPorPorte](imagens/12.AberturaporPorte.png)

![ResultadoSegmentoPorte](imagens/13.ResultadosporSegmentoPorte.png)


#### Outliers
Da mesma maneira da análise com dataset completo, os clusters gerados tem a mesma caracteristica como identificamos visualmente 
- A variável ‘ano inicio atividade’ foi um dos fatores de separação;
- Alguns clusters tem a mesma quantidade de amostras de pequenos outliers abaixo, será necessário algum ajuste fino no algoritmo para incluir alguns destes registros. 
    
![OutliersFinal](imagens/14.Outliers.png)


-----------------------
### Conclusões Finais 
Identificados clusters atraves de similaridades por Modalidades de Compra.

Caso selecionamos outra modalidade ( ou adicionar outros filtros ) o resultado gerado pode ser diferente. Nestes casos sempre serão necessários a reparametrização diferente no DBSCAN.

Conseguimos demonstrar que a clusterização é viável com as variáveis disponíveis neste dataset publico e realizar a segmentação com as similaridades descobertas. 

Sempre que houver alguma necessidade adicional o algortimo pode ser reexecutado diversas vezes , com novos parametros para melhorar mais o resultado. Haverá um custo de processamento maior se a quantidade de amostras do dataset for maior e na quantidade de iterações necessárias para comparação dos resultados.
 
Ainda foi percebido que a análise pode ter continuidade, adicionando mais variáveis e um dataset maior para que possa melhorar a qualidade dos resultados e reduzindo outliers. Ainda posteriormente pode-se adicionar outros métodos supervisionados de análise para previsão com novas entradas de dados.

  
### Bibliografia


### Anexos
#### Dicionario de Dados
+---------------------+--------------+-----------------------------------------+
| Field               | Type         | Descricao                               |
+---------------------+--------------+-----------------------------------------+
| mesref              | char(6)      | mes de referencia da licitacao          |
| num_licitacao       | varchar(255) | Número que identifica a licitação SIASG |
| cod_ug              | varchar(255) | Número do processo da licitação         |
| dat_resultado       | date         | data do resultado                       |
| modal_compra        | varchar(255) | modalidade de compra na licitacao       |
| objeto              | text         | objeto da licitacao                     |
| cnpj                | varchar(255) | cnpj do licitante vencedor              |
| tipo_pessoa         | varchar(2)   | tipo de pessoa NO                       |
| ind_matriz          | char(1)      | indicador matriz ou filial              |
| razao_social        | varchar(150) | razao social do licitante               |
| situacao_cadastral  | varchar(8)   | descricao situacao cadastral            |
| dat_sit_cadastral   | date         | data situacao cadastral                 |
| ano_sit_cadastral   | int(4)       | ano situacao cadastral                  |
| motiv_sit_cadastral | varchar(255) | motivo situacaocadastral se nao ativa   |
| tipo_nat_juridica   | varchar(255) | tipo nat juridica                       |
| dat_ini_ativ        | date         | data inicio atividade                   |
| ano_ini_ativ        | int(4)       | ano inicio atividade                    |
| qualif_resp         | varchar(255) | qualificacao do responsavel da empresa  |
| setor_cnae          | varchar(255) | setor cadastro CNAE                     |
| porte_empr          | varchar(13)  | porte empresarial                       |
| opt_simples         | varchar(11)  | optante pelo simples                    |
| motiv_impedimento   | varchar(255) | motivo de eventual impedimento          |
| motiv_punicao       | varchar(255) | motivo punicao                          |
| motiv_inidonea      | varchar(255) | motivo inidonea                         |  
+---------------------+--------------+-----------------------------------------+


  
