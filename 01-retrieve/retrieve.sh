#!/bin/bash
rm -rf ./downloads 
mkdir ./downloads

filename=$1

if [ $# -ne 1 ]; then
    echo "Usage: $0 <hashtags file>"
    exit 1
fi

while IFS='' read -r hashtag || [ -n "$hashtag" ]; do
        echo "hashtag: $hashtag"
        twurl  "/1.1/search/tweets.json?result_type=recent&count=200&q=$hashtag" > ./downloads/$hashtag
done < "$filename"

hdfs dfs -put -f downloads 
