import mongoose from "mongoose";

const BookSchema = new mongoose.Schema({
    title: { type: String, required: true },
    author: { type: String, required: true },
    publicationDate: { type: Date, required: true },
    quantity: { type: Number, required: true }
});

export const Book = mongoose.model('Book', BookSchema);