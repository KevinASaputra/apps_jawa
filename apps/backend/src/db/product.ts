import { pgTable, serial } from "drizzle-orm/pg-core";

export const product = pgTable("products", {
  id: serial("id").primaryKey(),
})