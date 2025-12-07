CREATE TABLE "citizens" (
	"id" serial PRIMARY KEY NOT NULL,
	"nik" varchar(16) NOT NULL,
	"name" varchar(150) NOT NULL,
	"gender" varchar(10),
	"birth_place" varchar(100),
	"birth_date" varchar(15),
	"address" varchar(255),
	"email" varchar(150) NOT NULL,
	"password_hash" varchar(255) NOT NULL,
	"role" varchar(20) DEFAULT 'pembeli' NOT NULL,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "citizens_nik_unique" UNIQUE("nik"),
	CONSTRAINT "citizens_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "password_reset" (
	"id" serial PRIMARY KEY NOT NULL,
	"email" varchar(150) NOT NULL,
	"otp" varchar(255) NOT NULL,
	"expires_at" timestamp NOT NULL
);
