config = {_id: 'shard1_replset',
          members: [
               {_id: 0, host: 'localhost:3200'},
               {_id: 1, host: 'localhost:3205'},
               {_id: 2, host: 'localhost:3210'}
               ]
           };
rs.initiate(config);
rs.status(); 