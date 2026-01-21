import type { Request, Response } from "express";
import {
  addProductServices,
  getProductsService,
  deleteProductService,
} from "../services/admin.services";
import { Order } from "../models/order";

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

export async function getOrders(req: Request, res: Response) {
  try {
    const userId = req.user;

    const orders = await Order.find().sort({ orderedAt: -1 });

    if (orders.length === 0) {
      return res.status(404).json({ message: "No orders found" });
    }

    res.status(200).json(orders);
  } catch (error: any) {
    console.log(error);
    res.status(500).json({ error: "Failed to get orders" });
  }
}

export async function updateOrderStatus(req: Request, res: Response) {
  try {
    const { orderId, status } = req.body;

    if (!orderId || !status) {
      return res.status(400).json({ message: "Invalid params" });
    }

    const order = await Order.findByIdAndUpdate(
      orderId,
      { status },
      { new: true },
    );

    if (!order) {
      return res.status(404).json({ message: "Order not found" });
    }

    return res.status(200).json(order);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Failed to update order status" });
  }
}

const CATEGORIES = [
  "Mobiles",
  "Essentials",
  "Appliances",
  "Books",
  "Fashion",
] as const;

export async function getAnalytics(req: Request, res: Response) {
  try {
    // Total Earnings
    const total = await Order.aggregate([
      { $group: { _id: null, total: { $sum: "$totalPrice" } } },
    ]);

    // ---- Earnings by Category (raw) ----
    const rawByCategory = await Order.aggregate([
      { $unwind: "$products" },
      {
        $group: {
          _id: "$products.category",
          earnings: {
            $sum: {
              $multiply: ["$products.priceAtPurchase", "$products.quantity"],
            },
          },
        },
      },
    ]);

    // ---- Map to full category list (with zeros) ----
    const earningsByCategory = CATEGORIES.map((cat) => {
      const found = rawByCategory.find((r) => r._id === cat);
      return {
        category: cat,
        earnings: found ? found.earnings : 0,
      };
    });

    // Earnings by Day
    const earningsByDay = await Order.aggregate([
      {
        $group: {
          _id: {
            $dateToString: { format: "%Y-%m-%d", date: "$orderedAt" },
          },
          earnings: { $sum: "$totalPrice" },
        },
      },
      { $sort: { _id: 1 } },
    ]);

    // Earnings by Week
    const earningsByWeek = await Order.aggregate([
      {
        $group: {
          _id: {
            year: { $year: "$orderedAt" },
            week: { $week: "$orderedAt" },
          },
          earnings: { $sum: "$totalPrice" },
        },
      },
      { $sort: { "_id.year": 1, "_id.week": 1 } },
    ]);

    // Earnings by Month
    const earningsByMonth = await Order.aggregate([
      {
        $group: {
          _id: {
            year: { $year: "$orderedAt" },
            month: { $month: "$orderedAt" },
          },
          earnings: { $sum: "$totalPrice" },
        },
      },
      { $sort: { "_id.year": 1, "_id.month": 1 } },
    ]);

    // Earnings by Year
    const earningsByYear = await Order.aggregate([
      {
        $group: {
          _id: { year: { $year: "$orderedAt" } },
          earnings: { $sum: "$totalPrice" },
        },
      },
      { $sort: { "_id.year": 1 } },
    ]);

    return res.status(200).json({
      totalEarnings: total[0]?.total || 0,
      earningsByCategory,
      earningsByDay,
      earningsByWeek,
      earningsByMonth,
      earningsByYear,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Analytics failed" });
  }
}
