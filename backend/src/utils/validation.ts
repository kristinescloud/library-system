import librarianData from '../data/librarianIDs.json';
import patronData from '../data/patronIDs.json';

export const isValidPatronID = (patronID: string): boolean => {
    if (patronID.length !== 14) return false;
    let isNum = /^\d+$/.test(patronID);
    if (!isNum) return false;
    return true;
};

export const isValidLibrarianID = (librarianID: string): boolean => {
    if (librarianID.length !== 11) return false;
    if (librarianID.charAt(0) !== 'L') return false;
    if (!(65 <= librarianID.charCodeAt(10)) || !(librarianID.charCodeAt(10) <= 90)) return false;
    let isNum = /^\d+$/.test(librarianID.substring(1,10));
    if (!isNum) return false;
    return true;
};

export const isExistingPatronID = (patronID: string): boolean => {
    return patronData.hasOwnProperty(patronID);
};

export const isExistingLibrarianID = (librarianID: string): boolean => {
    return librarianData.hasOwnProperty(librarianID);
};