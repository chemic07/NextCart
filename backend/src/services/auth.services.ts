import bcrypt from "bcryptjs";
import jwt, { type JwtPayload } from "jsonwebtoken";
import { User } from "../models/user";
import type { UserModel } from "../types/user";

export async function signupService(data: UserModel) {
  const { name, email, password, address } = data;

  const existingUser = await User.findOne({ email });
  if (existingUser) {
    throw new Error("EMAIL_EXISTS");
  }

  const hashedPassword = await bcrypt.hash(password, 10);

  const user = await User.create({
    name,
    email,
    password: hashedPassword,
    address,
  });

  return user;
}

export async function loginService(email: string, password: string) {
  const existingUser = await User.findOne({ email }).select("+password");

  if (!existingUser) {
    throw new Error("INVALID_CREDENTIALS");
  }

  const isMatch = await bcrypt.compare(password, existingUser.password);

  if (!isMatch) {
    throw new Error("INVALID_CREDENTIALS");
  }

  const token = jwt.sign(
    { userId: existingUser._id },
    process.env.JWT_SECRET as string
    // {
    //   expiresIn: process.env.JWT_EXPIRES_IN || "7d",
    // }
  );

  return {
    token,
    _id: existingUser._id,
    name: existingUser.name,
    email: existingUser.email,
    password: existingUser.password,
    type: existingUser.type,
    address: existingUser.address,
  };
}

interface JwtUserPayload extends JwtPayload {
  userId: string;
}

export async function validateToken(token: string) {
  const jwtSecret = process.env.JWT_SECRET;
  if (!jwtSecret) {
    throw new Error("INVALID_TOKEN");
  }

  const decoded = jwt.verify(token, jwtSecret);

  if (
    typeof decoded !== "object" ||
    decoded === null ||
    !("userId" in decoded)
  ) {
    throw new Error("INVALID_TOKEN");
  }

  const user = await User.findById((decoded as JwtUserPayload).userId);

  if (!user) {
    throw new Error("INVALID_TOKEN");
  }

  return user;
}
