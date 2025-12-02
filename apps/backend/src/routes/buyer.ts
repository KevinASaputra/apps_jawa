import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";

export const buyerRoute = new Hono();

buyerRoute.use("*", authMiddleware);
buyerRoute.use("*", allowRole(["Buyer"]));

buyerRoute.get("/", (c) => {
  return c.json({ message: "Welcome Buyer!" });
});