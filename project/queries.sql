-- Query usernames with thier bios and social media links (X and GitHub)
SELECT
    "u"."username", 
    "p"."bio",
    "p"."social_links"->>'x' AS "x",
    "p"."social_links"->>'github' AS "GitHub"
    FROM "users" AS "u"
    JOIN "profiles" AS "p" ON "u"."id" = "p"."user_id";

-- Query each user's posts along with post titles and excerpts (for preview)
SELECT
    "u"."username",
    "p"."title" AS "post title",
    get_post_like("p"."id") AS "likes"
    -- "p"."excerpt"
    FROM "users" AS "u"
    JOIN "posts" AS "p" ON "u"."id" = "p"."user_id"
    ORDER BY "likes" DESC, "post title";

-- Query posts grouped by category
SELECT
    "c"."title" AS "category",
    "p"."title" AS "post title",
    "a"."username" AS "written by"
    FROM "posts" AS "p"
    JOIN "users" AS "a" ON "p"."user_id" = "a"."id"
    JOIN "post_categories" AS "pc" ON "p"."id" = "pc"."post_id"
    JOIN "categories" AS "c" ON "pc"."category_id" = "c"."id";

-- Query posts and count their likes
SELECT
    "p"."title" AS "post title",
    COUNT("l"."post_id") AS "likes"
    FROM "posts" AS "p"
    JOIN "likes" AS "l" ON "p"."id" = "l"."post_id"
    GROUP BY "p"."title"
    ORDER BY "likes" DESC, "post title";
