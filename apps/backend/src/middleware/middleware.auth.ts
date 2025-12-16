import type { Context, Next } from "hono";
import jwt from "jsonwebtoken";
import { isBlacklisted } from "../utils/tokenStore.js";
import type { UserPayload } from "../types/auth.js";

export const authMiddleware = async (
  c: Context<{ Variables: { user: UserPayload } }>,
  next: Next
) => {
  const authHeader = c.req.header("Authorization");

  if (!authHeader) {
    return c.json({ error: "Unauthorized: Token is missing" }, 401);
  }

  const token = authHeader.replace("Bearer ", "").trim();

  if (isBlacklisted(token)) {
    return c.json({ error: "Token has been revoked" }, 401);
  }

  try {
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET!
    ) as UserPayload;

    c.set("user", decoded);

    await next();
  } catch (err: any) {
    if (err.name === "TokenExpiredError") {
      return c.json({ error: "Token expired" }, 401);
    }

    return c.json({ error: "Invalid token" }, 401);
  }
};
