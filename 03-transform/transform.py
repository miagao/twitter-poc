from pyspark.sql import SparkSession
from pyspark.sql.types import BooleanType, TimestampType
from pyspark.sql.functions import udf, col, hour, explode
from datetime import datetime, timedelta


spark = SparkSession\
    .builder\
    .appName("PythonSQL")\
    .config("spark.some.config.option", "some-value")\
    .getOrCreate()

hashtags = ["#brasil", "#brazil", "#brasil2016","#brasil2016","#jogosolimpicos","#olimpiadas","#olimpiadas2016","#olympics", "#rio2016","#riodejaneiro" ]

print 'Qual o numero de tweets em portugues para cada hashtag?'
for hash in hashtags: 
    print "hashtag: " + hash 
    df = spark.read.json("downloads/" + hash)
    exp = df.select(explode(df.statuses).alias("tweet"))
    print exp.where("tweet.lang=\"pt\"").count()


# read all downloaded files 
df = spark.read.json("downloads")
exp = df.select(explode(df.statuses).alias("tweet"))

# get  the top 5 users with more followers. 
print "Quais os 5 usuarios com o maior numero de seguidores? "
exp.select("tweet.user.screen_name", "tweet.user.followers_count").distinct().sort("followers_count", ascending=False).limit(5).show()

# group tweets based on the hour of the day
print "Mostrar o numero de tweets agregados por hora do dia"
def parse_dt():
  def _parse(dt):
    return datetime.strptime(dt, '%a %b %d %H:%M:%S +0000 %Y')
  return udf(_parse, TimestampType())

exp_with_timestamp = exp.withColumn("timestamp", parse_dt()(exp.tweet.created_at))

exp_with_timestamp.groupBy(hour("timestamp")).count().orderBy(hour("timestamp")).show(24)



