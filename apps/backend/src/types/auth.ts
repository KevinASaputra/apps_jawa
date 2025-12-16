export interface UserPayload {
  id: number;
  name: string;
  email: string;
  role: "Buyer" | "Seller";
  iat: number;
  exp: number;
}
