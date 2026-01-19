import Express from "express";
import authMiddleware from "../middleware/auth.middleware";
import { addToCart } from "../controller/user.controller";

const userRouter = Express.Router();

userRouter.post("/user/add-to-cart", authMiddleware, addToCart);

export default userRouter;
