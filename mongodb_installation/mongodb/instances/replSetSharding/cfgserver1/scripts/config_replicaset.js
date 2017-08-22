rs.initiate(
  {
    _id: "cfgServer",
    configsvr: true, //indicates it is config server replica-set
    members: [
      { _id : 0, host : "localhost:3100" },
      { _id : 1, host : "localhost:3110" },
      { _id : 2, host : "localhost:3120" }
    ]
  }
)