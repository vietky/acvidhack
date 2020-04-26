const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const issueSchema = new Schema({
    fullName: String,
    address: String,
    birthDate: Number,
    birthMonth: Number,
    birthYear: Number,
    phone: String,
    email: String,
    identityNumber: String,
    sex: String,
    issueType: String,
    issueDescription: String,
    wellBeing: Boolean,
    disability: Boolean,
    homelessness: Boolean,
    urgency: Number,
    isYourself: Boolean,
    createDate: Number,
    createMonth: Number,
    createYear: Number,
    closeDate: Number,
    closeMonth: Number,
    closeYear: Number,
});

module.exports = mongoose.model('Issue', issueSchema);