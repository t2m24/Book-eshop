CREATE TABLE `users` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `email` varchar(100) UNIQUE NOT NULL,
    `phone_number` varchar(20),
    `password` varchar(255) NOT NULL,
    `full_name` varchar(100),
    `role` varchar(20) NOT NULL
);

CREATE TABLE `books` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `title` varchar(255) NOT NULL,
    `cover_image_url` varchar(512),
    `description` text,
    `isbn` varchar(20) UNIQUE NOT NULL,
    `publication_year` integer,
    `price` decimal(10,2) NOT NULL,
    `is_ebook_available` boolean DEFAULT false
);

CREATE TABLE `authors` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(100) NOT NULL
);

CREATE TABLE `genres` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(50) NOT NULL
);

CREATE TABLE `book_authors` (
    `book_id` integer,
    `author_id` integer
);

CREATE TABLE `book_genres` (
    `book_id` integer,
    `genre_id` integer
);

CREATE TABLE `stores` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    `address` varchar(255)
);

CREATE TABLE `store_inventory` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `store_id` integer,
    `book_id` integer,
    `stock_amount` integer
);

CREATE TABLE `orders` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `user_id` integer,
    `order_type` varchar(20) NOT NULL,
    `selected_store_id` integer,
    `status` varchar(30) NOT NULL,
    `created_at` timestamp DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE `order_items` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `order_id` integer,
    `book_id` integer,
    `is_ebook` boolean DEFAULT false,
    `quantity` integer NOT NULL,
    `price_per_unit` decimal(10,2) NOT NULL
);

CREATE TABLE `ebook_rentals` (
    `id` integer PRIMARY KEY AUTO_INCREMENT,
    `user_id` integer,
    `book_id` integer,
    `rented_at` timestamp DEFAULT CURRENT_TIMESTAMP,
    `expires_at` timestamp,
    `is_active` boolean DEFAULT true
);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `book_genres` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_genres` ADD FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`);

ALTER TABLE `store_inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `store_inventory` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`selected_store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `ebook_rentals` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `ebook_rentals` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);