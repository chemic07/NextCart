import Express from "express";
import authMiddleware from "../middleware/auth.middleware";
import {
  addToCart,
  removeFromCart,
  saveUserAddress,
} from "../controller/user.controller";

const userRouter = Express.Router();

userRouter.post("/user/add-to-cart", authMiddleware, addToCart);
userRouter.delete("/user/remove-from-cart/:id", authMiddleware, removeFromCart);
userRouter.post("/user/save-user-address", authMiddleware, saveUserAddress);

export default userRouter;
