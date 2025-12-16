import { writeFileSync, mkdirSync, existsSync } from "fs";
import { join } from "path";
import { swaggerSpec } from "../src/docs/swagger.js";

const EXPORT_DIR = join(process.cwd(), "/exports");

if (!existsSync(EXPORT_DIR)) {
  mkdirSync(EXPORT_DIR, { recursive: true });
  console.log("📁 Folder 'exports' created.");
}

interface PostmanRequestItem {
  name: string;
  request: {
    method: string;
    header: Array<{ key: string; value: string; type: string }>;
    url: {
      raw: string;
      host: string[];
      path: string[];
    };
  };
}

interface InsomniaResource {
  _id: string;
  parentId?: string;
  _type: "workspace" | "request" | "environment";
  name: string;
  method?: string;
  url?: string;
  headers?: Array<{ name: string; value: string }>;
  body?: any;
}

const postman = {
  info: {
    _postman_id: "jawara-api",
    name: "Jawara API Collection",
    schema:
      "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
  },
  variable: [
    { key: "base_url", value: "http://localhost:3000" },
    { key: "token", value: "" },
  ],
  item: [] as PostmanRequestItem[],
};

for (const path in swaggerSpec.paths) {
  const methods = swaggerSpec.paths[path];

  for (const method in methods) {
    const endpoint: any = methods[method];

    postman.item.push({
      name: endpoint.summary || `${method.toUpperCase()} ${path}`,
      request: {
        method: method.toUpperCase(),
        header: endpoint.security
          ? [{ key: "Authorization", value: "Bearer {{token}}", type: "text" }]
          : [],
        url: {
          raw: `{{base_url}}${path}`,
          host: ["{{base_url}}"],
          path: path.replace(/^\//, "").split("/"),
        },
      },
    });
  }
}

writeFileSync(
  join(EXPORT_DIR, "postman_collection.json"),
  JSON.stringify(postman, null, 2),
  "utf8"
);

const insomnia = {
  _type: "export",
  __export_format: 4,
  __export_date: new Date().toISOString(),
  resources: [] as InsomniaResource[],
};

let counter = 1;
const newId = () => `req_${counter++}`;

insomnia.resources.push({
  _id: "wrk_jawara",
  _type: "workspace",
  name: "Jawara API Workspace",
});

insomnia.resources.push({
  _id: "env_jawara",
  parentId: "wrk_jawara",
  _type: "environment",
  name: "Base Environment",
  body: {
    base_url: "http://localhost:3000",
    token: "",
  },
});

for (const path in swaggerSpec.paths) {
  const methods = swaggerSpec.paths[path];

  for (const method in methods) {
    const endpoint: any = methods[method];

    insomnia.resources.push({
      _id: newId(),
      parentId: "wrk_jawara",
      _type: "request",
      name: endpoint.summary || `${method.toUpperCase()} ${path}`,
      method: method.toUpperCase(),
      url: `{{ base_url }}${path}`,
      headers: endpoint.security
        ? [{ name: "Authorization", value: "Bearer {{ token }}" }]
        : [],
      body: {},
    });
  }
}

writeFileSync(
  join(EXPORT_DIR, "insomnia_collection.json"),
  JSON.stringify(insomnia, null, 2),
  "utf8"
);

console.log(
  "✨ Successfully generated Postman & Insomnia collections in /apps/backend/exports/"
);
