import { Request, Response } from "express";
import { Book } from "../models/book";
import { error } from "console";
import { Error } from "mongoose";

export const addBook = async (req: Request, res: Response) => {
    try {
        const book = await Book.create(req.body);
        res.status(201).json(book);
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};

export const listAllBooks = async (req: Request, res: Response) => {
    try {
        const books = await Book.find();
        res.status(200).json(books);
    } catch (err: any) {
        res.status(500).json({ error: err.message });
    }
};
