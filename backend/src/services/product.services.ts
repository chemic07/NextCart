import { Product } from "../models/product";

export async function getProductByCategory(category: string) {
  return await Product.find({ category: category });
}

export async function getProductByQuery(query: string) {
  return await Product.find({ name: { $regex: query, $options: "i" } });
}
