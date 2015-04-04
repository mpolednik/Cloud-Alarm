/**
 * Created by tomasskopal on 04.04.15.
 */

var User = require('../models/UserModel');
var Token = require("../models/TokenModel");

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
            return res.send(err);

        // Create a new access token
        var token = new Token({
            value: uid(128),
            userId: user._id
        });

        token.save(function (err) {
            if (err) { return res.send(err); }

            res.status(201).json({ message: 'New user added!', body: token.value });
        });
    });
};

/**
 * Create endpoint /api/users for GET
 * Returns users with tokens
 */
exports.getUsers = function(req, res) {
    User.find(function(err, users) {
        if (err)
            return res.send(err);

        Token.find(function(err, tokens) {
            if (err)
                return res.send(err);

            res.status(200).json({ users: users, tokens: tokens });
        });
    });
};

function uid (len) {
    var buf = []
        , chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
        , charlen = chars.length;

    for (var i = 0; i < len; ++i) {
        buf.push(chars[getRandomInt(0, charlen - 1)]);
    }

    return buf.join('');
};

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}