#!/bin/bash
rm -rf ./output 
mkdir ./output
rm -rf ./downloads 
mkdir ./downloads

filename=$1

if [ $# -ne 1 ]; then
    echo "Usage: $0 <hashtags file>"
    exit 1
fi


while IFS='' read -r hashtag || [[ -n "$hashtag" ]]; do
        echo "hashtag: $hashtag"
        twurl  "/1.1/search/tweets.json?result_type=recent&count=200&q=$hashtag" > ./downloads/$hashtag
        jq '[.statuses[] |{user: .user.screen_name, followers: .user.followers_count}]|sort_by(.followers)|reverse|.[0:5]' ./downloads/$hashtag > ./output/top5-$hashtag
        jq  '[.statuses[] |select(.user.lang=="pt")]|reduce .[] as $item (0; .+1)' ./downloads/$hashtag > ./output/pt-$hashtag
        jq '[.statuses[] |.created_at]' ./downloads/$hashtag >> tmp_hourly
done < "$filename"

echo "Hora, frequencia" >> ./output/hourly_freq.csv
for hour in `seq -w 00 23`
do 
  freq=`cat tmp_hourly|sort|awk '{print $4}'|awk -F ':' '{print $1}'|grep -c "$hour"`     
  echo "$hour,$freq" >> ./output/hourly_freq.csv
done
rm tmp_hourly
