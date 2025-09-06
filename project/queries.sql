SELECT "u"."first_name", "u"."last_name",
    "u"."username", 
    "p"."profile_picture", 
    "p"."bio",
    "p"."social_links" 
    FROM "users" AS "u"
    JOIN "profiles" AS "p" ON "u"."id" = "p"."user_id";

