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
    • Portal da Transparência ( http://www.portaltransparencia.gov.br/download-de-dados )
    • Dados públicos de CNPJ ( https://www.receita.economia.gov.br/orientacao/tributaria/cadastros/cadastro-nacional-de-pessoas-juridicas-cnpj/dados-publicos-cnpj )
    • Dados Abertos ( https://dados.gov.br/ )


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

obs: O período de informações extraídas compreendeu do período jan-out 2020.


-----------------------
### Conclusões Finais 
Identificados clusters atraves de similaridades por Modalidades de Compra.

Caso selecionamos outra modalidade ( ou adicionar outros filtros ) o resultado gerado pode ser diferente. Nestes casos sempre serão necessários a reparametrização diferente no DBSCAN.

Conseguimos demonstrar que a clusterização é viável com as variáveis disponíveis neste dataset publico e realizar a segmentação com as similaridades descobertas. 

Sempre que houver alguma necessidade adicional o algortimo pode ser reexecutado diversas vezes , com novos parametros para melhorar mais o resultado. Haverá um custo de processamento maior se a quantidade de amostras do dataset for maior e na quantidade de iterações necessárias para comparação dos resultados.
 
Ainda foi percebido que a análise pode ter continuidade, adicionando mais variáveis e um dataset maior para que possa melhorar a qualidade dos resultados e reduzindo outliers. Ainda posteriormente pode-se adicionar outros métodos supervisionados de análise para previsão com novas entradas de dados.

  
  
  
