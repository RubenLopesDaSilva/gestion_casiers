const mongoose = require('mongoose');

const studentSchema = new mongoose.Schema({
    _id: { type: String, require: true },
    firstName: { type: String, require: true },
    lastName: { type: String, require: true },
    job: { type: String, require: true },
    year: { type: Number, require: true },
    title: { type: String, require: true },
    login: { type: String, require: true },
    deposit: { type: Number, require: true }
}, { versionKey: false });
const Student = mongoose.model("Student", studentSchema);
module.exports = Student;