import Express from "express";
import authMiddleware from "../middleware/auth.middleware";
import {
  addToCart,
  getOrders,
  placeOrder,
  removeFromCart,
  saveUserAddress,
} from "../controller/user.controller";

const userRouter = Express.Router();

userRouter.post("/user/add-to-cart", authMiddleware, addToCart);
userRouter.delete("/user/remove-from-cart/:id", authMiddleware, removeFromCart);
userRouter.post("/user/save-user-address", authMiddleware, saveUserAddress);
userRouter.post("/user/place-order", authMiddleware, placeOrder);
userRouter.get("/user/orders/me", authMiddleware, getOrders);

export default userRouter;
