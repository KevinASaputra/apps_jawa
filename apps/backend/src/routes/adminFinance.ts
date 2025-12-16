import { Hono } from "hono";
import { db } from "../db/client.js";
import { finances } from "../db/schema.js";
import { eq } from "drizzle-orm";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import type { UserPayload } from "../types/auth.js";


export const adminFinanceRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();

adminFinanceRoute.use("*", authMiddleware);
adminFinanceRoute.use("*", allowRole(["Admin"]));


adminFinanceRoute.post("/", async (c) => {
  const admin = c.get("user");
  const { type, amount, description, date } = await c.req.json();

  if (!["income", "expense"].includes(type)) {
    return c.json({ error: "Invalid finance type" }, 400);
  }

  if (!amount || !date) {
    return c.json({ error: "Amount & date required" }, 400);
  }

  const inserted = await db
    .insert(finances)
    .values({
      type,
      amount,
      description,
      date,
      created_by: admin.id,
    })
    .returning();

  return c.json({
    message: "Finance record created",
    data: inserted[0],
  });
});

adminFinanceRoute.get("/", async () => {
  const data = await db
    .select()
    .from(finances)
    .orderBy(finances.date);

  return new Response(JSON.stringify(data), { status: 200 });
});

adminFinanceRoute.put("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const body = await c.req.json();

  const updated = await db
    .update(finances)
    .set({
      type: body.type,
      amount: body.amount,
      description: body.description,
      date: body.date,
    })
    .where(eq(finances.id, id))
    .returning();

  if (!updated.length) {
    return c.json({ error: "Finance record not found" }, 404);
  }

  return c.json({
    message: "Finance record updated",
    data: updated[0],
  });
});

adminFinanceRoute.delete("/:id", async (c) => {
  const id = Number(c.req.param("id"));

  const deleted = await db
    .delete(finances)
    .where(eq(finances.id, id))
    .returning();

  if (!deleted.length) {
    return c.json({ error: "Finance record not found" }, 404);
  }

  return c.json({ message: "Finance record deleted" });
});
