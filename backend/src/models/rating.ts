import mongoose, { Document, model, Schema } from "mongoose";

export interface IRating extends Document {
  userid: string;
  rating: number;
}

export const ratingSchema = new Schema<IRating>({
  userid: { type: String, required: true },
  rating: { type: Number, required: true },
});
