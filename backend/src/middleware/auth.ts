import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import { Secret } from 'jsonwebtoken';

const SECRET_KEY = process.env.TOKEN_SECRET as Secret;

export const authorizeRole = (role: string) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const token = req.headers.authorization?.split(' ')[1];

        if (!token) {
            res.status(401).json({ error: 'Access denied. No token provided.' });
            return;
        }

        try {
            const decoded = jwt.verify(token, SECRET_KEY) as { id: string; role: string };

            if (decoded.role !== role) {
                res.status(402).json({ error: 'Access denied. Insufficient permissions.'});
                return;
            }

            req.user = decoded;
            next();

        } catch (err: any) {
            res.status(401).json({ error: 'Invalid token.' });
        }
    }
};