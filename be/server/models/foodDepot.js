const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const foodDepotSchema = new Schema({
    name: String,
    address: String,
    longitude: Number,
    latitude: Number,
    provider: String,
    phone: String,
    merchandiseIdList: new Array(String),
});

module.exports = mongoose.model('Food depot', foodDepotSchema);