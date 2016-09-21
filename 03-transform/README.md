# transform

Este módulo produz as transformações necessárias para respondermos as 3 perguntas da questão 5.

## Pré requisitos

Spark 2.0.0 e pyspark instalados e configurados.

```
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_102.jdk/Contents/Home
export PATH=$PATH:$JAVA_HOME/bin
export HADOOP_HOME=${HOME}/opt/hadoop-2.7.2
export HADOOP_PREFIX=${HADOOP_HOME}
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop/
export SPARK_HOME=$HOME/opt/spark-2.0.0-bin-hadoop2.7/
export PATH=$PATH:$SPARK_HOME/bin
export PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH
```

Hadoop (local de armazenamento dos arquivos baixados do twitter do item anterior, o script assume que o diretorio /downloads está dentro da home do usuário hdfs) 

## As perguntas:

###1 - Da amostra coletada, quais os 5 usuários que tem mais seguidores?

###2 - Qual o total de tweets em português para cada hashtag?

###3 - Qual o total de postagens agrupadas por hora do dia?

## As respostas:

Para rodar o script, executar: 

`pyspark < transform.py` 

```

➜  03-transform git:(master) ✗ pyspark < transform.py
Setting default log level to "WARN".
To adjust logging level use sc.setLogLevel(newLevel).
16/09/21 05:44:19 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Qual o numero de tweets em portugues para cada hashtag?
hashtag: #brasil
16/09/21 05:44:26 WARN util.Utils: Truncated the string representation of a plan since it was too large. This behavior can be adjusted by setting 'spark.debug.maxToStringFields' in SparkEnv.conf.
25
hashtag: #brazil
7
hashtag: #brasil2016
54
hashtag: #brasil2016
54
hashtag: #jogosolimpicos
96
hashtag: #olimpiadas
48
hashtag: #olimpiadas2016
62
hashtag: #olympics
0
hashtag: #rio2016
1
hashtag: #riodejaneiro
24
Quais os 5 usuarios com o maior numero de seguidores?
+---------------+---------------+
|    screen_name|followers_count|
+---------------+---------------+
|    magdyelugaz|         945615|
|   NesterTweets|         925213|
| luxury__travel|         641665|
|       fersch_4|         597293|
|ViniciusRio2016|         417473|
+---------------+---------------+

Mostrar o numero de tweets agregados por hora do dia
+---------------+-----+
|hour(timestamp)|count|
+---------------+-----+
|              0|   25|
|              1|   52|
|              2|   32|
|              3|   37|
|              4|   17|
|              5|   11|
|              6|   72|
|              7|  166|
|              8|  182|
|              9|    4|
|             10|    6|
|             11|    6|
|             12|    5|
|             13|   10|
|             14|   18|
|             15|   14|
|             16|   32|
|             17|   29|
|             18|   26|
|             19|   27|
|             20|   45|
|             21|   28|
|             22|   23|
|             23|   23|
+---------------+-----+

```


