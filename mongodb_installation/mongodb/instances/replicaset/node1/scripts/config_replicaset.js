config = {_id: 'replSet', members: [
               {_id: 0, host: 'localhost:3200'},
               {_id: 1, host: 'localhost:3205'},
               {_id: 2, host: 'localhost:3210'},
               {_id: 3, host: 'localhost:3215'},                              
               {_id: 4, host: 'localhost:3220', arbiterOnly: true}]
           };
rs.initiate(config);
rs.status(); 