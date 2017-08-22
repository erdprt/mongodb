conn = new Mongo("localhost:10000");
db = conn.getDB("test");
db.setProfilingLevel(2,50);