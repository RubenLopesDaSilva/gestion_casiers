const mongoose = require('mongoose');

const lockerSchema = new mongoose.Schema({
    _id: { type: String, require: true },
    number: { type: Number, require: true },
    floor: { type: String, require: true },
    keyCount: { type: Number, require: true },
    lockNumber: { type: Number, require: true },
    responsable: { type: String, require: true },
    place: { type: String, require: true },
    studentId: { type: String, require: false },
    lockerCondition: { type: Object, require: true }
}, { versionKey: false });
const Locker = mongoose.model("Locker", lockerSchema);
module.exports = Locker;