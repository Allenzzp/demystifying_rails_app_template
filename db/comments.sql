CREATE TABLE "comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "body" text,
  "author" varchar,
  "post_id" INTEGER,
  "created_At" datetime NOT NULL
);