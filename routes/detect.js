// Route for detecting site software and gathering site info
// example curl -XPOST -H "Content-Type: application/json" -d '{"hostname":"http://google.com","path":"/"}' http://localhost:3000/detect

var express     = require('express');
var router      = express.Router();
var detectcode  = require('../lib/detect');

/* POST lookup */
router.post('/url',function(req,res,next) {
   detectcode.UrlDetect(req.body.hostname,req.body.path,function(err,rc) {
     console.log("Post to Detect Route:");
     res.end(JSON.stringify(rc));
   });
});

router.post('/geoip',function(req,res,next) {
	detectcode.GeoipDetect(req.body.hostname,function(err,rc) {
		console.log("Post to Detect Geoip:");
		res.end(JSON.stringify(rc));
	});
});

module.exports = router;
