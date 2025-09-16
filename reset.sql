DROP TYPE IF EXISTS
    user_role
CASCADE;

DROP TABLE IF EXISTS 
    post_categories,
    categories,
    likes,
    posts,
    profiles,
    users
CASCADE;

DROP FUNCTION IF EXISTS get_post_likes(specific_post_id INTEGER);

DROP INDEX IF EXISTS
    idx_profile_user_id,
    idx_likes_post_id
CASCADE;