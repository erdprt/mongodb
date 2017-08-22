conn = new Mongo("localhost:10000");
db = conn.getDB("test");
for (var i = 1; i <= 50000; i++) db.person.insert({ firstname : "firstname" + i , lastname : "lastname" + i, "civility": "M" } );
for (var i = 1; i <= 50000; i++) db.address.insert({ firstname : "firstname" + i , street : "street" + i, country : "France" } );