import bcrypt from "bcryptjs";
import { Hono } from "hono";
import { citizens } from "../db/schema.js";
import { db } from "../db/client.js";
import { eq } from "drizzle-orm";
import jwt from "jsonwebtoken";

export const authRoute = new Hono();

authRoute.post("/register", async (c) => {
  const body = await c.req.json();

  const {
    nik,
    name,
    gender,
    birthPlace,
    birthDate,
    address,
    email,
    password,
    role = "Buyer"
  } = body;

  if (!nik || !name || !email || !password) {
    return c.json({ message: "Bad Request: Missing required fields" }, 400);
  }

  const passwordHash = await bcrypt.hash(password, 10);

  const inserted = await db
    .insert(citizens)
    .values({
      nik,
      name,
      gender,
      birth_place: birthPlace,
      birth_date: birthDate,
      address,
      email,
      password_hash: passwordHash,
      role
    })
    .returning();


  return c.json({ message: "Register berhasil", user: inserted[0] });
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
      nik: user.nik,
      name: user.name,
      email: user.email,
      role: user.role
    },
    process.env.JWT_SECRET!,
    { expiresIn: 60 * 60 * 24 }
  );

  return c.json({
    message: "Login berhasil",
    token,
    data: {
      id: user.id,
      nik: user.nik,
      name: user.name,
      email: user.email,
      role: user.role
    }
  });
});
