import type { Request, Response } from "express";
import {
  addProductServices,
  getProductsService,
  deleteProductService,
} from "../services/admin.services";
import { id } from "zod/locales";

export async function addProduct(req: Request, res: Response) {
  try {
    const product = await addProductServices(req.body);
    res.status(201).json(product);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to add product" });
  }
}

export async function getProducts(params: Request, res: Response) {
  try {
    const products = await getProductsService();
    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: "Failed to get products" });
  }
}

export async function deleteProduct(req: Request, res: Response) {
  try {
    const productId = req.params.productId;

    if (typeof productId !== "string") {
      return res.status(400).json({ message: "Invalid product id" });
    }

    const deletedProduct = await deleteProductService(productId);

    if (!deletedProduct) {
      return res.status(404).json({ message: "Product not found" });
    }

    return res.status(200).json({
      message: "Product deleted successfully",
      product: deletedProduct,
    });
  } catch (error) {
    console.error("Delete product error:", error);
    return res
      .status(500)
      .json({ message: "Server error while deleting product" });
  }
}
