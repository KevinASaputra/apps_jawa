import { Hono } from "hono";
import { serve } from "@hono/node-server";
import "dotenv/config";
import { usersRoute } from "./routes/users.js";
import { authRoute } from "./routes/auth.js";
import { logoutRoute } from "./routes/logout.js";
import { forgotPasswordRoute } from "./routes/forgotPassword.js";
import { sellerProductsRoute } from "./routes/sellerProducts.js";
import { productsRoute } from "./routes/route.products.js";


const app = new Hono();

app.get("/", (c) => c.text("Hono + Supabase PostgreSQL API Ready!"));
app.route("/users", usersRoute);
app.route("/auth", authRoute);
app.route("/logout", logoutRoute);
app.route("/forgot-password", forgotPasswordRoute);
app.route("/seller/products", sellerProductsRoute);
app.route("/products", productsRoute)


const port = Number(process.env.PORT) || 3001;
console.log(`Server running at http://localhost:${port}`);

serve({
  fetch: app.fetch,
  port
});
