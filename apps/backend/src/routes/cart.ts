import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import { db } from "../db/client.js";
import { cartItems, products } from "../db/schema.js";
import { eq } from "drizzle-orm";

interface UserPayload {
  id: number;
  email: string;
  name: string;
  role: string;
  exp: number;
  iat: number;
}

export const cartRoute = new Hono<{
  Variables: { user: UserPayload }
}>();

cartRoute.use("*", authMiddleware);
cartRoute.use("*", allowRole(["Buyer"]));

cartRoute.post("/add", async (c) => {
  const user = c.get("user");
  const { productId, quantity } = await c.req.json();

  await db.insert(cartItems).values({
    buyerId: user.id,
    productId,
    quantity,
  });

  return c.json({ message: "Product added to cart" });
});

cartRoute.get("/", async (c) => {
  const user = c.get("user");

  const rows = await db
    .select()
    .from(cartItems)
    .leftJoin(products, eq(cartItems.productId, products.id))
    .where(eq(cartItems.buyerId, user.id));

  let total = 0;

  const items = rows.map((row) => {
    const cart = row.cart_items;
    const product = row.products!;

    total += product.price * cart.quantity;

    return {
      cartItemId: cart.id,
      productId: product.id,
      name: product.name,
      price: product.price,
      quantity: cart.quantity,
    };
  });

  return c.json({ items, total });
});

cartRoute.put("/:id", async (c) => {
  const id = Number(c.req.param("id"));
  const { quantity } = await c.req.json();

  await db
    .update(cartItems)
    .set({ quantity })
    .where(eq(cartItems.id, id));

  return c.json({ message: "Quantity updated" });
});

cartRoute.delete("/:id", async (c) => {
  const id = Number(c.req.param("id"));

  await db.delete(cartItems).where(eq(cartItems.id, id));

  return c.json({ message: "Item removed" });
});
