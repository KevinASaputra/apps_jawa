import { Hono } from "hono";
import { db } from "../db/client.js";
import { activities } from "../db/schema.js";
import { eq } from "drizzle-orm";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import type { UserPayload } from "../types/auth.js";



export const adminActivitiesRoute = new Hono<{
  Variables: { user: UserPayload };
}>();

adminActivitiesRoute.use("*", authMiddleware);
adminActivitiesRoute.use("*", allowRole(["Admin"]));

adminActivitiesRoute.post("/", async (c) => {
  const admin = c.get("user");
  const { title, description, date, location } = await c.req.json();

  if (!title || !date) {
    return c.json({ error: "Title & date required" }, 400);
  }

  const inserted = await db
    .insert(activities)
    .values({
      title,
      description,
      date,
      location,
      created_by: admin.id,
    })
    .returning();

  return c.json({
    message: "Activity created",
    data: inserted[0],
  });
})


adminActivitiesRoute.get("/", async () => {
  const data = await db
    .select()
    .from(activities)
    .orderBy(activities.date);

  return new Response(JSON.stringify(data), { status: 200 });
});


adminActivitiesRoute.put("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const body = await c.req.json();

  const updated = await db
    .update(activities)
    .set({
      title: body.title,
      description: body.description,
      date: body.date,
      location: body.location,
    })
    .where(eq(activities.id, id))
    .returning();

  if (!updated.length) {
    return c.json({ error: "Activity not found" }, 404);
  }

  return c.json({
    message: "Activity updated",
    data: updated[0],
  });
});

adminActivitiesRoute.delete("/:id", async (c) => {
  const id = Number(c.req.param("id"));

  const deleted = await db
    .delete(activities)
    .where(eq(activities.id, id))
    .returning();

  if (!deleted.length) {
    return c.json({ error: "Activity not found" }, 404);
  }

  return c.json({ message: "Activity deleted" });
});
