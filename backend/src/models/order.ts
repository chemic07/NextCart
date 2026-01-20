import { Schema, Document } from "mongoose";
import type { ProductModel } from "../types/product";

export interface IOrder extends Document {
  Products: ProductModel[];
  totalPrice: number;
  address: string;
  userId: string;
  orderedAt: number;
  status: string;
  createdAt: Date;
  updatedAt: Date;
}
