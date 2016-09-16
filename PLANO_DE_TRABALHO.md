O Sistema proposto tem 4 componentes distintos e encadeados, podendo ser modularizados, com preocupações ortogonais em relação à qualidade, operação e manutenabilidade do sistema.

##Parte 0: MVP
-- *mvp*

Input: hashtags
Output: agregações e validações de conceito

## Parte 1: Extração:
-- *retrieve*

Input: hashtags.

Output: arquivos de texto contendo 100 últimos tweets para cada hashtag. 

##Parte 2: Carga:
-- *load*

Input: arquivos contendo tweets. 

Output: carga de dados em banco de dados.

##Parte 3: Transformação
-- *transform*

Input: Regras de agregação e sumarização

Output: publicação da transformação em banco de dados  

##Parte 4: Publicação
-- *publish* 

Input: modelo de dados a serem disponibilizados 

Output: API REST desse modelo de dados

