import type { Request, Response } from "express";
import { signupService, loginService } from "../services/auth.services";
import { User } from "../models/user";

export async function signup(req: Request, res: Response) {
  try {
    await signupService(req.body);
    res.status(200).json({ message: "User created" });
  } catch (error) {
    if ((error as Error).message === "EMAIL_EXISTS") {
      return res.status(400).json({ message: "Email already exists" });
    }
    res.status(500).json({ error: "Internal server error" });
  }
}

export async function login(req: Request, res: Response) {
  try {
    const data = await loginService(req.body.email, req.body.password);
    res.status(200).json({
      ...data,
    });
  } catch (error) {
    if ((error as Error).message === "INVALID_CREDENTIALS") {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    res.status(500).json({ error: "Internal server error" });
  }
}

export async function tokenIsValid(req: Request, res: Response) {
  res.status(200).json({ valid: true });
}

export async function getUser(req: Request, res: Response) {
  if (!req.user) {
    return res.status(401).json({ message: "Unauthorized" });
  }

  const user = await User.findById(req.user).select("+password");

  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  console.log(user.password);
  console.log(user);
  res.status(200).json({
    _id: user._id,
    email: user.email,
    name: user.name,
    password: user.password,
    address: user.address,
    type: user.type,
    token: req.token,
  });
}
