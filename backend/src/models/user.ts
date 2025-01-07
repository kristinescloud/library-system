import mongoose from "mongoose";

const UserSchema = new mongoose.Schema({
    _id: { type: String, required: true }, // 14-digit number will be patron ID and 9-digit number will be librarian ID
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    role: { type: String, enum: ['patron', 'librarian'], required: true},
});

export const User = mongoose.model('User', UserSchema);