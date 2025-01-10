import mongoose from "mongoose";
import { title } from "process";

const BookSchema = new mongoose.Schema({
    title: { type: String, required: true, trim: true },
    author: { type: String, required: true, trim: true},
    category: { type: String, trim: true },
    genre: { type: String, trim: true },
    publicationDate: { type: String, required: true },
    isbn: {
        type: String,
        required: true,
        validate: {
            validator: function (val: any) {
                // Ensures that at least one of the ISBN fields has a value
                return /^\d{9}$|^\d{10}$|^\d{13}$/.test(val);
            },
            message: 'At least one of SBN, ISBN10, or ISBN13, must be provided in the ISBN object.',
        },
    },
    quantity: { 
        type: String,
        required: true,
        validate: {
            validator: function (val: any) {
                // Ensures that at least one of the ISBN fields has a value
                return /^[1-9][0-9]{0,1000000000}$/.test(val);
            },
            message: 'The number of copies must be a number.',
        },
    },
    description: { type: String, trim: true },
    language: { type: String, trim: true },
    format: { type: String, trim: true },
    publisher: { type: String, trim: true },
    bookCover: { type: String, trim: true },
});

BookSchema.index({ title: 1 });
BookSchema.index({ author: 1 });
BookSchema.index({ genre: 1 });
BookSchema.index({ isbn: 1 });

export const Book = mongoose.model('Book', BookSchema);