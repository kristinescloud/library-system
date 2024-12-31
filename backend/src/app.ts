import express from "express";
import mongoose, { ConnectOptions } from "mongoose";
import dotenv from "dotenv";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json())

mongoose
        .connect(process.env.MONGO_URI as string, { useNewUrlParser: true, useUnifiedTopology: true } as ConnectOptions)
        .then(() => console.log('Connected to MongoDB'))
        .catch((err) => console.error('Failed to connect to MongoDB:', err));

export default app;




