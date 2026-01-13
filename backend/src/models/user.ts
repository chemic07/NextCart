import mongoose, { Document, Schema } from "mongoose";

export interface IUser extends Document {
  name: string;
  email: string;
  password: string;
  address: string;
  type: string;
  createdAt: Date;
  updatedAt: Date;
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
  },
  {
    timestamps: true, // createdAt + updatedAt
  }
);

export const User = mongoose.model<IUser>("User", userSchema);
