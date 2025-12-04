import { integer, pgTable, serial, text, timestamp, varchar } from "drizzle-orm/pg-core";

export const product = pgTable("products", {
  id: serial("id").primaryKey(),
  sellerId: integer("seller_id").notNull(),
  name: varchar("name", { length: 255 }).notNull(),
  description: text("description").notNull(),
  price: integer("price").notNull(),
  stock: integer("stock").notNull().default(0),

  imageUrl: varchar("image_url", { length: 255 }),

  createdAt: timestamp("created_at").defaultNow(),
  updateAt: timestamp("updated_at").defaultNow()
})