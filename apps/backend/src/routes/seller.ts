import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";

export const sellerRoute = new Hono();

sellerRoute.use("*", authMiddleware);
sellerRoute.use("*", allowRole(["Seller"]));

sellerRoute.get("/", (c) => {
  return c.json({ message: "Welcome Seller!" });
});