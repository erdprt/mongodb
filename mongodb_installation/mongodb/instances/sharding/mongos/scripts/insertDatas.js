conn = new Mongo("localhost:3000");
db = conn.getDB("dbShardingTest");
//use dbShardingTest
for (var i = 1; i <=1000; i++) db.persons.insert( { name : "name" + i } )