import { Request, Response } from "express";
import { Book } from "../models/book";
import { error } from "console";
import { Error } from "mongoose";
import { escape } from "querystring";

export const addBook = async (req: Request, res: Response) => {
    try {
        const book = await Book.create(req.body);
        res.status(200).json(book);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};

export const listAllBooks = async (req: Request, res: Response) => {
    try {
        const books = await Book.find();
        res.status(200).json(books);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};

// query parameters – criteria: String, keyword: String
export const searchBooks = async (req: Request, res: Response) => {
    const searchParams = req.query.params as string;
    if (!searchParams) {
        res.status(400).json({ error: 'Search parameter is required' });
        return;
    }
    
    const [criteria, keyword] = searchParams.split(':');

    if (!criteria) {
        res.status(401).json({ error: 'Criteria is needed in order to search.' });
        return;
    }

    const searchQuery: { [key: string]: string | RegExp } = {};
    searchQuery[criteria as string] = new RegExp(keyword as string, 'i');

    try {
        const books = await Book.find(searchQuery);
        res.status(200).json(books);
    } catch (err: any) {
        res.status(400).json({ error: err.message })
    }
}; 

// request parameters – bookID: String
export const viewBookDetails = async (req: Request, res: Response) => {
    const { bookID } = req.params;

    try {
        const book = await Book.find({ 'isbn': bookID });
        if (!book) {
            res.status(404).json({ error: `Book not found, ${bookID.length}` });
            return;
        }
        res.status(200).json(book);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
}; 

// request parameters – bookID: String, bookDetails: BookDetails
export const updateBookDetails = async (req: Request, res: Response) => {
    const { bookID } = req.params;
    const updatedDetails = req.body;

    try {
        const book = await Book.findOneAndUpdate(
            { 'isbn': bookID },
            updatedDetails,
            { new: true, runValidators: true });
        if (!book) {
            res.status(404).json({ error: 'Book not found' });
            return;
        }
        res.status(200).json(book);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};

// request parameters – bookID: String
export const removeBook = async (req: Request, res: Response) => {
    const { bookID } = req.params;

    try {
        const book = await Book.findOneAndDelete({ 'isbn': bookID });
        if (!book) {
            res.status(404).json({ error: 'Book not found' });
            return;
        }
        res.status(201).json({ message: 'Book removed successfully' });
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};
