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