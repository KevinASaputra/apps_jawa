import { pgTable, serial, timestamp, varchar } from "drizzle-orm/pg-core";

export const citizens = pgTable("citizens", {
  id: serial("id").primaryKey(),

  nik: varchar("nik", { length: 16 }).notNull().unique(),
  name: varchar("name", { length: 150 }).notNull(),
  gender: varchar("gender", { length: 10 }),

  birthPlace: varchar("birth_place", { length: 100 }),
  birthDate: varchar("birth_date", { length: 15 }),

  address: varchar("address", { length: 255 }),
  email: varchar("email", { length: 150 }).notNull().unique(),

  passwordHash: varchar("password_hash", { length: 255 }).notNull(),

  createdAt: timestamp("created_at").defaultNow(),
});
