import express from "express";
import { addBook, listAllBooks, searchBooks, viewBookDetails, updateBookDetails, removeBook } from "../controllers/bookController";

const router = express.Router();

router.post('/books', addBook);
router.get('/books', listAllBooks);
router.get('/books/search', searchBooks);
router.get('/books/:bookID', viewBookDetails);
router.put('/books/:bookID', updateBookDetails);
router.delete('/books/:bookID', removeBook);

export default router;