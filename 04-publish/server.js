var express = require('express');
var app = express();
var fs = require("fs");
var async = require('async');

const cassandra = require('cassandra-driver');
const client = new cassandra.Client({ contactPoints: ['localhost'], keyspace: 'twitter_keyspace'});



app.get('/top_followers', function (req, res) {
    const query = 'SELECT user_id, followers_count FROM top_followers_count WHERE search_hashtag = ? LIMIT 5';
    console.log(req.params.hashtag);
    client.execute(query, req.params.hashtag , function(err, result) {
           if (!err){
               console.log("not err")
               if ( result.rows.length > 0 ) {
                   var user = result.rows[0];
                   console.log("name = %s, followers = %d", user.screen_name, user.followerss_count);
               } else {
                   console.log("No results");
               }
           }
    });
    
})

app.get('/pt_tweets', function (req, res) {
   fs.readFile( __dirname + "/" + "pt_tweets.json", 'utf8', function (err, data) {
      console.log( data );
      res.end( data );
   });
})

app.get('/tweets_by_hour', function (req, res) {
   fs.readFile( __dirname + "/" + "tweets_by_hour.json", 'utf8', function (err, data) {
      console.log( data );
      res.end( data );
   });
})

var server = app.listen(8081, function () {

   var host = server.address().address
   var port = server.address().port

   console.log("Example app listening at http://%s:%s", host, port)

})
