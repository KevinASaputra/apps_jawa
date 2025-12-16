import { Hono } from "hono";
import { db } from "../db/client.js";
import { citizens, profiles, familyMembers } from "../db/schema.js";
import { eq } from "drizzle-orm";
import { authMiddleware } from "../middleware/middleware.auth.js"
import type { UserPayload } from "../types/auth.js";

export const profileRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();


profileRoute.use("*", authMiddleware);

profileRoute.get("/", async (c) => {
  const user = c.get("user");

  const account = await db
    .select()
    .from(citizens)
    .where(eq(citizens.id, user.id));

  const profile = await db
    .select()
    .from(profiles)
    .where(eq(profiles.user_id, user.id));

  return c.json({
    account: {
      name: account[0].name,
      email: account[0].email,
      role: account[0].role,
    },
    profile: profile[0] || null,
  });
});

profileRoute.put("/", async (c) => {
  const user = c.get("user");
  const body = await c.req.json();

  const updated = await db
    .update(citizens)
    .set({
      address: body.address,
      phone: body.phone,
      birth_date: body.birth_date,
    })
    .where(eq(citizens.id, user.id))
    .returning();

  return c.json({
    message: "Profile updated",
    data: updated[0],
  });
});
