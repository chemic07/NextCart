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

export async function removeFromCart(req: Request, res: Response) {
  try {
    const { id } = req.params; // productId
    const userId = req.user;

    if (!userId) {
      return res.status(401).json({ message: "Unauthorized" });
    }

    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    const itemIndex = user.cart.findIndex(
      (item) => item.product.toString() === id,
    );

    if (itemIndex === -1) {
      return res.status(404).json({ message: "Item not in cart" });
    }

    if (user.cart[itemIndex]!.quantity <= 1) {
      user.cart.splice(itemIndex, 1);
    } else {
      user.cart[itemIndex]!.quantity -= 1;
      console.log(user.cart[itemIndex]!.quantity);
    }

    await user.save();
    await user.populate("cart.product");

    return res.status(200).json({
      cart: user.cart,
    });
  } catch (e) {
    console.error(e);
    return res.status(500).json({ message: "Failed to remove from cart" });
  }
}

export async function saveUserAddress(req: Request, res: Response) {
  try {
    const { address } = req.body;
    const userId = req.user;

    const user = await User.findByIdAndUpdate(
      userId,
      { address },
      { new: true },
    );

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json({
      address: user.address,
    });
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: "Failed to save the address" });
  }
}
