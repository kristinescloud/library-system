import jwt from 'jsonwebtoken';
import { Secret, PrivateKey } from 'jsonwebtoken';
import bcrypt from 'bcryptjs';

export const generateToken = (user: { id: string; username: string; password: string; role: string }) => {
    const SECRET_KEY = process.env.TOKEN_SECRET;
    if (!SECRET_KEY) {
        throw new Error('TOKEN_SECRET is not defined');
    }
    // console.log(process.env.TOKEN_SECRET);
    console.log(SECRET_KEY);
    return jwt.sign(user, SECRET_KEY, { expiresIn: '1h' });
};

export const verifyToken = (token: string) => {
    const SECRET_KEY = process.env.TOKEN_SECRET;
    if (!SECRET_KEY) {
        throw new Error('TOKEN_SECRET is not defined');
    }
    // console.log(process.env.TOKEN_SECRET);
    // console.log(SECRET_KEY);
    return jwt.verify(token, SECRET_KEY);
};

export const hashPassword = async (password: string) => {
    return await bcrypt.hash(password, 10);
};

export const comparePassword = async (password: string, hashedPassword: string) => {
    return await bcrypt.compare(password, hashedPassword);
};

