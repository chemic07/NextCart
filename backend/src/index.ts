import app from "./app";
import { connectDB } from "./config/db";

const PORT = Number(process.env.PORT) || 3000;

await connectDB();

app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
