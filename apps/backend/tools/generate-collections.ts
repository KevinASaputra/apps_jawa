import { writeFileSync, mkdirSync, existsSync } from "fs";
import { swaggerSpec } from "../src/docs/swagger.js";
import { join } from "path";

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
  _type: string;
  name: string;
  method?: string;
  url?: string;
  headers?: Array<{ name: string; value: string }>;
  body?: any;
}

const postman: {
  info: any;
  item: PostmanRequestItem[];
} = {
  info: {
    _postman_id: "jawara-api",
    name: "Jawara API Collection",
    schema:
      "https://schema.getpostman.com/json/collection/v2.1.0/collection.json",
  },
  item: [],
};

for (const path in swaggerSpec.paths) {
  const methods = swaggerSpec.paths[path];

  for (const method in methods) {
    const endpoint = methods[method];

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

const insomnia: {
  _type: string;
  __export_format: number;
  resources: InsomniaResource[];
} = {
  _type: "export",
  __export_format: 4,
  resources: [],
};

let counter = 1;
const newId = () => `id_${counter++}`;

insomnia.resources.push({
  _id: "wrk_1",
  _type: "workspace",
  name: "Jawara API Workspace",
});

for (const path in swaggerSpec.paths) {
  const methods = swaggerSpec.paths[path];

  for (const method in methods) {
    const endpoint = methods[method];

    insomnia.resources.push({
      _id: newId(),
      parentId: "wrk_1",
      _type: "request",
      name: endpoint.summary || `${method.toUpperCase()} ${path}`,
      method: method.toUpperCase(),
      url: `{{base_url}}${path}`,
      headers: endpoint.security
        ? [{ name: "Authorization", value: "Bearer {{token}}" }]
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

console.log("✨ Successfully generated Postman & Insomnia collections in /apps/backend/exports/");
