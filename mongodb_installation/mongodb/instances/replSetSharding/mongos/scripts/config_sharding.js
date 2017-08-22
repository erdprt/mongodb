sh.addShard("sharda/localhost:3200,localhost:3300")
sh.addShard("shardb/localhost:5200,localhost:5300")

sh.enableSharding("db_sharding_test")
db.test.ensureIndex({_id : "hashed"})
sh.shardCollection("db_sharding_test.persons",  { "_id": "hashed" })