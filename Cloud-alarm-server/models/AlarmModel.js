/**
 * Created by tomasskopal on 29.03.15.
 */

var mongoose = require('mongoose');
var Schema = mongoose.Schema; // schema odpovida kolekci ~ tabulka v relacnich dtb

var AlarmSchema = new Schema({
    _id: Number,
    title: String,
    hour: Number,
    minute: Number,
    enabled: Boolean,
    repeat: Boolean,
    days: [Number],
    userId: String
});

module.exports = mongoose.model('Alarm', AlarmSchema); // model odpovida dokumentu ~ radek v tabulce
