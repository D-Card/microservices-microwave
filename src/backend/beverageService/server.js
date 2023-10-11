var express = require("express");
var app = express();

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  next();
});

app.get("/", (req, res) => {
  const volume = parseInt(req.query["weight"]);
  const time = volume * 0.005;
  console.log(
    `A ${req.query["weight"]}ml beverage is going to be ready in ${time} minutes`
  );
  res.send({ time });
});

app.listen(80, () => {
  console.log("beverageService listening at port 80");
});
