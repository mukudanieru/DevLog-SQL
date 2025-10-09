-- Define user role enum
CREATE TYPE user_role AS ENUM ('admin', 'user');

-- Store user account information
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(180) NOT NULL UNIQUE,
    username VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR NOT NULL,
    role user_role NOT NULL DEFAULT 'user',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Store user profile details
CREATE TABLE profiles (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    profile_picture TEXT,
    bio TEXT,
    social_links JSONB DEFAULT '{}'::jsonb,
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

-- Store blog posts
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    excerpt TEXT,
    slug VARCHAR NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMPTZ,
    CONSTRAINT title_length_check CHECK (length(title) <= 100)
);

-- Store post likes from users
CREATE TABLE likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id, post_id),
    FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE
);

-- Store post categories
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL UNIQUE,
    slug VARCHAR(255) NOT NULL UNIQUE
);

-- Associate posts with categories (many-to-many)
CREATE TABLE post_categories (
    post_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (post_id, category_id),
    FOREIGN KEY (post_id) REFERENCES posts (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
);

-- Improve post lookup performance by user
CREATE INDEX idx_posts_user_id ON posts(user_id);

-- Improve like lookup performance by user
CREATE INDEX idx_likes_user_id ON likes(user_id);

-- Improve like lookup performance by post
CREATE INDEX idx_likes_post_id ON likes(post_id);

-- Improve post-category join performance by post
CREATE INDEX idx_post_categories_post_id ON post_categories(post_id);

-- Improve post-category join performance by category
CREATE INDEX idx_post_categories_category_id ON post_categories(category_id);

-- Count total likes for a specific post
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

-- Retrieve posts for a specific category with author and category details
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

-- Display user statistics including post count and total likes received
CREATE VIEW user_overview AS
SELECT
    u.username,
    u.email,
    COUNT(p.title) AS post_count,
    COUNT(l.post_id) AS total_likes
FROM users AS u
JOIN posts AS p ON u.id = p.user_id
JOIN likes AS l ON p.id = l.post_id
GROUP BY u.username, u.email;

-- Display post details with author and like count
CREATE VIEW post_overview AS
SELECT
    u.username,
    p.title AS post_title,
    p.excerpt AS post_excerpt,
    p.created_at,
    get_post_likes(p.id) AS likes
FROM users AS u
JOIN posts AS p ON u.id = p.user_id;

-- Display post count per category
CREATE VIEW category_summary AS
SELECT 
    c.title AS category,
    COUNT(p.title) AS post_count
FROM categories AS c
JOIN post_categories AS pc ON c.id = pc.category_id
JOIN posts AS p ON pc.post_id = p.id
GROUP BY category;
