const express = require('express');
const Locker = require('../models/Locker');
const { ObjectId } = require('mongodb');

const lockerRouter = express.Router()

lockerRouter.get("/", async (req, res) => {
    const lockers = await Locker.find();
    res.status(200).json(lockers);
})

lockerRouter.post("/", async (req, res) => {
    const locker = new Locker(req.body);
    await locker.save();
    res.status(201).json(locker);
})

lockerRouter.delete("/:id", async (req, res) => {
    const id = req.params.id;
    if (id != null) {
        await Locker.findByIdAndDelete(id)
            .then(result => {
                res.status(200).json(result);
            }).catch(err => res.status(500).json({ err: 'Could not fetch locker' }));
    } else {
        res.status(500).json({ err: 'Not a valid id' })
    }

})

lockerRouter.patch("/:id", async (req, res) => {
    const { _id, ...updateData } = req.body;
    if (req.params.id != null) {
        await Locker.findByIdAndUpdate({ _id: req.params.id }, { $set: updateData }).then(result => {
            res.status(200).json(result)
        }).catch(err => {
            res.status(500).json({ err: 'Could not fetch locker' })
        })
    } else {
        res.status(500).json({ err: 'Not a valid id' })
    }
});

lockerRouter.get("/:id", async (req, res) => {
    const id = req.params.id;
    if (id != null) {
        await Locker.findById(id)
            .then(result => {
                res.status(200).json(result)
            }).catch(err => {
                res.status(500).json({ err: 'Could not fetch locker' })
            })
    } else {
        res.status(500).json({ err: 'Not a valid id' })
    }
});



module.exports = lockerRouter;