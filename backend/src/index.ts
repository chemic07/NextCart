import app from "./app";
import { connectDB } from "./config/db";

const PORT = process.env.PORT || 3000;

await connectDB();

app.get("/", (_req, res) => {
  res.send("API is running...");
});

app.listen(PORT, () => console.log("Running on", PORT));
