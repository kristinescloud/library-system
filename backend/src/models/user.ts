import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    idNumber: { type: String, required: true },
    password: { type: String, required: true },
    role: { type: String, enum: ['patron', 'librarian'], required: true},
});

export const User = mongoose.model('User', UserSchema);