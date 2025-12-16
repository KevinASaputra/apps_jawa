import { Hono } from "hono";
import { db } from "../db/client.js";
import { activities } from "../db/schema.js";

export const activitiesRoute = new Hono();

activitiesRoute.get("/", async () => {
  const data = await db
    .select()
    .from(activities)
    .orderBy(activities.date);

  return new Response(JSON.stringify(data), { status: 200 });
});
