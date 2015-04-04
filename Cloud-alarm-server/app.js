/**
 * developed with using many tutorials. One of them is
 * tutorial: http://scottksmith.com/blog/2014/05/02/building-restful-apis-with-node/
 */

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var db = require('./db/MongoDbClient'); // open db connection
var alarmController = require('./controllers/AlarmController');

var app = express();


app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

// Create our Express router
var router = express.Router();

// Create endpoint handlers for /alarms
router.route('/alarms')
    .post(alarmController.postAlarm)
    .get(alarmController.getAlarms);

// Create endpoint handlers for /beers/:id
router.route('/alarms/:id')
    .get(alarmController.getAlarm)
    .put(alarmController.putAlarm)
    .delete(alarmController.deleteAlarm);

// Register all our routes with /api
app.use('/api', router);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
