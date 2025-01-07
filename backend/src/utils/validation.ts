import { librarianData } from '../data/librarianIDs';
import { patronData } from '../data/patronIDs';

export const isValidPatronID = (patronID: string): boolean => {
    const re = /^[0-9]{14}$/;
    let isValid = re.test(patronID);
    return isValid;
};

export const isValidLibrarianID = (librarianID: string): boolean => {
    const re = /^L[0-9]{9}[A-Z]$/
    let isValid = re.test(librarianID);
    return isValid;
};

export const isExistingPatronID = (patronID: string): boolean => {
    return patronData.hasOwnProperty(patronID);
};

export const isExistingLibrarianID = (librarianID: string): boolean => {
    return librarianData.hasOwnProperty(librarianID);
};