import jwt from "jsonwebtoken";
import type { Request, Response, NextFunction } from "express";
import type { JwtPayload } from "jsonwebtoken";

interface JwtUserPayload extends JwtPayload {
  userId: string;
}

function isJwtUserPayload(
  payload: string | JwtPayload
): payload is JwtUserPayload {
  return (
    typeof payload === "object" &&
    payload !== null &&
    "userId" in payload &&
    typeof (payload as { userId?: unknown }).userId === "string"
  );
}

export default function authMiddleware(
  req: Request,
  res: Response,
  next: NextFunction
) {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader?.startsWith("Bearer ")) {
      return res.status(401).json({ message: "Token is missing" });
    }

    const token = authHeader.split(" ")[1];

    const jwtSecret = process.env.JWT_SECRET;
    if (!jwtSecret) {
      throw new Error("JWT_SECRET is not defined");
    }

    const decoded = jwt.verify(token!, jwtSecret);

    if (!isJwtUserPayload(decoded)) {
      return res.status(401).json({ message: "Token is invalid" });
    }

    req.user = decoded.userId;
    req.token = token;

    next();
  } catch {
    return res.status(401).json({ message: "Token is invalid" });
  }
}
