import express from "express";
import mongoose, { ConnectOptions } from "mongoose";
import dotenv from "dotenv";
import bookRoutes from './routes/bookRoutes';
import authRoutes from './routes/authRoutes'

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use('/api', bookRoutes);
app.use('/api/auth', authRoutes);

mongoose
        .connect(process.env.MONGO_URI as string, { useNewUrlParser: true, useUnifiedTopology: true } as ConnectOptions)
        .then(() => console.log('Connected to MongoDB'))
        .catch((err) => console.error('Failed to connect to MongoDB:', err));

export default app;




