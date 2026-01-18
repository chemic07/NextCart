import { Router } from "express";
import adminMiddleware from "../middleware/admin.middlerware";
import { validate } from "../middleware/validate";
import { productSchema } from "../validators/product.schema";
import {
  addProduct,
  deleteProduct,
  getProducts,
} from "../controller/admin.controller";
import authMiddleware from "../middleware/auth.middleware";

const adminRouter = Router();

adminRouter.post(
  "/admin/add-product",
  validate(productSchema),
  adminMiddleware,
  addProduct,
);

adminRouter.get("/admin/get-products", adminMiddleware, getProducts);

adminRouter.delete(
  "/admin/delete-product/:productId",
  authMiddleware,
  adminMiddleware,
  deleteProduct,
);

export default adminRouter;
