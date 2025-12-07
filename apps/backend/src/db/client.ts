import { Client } from "pg";
import { drizzle } from "drizzle-orm/node-postgres";
import "dotenv/config";

const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false }
});

client.connect().catch((err) => {
  console.error("Failed to connect to database:", err);
});

export const db = drizzle(client);
export { client };
