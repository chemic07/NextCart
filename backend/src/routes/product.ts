import { Router } from "express";
import authMiddleware from "../middleware/auth.middleware";
import {
  getProductsByCategory,
  getProductsByQuery,
  rateProduct,
} from "../controller/product.controller";

const productRouter = Router();

productRouter.get("/api/products", authMiddleware, getProductsByCategory);
productRouter.get(
  "/api/products/search/:query",
  authMiddleware,
  getProductsByQuery,
);

productRouter.post("/api/rate-product", authMiddleware, rateProduct);

export default productRouter;
