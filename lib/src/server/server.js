const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const lockerRoutes = require('./routes/lockerRoutes');
const studentRoutes = require('./routes/studentRoutes');

const app = express();
app.use(cors());
app.use(express.json());

const dbUri = "mongodb://localhost:27017/lockerstore";
mongoose.connect(dbUri)
    .then(result => {
        app.listen(3000);
        console.log('connected to db');
    })

app.use("/locker", lockerRoutes);
app.use("/student", studentRoutes);

