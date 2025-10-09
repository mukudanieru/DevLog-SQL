# DevLog

#### By John Daniel C. Garan

Video overview: <URL HERE>

## Scope

This project is designed to support DevLog, a soon-to-be blogging platform aimed at developers and tech enthusiasts to share their knowledge, experiences, and insights within a community. The goal of DevLog is to create an environment where people in the tech field can publish articles, document their learning journeys, or exchange ideas. To bring this vision to life, I designed a relational database that serves as the foundation of DevLog. The database includes the following key entities:

-   **Users** – individuals who register to share their technical blogs, tutorials, experiences, etc.
-   **Profiles** – user information including bios, and links to their GitHub, X, and other professional profiles
-   **Categories** – topics covering areas such as Artificial Intelligence, Web Development, and programming languages like Python or JavaScript.
-   **Blog posts** – articles covering programming languages, frameworks, tools, best practices, and tech experiences
-   **Likes** – likes that allow readers to show appreciation for helpful or insightful posts

To maintain focus on the core blogging functionality, the following features are currently outside the scope of the project:

-   **Comments and discussions** – conversations between readers and authors
-   **User followers or connections** – social networking features
-   **User permissions beyond roles** – fine-grained access control not yet supported

Future iterations of DevLog may expand to include these features as the platform evolves.

## Functional Requirements

The database will support core user interactions and functionality, allowing users to:

#### Account and Profile Management

-   **Register and authenticate** – create accounts with unique usernames and emails, with role-based access by default for users
-   **Manage profiles** – create and update profile information, including bio, profile picture, and social media links (GitHub, X, LinkedIn)

#### Content Creation and Organization

-   **Create and publish blog posts** – write blog posts with titles, excerpts, slugs, and full content
-   **Edit and delete posts** – update their own published content or remove posts entirely
-   **Categorize content** – assign one or multiple categories to posts for better organization

#### Engagement and Discovery

-   **Browse by category** – explore posts grouped by topics such as Python, JavaScript, or DevOps
-   **Search for content** – find specific posts, authors, or categories
-   **Engage with content** – like posts from other developers to show appreciation

#### Insights and Profiles

-   **View engagement statistics** – see like counts and engagement metrics on posts
-   **View user profiles** – see other developers' bios, social links, and their published posts
-   **Track contributions** – view summaries of their own posts and received likes

#### ⚠️ Out of Scope

Note that in this iteration, users will not be able to:

-   **Comment on posts** – users cannot yet discuss or provide feedback directly on articles
-   **Follow other users** – users cannot subscribe to authors or receive updates
-   **Upload media files** – embedding images or videos directly is not yet supported

## Representation

Entities are captured in PostgreSQL tables with the following schema. The reason behind using PostgreSQL is purely to learn PostgreSQL.

### Entities

#### Users

The `users` table represents individuals registered on DevLog. Each user has identifying and authentication information, along with a role to define their access level.

-   `id` – stored as `SERIAL PRIMARY KEY`, provides a unique, auto-incrementing identifier for each user
-   `first_name` and `last_name` – which specify the user's first and last name, stored as `VARCHAR(100)` to accommodate typical name lengths
-   `email` – `VARCHAR(180)` with a `UNIQUE` constraint ensures each account uses a distinct email
-   `username` – `VARCHAR(150)` with `UNIQUE` constraint prevents duplicates and supports display or login names
-   `password` – `VARCHAR`, allowing enough flexibility for hashed passwords of varying lengths
-   `role` – an `ENUM` type (`'admin'`, `'user'`) that restricts entries to defined roles and simplifies role-based access.
-   `created_at` – stored as `TIMESTAMPTZ`, automatically records when a user account is created, including time zone information

#### Profiles

The `profiles` table extends the users table by storing additional optional user information. Separating profiles from users allows profile data to be managed independently.

-   `id` – stored as `SERIAL PRIMARY KEY`, unique identifier for each profile entry
-   `user_id` – stored as `INT`, links the profile to a user through a foreign key
-   `profile_picture` – stored as `TEXT`, stores URLs or paths to profile images
-   `bio` – stored as `TEXT`, allows users to describe themselves in detail without length constraints
-   `social_links` – stored as `JSONB`, uses PostgreSQL’s JSONB type to flexibly store structured data like GitHub, X, or LinkedIn links

#### Blog Posts

The `posts` table contains all user-generated articles, including titles, excerpts, and main content.

-   `id` – stored as `SERIAL PRIMARY KEY`, unique identifier for each post
-   `user_id` – stored as `INT`, associates the post with its author
-   `title` – stored as `VARCHAR(255)`, descriptive title, limited in length for readability
-   `excerpt` – stored as `TEXT`, optional short preview or summary of the post
-   `slug` – stored as `VARCHAR`, URL-friendly version of the title for routing and readability
-   `content` – stored as `TEXT`, main body of the post
-   `created_at` and `updated_at` – stored as `TIMESTAMPTZ`, track post creation and modifications
-   `CHECK (length(title) <= 100)` – enforces a maximum title length to maintain consistent formatting

#### Categories

The `categories` table defines the different technology or topic areas to which blog posts can belong, supporting filtering and organization.

-   `id` – stored as `SERIAL PRIMARY KEY`, unique identifier for each category
-   `title` – stored as `VARCHAR(150)`, descriptive category name, ensuring no duplicates
-   `slug` – stored as `VARCHAR(255)`, used for clean URLs and consistent referencing

The accompanying `post_categories` table (many-to-many relationship) allows a single post to belong to multiple categories.

-   `post_id` and `category_id` – both stored as `INT`, form a composite primary key to link posts and categories uniquely

#### Likes

-   `user_id` and `post_id` – both stored as `INT`, together form a composite primary key to ensure one like per user per post
-   `created_at` – stored as `TIMESTAMPTZ`, records when the like was made

### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

## Optimizations

In this section you should answer the following questions:

-   Which optimizations (e.g., indexes, views) did you create? Why?

## Limitations

In this section you should answer the following questions:

-   What are the limitations of your design?
-   What might your database not be able to represent very well?
