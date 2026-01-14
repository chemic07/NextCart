import type { Request, Response } from "express";
import { addProductServices } from "../services/admin.services";

export async function addProduct(req: Request, res: Response) {
  try {
    const product = await addProductServices(req.body);
    res.status(201).json(product);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to add product" });
  }
}
