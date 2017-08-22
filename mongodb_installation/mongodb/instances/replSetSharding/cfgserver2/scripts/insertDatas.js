conn = new Mongo("localhost:3100");
db = conn.getDB("db_sharding");
for (var i = 1; i <= 20000; i++) db.persons.insert( { x : i }, { name : "name" + i } );