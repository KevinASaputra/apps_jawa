import { Client } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";
import "dotenv/config";

export const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

await client.connect();

export const db = drizzle(client);
