var express = require("express");
var app = express();

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

app.get("/", (req, res) => {
  const weight = parseInt(req.query["weight"]);
  const time = weight * 0.07;
  console.log(
    `A ${req.query["weight"]}g potato is going to be ready in ${time} minutes`
  );
  res.send({ time });
});

app.listen(80, () => {
  console.log("potatoService listening at port 80");
});
