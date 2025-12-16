import { Hono } from "hono";
import { swaggerSpec } from "../docs/swagger.js";

export const docsRoute = new Hono();

docsRoute.use("/docs/*", async (c, next) => {
  const key = c.req.header("X-Docs-Key");

  if (key !== process.env.DOCS_SECRET) {
    return c.json(
      {
        error: "Unauthorized access to API Documentation",
        hint: "Provide X-Docs-Key header",
      },
      401
    );
  }

  await next();
});

docsRoute.get("/docs", (c) => {
  return c.html(`
  <!DOCTYPE html>
  <html>
    <head>
      <title>Jawara API Docs</title>
      <link rel="stylesheet" href="https://unpkg.com/swagger-ui-dist/swagger-ui.css" />
      <style>
        body { margin: 0; padding: 0; font-family: sans-serif; background: #f4f4f4; }
        #swagger-ui { margin: 0; }
      </style>
    </head>
    <body>
      <div id="swagger-ui"></div>

      <script src="https://unpkg.com/swagger-ui-dist/swagger-ui-bundle.js"></script>
      <script src="https://unpkg.com/swagger-ui-dist/swagger-ui-standalone-preset.js"></script>

      <script>
        window.onload = () => {
          SwaggerUIBundle({
            url: "/docs/swagger.json",
            dom_id: "#swagger-ui",
            presets: [SwaggerUIBundle.presets.apis, SwaggerUIStandalonePreset],
            layout: "StandaloneLayout",
            docExpansion: "none",
            deepLinking: true,
            displayRequestDuration: true
          });
        };
      </script>
    </body>
  </html>
  `);
});

docsRoute.get("/docs/swagger.json", (c) => c.json(swaggerSpec));
