import { Request, Response, NextFunction } from 'express';
import { isValidLibrarianID, isValidPatronID, isExistingLibrarianID, isExistingPatronID } from '../utils/validation';

export const validateRegisterInput = (req: Request, res: Response, next: NextFunction) => {
  const { id, username, password, role } = req.body;

  if (!username || typeof username !== 'string') {
    res.status(400).json({ error: 'Username is required and must be a string.' });
    return;
  }

  if (!password || typeof password !== 'string' || password.length < 6) {
    res.status(400).json({ error: 'Password is required and must be at least 6 characters long.' });
    return;
  }

  if (!role || !['patron', 'librarian'].includes(role)) {
    res.status(400).json({ error: 'Role must be either "patron" or "librarian".' });
    return;
  }

  if (role === 'patron' && (!id || !isValidPatronID(id) || !isExistingPatronID(id))) {
    res.status(400).json({ error: 'Library card number is required for patrons.' });
    return
  }

  if (role === 'librarian' && (!id || !isValidLibrarianID(id) || !isExistingLibrarianID(id))) {
    res.status(400).json({ error: 'Librarian ID is required for librarians.' });
    return
  }

  next();
};
