import { Hono } from "hono";
import { eq } from "drizzle-orm";
import { citizens } from "../db/schema.js";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { db } from "../db/client.js";

interface UserPayload {
  id: number;
  nik: string;
  email: string;
  name: string;
  role: "pembeli" | "penjual";
  exp: number;
  iat: number;
}

export const profileRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();

profileRoute.use("*", authMiddleware);

profileRoute.get("/", async (c) => {
  const user = c.get("user");

  const result = await db.select().from(citizens)
    .where(eq(citizens.id, user.id));

  return c.json(result[0]);
});

profileRoute.put("/", async (c) => {
  const user = c.get("user");
  const body = await c.req.json();

  const {
    name,
    gender,
    birthPlace,
    birthDate,
    address,
    email
  } = body;

  const updated = await db
    .update(citizens)
    .set({
      name,
      gender,
      birthPlace,
      birthDate,
      address,
      email
    })
    .where(eq(citizens.id, user.id))
    .returning();

  return c.json({
    message: "Data berhasil diperbarui",
    data: updated[0]
  });
});
