import mongoose, { Schema, Types } from "mongoose";

export interface IOrderProduct {
  productId: Types.ObjectId;
  quantity: number;
  priceAtPurchase: number;
  name: string;
  image: string;
}

export interface IOrder {
  products: IOrderProduct[];
  totalPrice: number;
  address: string;
  userId: Types.ObjectId;
  orderedAt: Date;
  status: number;
}

const orderProductSchema = new Schema(
  {
    productId: {
      type: Schema.Types.ObjectId,
      ref: "Product",
      required: true,
    },
    quantity: {
      type: Number,
      required: true,
    },
    priceAtPurchase: {
      type: Number,
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      required: true,
    },
  },
  { _id: false },
);

export const orderSchema = new Schema<IOrder>(
  {
    products: {
      type: [orderProductSchema],
      required: true,
    },

    totalPrice: {
      type: Number,
      required: true,
    },

    address: {
      type: String,
      required: true,
    },

    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },

    orderedAt: {
      type: Date,
      default: Date.now,
    },

    status: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true },
);

export const Order = mongoose.model<IOrder>("Order", orderSchema);
