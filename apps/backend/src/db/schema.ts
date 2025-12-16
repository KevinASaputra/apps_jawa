import {
  pgTable,
  serial,
  varchar,
  integer,
  text,
  timestamp,
  date,
  boolean,
} from "drizzle-orm/pg-core";

export const citizens = pgTable("citizens", {
  id: serial("id").primaryKey(),

  name: varchar("name", { length: 150 }).notNull(),
  email: varchar("email", { length: 150 }).notNull().unique(),
  password_hash: text("password_hash").notNull(),

  role: varchar("role", { length: 20 }).default("Buyer").notNull(),

  account_status: varchar("account_status", { length: 20 })
    .default("PENDING")
    .notNull(),

  address: text("address"),
  phone: varchar("phone", { length: 20 }),
  birth_date: date("birth_date"),

  verified_at: timestamp("verified_at"),
  verified_by: integer("verified_by"),


  created_at: timestamp("created_at").defaultNow(),
});


export const profiles = pgTable("profiles", {
  id: serial("id").primaryKey(),

  user_id: integer("user_id")
    .references(() => citizens.id)
    .notNull()
    .unique(),

  gender: varchar("gender", { length: 10 }),
  birth_place: varchar("birth_place", { length: 100 }),
  birth_date: date("birth_date"),
  address: varchar("address", { length: 255 }),
  phone: varchar("phone", { length: 20 }),

  updated_at: timestamp("updated_at").defaultNow(),
});

export const familyMembers = pgTable("family_members", {
  id: serial("id").primaryKey(),

  citizen_id: integer("citizen_id")
    .references(() => citizens.id, { onDelete: "cascade" })
    .notNull(),

  name: varchar("name", { length: 150 }).notNull(),
  relation: varchar("relation", { length: 50 }).notNull(),
  birth_date: date("birth_date"),

  is_head: boolean("is_head").default(false),

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
  rating_avg: integer("rating_avg").default(0),
  rating_count: integer("rating_count").default(0),
  sold_count: integer("sold_count").default(0),

  createdAt: timestamp("created_at").defaultNow(),
  updatedAt: timestamp("updated_at").defaultNow(),
});

export const productReviews = pgTable("product_reviews", {
  id: serial("id").primaryKey(),
  product_id: integer("product_id")
    .references(() => products.id, { onDelete: "cascade" })
    .notNull(),

  user_id: integer("user_id")
    .references(() => citizens.id, { onDelete: "cascade" })
    .notNull(),
  rating: integer("rating").notNull(), // 1–5
  comment: text("comment"),
  created_at: timestamp("created_at").defaultNow(),
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

export const finances = pgTable("finances", {
  id: serial("id").primaryKey(),

  type: varchar("type", { length: 20 }).notNull(),
  amount: integer("amount").notNull(),
  description: text("description"),

  created_by: integer("created_by")
    .notNull()
    .references(() => citizens.id),

  date: date("date").notNull(),

  created_at: timestamp("created_at").defaultNow(),
});

export const activities = pgTable("activities", {
  id: serial("id").primaryKey(),

  title: varchar("title", { length: 150 }).notNull(),
  description: text("description"),
  date: date("date").notNull(),
  location: varchar("location", { length: 150 }),

  created_by: integer("created_by")
    .notNull()
    .references(() => citizens.id),

  created_at: timestamp("created_at").defaultNow(),
});
