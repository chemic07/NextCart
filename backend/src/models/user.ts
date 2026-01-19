import mongoose, { Document, Schema } from "mongoose";
import type { Cart } from "../types/user";

export interface IUser extends Document {
  name: string;
  email: string;
  password: string;
  address: string;
  type: string;
  createdAt: Date;
  updatedAt: Date;
  cart: Cart[];
}

const userSchema = new Schema<IUser>(
  {
    name: { type: String, required: true, trim: true },
    email: {
      type: String,
      required: true,
      trim: true,
      unique: true,
      lowercase: true,
    },
    password: {
      type: String,
      required: true,
      minlength: 6,
      select: false,
    },
    address: { type: String, default: "" },
    type: { type: String, default: "user" },
    cart: [
      {
        product: { type: Schema.Types.ObjectId, ref: "Product" },
        quantity: { type: Number, required: true, default: 1 },
      },
    ],
  },
  {
    timestamps: true,
  },
);

export const User = mongoose.model<IUser>("User", userSchema);
