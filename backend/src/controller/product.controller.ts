import type { Request, Response } from "express";
import {
  getProductByCategory,
  getProductByQuery,
} from "../services/product.services";
import { Product } from "../models/product";

export async function getProductsByCategory(req: Request, res: Response) {
  try {
    const category = req.query.category as string;

    if (typeof category !== "string") {
      return res.status(400).json({ message: "Invalid product category" });
    }

    const products = await getProductByCategory(category);

    if (products.length === 0) {
      return res
        .status(404)
        .json({ message: "No products found in this category" });
    }
    res.status(200).json(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to find products" });
  }
}

export async function getProductsByQuery(req: Request, res: Response) {
  try {
    const { query } = req.params;

    if (typeof query !== "string") {
      return res.status(400).json({ message: "Invalid product query" });
    }

    const products = await getProductByQuery(query);

    res.status(200).json(products);
    // console.log(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to find products" });
  }
}

export async function rateProduct(req: Request, res: Response) {
  try {
    const { id, rating } = req.body;
    const userId = req.user;

    if (!userId || !id || typeof rating !== "number") {
      return res.status(400).json({ message: "Invalid rating data" });
    }

    if (rating < 1 || rating > 5) {
      return res
        .status(400)
        .json({ message: "Rating must be between 1 and 5" });
    }

    const product = await Product.findByIdAndUpdate(id, {
      $pull: { ratings: { userid: userId } },
    });

    if (!product) {
      res.status(400).json({ message: "Porduct not found" });
    }

    const updatedProduct = await Product.findByIdAndUpdate(
      id,
      { $push: { ratings: { userid: userId, rating } } },
      { new: true },
    );

    res.status(200).json({
      message: "Product rated successfully",
      product: updatedProduct,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Failed to rate product" });
  }
}
