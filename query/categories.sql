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

-- Query all categories along with the number of posts assigned to each
SELECT 
    "c"."title" AS "category",
    COUNT("p"."title") AS "post count"
FROM "categories" AS "c"
JOIN "post_categories" AS "pc" ON "c"."id" = "pc"."category_id"
JOIN "posts" AS "p" ON "pc"."post_id" = "p"."id"
GROUP BY "category"
ORDER BY "post count" DESC;
