import { Hono } from "hono";
import { serve } from "@hono/node-server";
import "dotenv/config";
import { usersRoute } from "./routes/users.js";


const app = new Hono();

app.get("/", (c) => c.text("Hono + Supabase PostgreSQL API Ready!"));
app.route("/users", usersRoute);

const port = Number(process.env.PORT) || 3001;
console.log(`Server running at http://localhost:${port}`);

serve({
  fetch: app.fetch,
  port
});
