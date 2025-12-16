import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { db } from "../db/client.js";
import { familyMembers } from "../db/schema.js";
import { eq } from "drizzle-orm";
import type { UserPayload } from "../types/auth.js";

export const familyRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();

familyRoute.use("*", authMiddleware);

familyRoute.post("/", async (c) => {
  const user = c.get("user");
  const { name, relation, birth_date } = await c.req.json();

  if (!name || !relation) {
    return c.json({ error: "Invalid data" }, 400);
  }

  await db.insert(familyMembers).values({
    citizen_id: user.id,
    name,
    relation,
    birth_date,
  });

  return c.json({ message: "Anggota keluarga ditambahkan" });
});


familyRoute.get("/", async (c) => {
  const user = c.get("user");

  const list = await db
    .select()
    .from(familyMembers)
    .where(eq(familyMembers.citizen_id, user.id));

  return c.json(list);
});
