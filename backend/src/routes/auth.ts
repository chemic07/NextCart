import { Router } from "express";
import {
  getUser,
  login,
  signup,
  tokenIsValid,
} from "../controller/auth.controller";
import { validate } from "../middleware/validate";
import { loginSchema, signupSchema } from "../validators/auth.schema";
import authMiddleware from "../middleware/auth.middleware";

const router = Router();

router.post("/api/signup", validate(signupSchema), signup);
router.post("/api/login", validate(loginSchema), login);

router.get("/api/token/validate", authMiddleware, tokenIsValid);
router.get("/me", authMiddleware, getUser);

export default router;
