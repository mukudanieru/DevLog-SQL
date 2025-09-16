-- Query usernames with thier bios and social media links (X and GitHub)
SELECT
    "u"."username", 
    "p"."bio",
    "p"."social_links"->>'github' AS "GitHub",
    "p"."social_links"->>'x' AS "x"
FROM "users" AS "u"
JOIN "profiles" AS "p" ON "u"."id" = "p"."user_id";

-- Query each users' number of posts they've made
SELECT
    "u"."username",
    COUNT("p"."title") AS "post count"
FROM "users" AS "u"
JOIN "posts" AS "p" ON "u"."id" = "p"."user_id"
GROUP BY "u"."username"
ORDER BY "post count" DESC;
