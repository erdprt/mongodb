conn = new Mongo("localhost:3000");
db = conn.getDB("db_sharding_test");
//use dbShardingTest
for (var i = 1; i <=100000; i++) db.persons.insert( { name : "name" + i } )