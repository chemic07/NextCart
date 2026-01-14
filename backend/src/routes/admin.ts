import { Router } from "express";
import adminMiddleware from "../middleware/admin.middlerware";
import { validate } from "../middleware/validate";
import { productSchema } from "../validators/product.schema";
import { addProduct } from "../controller/admin.controller";

const adminRouter = Router();

adminRouter.post(
  "/admin/add-product",
  validate(productSchema),
  adminMiddleware,
  addProduct
);

export default adminRouter;
