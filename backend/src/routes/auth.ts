import { Router } from "express";
import { login, signup } from "../controller/auth.controller";
import { validate } from "../middleware/validate";
import { loginSchema, signupSchema } from "../validators/auth.schema";

const router = Router();

router.post("/api/signup", validate(signupSchema), signup);
router.post("/api/login", validate(loginSchema), login);

export default router;
