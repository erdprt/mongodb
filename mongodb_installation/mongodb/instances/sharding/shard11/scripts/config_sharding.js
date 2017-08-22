// first possibility
sh.addShard( "localhost:3200")
sh.addShard( "localhost:3205")
sh.addShard( "localhost:3210")
// second possibility: more options
//db.runCommand( { addshard : "localhost:3200", allowLocal : true, name: "shard11" } )
//db.runCommand( { addshard : "localhost:3205", allowLocal : true, name: "shard12" } )
//db.runCommand( { addshard : "localhost:3210", allowLocal : true, name: "shard13" } )

sh.enableSharding("dbShardingTest")
db.test.ensureIndex({_id : "hashed"})
sh.shardCollection("dbShardingTest.persons",  { "_id": "hashed" })