import type { Response, Request, NextFunction } from "express";
import jwt, { type JwtPayload } from "jsonwebtoken";
import { User } from "../models/user";
import type { UserModel } from "../types/user";

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

export default async function adminMiddleware(
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
    const jwtsecret = process.env.JWT_SECRET;

    const decoded = jwt.verify(token!, jwtsecret!);

    if (!isJwtUserPayload(decoded)) {
      return res.status(401).json({ message: "Token is invalid" });
    }

    const user = (await User.findById(decoded.userId)) as UserModel;

    if (!user) {
      return res.status(401).json({ message: "User not found" });
    }

    if (user.type !== "admin") {
      return res.status(403).json({ message: "Admin access only" });
    }

    req.user = decoded.userId;
    req.token = token;
    next();
  } catch (error) {
    console.error(error);
    return res.status(401).json({ message: "Authentication failed" });
  }
}
