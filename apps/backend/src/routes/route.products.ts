import { Hono } from "hono";
import { db } from "../db/client.js";
import { product } from "../db/product.js";

export const productsRoute = new Hono();

productsRoute.get("/", async (c) => {
  const list = await db.select().from(product);
  return c.json(list);
});