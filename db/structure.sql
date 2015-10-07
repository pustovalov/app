CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "cards" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "original_text" text, "translated_text" text, "review_date" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES ('20151007080610');

