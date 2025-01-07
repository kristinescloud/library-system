import mongoose from "mongoose";
import { title } from "process";

const ISBNSubSchema = new mongoose.Schema(
    {
        sbn: { type: String, trim: true },
        isbn10: { type: String, trim: true },
        isbn13: { type: String, trim: true },
        other: { type: String, trim: true },
    },
    { _id: false }
);

const BookSchema = new mongoose.Schema({
    title: { type: String, required: true, trim: true },
    author: { type: String, required: true, trim: true},
    category: { type: String, trim: true },
    genre: { type: String, trim: true },
    publicationDate: { type: String, required: true },
    isbn: {
        type: ISBNSubSchema,
        validate: {
            validator: function (value: {sbn?: string; isbn10?: string; isbn13?: string; other?: string }) {
                // Ensures that at least one of the ISBN fields has a value
                return !!(value.sbn || value.isbn10 || value.isbn13 || value.other)
            },
            message: 'At least one of SBN, ISBN10, ISBN13, or Other must be provided in the ISBN object.',
        }
    },
    quantity: { type: Number, required: true, min: 0 }
});

BookSchema.index({ title: 1 });
BookSchema.index({ author: 1 });
BookSchema.index({ genre: 1 });
ISBNSubSchema.index({ sbn: 1 });
ISBNSubSchema.index({ isbn10: 1 });
ISBNSubSchema.index({ isbn13: 1 });
ISBNSubSchema.index({ other: 1 });

export const Book = mongoose.model('Book', BookSchema);