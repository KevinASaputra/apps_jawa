import type { Context, Next } from "hono";

export function allowRole(allowed: string[]) {
  return async (c: Context, next: Next) => {
    const user = c.get("user");

    if (!allowed.includes(user.role)) {
      return c.json({ error: "Akses ditolak (unauthorized role)" }, 403);
    }

    await next();
  };
}
