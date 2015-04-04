/**
 * developed with using many tutorials. One of them is
 * tutorial: http://scottksmith.com/blog/2014/05/02/building-restful-apis-with-node/
 */

var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var passport = require('passport');
var bodyParser = require('body-parser');

var alarmController = require('./controllers/AlarmController');
var userController = require('./controllers/UserController');
var authController = require('./controllers/AuthController');

var db = require('./db/MongoDbClient'); // open db connection
var app = express();


app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(passport.initialize());

// Create our Express router
var router = express.Router();

// Create endpoint handlers for /alarms
router.route('/alarms')
    .post(authController.isAuthenticated, alarmController.postAlarm)
    .get(authController.isAuthenticated, alarmController.getAlarms);

// Create endpoint handlers for /beers/:id
router.route('/alarms/:id')
    .get(authController.isAuthenticated, alarmController.getAlarm)
    .put(authController.isAuthenticated, alarmController.putAlarm)
    .delete(authController.isAuthenticated, alarmController.deleteAlarm);

// Create endpoint handlers for /users
router.route('/users')
    .post(userController.postUser)
    .get(authController.isAuthenticated, userController.getUsers);


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
