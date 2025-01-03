import express from 'express';
import { registerUser, loginUser } from '../controllers/authController';
import { validateRegisterInput } from '../middleware/validateInput';

const router = express.Router();

router.post('/register', validateRegisterInput, registerUser);
router.post('/login', loginUser);

export default router;