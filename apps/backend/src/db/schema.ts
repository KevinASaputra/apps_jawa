import {
  pgTable,
  serial,
  varchar,
  integer,
  text,
  timestamp,
} from "drizzle-orm/pg-core";

export const citizens = pgTable("citizens", {
  id: serial("id").primaryKey(),

  nik: varchar("nik", { length: 16 }).notNull(),
  name: varchar("name", { length: 150 }).notNull(),
  gender: varchar("gender", { length: 10 }),

  birth_place: varchar("birth_place", { length: 100 }),
  birth_date: varchar("birth_date", { length: 15 }),

  address: varchar("address", { length: 255 }),

  email: varchar("email", { length: 150 }).notNull(),
  password_hash: varchar("password_hash", { length: 255 }).notNull(),

  role: varchar("role", { length: 20 }).notNull().default("pembeli"),

  created_at: timestamp("created_at").defaultNow(),
});

export const passwordReset = pgTable("password_reset", {
  id: serial("id").primaryKey(),
  email: varchar("email", { length: 150 }).notNull(),
  otp: varchar("otp", { length: 255 }).notNull(),
  expires_at: timestamp("expires_at").notNull(),
});

export const products = pgTable("products", {
  id: serial("id").primaryKey(),
  sellerId: integer("seller_id").notNull(),
  name: varchar("name", { length: 255 }).notNull(),
  description: text("description").notNull(),
  price: integer("price").notNull(),
  stock: integer("stock").notNull().default(0),
  imageUrl: varchar("image_url", { length: 255 }),
  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});


export const orders = pgTable("orders", {
  id: serial("id").primaryKey(),
  buyerId: integer("buyer_id").notNull(),
  totalPrice: integer("total_price").notNull(),
  status: varchar("status", { length: 20 }).default("pending"),
  createdAt: timestamp("created_at").defaultNow(),
});

export const orderItems = pgTable("order_items", {
  id: serial("id").primaryKey(),
  orderId: integer("order_id").notNull(),
  productId: integer("product_id").notNull(),
  quantity: integer("quantity").notNull(),
  price: integer("price").notNull(),
});

export const cartItems = pgTable("cart_items", {
  id: serial("id").primaryKey(),
  buyerId: integer("buyer_id").notNull(),
  productId: integer("product_id").notNull(),
  quantity: integer("quantity").notNull().default(1),
  createdAt: timestamp("created_at").defaultNow(),
});

