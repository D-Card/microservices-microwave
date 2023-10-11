var express = require("express");
var app = express();

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

app.get("/", (req, res) => {
  const weight = parseInt(req.query["weight"]);
  const time = weight * 0.02;
  console.log(`The ${weight}g product is going to be ready in ${time} minutes`);
  res.send({ time });
});

app.listen(80, () => {
  console.log("defrostService listening at port 80");
});
