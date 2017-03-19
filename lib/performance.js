// Performance.js library
// This library is designed to look at a URL and analyze performance via a node scraper
//
// Depends on
//   paulirish/request-capture-har ; https://github.com/paulirish/request-capture-har
//   yslow-node                    ; https://www.npmjs.com/package/yslow-node
//   jsdom
// ---------------------- Requires ---------------
//var yslow = require('yslow-node');
//var jsdom = require('jsdom');
var   request	 = require('request');
// ---------------------- Functions --------------
// Function fetch_pageload() - get's page load time
function fetch_pageload(url,callback) {
	var rc  = { url: url };
	try {
		var sdate = new Date();
		request({url: url, json:true }, function(err,res,body){
			var edate     = new Date();
			var page_load = edate - sdate
			Object.assign(rc,{"status": res.statusCode, "page_load": page_load });
			console.log("Pageload: ",url," ",page_load,"ms status",res.statusCode);
		    callback({},rc);
		});
	} catch (e) {
		console.log("Pageload:  Error loading ",url );
		Object.assign(rc,{"pageload": 0,"status": nil });
		callback({},rc);
	}	
};
function batch_pageload(urls,callback) {
	var rc    = [];
	var count = 0;
	
	function report(err,res) {
		count++;
		rc.push(res);
		// Build up the return array when all callbacks handled
		if(count === urls.length)
			callback(null,rc);
	}
	// Queue up each url by traversing array
	for(var i=0;i<urls.length;i++) {
		var url = urls[i];
		fetch_pageload(url,report);
	}
};



// usage
// wrap around your request module
//const RequestCaptureHar = require('request-capture-har');
//const requestCaptureHar = new RequestCaptureHar(require('request'));

// ...
// `requestCaptureHar.request` is your `request` module's API.
// ...
//requestCaptureHar.request(uri, options, callback);

// Save HAR file to disk
//requestCaptureHar.saveHar(`network-waterfall_${new Date().toISOString()}.har`);

// You can also clear any collected traffic
//requestCaptureHar.clearHar();

//
//> require('fs').readFile('example.com.har', function (err, data) {
//    var har = JSON.parse(data),
//        YSLOW = require('yslow-node').YSLOW,
//        doc = require('jsdom').jsdom(),
//        res = YSLOW.harImporter.run(doc, har, 'ydefault'),
//        content = YSLOW.util.getResults(res.context, 'basic');
// 
//    console.log(content);
//});
//{ w: 98725, o: 89, u: 'http%3A%2F%2Fexample.com%2F', r: 9, i: 'ydefault', lt: 981 }



// ----------------------- Exports ----------------
exports.PageLoad        = batch_pageload;