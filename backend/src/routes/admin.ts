import { Router } from "express";
import adminMiddleware from "../middleware/admin.middlerware";
import { validate } from "../middleware/validate";
import { productSchema } from "../validators/product.schema";
import {
  addProduct,
  deleteProduct,
  getOrders,
  getProducts,
  updateOrderStatus,
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

adminRouter.get(
  "/admin/get-orders",
  authMiddleware,
  adminMiddleware,
  getOrders,
);

adminRouter.patch(
  "/admin/order/update-status",
  authMiddleware,
  adminMiddleware,
  updateOrderStatus,
);

export default adminRouter;
