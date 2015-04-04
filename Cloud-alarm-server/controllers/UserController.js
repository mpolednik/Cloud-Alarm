/**
 * Created by tomasskopal on 04.04.15.
 */

var User = require('../models/UserModel');

/**
 * Create endpoint /api/users for POST
 */
exports.postUser = function(req, res) {
    var user = new User({
        username: req.body.username,
        password: req.body.password
    });

    user.save(function(err) {
        if (err)
            res.send(err);

        res.status(201).json({ message: 'New user added!' });
    });
};

/**
 * Create endpoint /api/users for GET
 */
exports.getUsers = function(req, res) {
    User.find(function(err, users) {
        if (err)
            res.send(err);

        res.status(200).json(users);
    });
};