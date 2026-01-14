import { z } from "zod";

export const productSchema = z.object({
  name: z.string().min(1, "Name is required"),
  description: z.string().min(1, "Description is required"),
  price: z.number().positive("Price must be positive"),
  quantity: z.number().int().nonnegative("Quantity must be 0 or more"),
  images: z.array(z.string()),
  category: z.enum(["Mobiles", "Essentials", "Appliances", "Books", "Fashion"]),
});
