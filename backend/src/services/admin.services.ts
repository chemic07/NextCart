import { Product } from "../models/product";
import type { ProductModel } from "../types/product";

export async function addProductServices(productData: ProductModel) {
  const { name, description, price, images, category, quantity } = productData;

  const product = await Product.create({
    name,
    description,
    price,
    quantity,
    images,
    category,
  });

  return product;
}
