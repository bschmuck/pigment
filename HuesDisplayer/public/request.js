var URLRequest = (function() {
function URLRequest() {
    	this.session = function(URL, method, data, callback) {
    		$.ajax({
    			url: URL,
    			type: method,
    			data: data,
    			complete: function(result) {
    				if(result.status == 200) {
                        callback(JSON.parse(result.responseText));
    				}
    			}
    		});
    	}
    }
    return URLRequest;
}());

var urlRequest = new URLRequest();