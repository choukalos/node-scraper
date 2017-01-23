// Detect.js library
// This library is designed to look at a URL and detect
//    Hostname, TLD, URLPath
//    Reverse IP lookup the Hostname to Geoip
//    Wappalyzer the URL to detect what software is running there*
//
// --------------------- Requires -------------------------
var   geoip      = require('geoip-lite');
var   dns        = require('dns');
const wappalyzer = require('@wappalyzer/wappalyzer');
var   tldparser  = require('tld-extract');
// --------------------- Functions ------------------------
// Function:  ip_lookup with callback function
function ip_lookup(hostname,callback){
//	console.log("looking up hostname ip", hostname);
	dns.lookup(hostname,function(err,addresses,family) {
		var result = {"ip":addresses,"family":family};
		callback(err,result);
	});
};
// Function:  geoiplookup with callback function
function geoip_lookup(ip,callback){
//	console.log('looking up ip',ip);
	var geo = geoip.lookup(ip);
	callback({},geo);
};
// Function:  json_safe_parse  syncronous function
function json_safe_parse(json) {
	var parsed
	try {
		parsed = JSON.parse(json);
	} catch (e) {
		// parsed = JSON.parse(JSON.stringify(json));  // this is just munged string
		// json.replace('=',"");					   // substitution does not work
		console.log("Odd JSON String from WAP:",json);
		// parsed = { wapstring: json };
	}
	return parsed
}
// Function:  wap_lookup with callback function
function wap_lookup(url,callback){
    var params = [url, '--quiet','--resource-timeout=10000'];
    wappalyzer.run(params, function(out,err) {
		var rc = json_safe_parse(out);
		callback({},rc);	
    });
};

// Function:  url_detect with callback function
function url_detect(hostname,path,callback){
	console.log('detecting url',hostname,path);
    var rc = tldparser("http://" + hostname);
	ip_lookup(hostname, function(err,res){
//		console.log("got ip:",res)
		Object.assign(rc,res);
		geoip_lookup(rc.ip, function(err,res){
//			console.log("got geoip:",res);			
			Object.assign(rc,res);
			wap_lookup("http://"+hostname+path,function(err,res){
//			  console.log("got wap:",res);
			  Object.assign(rc,res);	
			  callback({},rc);					
			});
		});	
	});
};
function geoip_detect(hostname,callback){
	console.log('detecting hostname:',hostname);
	var rc = tldparser("http://"+hostname);
	ip_lookup(hostname, function(err,res){
//		console.log("got ip:",res)
		Object.assign(rc,res);
		geoip_lookup(rc.ip, function(err,res){
//			console.log("got geoip:",res);			
			Object.assign(rc,res);	
			callback({},rc);					
		});
	});	
}
// Todo
//  - Batch Geoip Lookup Function
//  - Batch Wappalyzer Lookup Function
// Async JS iterative pattern - https://mostafa-samir.github.io/async-iterative-patterns-pt1/
//

// ------------------- Exports -----------------------------
exports.UrlDetect        = url_detect;
exports.LookupGeoip      = geoip_lookup;
exports.LookupWappalyzer = wap_lookup;
exports.LookupIp		 = ip_lookup;
exports.GeoipDetect		 = geoip_detect;

