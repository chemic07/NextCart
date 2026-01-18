import mongoose, { Schema, Document } from "mongoose";
import { ratingSchema } from "./rating";

export interface IProduct extends Document {
  name: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  quantity: number;
  ratings: number[];
  createdAt: Date;
  updatedAt: Date;
}

const productSchema = new Schema<IProduct>(
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
