$(document).ready(function() {
    getColors();
    // make it loop every 100 milliseconds
    var interval = setInterval(function(){
        getColors();
      }, 100); // every 100 milliseconds
});

function getColors() {
    urlRequest.session("https://steelhacks.herokuapp.com/colors/1", "GET", null, function(data) {
       if(data) {
            console.log("Data: " + JSON.stringify(data));
            $("#color1Div").css("background-color" , 'rgba(' + data.red + "," + data.green + ","  + data.blue + ",1");
        }
    });
    urlRequest.session("https://steelhacks.herokuapp.com/colors/2", "GET", null, function(data) {
       if(data) {
            $("#color2Div").css("background-color" , 'rgba(' + data.red + "," + data.green + ","  + data.blue + ",1");
        } 
    });
    urlRequest.session("https://steelhacks.herokuapp.com/colors/3", "GET", null, function(data) {
       if(data) {
            $("#color3Div").css("background-color" , 'rgba(' + data.red + "," + data.green + ","  + data.blue + ",1");
        }
    });
    urlRequest.session("https://steelhacks.herokuapp.com/colors/4", "GET", null, function(data) {
       if(data) {
            $("#color4Div").css("background-color" , 'rgba(' + data.red + "," + data.green + ","  + data.blue + ",1");
        }
    });
    urlRequest.session("https://steelhacks.herokuapp.com/colors/5", "GET", null, function(data) {
        if(data) {
            $("#color5Div").css("background-color" , 'rgba(' + data.red + "," + data.green + ","  + data.blue + ",1");
        }
    });

}