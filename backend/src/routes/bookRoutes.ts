import express from "express";
import { addBook, listAllBooks, searchBooks, viewBookDetails, updateBookDetails, removeBook } from "../controllers/bookController";
import { authorizeRole } from "../middleware/auth";

const router = express.Router();

router.post('/books', authorizeRole('librarian'), addBook);
router.get('/books', listAllBooks);
router.get('/books/search', searchBooks);
router.get('/books/:bookID', viewBookDetails);
router.put('/books/:bookID', authorizeRole('librarian'), updateBookDetails);
router.delete('/books/:bookID', authorizeRole('librarian'), removeBook);

export default router;