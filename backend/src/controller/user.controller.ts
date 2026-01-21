import type { Request, Response } from "express";
import { Product } from "../models/product";
import { User } from "../models/user";
import { Order, type IOrder, type IOrderProduct } from "../models/order";

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

    const cartItem = user.cart.find(
      (item) => item.product.toString() === productId,
    );

    if (cartItem) {
      cartItem.quantity += 1;
    } else {
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
export async function placeOrder(req: Request, res: Response) {
  try {
    const { cart, totalPrice, address } = req.body;

    if (!cart || cart.length === 0) {
      return res.status(400).json({ message: "Cart is empty" });
    }

    const products = [] as IOrderProduct[];

    for (const item of cart) {
      const product = await Product.findById(item.productId);

      if (!product) {
        return res.status(404).json({ message: "Product not found" });
      }

      if (product.quantity < item.quantity) {
        return res
          .status(400)
          .json({ message: `Insufficient stock for ${product.name}` });
      }

      product.quantity -= item.quantity;
      await product.save();

      products.push({
        productId: product._id,
        quantity: item.quantity,
        priceAtPurchase: product.price,
        name: product.name,
        image: product.images[0]!,
        category: product.category,
      });
    }

    await User.findByIdAndUpdate(req.user, { $set: { cart: [] } });

    const order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      status: 0,
    });

    const savedOrder = await order.save();
    res.status(201).json(savedOrder);
    console.log(savedOrder);
  } catch (error: any) {
    console.error(error);
    res.status(500).json({ message: "Order failed" });
  }
}
export async function getOrders(req: Request, res: Response) {
  try {
    const userId = req.user;

    const orders = await Order.find({ userId }).sort({ orderedAt: -1 });

    if (orders.length === 0) {
      return res.status(404).json({ message: "No orders found" });
    }

    res.status(200).json(orders);
  } catch (error) {
    console.error("GET ORDERS ERROR:", error);
    res.status(500).json({ message: "Failed to fetch orders" });
  }
}
