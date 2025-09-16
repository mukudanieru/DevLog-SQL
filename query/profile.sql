-- Query usernames with thier bios and social media links (X and GitHub)
SELECT
    "u"."username", 
    "p"."bio",
    "p"."social_links"->>'github' AS "GitHub",
    "p"."social_links"->>'x' AS "x"
    FROM "users" AS "u"
    JOIN "profiles" AS "p" ON "u"."id" = "p"."user_id";