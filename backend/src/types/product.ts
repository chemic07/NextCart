import type { IRating } from "../models/rating";

export interface ProductModel {
  name: string;
  description: string;
  price: number;
  images: string[];
  category: string;
  quantity: number;
  ratings: IRating[];
}
