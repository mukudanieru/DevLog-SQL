-- Function to count the number of likes for a given post
CREATE OR REPLACE FUNCTION get_post_likes(specific_post_id INTEGER)
RETURNS INTEGER AS
$$
DECLARE
    post_like_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO post_like_count
    FROM likes
    WHERE post_id = specific_post_id;
    RETURN post_like_count;
END;
$$
LANGUAGE plpgsql;

-- Query each user's posts along with post titles and excerpts sorted by most recent first
SELECT
    "u"."username",
    "p"."title" AS "post title",
    "p"."excerpt" AS "post excerpt",
    "p"."created_at"
FROM "users" AS "u"
JOIN "posts" AS "p" ON "u"."id" = "p"."user_id"
ORDER BY "p"."created_at" DESC;

-- Query posts by most likes 
SELECT
    "u"."username",
    "p"."title" AS "post title",
    "p"."excerpt" AS "post excerpt",
    get_post_likes("p"."id") AS "likes"
FROM "users" AS "u"
JOIN "posts" AS "p" ON "u"."id" = "p"."user_id"
ORDER BY "likes" DESC, "post title" ASC;
