import { Hono } from "hono";
import { db } from "../db/client.js";
import { products } from "../db/schema.js";

export const productsRoute = new Hono();

productsRoute.get("/", async (c) => {
  const list = await db.select().from(products);

  return c.json(
    list.map((p) => ({
      id: p.id,
      name: p.name,
      price: p.price,
      stock: p.stock,
      imageUrl: p.imageUrl,
      rating: {
        avg: p.rating_avg,
        count: p.rating_count,
      },
      sold: p.sold_count,
    }))
  );
});