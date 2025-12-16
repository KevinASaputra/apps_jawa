import bcrypt from "bcryptjs";
import { db } from "../db/client.js";
import { citizens } from "../db/schema.js";

async function seedAdmin() {
  const hash = await bcrypt.hash("admin123", 10);

  await db.insert(citizens).values({
    name: "Super Admin",
    email: "admin@jawara.app",
    password_hash: hash,
    role: "Admin",
    account_status: "VERIFIED",
    verified_at: new Date(),
  });

  console.log("✅ Admin seeded successfully");
  process.exit(0);
}

seedAdmin().catch((err) => {
  console.error("❌ Seed admin failed:", err);
  process.exit(1);
});
