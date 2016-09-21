# retrieve

Este módulo tem como finalidade baixar os 100 últimos tweets de dadas hashtags.

## Pré requisitos

### 0. Conta no twitter, App no twitter.
 
### 1. [twurl](https://github.com/twitter/twurl)

```
gem install twurl 

twurl authorize -u <<USER>> -p <<PASSWORD>> --consumer-key <<CONSUMER_KEY>> --consumer-secret <<CONSUMER_SECRET>> 

```
Visitar a URL mencionada, fazer login na sua conta e copiar o PIN para autorizar o twurl a acessar a API do Twitter.
 
 
### 2 [jq](https://stedolan.github.io/jq/) 

No Mac:

```
brew install jq 
```
Em outras plataformas: [https://stedolan.github.io/jq/download/](https://stedolan.github.io/jq/download/)


## retrieve.sh

```
sh download.sh hashtags 
```
Este script baixa os 100 mais recentes tweets contendo cada hashtag que está listada no arquivo de entrada ./hashtags em um diretório ./download/. 


Obs: ao final do download, o script faz o upload da pasta para o diretório home do hdfs, necessário para a fase seguinte, onde o Spark busca os arquivos. 

