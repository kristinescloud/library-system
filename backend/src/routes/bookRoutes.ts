import express from "express";
import { addBook, listAllBooks } from "../controllers/bookController";

const router = express.Router();

router.post('/books', addBook);
router.get('/oooks', listAllBooks);

export default router;