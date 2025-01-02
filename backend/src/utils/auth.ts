import jwt from 'jsonwebtoken';
import { Secret, PrivateKey } from 'jsonwebtoken';
import bcrypt from 'bcryptjs';

const SECRET_KEY = process.env.TOKEN_SECRET as Secret;

export const generateToken = (user: { id: string; role: string }) => {
    return jwt.sign(user, SECRET_KEY, { expiresIn: '1h' });
};

export const verifyToken = (token: string) => {
    return jwt.verify(token, SECRET_KEY);
};

export const hashPassword = async (password: string) => {
    return await bcrypt.hash(password, 10);
};

export const comparePassword = async (password: string, hashedPassword: string) => {
    return await bcrypt.compare(password, hashedPassword);
};

