import { Hono } from "hono";
import { serve } from "@hono/node-server";
import "dotenv/config";

import { authRoute } from "./routes/auth.js";
import { logoutRoute } from "./routes/logout.js";
import { forgotPasswordRoute } from "./routes/forgotPassword.js";
import { sellerProductsRoute } from "./routes/sellerProducts.js";
import { productsRoute } from "./routes/route.products.js";
import { roleRoute } from "./routes/role.js";
import { cartRoute } from "./routes/cart.js";
import { checkoutRoute } from "./routes/checkout.js";
import { profileRoute } from "./routes/profile.js";
import { docsRoute } from "./routes/docs.js";

const app = new Hono();

app.get("/", (c) => c.json({
  message: "API Jawara berjalan dengan baik 🚀",
  docs: "/docs"
}));

app.route("/", docsRoute);

app.route("/auth", authRoute);
app.route("/logout", logoutRoute);
app.route("/forgot-password", forgotPasswordRoute);

app.route("/role", roleRoute);

app.route("/cart", cartRoute);
app.route("/checkout", checkoutRoute);
app.route("/profile", profileRoute);

app.route("/seller/products", sellerProductsRoute);

app.route("/products", productsRoute);

const port = Number(process.env.PORT) || 3000;

console.log(`🚀 Server berjalan di http://localhost:${port}`);

serve({
  fetch: app.fetch,
  port,
});
