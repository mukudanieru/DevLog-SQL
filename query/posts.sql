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

-- Function to retrieve posts belonging to a specific category,
-- returning the username of the author, category title, post title, and excerpt
CREATE OR REPLACE FUNCTION get_posts_by_category(specific_category_id INTEGER)
RETURNS TABLE (
    username VARCHAR(150),
    category VARCHAR(150),
    post_title VARCHAR(255),
    post_excerpt TEXT
) AS
$$
BEGIN
    RETURN QUERY
    SELECT
        u.username,
        c.title AS category,
        p.title AS post_title,
        p.excerpt AS post_excerpt
    FROM users u
    JOIN posts p ON u.id = p.user_id
    JOIN post_categories pc ON p.id = pc.post_id
    JOIN categories c ON pc.category_id = c.id
    WHERE c.id = specific_category_id;
END;
$$
LANGUAGE plpgsql;

-- Query each user's posts along with post titles and excerpts
SELECT
    "u"."username",
    "p"."title" AS "post title",
    "p"."excerpt" AS "post excerpt"
    FROM "users" AS "u"
    JOIN "posts" AS "p" ON "u"."id" = "p"."user_id";

-- Query posts by most likes 
SELECT
    "u"."username",
    "p"."title" AS "post title",
    "p"."excerpt" AS "post excerpt",
    get_post_likes("p"."id") AS "likes"
    FROM "users" AS "u"
    JOIN "posts" AS "p" ON "u"."id" = "p"."user_id"
    ORDER BY "likes" DESC, "post title" DESC;
