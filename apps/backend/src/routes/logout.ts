import { Hono } from "hono";
import jwt from "jsonwebtoken";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { blacklistToken } from "../utils/tokenStore.js";

export const logoutRoute = new Hono();

logoutRoute.use("*", authMiddleware);

logoutRoute.post("/", (c) => {
  const header = c.req.header("Authorization")!;
  const token = header.replace("Bearer", "");

  const decoded = jwt.decode(token) as { exp: number };

  blacklistToken(token, decoded.exp);

  return c.json({ message: "Logout success" }, 200);
})