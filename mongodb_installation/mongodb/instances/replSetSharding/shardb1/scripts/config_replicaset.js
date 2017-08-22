//config = {_id: 'shardb', members: [
//               {_id: 0, host: 'localhost:5200'},
//               {_id: 1, host: 'localhost:5300'},
//               {_id: 3, host: 'localhost:5400'}]
//           };
config = {_id: 'shardb', members: [
               {_id: 0, host: 'localhost:5200'},
               {_id: 1, host: 'localhost:5300'}]
              };

rs.initiate(config);
rs.status(); 