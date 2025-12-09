import type { OpenAPIObject } from "openapi3-ts";

export const swaggerSpec: OpenAPIObject = {
  openapi: "3.0.0",

  info: {
    title: "Jawara API Documentation",
    version: "1.0.0",
    description:
      "Dokumentasi resmi API Jawara untuk Autentikasi, Role, Produk, Cart, Checkout, dan Profil.",
  },

  servers: [
    {
      url: "http://localhost:3000",
      description: "Local Development Server",
    },
  ],

  components: {
    securitySchemes: {
      bearerAuth: {
        type: "http",
        scheme: "bearer",
        bearerFormat: "JWT",
      },
    },

    schemas: {
      User: {
        type: "object",
        properties: {
          id: { type: "number" },
          nik: { type: "string" },
          name: { type: "string" },
          email: { type: "string" },
          role: { type: "string", enum: ["Buyer", "Seller"] },
        },
      },

      Product: {
        type: "object",
        properties: {
          id: { type: "number" },
          sellerId: { type: "number" },
          name: { type: "string" },
          description: { type: "string" },
          price: { type: "number" },
          stock: { type: "number" },
          imageUrl: { type: "string" },
        },
      },

      CartItem: {
        type: "object",
        properties: {
          id: { type: "number" },
          productId: { type: "number" },
          quantity: { type: "number" },
        },
      },

      CheckoutResult: {
        type: "object",
        properties: {
          orderId: { type: "number" },
          message: { type: "string" },
        },
      },
    },
  },

  paths: {
    "/auth/register": {
      post: {
        summary: "Register user baru",
        tags: ["Auth"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              example: {
                nik: "3517xxxxxxx",
                name: "Peri Cantik",
                email: "peri@example.com",
                password: "password123",
              },
            },
          },
        },
        responses: { 200: { description: "Register berhasil" } },
      },
    },

    "/auth/login": {
      post: {
        summary: "Login mendapatkan JWT",
        tags: ["Auth"],
        requestBody: {
          required: true,
          content: {
            "application/json": {
              example: {
                email: "peri@example.com",
                password: "password123",
              },
            },
          },
        },
        responses: {
          200: {
            description: "Login sukses",
            content: {
              "application/json": {
                example: {
                  token: "jwt-token-here",
                },
              },
            },
          },
        },
      },
    },

    "/profile": {
      get: {
        summary: "Ambil profil user",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "OK" } },
      },
      put: {
        summary: "Update profil user",
        tags: ["Profile"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          content: {
            "application/json": {
              example: {
                name: "Peri Baru",
                address: "Jl Baru No. 1",
              },
            },
          },
        },
        responses: { 200: { description: "Update berhasil" } },
      },
    },

    "/role": {
      put: {
        summary: "Rubah role menjadi Buyer / Seller",
        tags: ["Role"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          content: {
            "application/json": {
              example: {
                role: "Seller",
              },
            },
          },
        },
        responses: { 200: { description: "Role updated" } },
      },
    },

    "/products": {
      get: {
        summary: "List semua produk publik",
        tags: ["Products"],
        responses: { 200: { description: "List of products" } },
      },
    },

    "/seller/products": {
      post: {
        summary: "Tambah produk baru (Seller only)",
        tags: ["Seller Products"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          content: {
            "application/json": {
              example: {
                name: "Nasi Goreng",
                description: "Enak banget",
                price: 20000,
                stock: 10,
              },
            },
          },
        },
        responses: { 200: { description: "Produk dibuat" } },
      },

      get: {
        summary: "List produk milik seller",
        tags: ["Seller Products"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "OK" } },
      },
    },

    "/cart": {
      get: {
        summary: "Lihat semua cart",
        tags: ["Cart"],
        security: [{ bearerAuth: [] }],
        responses: { 200: { description: "OK" } },
      },
    },

    "/cart/add": {
      post: {
        summary: "Tambah item ke cart",
        tags: ["Cart"],
        security: [{ bearerAuth: [] }],
        requestBody: {
          content: {
            "application/json": {
              example: {
                productId: 1,
                quantity: 2,
              },
            },
          },
        },
        responses: { 200: { description: "Added" } },
      },
    },

    "/checkout": {
      post: {
        summary: "Checkout cart user",
        tags: ["Checkout"],
        security: [{ bearerAuth: [] }],
        responses: {
          200: {
            description: "Checkout done",
            content: {
              "application/json": {
                example: {
                  orderId: 123,
                  message: "Checkout berhasil",
                },
              },
            },
          },
        },
      },
    },
  },
};
