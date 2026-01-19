import type { Types } from "mongoose";

export type UserRole = "user" | "admin";

export interface UserModel {
  name: string;
  email: string;
  password: string;
  address?: string;
  type: UserRole;
  cart: Cart[];
}

export interface Cart {
  product: Types.ObjectId;
  quantity: number;
}
