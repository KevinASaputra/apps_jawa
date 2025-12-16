import { Hono } from "hono";
import { authMiddleware } from "../middleware/middleware.auth.js";
import { allowRole } from "../middleware/middleware.role.js";
import { db } from "../db/client.js";
import { product } from "../db/product.js";
import { and, eq } from "drizzle-orm";
import { requireVerifiedAccount } from "../middleware/middleware.accountVerif.js";

interface UserPayload {
  id: number;
  email: string;
  name: string;
  role: string;
  exp: number;
  iat: number;
}


export const sellerProductsRoute = new Hono<{
  Variables: {
    user: UserPayload;
  };
}>();


sellerProductsRoute.use("*", authMiddleware);
sellerProductsRoute.use("*", requireVerifiedAccount);
sellerProductsRoute.use("*", allowRole(["Seller"]));

sellerProductsRoute.post("/", async (c) => {
  const user = c.get("user");
  const { name, description, price, stock, imageUrl } = await c.req.json();

  if (!name || !price || stock == null) {
    return c.json({ error: "Name, Price, stok, Missing required fields" }, 400);
  }

  const inserted = await db.insert(product).values({
    sellerId: user.id,
    name,
    description,
    price,
    stock,
    imageUrl
  }).returning();

  return c.json({
    message: "Product created successfully",
    data: inserted[0]
  })
});


sellerProductsRoute.get("/", async (c) => {
  const user = c.get("user");

  const list = await db
    .select()
    .from(product)
    .where(eq(product.sellerId, user.id));
})

sellerProductsRoute.put("/:id", async (c) => {
  const user = c.get("user");
  const id = Number(c.req.param("id"));
  const body = await c.req.json();

  const updated = await db
    .update(product)
    .set({
      name: body.name,
      description: body.description,
      price: body.price,
      stock: body.stock,
      imageUrl: body.imageUrl,
      updateAt: new Date(),
    })
    .where(
      and(eq(product.id, id), eq(product.sellerId, user.id))
    )
    .returning();

  return c.json({
    message: "Product updated successfully",
    data: updated[0]
  });
});


sellerProductsRoute.delete("/:id", async (c) => {
  const user = c.get("user");
  const id = Number(c.req.param("id"));

  const deleted = await db
    .delete(product)
    .where(
      and(eq(product.id, id), eq(product.sellerId, user.id))
    )
    .returning();

  if (deleted.length === 0) {
    return c.json({ error: "Product not found" }, 404);
  }
  return c.json({
    message: "Product deleted successfully",
  })
})