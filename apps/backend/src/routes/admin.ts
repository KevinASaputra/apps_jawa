import { Hono } from "hono";
import { db } from "../db/client.js";
import { activities, citizens, familyMembers, finances, products } from "../db/schema.js";
import { eq, sql } from "drizzle-orm";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import type { UserPayload } from "../types/auth.js";

export const adminRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();

adminRoute.use("*", authMiddleware);
adminRoute.use("*", allowRole(["Admin"]));

adminRoute.put("/verify/:citizenId", async (c) => {
  const admin = c.get("user");
  const citizenId = Number(c.req.param("citizenId"));

  const citizen = await db
    .select()
    .from(citizens)
    .where(eq(citizens.id, citizenId));

  if (citizen.length === 0) {
    return c.json({ error: "Warga tidak ditemukan" }, 404);
  }

  const family = await db
    .select()
    .from(familyMembers)
    .where(eq(familyMembers.citizen_id, citizenId));

  if (family.length === 0) {
    return c.json(
      { error: "Warga belum menambahkan anggota keluarga" },
      400
    );
  }

  const updated = await db
    .update(citizens)
    .set({
      account_status: "VERIFIED",
      verified_at: new Date(),
      verified_by: admin.id,
    })
    .where(eq(citizens.id, citizenId))
    .returning();

  return c.json({
    message: "Warga berhasil diverifikasi",
    data: updated[0],
  });
});


adminRoute.get("/dashboard", async (c) => {
  const [{ totalCitizens }] = await db
    .select({
      totalCitizens: sql<number>`count(*)`,
    })
    .from(citizens);

  const [{ totalFamily }] = await db
    .select({
      totalFamily: sql<number>`count(*)`,
    })
    .from(familyMembers);

  const [{ verified }] = await db
    .select({
      verified: sql<number>`count(*)`,
    })
    .from(citizens)
    .where(sql`account_status = 'VERIFIED'`);

  const [{ pending }] = await db
    .select({
      pending: sql<number>`count(*)`,
    })
    .from(citizens)
    .where(sql`account_status = 'PENDING'`);

  const [{ totalProducts }] = await db
    .select({
      totalProducts: sql<number>`count(*)`,
    })
    .from(products);

  const [{ totalActivities }] = await db
    .select({
      totalActivities: sql<number>`count(*)`,
    })
    .from(activities);


  const [{ totalIncome }] = await db
    .select({
      totalIncome: sql<number>`coalesce(sum(amount),0)`,
    })
    .from(finances)
    .where(sql`type = 'income'`);

  const [{ totalExpense }] = await db
    .select({
      totalExpense: sql<number>`coalesce(sum(amount),0)`,
    })
    .from(finances)
    .where(sql`type = 'expense'`);

  return c.json({
    citizens: {
      total: totalCitizens,
      verified,
      pending,
    },
    familyMembers: {
      total: totalFamily,
    },
    products: {
      total: totalProducts,
    },
    activities: {
      total: totalActivities,
    },
    finance: {
      income: totalIncome,
      expense: totalExpense,
      balance: totalIncome - totalExpense,
    },
  });
});
