import { z } from "zod";

export const signupSchema = z.object({
  name: z.string().min(2),
  email: z.email(),
  password: z.string().min(6),
  address: z.string().optional(),
});

export const loginSchema = z.object({
  email: z.email(),
  password: z.string().min(6),
});

export type SignupInput = z.infer<typeof signupSchema>;
export type LoginInput = z.infer<typeof loginSchema>;
