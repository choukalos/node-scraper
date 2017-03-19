// Route for detecting site software and gathering site info
// example curl -XPOST -H "Content-Type: application/json" -d '{"urls":["http://google.com","http://magento.com","http://hellyhanson.com"]}' http://localhost:3000/performance/pageload

var express          = require('express');
var router           = express.Router();
var performancecode  = require('../lib/performance');

/* POST lookup */
router.post('/pageload',function(req,res,next) {
	performancecode.PageLoad(req.body.urls,function(err,rc) {
		console.log("Post to Batch Pagespeed:");
		res.end(JSON.stringify(rc),null,3);
	});
});

module.exports = router;
