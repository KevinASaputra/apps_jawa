import bcrypt from "bcryptjs";
import { Hono } from "hono";
import { citizens } from "../db/schema.js";
import { db } from "../db/client.js";

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
      birthPlace,
      birthDate,
      address,
      email,
      passwordHash
    })
    .returning();

  return c.json({ message: "Register berhasil", user: inserted[0] });
});