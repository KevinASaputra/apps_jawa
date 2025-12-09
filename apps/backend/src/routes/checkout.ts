import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import { db } from "../db/client.js";
import { cartItems, products, orders, orderItems } from "../db/schema.js";
import { eq } from "drizzle-orm";

interface UserPayload {
  id: number;
  email: string;
  name: string;
  role: string;
}

export const checkoutRoute = new Hono<{
  Variables: { user: UserPayload }
}>();

checkoutRoute.use("*", authMiddleware);
checkoutRoute.use("*", allowRole(["Buyer"]));


checkoutRoute.post("/", async (c) => {
  const user = c.get("user");

  const rows = await db
    .select()
    .from(cartItems)
    .leftJoin(products, eq(cartItems.productId, products.id))
    .where(eq(cartItems.buyerId, user.id));

  if (rows.length === 0) {
    return c.json({ error: "Cart kosong" }, 400);
  }

  let total = 0;
  rows.forEach((row) => {
    total += row.products!.price * row.cart_items.quantity;
  });

  const newOrder = await db.insert(orders)
    .values({
      buyerId: user.id,
      totalPrice: total,
    })
    .returning();

  const orderId = newOrder[0].id;

  for (const row of rows) {
    await db.insert(orderItems).values({
      orderId,
      productId: row.cart_items.productId,
      quantity: row.cart_items.quantity,
      price: row.products!.price
    });
  }

  await db.delete(cartItems).where(eq(cartItems.buyerId, user.id));

  return c.json({
    message: "Checkout berhasil",
    orderId,
    total
  });
});
