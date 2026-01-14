import express from "express";
import authRoutes from "./routes/auth";
import { errorHandler } from "./middleware/error";
import adminRouter from "./routes/admin";
const app = express();

app.use(express.json());

// routes
app.use(authRoutes);
app.use(adminRouter);

// health check
app.get("/health", (_, res) => {
  res.status(200).json({ status: "ok" });
});

app.use(errorHandler);

export default app;
