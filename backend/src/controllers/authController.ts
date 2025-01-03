import { Request, Response } from 'express';
import { User } from '../models/user';
import { hashPassword, comparePassword, generateToken } from '../utils/auth';
import { isExistingPatronID, isExistingLibrarianID } from '../utils/validation';

export const registerUser = async (req: Request, res: Response) => {
    const { id, username, password, role } = req.body;

    try {
        if (role === 'patron') {
            if (!id || !isExistingPatronID(id)) {
                res.status(401).json({ error: 'Invalid or missing library card number.' });
                return;
            }
        }
        else if (role === 'librarian') {
            if (!id || !isExistingLibrarianID(id)) {
                res.status(401).json({ error: 'Invalid or missing librarian ID.' });
                return;
            }
        }
        else {
            res.status(401).json({ error: 'Invalid or unspecified role.' });
            return;
        }
        
        const hashedPassword = await hashPassword(password);
        const user = await User.create({ _id: id, username, password: hashedPassword, role});

        res.status(201).json({ message: 'User registered successfully.' });
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
};

export const loginUser = async (req: Request, res: Response) => {
    const { username, password } = req.body;

    try {
        const user = await User.findOne({ username });

        if (!user || !(await comparePassword(password, user.password))) {
            res.status(401).json({ error: 'Invalid username or password' });
            return;
        }

        const token = generateToken({ id: user._id, role: user.role });
        res.status(200).json({ token });
    } catch (err: any) {
        res.status(400).json({ error: err.message });
    }
}