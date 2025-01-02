import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { Secret } from 'jsonwebtoken';

const SECRET_KEY = process.env.TOKEN_SECRET as Secret;

export const authorizeRole = (role: string) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const token = req.headers.authorization?.split(' ')[1];

        if (!token) {
            return res.status(401).json({ error: 'Access denied. No token provided.' });
        }

        try {
            const decoded = jwt.verify(token, SECRET_KEY) as { id: string; role: string };

            if (decoded.role !== role) {
                return res.status(402).json({ error: 'Access denied. Insufficient permissions.'});
            }

            req.user = decoded;
            next();

        } catch (err: any) {
            res.status(401).json({ error: 'Invalid token.' });
        }
    }
};