var mongoose = require("mongoose");

var ColorSchema = new mongoose.Schema({
    red: Number,
    green: Number,
    blue: Number, 
    name: String,
    identifier: Number
});


module.exports = mongoose.model("Color", ColorSchema);