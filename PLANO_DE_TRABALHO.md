O Sistema proposto tem 4 componentes distintos e encadeados, podendo ser modularizados, com preocupações ortogonais em relação à qualidade, operação e manutenabilidade do sistema.

##Parte 0: MVP
-- *mvp*

Input: hashtags

Output: agregações e validações de conceito

Foram realizados vários testes, as agregações montadas serviram para validar o  conceito.


## Parte 1: Extração:
-- *retrieve*

Input: hashtags.

Output: arquivos de texto contendo 100 últimos tweets para cada hashtag.

A montagem da extração foi realizada rapidamente, pois não havia a necessidade de agendamento e streaming de dados. 

##Parte 2: Carga:
-- *load*

Input: arquivos contendo tweets. 

Output: carga de dados em banco de dados.

Esta parte engloba a modelagem do banco de dados e a carga do banco. A modelagem foi executada seguindo os objetivos de otimização do Cassandra e a carga dos dados ficou para trás.


##Parte 3: Transformação
-- *transform*

Input: Regras de agregação e sumarização

Output: publicação da transformação em banco de dados  

Dessa vez, a lógica e as regras de agregação e sumarização foram feitas, mas de novo a interface com o banco de dados ficou para trás.


##Parte 4: Publicação
-- *publish* 

Input: modelo de dados a serem disponibilizados 

Output: API REST desse modelo de dados

Nessa parte, somente consegui deixar o esqueleto da aplicação, com os pacotes que deveriam ser utilizados e os endpoints da aplicação montados. 



