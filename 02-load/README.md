# load

Este módulo tem como finalidade a carga dos dados baixados em **retrieve** em um banco de dados Cassandra.

## Pre requisitos

Cassandra 3.7 instalado

## DB Schema

### Cassandra

O esquema do banco de dados Cassandra necessita ser modelado em torno do padrão de queries que o sistema se propõe a servir. Nele o custo de uma operação de escrita é muito baixo, o que torna obrigatório o uso de desnormalização. 

O objetivos de otimização são o espalhar as chaves de particionamento e de minimizar o número de leituras em partições diferentes.

#### Keyspace 

Por se tratar de uma aplicação em fase de testes utilizarei uma keyspace simples em um só nó.

```
CREATE KEYSPACE IF NOT EXISTS twitter_keyspace 
WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 }
AND DURABLE_WRITES = true;

```

#### Padrão 1 - Top5 Followers

Para servir à busca dos top 5 usuários do twitter pelo número de followers:

 
```
CREATE TABLE status_by_hashtag (
  search_hashtag text,
  user_id text,
  user_id_hash text,
  status_id text,
  screen_name text,
  followers_count int,
  PRIMARY KEY (search_hashtag, user_id)
);

CREATE MATERIALIZED VIEW top_followers_count AS
       SELECT user_id, screen_name FROM status_by_hashtag
       WHERE search_hashtag IS NOT NULL AND user_id IS NOT NULL AND followers_count IS NOT NULL
       PRIMARY KEY (search_hashtag, followers_count, user_id)
       WITH CLUSTERING ORDER BY (followers_count  desc);
       
# TOP 5        
SELECT user_id, followers_count FROM top_followers_count WHERE search_hashtag = '#brasil' LIMIT 5;
       
```

Um ponto de melhoria aqui seria utilizar partition composta por uma função de hash, além da search_hashtag, para espalhar melhor a leitura no cluster.


#### Padrão 2 - número de tweets com lang=pt por search_hashtag

```
CREATE table tweets_by_lang
(
    lang text,
    status_id text,
    search_hashtag text,
    PRIMARY KEY (lang, hashtag, status_id)
);

SELECT count(*) FROM tweets_by_lang WHERE lang = 'pt' and search_hashtag = ?;

```

Aqui, como melhoria, além de utilizar uma função de hash para aumentar o espalhamento da chave primária, caso o número de tweets seja na casa dos milhões ou bilhões, devemos pensar em criar uma tabela com um contador específica para cada par lang x hashtag e um intervalo de tempo.


#### Padrão 3 - agregação de tweets por horas do dia

```
CREATE table tweets_by_datetime
(
    year int,
    month int,
    day int,
    hour int,
    status_id text,
    PRIMARY KEY (hour, day, month, year, status_id)
)

SELECT count(*) FROM tweets_by_datetime WHERE hour=? 

```



