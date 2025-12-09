import { Hono } from "hono";
import { citizens, passwordReset } from "../db/schema.js";
import { eq } from "drizzle-orm";
import { db } from "../db/client.js";
import bcrypt from "bcryptjs";

export const forgotPasswordRoute = new Hono();
function generateOTP() {
  return Math.floor(100000 + Math.random() * 900000).toString();
}

forgotPasswordRoute.post("/", async (c) => {
  const { email } = await c.req.json();
  if (!email) return c.json({ error: "Email wajib diisi" }, 400);

  const otp = generateOTP();
  const expiresAt = new Date(Date.now() + 5 * 60 * 1000);

  await db.delete(passwordReset).where(eq(passwordReset.email, email));

  await db.insert(passwordReset).values({
    email,
    otp,
    expires_at: expiresAt,
  });

  return c.json({
    message: "OTP berhasil dikirim",
    otp,
  });
});

forgotPasswordRoute.post("/verify", async (c) => {
  const { email, otp } = await c.req.json();

  const result = await db
    .select()
    .from(passwordReset)
    .where(eq(passwordReset.email, email));

  if (result.length === 0) {
    return c.json({ error: "OTP tidak ditemukan" }, 400);
  }

  const record = result[0];

  if (new Date() > new Date(record.expires_at)) {
    return c.json({ error: "OTP kadaluarsa" }, 400);
  }

  if (record.otp !== otp) {
    return c.json({ error: "OTP salah" }, 400);
  }

  return c.json({ message: "OTP valid" });
});

forgotPasswordRoute.post("/reset", async (c) => {
  const { email, otp, newPassword } = await c.req.json();

  if (!email || !otp || !newPassword) {
    return c.json({ error: "Data tidak lengkap" }, 400);
  }

  const result = await db
    .select()
    .from(passwordReset)
    .where(eq(passwordReset.email, email));

  if (result.length === 0) {
    return c.json({ error: "OTP tidak ditemukan" }, 400);
  }

  const record = result[0];

  if (record.otp !== otp) {
    return c.json({ error: "OTP salah" }, 400);
  }

  const hashedPassword = await bcrypt.hash(newPassword, 10);
  await db
    .update(citizens)
    .set({ password_hash: hashedPassword })
    .where(eq(citizens.email, email));

  await db.delete(passwordReset).where(eq(passwordReset.email, email));

  return c.json({ message: "Password berhasil direset" });
});
