-- Insert category data
INSERT INTO categories (title, slug) VALUES
('Artificial Intelligence and Machine Learning', 'artificial-intelligence-and-machine-learning'),
('C', 'c'),
('C#', 'c-sharp'),
('C++', 'c-plus-plus'),
('Cloud Computing', 'cloud-computing'),
('Cybersecurity', 'cybersecurity'),
('Data Science and Analytics', 'data-science-and-analytics'),
('DevOps', 'devops'),
('Developer Tools', 'developer-tools'),
('Game Development', 'game-development'),
('Go', 'go'),
('HTML and CSS', 'html-and-css'),
('Java', 'java'),
('JavaScript', 'javascript'),
('Mobile Development', 'mobile-development'),
('Open Source', 'open-source'),
('PHP', 'php'),
('Professional Skills', 'professional-skills'),
('Python', 'python'),
('SQL', 'sql'),
('Web Design', 'web-design'),
('Web Development', 'web-development');

-- Insert admin user
INSERT INTO users (first_name, last_name, email, username, password, role) VALUES
('John Daniel', 'Garan', 'john.garan@example.com', 'johngaran', '$2b$12$examplehashedpassword567mno', 'admin');

-- Insert regular user
INSERT INTO users (first_name, last_name, email, username, password) VALUES
('Brandon', 'Abuya', 'brandon.abuya@example.com', 'brandonabuya', '$2b$12$examplehashedpassword123abc'),
('Joeniesus', 'Vidal', 'joeniesus.vidal@example.com', 'joeniesusvidal', '$2b$12$examplehashedpassword012abc');

-- Insert user profiles
INSERT INTO profiles (user_id, profile_picture, bio, social_links) VALUES
(1, 'https://example.com/profiles/john.jpg',
    'Hey, I''m John Daniel! Open-source contributor and software engineer who loves to build things that make a difference. Always open to collaboration—let''s make something awesome.',
    '{"x": "https://x.com/mukudanieru", "github": "https://github.com/mukudanieru"}'),
(2, 'https://example.com/profiles/brandon.jpg',
    'Hi, I''m Brandon! A tech enthusiast who loves gaming and building cool stuff.',
    '{"x": "https://x.com/brandonabuya", "github": "https://github.com/nui"}'),
(3, 'https://example.com/profiles/joeniesus.jpg',
    'Hi, I''m Joeniesus! Software Engineer specializing in web development. I love diving deep into front-end and back-end technologies to build fast, responsive, and user-friendly web applications.',
    '{"x": "https://x.com/joeniesusvidal", "github": "https://github.com/jnssvdl"}');

-- Insert posts by John Daniel Garan
INSERT INTO posts (user_id, title, excerpt, slug, content) VALUES
(1, 'Why Open Source Matters: A Developer''s Perspective',
    'My journey with open source and why every developer should contribute to the community that built the tools we use every day.',
    'why-open-source-matters-developer-perspective',
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.'),

(1, 'Building Scalable Applications: Lessons Learned',
    'Key insights from building applications that can handle growth, from architecture decisions to performance optimization strategies.',
    'building-scalable-applications-lessons-learned'
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.');

-- Insert posts by Brandon Abuya
INSERT INTO posts (user_id, title, excerpt, slug, content) VALUES

(2, 'Game Development with Unity: A Beginner''s Journey',
    'My first steps into game development using Unity and C#, including the challenges I faced and lessons learned along the way.',
    'game-development-unity-beginner-journey',
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.'),

(2, 'Building a Gaming PC in 2024: Performance vs Budget',
    'A comprehensive guide to building a gaming PC that balances performance with cost-effectiveness in today''s market.',
    'building-gaming-pc-2024-performance-budget',
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.');

-- Insert posts by Joeniesus Vidal
INSERT INTO posts (user_id, title, excerpt, slug, content) VALUES

(3, 'The Power of React in Modern Web Development',
    'Why React continues to dominate the frontend landscape and how it has transformed the way we build user interfaces.',
    'power-of-react-modern-web-development',
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.'),

(3, 'Full-Stack Performance: Database to Browser',
    'Key strategies for optimizing web application performance across the entire stack.',
    'full-stack-performance-database-browser',
    'Lorem ipsum dolor sit amet consectetur adipiscing elit. Sit amet consectetur adipiscing elit quisque faucibus ex. Adipiscing elit quisque faucibus ex sapien vitae pellentesque.');

-- Insert like data
INSERT INTO likes (user_id, post_id) VALUES
(1, 6), (1, 7), (1, 8),
(2, 2), (2, 7),
(3, 6), (3, 2), (3, 3);

-- Associate posts with categories
INSERT INTO post_categories (post_id, category_id) VALUES
(1, 16),
(2, 18),
(3, 18),

(4, 10),
(5, 10),
(6, 10),

(7, 12), (7, 14), (7, 22),
(8, 22),
(9, 14);

-- Retrieve user profiles with social media links
SELECT
    u.username,
    p.bio,
    p.social_links->>'x' AS x,
    p.social_links->>'github' AS github
    FROM users AS u
    JOIN profiles AS p ON u.id = p.user_id;

-- Retrieve posts organized by category
SELECT
    c.title AS category,
    p.title AS post_title,
    a.username AS written_by
    FROM posts AS p
    JOIN users AS a ON p.user_id = a.id
    JOIN post_categories AS pc ON p.id = pc.post_id
    JOIN categories AS c ON pc.category_id = c.id;

-- Update username for Joeniesus Vidal
UPDATE users SET username = 'jnssvdl'
WHERE username = 'joeniesusvidal';

-- Update username for Brandon Abuya
UPDATE users SET username = 'nui'
WHERE username = 'brandonabuya';

-- Update post title for specific post
UPDATE posts SET title = 'Why Open Source Still Matters in 2025'
WHERE id = 1;

-- Update post content and excerpt
UPDATE posts 
SET 
    content = 'Lorem ipsum dolor sit amet consectetur adipiscing elit. Updated content with new insights and examples.',
    excerpt = 'An updated perspective on open source contributions and community involvement.',
    updated_at = CURRENT_TIMESTAMP
WHERE id = 1;

-- Update user profile bio
UPDATE profiles SET bio = 'Hey, I''m John Daniel! Senior Software Engineer and open-source advocate. Building tools that empower developers worldwide.'
WHERE user_id = 1;

-- Update profile picture and social links
UPDATE profiles 
SET 
    profile_picture = 'https://example.com/profiles/john-new.jpg',
    social_links = '{"x": "https://x.com/mukudanieru", "github": "https://github.com/mukudanieru", "linkedin": "https://linkedin.com/in/johngaran"}'
WHERE user_id = 1;

-- Delete specific post
DELETE FROM posts
WHERE id = '5';
