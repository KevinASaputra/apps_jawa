import type { OpenAPIObject } from "openapi3-ts";

export const swaggerSpec: OpenAPIObject = {
  openapi: "3.0.0",

  info: {
    title: "Jawara API Documentation",
    version: "1.0.0",
    description:
      "Dokumentasi resmi API Jawara – Auth, Profile, Family, Buyer, Seller, Cart, Checkout, Admin, Finance, Activity & Dashboard.",
  },

  servers: [
    {
      url: "https://apps-jawa-backend.vercel.app",
      description: "Production Server",
    },
    {
      url: "https://jawara-dev.vercel.app",
      description: "Staging / Dev Server",
    },
    {
      url: "http://localhost:3000",
      description: "Local Development",
    },
  ],

  tags: [
    { name: "Auth", description: "Authentication (public)" },
    { name: "Profile", description: "User profile & family" },
    { name: "Products", description: "Public product listing" },
    { name: "Buyer", description: "🔒 Buyer only APIs" },
    { name: "Seller", description: "🔒 Seller only APIs" },
    { name: "Admin", description: "🔒 Admin only APIs" },
    { name: "Finance", description: "🔒 Admin finance management" },
    { name: "Activities", description: "🔒 Admin activities management" },
    { name: "Dashboard", description: "🔒 Admin dashboard" },
  ],

  paths: {
    "/auth/register": {
      post: {
        summary: "Register user",
        tags: ["Auth"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/RegisterRequest" },
            },
          },
        },
        responses: { 200: { description: "Register berhasil" } },
      },
    },

    "/auth/login": {
      post: {
        summary: "Login",
        tags: ["Auth"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/LoginRequest" },
            },
          },
        },
        responses: { 200: { description: "Login berhasil" } },
      },
    },

    "/profile": {
      get: {
        summary: "Get profile",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Profile loaded" } },
      },
      put: {
        summary: "Update profile",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/ProfileUpdate" },
            },
          },
        },
        responses: { 200: { description: "Profile updated" } },
      },
    },

    "/profile/family": {
      get: {
        summary: "Get family members",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Family list" } },
      },
      post: {
        summary: "Add family member",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/FamilyMemberCreate" },
            },
          },
        },
        responses: { 200: { description: "Family member added" } },
      },
    },

    "/role": {
      put: {
        summary: "Upgrade role (Buyer → Seller)",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/RoleUpdate" },
            },
          },
        },
        responses: { 200: { description: "Role updated" } },
      },
    },

    "/products": {
      get: {
        summary: "List all products",
        tags: ["Products"],
        responses: { 200: { description: "Success" } },
      },
    },

    "/seller/products": {
      get: {
        summary: "Seller – list own products",
        tags: ["Seller"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Success" } },
      },
      post: {
        summary: "Seller – create product",
        tags: ["Seller"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/ProductCreate" },
            },
          },
        },
        responses: { 200: { description: "Product created" } },
      },
    },

    "/cart": {
      get: {
        summary: "View cart",
        tags: ["Buyer"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Success" } },
      },
    },

    "/cart/add": {
      post: {
        summary: "Add item to cart",
        tags: ["Buyer"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/CartAdd" },
            },
          },
        },
        responses: { 200: { description: "Item added" } },
      },
    },

    "/checkout": {
      post: {
        summary: "Checkout cart",
        tags: ["Buyer"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Checkout success" } },
      },
    },

    "/admin/verify/{citizenId}": {
      post: {
        summary: "Verify citizen (Head of family)",
        tags: ["Admin"],
        security: [{ bearerAuth: [] }],
        parameters: [
          {
            name: "citizenId",
            in: "path",
            required: true,
            schema: { type: "integer" },
          },
        ],
        responses: { 200: { description: "Citizen verified" } },
      },
    },

    "/admin/finance": {
      get: {
        summary: "List finance records",
        tags: ["Finance"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Success" } },
      },
      post: {
        summary: "Create finance record",
        tags: ["Finance"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/FinanceCreate" },
            },
          },
        },
        responses: { 200: { description: "Finance created" } },
      },
    },

    "/admin/activities": {
      get: {
        summary: "List activities",
        tags: ["Activities"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Success" } },
      },
      post: {
        summary: "Create activity",
        tags: ["Activities"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              schema: { $ref: "#/components/schemas/ActivityCreate" },
            },
          },
        },
        responses: { 200: { description: "Activity created" } },
      },
    },

    "/admin/dashboard": {
      get: {
        summary: "Admin dashboard summary",
        tags: ["Dashboard"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "Dashboard data" } },
      },
    },
  },

  components: {
    securitySchemes: {
      bearerAuth: {
        type: "http",
        scheme: "bearer",
        bearerFormat: "JWT",
      },
    },

    schemas: {
      RegisterRequest: {
        type: "object",
        required: ["name", "email", "password"],
        properties: {
          name: { type: "string" },
          email: { type: "string" },
          password: { type: "string" },
        },
      },

      LoginRequest: {
        type: "object",
        required: ["email", "password"],
        properties: {
          email: { type: "string" },
          password: { type: "string" },
        },
      },

      ProfileUpdate: {
        type: "object",
        properties: {
          address: { type: "string" },
          phone: { type: "string" },
          birth_date: { type: "string", format: "date" },
        },
      },

      FamilyMemberCreate: {
        type: "object",
        required: ["name", "relation"],
        properties: {
          name: { type: "string" },
          relation: { type: "string" },
          birth_date: { type: "string", format: "date" },
        },
      },

      RoleUpdate: {
        type: "object",
        required: ["role"],
        properties: {
          role: { type: "string", enum: ["Buyer", "Seller"] },
        },
      },

      ProductCreate: {
        type: "object",
        required: ["name", "price"],
        properties: {
          name: { type: "string" },
          description: { type: "string" },
          price: { type: "number" },
          stock: { type: "number" },
        },
      },

      CartAdd: {
        type: "object",
        required: ["productId", "quantity"],
        properties: {
          productId: { type: "number" },
          quantity: { type: "number" },
        },
      },

      FinanceCreate: {
        type: "object",
        required: ["type", "amount", "date"],
        properties: {
          type: { type: "string", enum: ["income", "expense"] },
          amount: { type: "number" },
          description: { type: "string" },
          date: { type: "string", format: "date" },
        },
      },

      ActivityCreate: {
        type: "object",
        required: ["title", "date"],
        properties: {
          title: { type: "string" },
          description: { type: "string" },
          date: { type: "string", format: "date" },
          location: { type: "string" },
        },
      },
    },
  },
};
