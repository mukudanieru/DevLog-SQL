SELECT
    "u"."username", 
    "p"."bio"
    FROM "users" AS "u"
    JOIN "profiles" AS "p" ON "u"."id" = "p"."user_id";

-- SELECT * FROM "posts";