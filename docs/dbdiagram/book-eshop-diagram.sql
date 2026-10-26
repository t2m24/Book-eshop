CREATE TABLE `countries` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `country_name` varchar(100) NOT NULL
);

CREATE TABLE `cities` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `country_id` integer,
  `city_name` varchar(100) NOT NULL
);

CREATE TABLE `addresses` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `city_id` integer,
  `user_id` integer,
  `street` varchar(255) NOT NULL,
  `zip_code` varchar(20) NOT NULL
);

CREATE TABLE `users` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `email` varchar(255) UNIQUE NOT NULL,
  `phone_number` varchar(20),
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `role` varchar(50) NOT NULL,
  `is_active` boolean DEFAULT true,
  `created_at` timestamp
);

CREATE TABLE `user_subscriptions` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `starts_at` datetime NOT NULL,
  `ends_at` datetime NOT NULL,
  `is_active` boolean DEFAULT true,
  `auto_renew` boolean DEFAULT false
);

CREATE TABLE `basket_statuses` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `status_code` varchar(50) UNIQUE NOT NULL,
  `description` varchar(255)
);

CREATE TABLE `baskets` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `status_id` integer,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `basket_items` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `basket_id` integer,
  `book_id` integer,
  `is_ebook` boolean DEFAULT false,
  `quantity` integer NOT NULL DEFAULT 1
);

CREATE TABLE `publishers` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `website` varchar(500)
);

CREATE TABLE `books` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `publisher_id` integer,
  `title` varchar(255) NOT NULL,
  `cover_image_url` varchar(500),
  `description` text,
  `isbn` varchar(13) UNIQUE NOT NULL,
  `publication_year` integer,
  `price` decimal(10.2) NOT NULL,
  `is_ebook_available` boolean DEFAULT false,
  `is_physical_available` boolean DEFAULT true,
  `created_at` timestamp
);

CREATE TABLE `book_discounts` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `book_id` integer,
  `discount_percentage` decimal(5.2) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL
);

CREATE TABLE `authors` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) NOT NULL
);

CREATE TABLE `genres` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(100) NOT NULL
);

CREATE TABLE `book_authors` (
  `book_id` integer,
  `author_id` integer,
  `author_order` integer NOT NULL DEFAULT 1
);

CREATE TABLE `book_genres` (
  `book_id` integer,
  `genre_id` integer
);

CREATE TABLE `stores` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `address_id` integer,
  `name` varchar(255) NOT NULL,
  `phone_number` varchar(20)
);

CREATE TABLE `store_inventory` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `store_id` integer,
  `book_id` integer,
  `stock_amount` integer DEFAULT 0
);

CREATE TABLE `orders` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `selected_store_id` integer,
  `shipping_address_id` integer,
  `order_type` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `total_price` decimal(10.2) NOT NULL,
  `created_at` timestamp
);

CREATE TABLE `order_items` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `order_id` integer,
  `book_id` integer,
  `is_ebook` boolean DEFAULT false,
  `quantity` integer NOT NULL,
  `price_per_unit` decimal(10.2) NOT NULL
);

CREATE TABLE `payments` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `order_id` integer UNIQUE,
  `subscription_id` integer,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(50) NOT NULL,
  `transaction_id` varchar(255),
  `amount` decimal(10.2) NOT NULL,
  `paid_at` timestamp
);

CREATE TABLE `book_reviews` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `book_id` integer,
  `rating` integer NOT NULL,
  `comment` text,
  `created_at` timestamp
);

CREATE TABLE `ebook_rentals` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `user_id` integer,
  `book_id` integer,
  `rented_at` timestamp,
  `expires_at` datetime,
  `is_active` boolean DEFAULT true
);

CREATE TABLE `book_buybacks` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `target_store_id` integer,
  `book_id` integer,
  `user_id` integer,
  `book_condition` varchar(50) NOT NULL,
  `offered_price` decimal(10.2),
  `status` varchar(50) NOT NULL,
  `created_at` timestamp
);

ALTER TABLE `cities` ADD FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`city_id`) REFERENCES `cities` (`id`);

ALTER TABLE `addresses` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `user_subscriptions` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `baskets` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `baskets` ADD FOREIGN KEY (`status_id`) REFERENCES `basket_statuses` (`id`);

ALTER TABLE `basket_items` ADD FOREIGN KEY (`basket_id`) REFERENCES `baskets` (`id`);

ALTER TABLE `basket_items` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `books` ADD FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`);

ALTER TABLE `book_discounts` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_authors` ADD FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`);

ALTER TABLE `book_genres` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_genres` ADD FOREIGN KEY (`genre_id`) REFERENCES `genres` (`id`);

ALTER TABLE `stores` ADD FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`);

ALTER TABLE `store_inventory` ADD FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `store_inventory` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`selected_store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `orders` ADD FOREIGN KEY (`shipping_address_id`) REFERENCES `addresses` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `order_items` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`subscription_id`) REFERENCES `user_subscriptions` (`id`);

ALTER TABLE `book_reviews` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `book_reviews` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `ebook_rentals` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

ALTER TABLE `ebook_rentals` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_buybacks` ADD FOREIGN KEY (`target_store_id`) REFERENCES `stores` (`id`);

ALTER TABLE `book_buybacks` ADD FOREIGN KEY (`book_id`) REFERENCES `books` (`id`);

ALTER TABLE `book_buybacks` ADD FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
