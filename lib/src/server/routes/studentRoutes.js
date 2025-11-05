const express = require('express')
const Student = require('../models/Student');

const studentRouter = express.Router();

studentRouter.get("/", async (req, res) => {
    const student = await Student.find();
    res.json(student);
});

studentRouter.post("/", async (req, res) => {
    const student = new Student(req.body);
    await student.save();
    res.status(201).json(student);
});

studentRouter.get("/search", async (req, res) => {
    try {
        const firstName = req.query.firstName;
        const lastName = req.query.lastName;
        if (firstName == null || lastName == null) {
            return res.status(400).json({ message: "Champs manquants" });
        }

        const student = await Student.findOne({ firstName, lastName });


        // if (student.$isEmpty) {
        //     console.error("Student null");
        //     res.status(404).json({ message: "Étudiant non trouvé" });
        //     return;
        // }
        res.status(200).json(student);
    } catch (error) {
        console.error("Erreur serveur:", error);
        res.status(500).json({ message: "Erreur serveur interne" });
    }
});

studentRouter.patch("/:id", async (req, res) => {
    const { _id, ...updateData } = req.body;
    try {
        const student = await Student.findOneAndUpdate({ _id: req.params.id }, { $set: updateData }, { new: true });
        if (student == null) {
            res.status(404).json({ message: "Étudiant introuvable" });
            return;
        }
        res.json(student);

    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Erreur serveur" });
    }
});

studentRouter.get("/:id", async (req, res) => {
    const id = req.params.id;
    if (id == "" || id.trim() === "") {
        return res.status(400).json({ err: "Missing or invalid ID" });
    }

    try {
        const student = await Student.findById(id);
        if (!student) {
            return res.status(404).json({ err: "Student not found" });
        }
        res.status(200).json(student);
    } catch (err) {
        console.error(err);
        res.status(500).json({ err: "Server error" });
    }
});



module.exports = studentRouter;