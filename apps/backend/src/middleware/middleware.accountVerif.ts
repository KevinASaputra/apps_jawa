import type { Context, Next } from "hono";

export const requireVerifiedAccount = async (c: Context, next: Next) => {
  const user = c.get("user");

  if (user.account_status !== "VERIFIED") {
    return c.json(
      { error: "Account belum diverifikasi admin" },
      403
    );
  }

  await next();
};
