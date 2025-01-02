import { Request, Response } from 'express';
import { User } from '../models/user';
import { hashPassword, comparePassword, generateToken } from '../utils/auth';

export const registerPatron = async (req: Request, res: Response) => {
    const { id, username, password } = req.body;

    try {
        // TODO: check that id is correct length part of the database of existing library card numbers
        const hashedPassword = await hashPassword(password);
        const user = await User.create({ _id: id, username, password: hashedPassword, role: 'patron' });

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