//config = {_id: 'sharda', members: [
//               {_id: 0, host: 'localhost:3200'},
//               {_id: 1, host: 'localhost:3300'},
//               {_id: 3, host: 'localhost:3400'}]
//           };
config = {_id: 'sharda', members: [
               {_id: 0, host: 'localhost:3200'},
               {_id: 1, host: 'localhost:3300'}]
           };

rs.initiate(config);
rs.status(); 