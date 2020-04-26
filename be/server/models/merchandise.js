const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const merchandiseSchema = new Schema({
    name: String,
});

module.exports = mongoose.model('Merchandise', merchandiseSchema);