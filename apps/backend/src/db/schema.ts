import { pgTable, serial, varchar, timestamp } from "drizzle-orm/pg-core";

export const users = pgTable("users", {
  id: serial("id").primaryKey(),
  name: varchar("name", { length: 150 }),
  email: varchar("email", { length: 150 }).notNull(),
  createdAt: timestamp("created_at").defaultNow()
});
