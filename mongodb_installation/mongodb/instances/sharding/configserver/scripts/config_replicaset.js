config = {_id: 'configserver_replset',
          configsvr: true, 
          members: [
               {_id: 0, host: 'localhost:3100'}]
           };
rs.initiate(config);
rs.status();