import { Hono } from "hono";
import { db } from "../db/client.js";
import { productReviews, products } from "../db/schema.js";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { eq, sql } from "drizzle-orm";
import type { UserPayload } from "../types/auth.js";

export const reviewRoute = new Hono<{
  Variables: { user: UserPayload }
}>();

reviewRoute.use("*", authMiddleware);

reviewRoute.post("/:productId", async (c) => {
  const user = c.get("user");
  const productId = Number(c.req.param("productId"));
  const { rating, comment } = await c.req.json();

  if (rating < 1 || rating > 5) {
    return c.json({ error: "Rating harus 1–5" }, 400);
  }

  await db.insert(productReviews).values({
    product_id: productId,
    user_id: user.id,
    rating,
    comment,
  });

  await db.execute(sql`
    UPDATE products
    SET
      rating_count = rating_count + 1,
      rating_avg = (
        (rating_avg * (rating_count) + ${rating})
        / (rating_count + 1)
      )
    WHERE id = ${productId}
  `);

  return c.json({ message: "Review berhasil dikirim" });
});
