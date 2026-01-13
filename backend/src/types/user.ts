export type UserRole = "user" | "admin";

export interface UserModel {
  name: string;
  email: string;
  password: string;
  address?: string;
  type: UserRole;
}
