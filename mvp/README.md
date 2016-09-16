# MVP
Este MVP tem como finalidade fazer um protótipo rápido para baixar os dados e fazer as agregações em um ambiente local.

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


## download.sh

```
sh download.sh hashtags 
```
Este script baixa os 100 mais recentes tweets contendo cada hashtag que está listada no arquivo de entrada ./hashtags em um diretório ./download/. Faz as devidas agregações para se obter as 5 contas com mais seguidores, o número de tweets em português em cada set de tweets, e a agregação por hora do dia em todos os tweets baixados, e os armazena em um diretório ./output/. 

Um sample dos arquivos estão no repositório git.


### Resultados:

```
➜  mvp git:(master) ✗ ls output/
hourly_freq.csv      pt-#jogosolimpicos   pt-#riodejaneiro     top5-#jogosolimpicos top5-#riodejaneiro
pt-#brasil           pt-#olimpiadas       top5-#brasil         top5-#olimpiadas
pt-#brasil2016       pt-#olimpiadas2016   top5-#brasil2016     top5-#olimpiadas2016
pt-#brazil           pt-#olympics         top5-#brazil         top5-#olympics
pt-#brazil2016       pt-#rio2016          top5-#brazil2016     top5-#rio2016

➜  mvp git:(master) ✗ cat output/pt-\#olimpiadas2016
51

➜  mvp git:(master) ✗ cat output/top5-\#brazil2016
[
  {
    "user": "DAILYSQUIB",
    "followers": 102918
  },
  {
    "user": "DAILYSQUIB",
    "followers": 102918
  },
  {
    "user": "BridgeStateU",
    "followers": 7966
  },
  {
    "user": "wanerge_",
    "followers": 6410
  },
  {
    "user": "TomFazakerley",
    "followers": 2519
  }
]

➜  mvp git:(master) ✗ cat output/hourly_freq.csv
Hora, frequencia
00,51
01,91
02,386
03,4
04,11
05,3
06,8
07,6
08,7
09,2
10,6
11,4
12,20
13,17
14,17
15,18
16,37
17,20
18,26
19,19
20,23
21,36
22,49
23,53

```




