import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { citizens } from "../db/schema.js";
import { eq } from "drizzle-orm";
import { db } from "../db/client.js";

interface UserPayload {
  id: number;
  nik: string;
  email: string;
  name: string;
  role: string;
  exp: number;
  iat: number;
}

export const roleRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();

roleRoute.use("*", authMiddleware);

roleRoute.put("/", async (c) => {
  const user = c.get("user");
  const { role } = await c.req.json();

  const allowedRoles = ["Buyer", "Seller"];

  if (!allowedRoles.includes(role)) {
    return c.json({ error: "Role tidak valid" }, 400);
  }

  const updated = await db
    .update(citizens)
    .set({ role })
    .where(eq(citizens.id, user.id))
    .returning();

  return c.json({
    message: "Role berhasil diperbarui",
    data: updated[0],
  });
});
