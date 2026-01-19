import type { Request, Response } from "express";
import { Product } from "../models/product";
import { User } from "../models/user";

export async function addToCart(req: Request, res: Response) {
  try {
    const { productId } = req.body;
    const userId = req.user;

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    // console.log(productId);

    const product = await Product.findById(productId);
    if (!product) {
      return res.status(404).json({ message: "Product not found" });
    }

    // find the item if it is already in the cart
    const cartItem = user.cart.find(
      (item) => item.product.toString() === productId,
    );

    // if found, increment the quantity
    if (cartItem) {
      cartItem.quantity += 1;
    } else {
      // if not found, add new item to cart
      user.cart.push({ product: product._id, quantity: 1 });
    }

    await user.save();

    // this will populate the product details in the cart
    await user.populate("cart.product");

    return res.status(200).json({
      cart: user.cart,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Failed to add to cart" });
  }
}
