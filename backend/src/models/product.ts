import mongoose, { Schema, Document } from "mongoose";
import { ratingSchema, type IRating } from "./rating";

export interface IProduct extends Document {
  name: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  quantity: number;
  ratings: IRating[];
  createdAt: Date;
  updatedAt: Date;
}

export const productSchema = new Schema<IProduct>(
  {
    name: { type: String, required: true, trim: true },
    description: { type: String, required: true, trim: true },
    images: [{ type: String, required: true }],
    price: { type: Number, required: true },
    quantity: { type: Number, required: true },
    category: {
      type: String,
      required: true,
      enum: ["Mobiles", "Essentials", "Appliances", "Books", "Fashion"],
    },
    ratings: [ratingSchema],
  },
  { timestamps: true },
);

export const Product = mongoose.model<IProduct>("Product", productSchema);
