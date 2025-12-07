import { Hono } from "hono";
import { eq } from "drizzle-orm";
import { db } from "../db/client.js";
import { citizens } from "../db/schema.js";

export const citizensRoute = new Hono();

citizensRoute.get("/", async (c) => {
  const all = await db.select().from(citizens);
  return c.json(all);
});

citizensRoute.get("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const result = await db.select().from(citizens).where(eq(citizens.id, id));
  return c.json(result[0] ?? {});
});

citizensRoute.post("/", async (c) => {
  const body = await c.req.json();
  const created = await db.insert(citizens).values(body).returning();
  return c.json(created[0]);
});

citizensRoute.put("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const body = await c.req.json();
  const updated = await db
    .update(citizens)
    .set(body)
    .where(eq(citizens.id, id))
    .returning();
  return c.json(updated[0]);
});

citizensRoute.delete("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  await db.delete(citizens).where(eq(citizens.id, id));
  return c.json({ message: "Deleted" });
});
