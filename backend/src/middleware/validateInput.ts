import { Request, Response, NextFunction } from 'express';
import { isValidLibrarianID, isValidPatronID, isExistingLibrarianID, isExistingPatronID } from '../utils/validation';
import { User } from '../models/user';

export const validateRegisterInput = async (req: Request, res: Response, next: NextFunction) => {
  const { id, username, password, role } = req.body;

  if (!username || typeof username !== 'string') {
    res.status(400).json({ error: 'Username is required and must be a string.' });
    return;
  }

  const existingUser = await User.findOne({ username });
  if (existingUser) {
    res.status(400).json({ error: 'Username is already taken.' });
    return;
  }
 
  if (!password || typeof password !== 'string' || password.length < 6 || password.length > 50) {
    res.status(400).json({ error: 'Password is required and must be at least 6 characters long.' });
    return;
  }

  if (!role || !['patron', 'librarian'].includes(role)) {
    res.status(400).json({ error: 'Role must be either "patron" or "librarian".' });
    return;
  }

  if (role == 'patron') {
    if (!id) {
      res.status(400).json({ error: 'Patron ID is required for patrons.' });
      return;
    }
    if (!isValidPatronID(id)) {
      res.status(400).json({ error: 'Patron ID is invalid.' });
      return;
    }
    if (!isExistingPatronID(id)) {
      res.status(400).json({ error: 'Patron ID not found.' });
      return;
    }
    
  } else if (role == 'librarian') {
    console.log(id);
    console.log(isValidLibrarianID(id));
    console.log(isExistingLibrarianID(id));
    if (!id) {
      res.status(400).json({ error: 'Librarian ID is required for librarians.' });
      return;
    }
    if (!isValidLibrarianID(id)) {
      res.status(400).json({ error: 'Librarian ID is invalid.' });
      return;
    } 
    if (!isExistingLibrarianID(id)) {
      res.status(400).json({ error: 'Librarian ID not found.' });
      return;
    }
  }

  next();
};
