// first possibility
db.runCommand( { removeShard : "localhost:3215" } )
//sh.enableSharding("dbShardingTest")
//db.test.ensureIndex({_id : "hashed"})
//sh.shardCollection("dbShardingTest.persons",  { "_id": "hashed" })