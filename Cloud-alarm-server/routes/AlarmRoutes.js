var express = require('express');
var router = express.Router();
var Alarm = require('../entities/AlarmModel');


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
        new Alarm({
            _id: req.body.id,
            title: req.body.title,
            hour: req.body.header,
            minute: req.body.minute,
            enabled: req.body.enabled,
            repeat: req.body.repeat,
            days: req.body.days
        }).save();
        res.status(201).send("created");
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
        var id = req.params.id;
        Alarm.find({ _id : id}, function(err,data) {
            res.status(200).json(data);
        });
    }
);

router.delete('/:id', function(req, res, next) { // example http://localhost:3000/alarms/1
        if (req.params.id === undefined) {
            res.status(400).send("Id is undefined");
        } else {
            next();
        }
    },
    function(req, res) {
        var id = req.params.id;
        Alarm.findOneAndRemove({ _id : id}, function() {
            res.status(200).send("Removed");
        });
    }
);

module.exports = router;