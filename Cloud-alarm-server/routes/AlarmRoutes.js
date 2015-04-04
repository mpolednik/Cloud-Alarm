var express = require('express');
var router = express.Router();
var Alarm = require('../models/AlarmModel');


router.get('/', function(req, res) {
    Alarm.find({}, function(err,data) {
        res.status(200).json(data);
    });
});

router.post('/', function(req, res, next) {
        if(req.body.title === undefined) { // Better one validation than nothing
            console.log(req.body);
            res.status(400).send("Title is missing");
        } else {
            next();
        }
    },
    function(req, res) {
        console.log(req.body);

        var alarm = createNewAlarm(req.body);

        alarm.save(function(err) {
            if (err)
                res.send(err);

            res.status(201).json({ message: 'Alarm added to the dtb!', data: alarm });
        });
    }
);

router.get('/:id', function(req, res, next) { // example http://localhost:3000/alarms/1
        if (req.params.id === undefined) {
            res.status(400).send("Id is undefined");
        } else {
            next();
        }
    },
    function(req, res) {
        Alarm.findById(req.params.id, function(err,data) {
            if (err)
                res.send(err);
            res.status(200).json(data);
        });
    }
);

router.put("/:id", function(req, res) {
    Alarm.findById(req.params.id, function(err, data) {
        if (err)
            res.send(err);

        var alarm = copyValuesOfAlarm(data, req.body);

        alarm.save(function(err) {
            if (err)
                res.send(err);

            res.status(200).json(data);
        });
    });
});

router.delete('/:id', function(req, res, next) { // example http://localhost:3000/alarms/1
        if (req.params.id === undefined) {
            res.status(400).send("Id is undefined");
        } else {
            next();
        }
    },
    function(req, res) {
        var id = req.params.id;
        Alarm.findOneAndRemove({ _id : id}, function(err) {
            if (err)
                res.send(err);
            res.status(200).send("Removed");
        });
    }
);

function createNewAlarm(requestBody) {
    var alarm = new Alarm();
    alarm._id = requestBody.id;
    alarm.title = requestBody.title;
    alarm.hour = requestBody.hour;
    alarm.minute = requestBody.minute;
    alarm.enabled = requestBody.enabled;
    alarm.repeat = requestBody.repeat;
    alarm.days = requestBody.days;
    return alarm;
};

function copyValuesOfAlarm(alarmTo, alarmFrom) {
    var alarm = new Alarm();
    alarmTo.title = alarmFrom.title;
    alarmTo.hour = alarmFrom.hour;
    alarmTo.minute = alarmFrom.minute;
    alarmTo.enabled = alarmFrom.enabled;
    alarmTo.repeat = alarmFrom.repeat;
    alarmTo.days = alarmFrom.days;
    return alarmTo;
};


module.exports = router;