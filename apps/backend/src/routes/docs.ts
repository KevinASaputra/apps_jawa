import { Hono } from "hono";
import { swaggerSpec } from "../docs/swagger.js";

export const docsRoute = new Hono();

// Serve Swagger UI via CDN
docsRoute.get("/docs", (c) => {
  return c.html(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>Jawara API Docs</title>

      <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/swagger-ui-dist/swagger-ui.css"
      />

      <style>
        body { margin: 0; padding: 0; background: #f2f2f2; }
        #swagger { width: 100%; height: 100vh; }
      </style>
    </head>

    <body>
      <div id="swagger"></div>

      <script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist/swagger-ui-bundle.js"></script>

      <script>
        window.onload = () => {
          SwaggerUIBundle({
            url: "/docs/swagger.json",
            dom_id: "#swagger",
            presets: [
              SwaggerUIBundle.presets.apis,
              SwaggerUIBundle.SwaggerUIStandalonePreset
            ]
          });
        };
      </script>
    </body>
    </html>
  `);
});

// JSON Spec
docsRoute.get("/docs/swagger.json", (c) => c.json(swaggerSpec));
