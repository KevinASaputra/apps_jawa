import bcrypt from "bcryptjs";
import { Hono } from "hono";
import { citizens } from "../db/schema.js";
import { db } from "../db/client.js";
import { eq } from "drizzle-orm";
import jwt from "jsonwebtoken";

export const authRoute = new Hono();

authRoute.post("/register", async (c) => {
  const { name, email, password } = await c.req.json();

  if (!name || !email || !password) {
    return c.json({ error: "Name, email, password required" }, 400);
  }

  const hash = await bcrypt.hash(password, 10);

  const user = await db
    .insert(citizens)
    .values({
      name,
      email,
      password_hash: hash,
    })
    .returning();

  return c.json({
    message: "Register berhasil, silakan lengkapi profil & data keluarga",
    user: {
      id: user[0].id,
      name: user[0].name,
      email: user[0].email,
      account_status: user[0].account_status,
    },
  });
});



authRoute.post("/login", async (c) => {
  const { email, password } = await c.req.json();

  if (!email || !password) {
    return c.json({ error: "Email dan password wajib diisi" }, 400);
  }

  const result = await db
    .select()
    .from(citizens)
    .where(eq(citizens.email, email));

  if (result.length === 0) {
    return c.json({ error: "Email tidak ditemukan" }, 404);
  }

  const user = result[0];
  const isMatch = await bcrypt.compare(password, user.password_hash);

  if (!isMatch) {
    return c.json({ error: "Password salah" }, 401);
  }

  const token = jwt.sign(
    {
      id: user.id,
      email: user.email,
      role: user.role,
      account_status: user.account_status,
    },
    process.env.JWT_SECRET!,
    { expiresIn: "1d" }
  );


  return c.json({
    message: "Login berhasil",
    token,
    user: {
      id: user.id,
      name: user.name,
      email: user.email,
      role: user.role,
    },
  });
})