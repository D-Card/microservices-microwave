var express = require("express");
var app = express();

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

app.get("/", (req, res) => {
  const time = 3;
  console.log(`The popcorn is going to be ready in ${time} minutes`);
  res.send({ time });
});

app.listen(80, () => {
  console.log("popcornService listening at port 80");
});
