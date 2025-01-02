import express from 'express';
import { registerPatron, loginUser } from '../controllers/authController';

const router = express.Router();

router.post('/register', registerPatron);
router.post('/login', loginUser);

export default router;