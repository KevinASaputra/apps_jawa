import { Hono } from "hono";
import { eq } from "drizzle-orm";
import { db } from "../db/client.js";
import { users } from "../db/schema.js";

export const usersRoute = new Hono();

usersRoute.get("/", async (c) => {
  const all = await db.select().from(users);
  return c.json(all);
});

usersRoute.get("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const result = await db.select().from(users).where(eq(users.id, id));
  return c.json(result[0] ?? {});
});

usersRoute.post("/", async (c) => {
  const body = await c.req.json();
  const created = await db.insert(users).values(body).returning();
  return c.json(created[0]);
});

usersRoute.put("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const body = await c.req.json();
  const updated = await db
    .update(users)
    .set(body)
    .where(eq(users.id, id))
    .returning();
  return c.json(updated[0]);
});

usersRoute.delete("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  await db.delete(users).where(eq(users.id, id));
  return c.json({ message: "Deleted" });
});
