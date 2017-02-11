var express = require("express");
var app = express();
var mongoose = require("mongoose");
var path =  require("path");

mongoose.connect("mongodb://bschmuck:password123@ds149049.mlab.com:49049/steelhacks");
var Color = require("./models/color");

app.use("/", express.static(__dirname + '/public'));


app.get("/", function(req, res) {
	res.sendFile(path.join(__dirname+'/index.html'));
});

//Get color 1
app.get("/colors/:id", function(req, res) {
	Color.findOne({"identifier" : req.params.id}, function(err, color) {
		if(err) {
			console.log(err); 
			res.sendStatus(500);
		} else if(color){
			res.writeHead(200, {"Content-Type": "application/json"});
			res.end(JSON.stringify(color));
		} else {
			console.log("Color not found.\n");
			res.writeHead(200, {"Content-Type": "application/json"});
			res.end(JSON.stringify({red: 0, green: 0, blue: 0, identifier: 1, name: "white"}));
		}
	})
});

app.post("/colors/:id", function(req, res) {
	Color.findOne({"identifier" : req.params.id}, function(err, color) {
		if(err) {
			console.log(err); 
		} else if(color){
			color.red = Number(req.query.red);
			color.green = Number(req.query.green);
			color.blue = Number(req.query.blue);
			color.name = req.query.name;
			color.save();
			res.sendStatus(200);
		} else {
			var dict = {
			    red: Number(req.query.red),
			    green: Number(req.query.green),
			    blue: Number(req.query.blue), 
			    name: req.query.name,
			    identifier: Number(req.params.id)
			};
			Color.create(dict, function(err, color) {
				if(err) {
					console.log(err); 
					res.sendStatus(500);
				} else {
					res.sendStatus(200);
				}
			})
		}
	})
})

var port = process.env.PORT || 8080;
app.listen(port, function(){
	console.log("Listening on Port " + port + "...");
});