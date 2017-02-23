
var express = require('express')
  , routes = require('./routes')
  , url = require('url')
  , bodyParser = require('body-parser')
  , proxy = require('proxy-middleware');

var app = module.exports = express.createServer();

app.use('/api/hotels', proxy(url.parse('https://m.travelrepublic.co.uk/api2/hotels/static/gethotelsbydestination')));
app.use('/api/destinations', proxy(url.parse('https://m.travelrepublic.co.uk/api2/destination/v2/search')));

// Configuration
app.configure(function () {
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({ extended: false }));
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function () {
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function () {
  app.use(express.errorHandler());
});

// Routes

app.get('/', routes.index);

app.listen(2020, function () {
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});
