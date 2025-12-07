import type { Context, Next } from "hono";
import jwt from "jsonwebtoken";
import { isBlacklisted } from "../utils/tokenStore.js";

export const authMiddleware = async (c: Context, next: Next) => {
  const authHeader = c.req.header("Authorization");

  if (!authHeader) {
    return c.json({ message: "Unauthorized: Token is missing" }, 401);
  }

  const token = authHeader.replace("Bearer", " ").trim();

  if (isBlacklisted(token)) {
    return c.json({ err: "Token has bee revoked" }, 401)
  }

  try {
    const decode = jwt.verify(token, process.env.JWT_SECRET!);

    c.set("user", decode);
    await next();
  } catch (err: any) {
    if (err.name === "TokenExpiredError") {
      return c.json({ err: "Token expired" }, 401);
    }

    return c.json({ err: "Invalid token" }, 401);
  }
}