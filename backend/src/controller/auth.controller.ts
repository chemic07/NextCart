import type { Request, Response } from "express";
import { signupService, loginService } from "../services/auth.services";

export async function signup(req: Request, res: Response) {
  try {
    await signupService(req.body);
    res.status(201).json({ message: "User created" });
  } catch (error) {
    if ((error as Error).message === "EMAIL_EXISTS") {
      return res.status(409).json({ error: "Email already exists" });
    }
    res.status(500).json({ error: "Internal server error" });
  }
}

export async function login(req: Request, res: Response) {
  try {
    console.log("here 3");
    const data = await loginService(req.body.email, req.body.password);
    res.status(200).json({
      message: "Login successful",
      ...data,
    });
    console.log("htis");
  } catch (error) {
    if ((error as Error).message === "INVALID_CREDENTIALS") {
      return res.status(401).json({ error: "Invalid credentials" });
    }
    console.log("herer");
    res.status(500).json({ error: "Internal server error" });
    console.log("here 2");
  }
}
