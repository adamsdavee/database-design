-- CREATE DATABASE
CREATE DATABASE inventory_management;


-- USE DATABASE
USE inventory_management_system;

-- CREATION OF ENITITIES

-- USERS TABLE
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'user') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ITEMS TABLE
CREATE TABLE items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    size ENUM('small', 'medium', 'large') NOT NULL,
    category ENUM('electronics', 'groceries', 'office_supplies', 'others') NOT NULL,
    quantity INT NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ORDERS TABLE
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    approved_by INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (approved_by) REFERENCES users(id)
);

-- ORDER_ITEMS TABLE
CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (item_id) REFERENCES items(id)
);



-- INSERT INTO ENITITIES
INSERT INTO users (name, email, password, role)
VALUES
('Chukwudi David', 'dave@gmail.com', 'daveee', 'admin'),
('Alt school', 'alt@gmail.com', 'dave45', 'user');

INSERT INTO items (name, price, size, category, quantity, description)
VALUES
('Laptop', 1500.00, 'medium', 'electronics', 10, 'Office laptop'),
('Printer Paper', 20.00, 'small', 'office_supplies', 100, 'A4 printing paper');


INSERT INTO orders (user_id)
VALUES (2);

INSERT INTO order_items (order_id, item_id, quantity, unit_price)
VALUES
(1, 1, 1, 1500.00),
(1, 2, 2, 20.00);


-- GET RECORDS FROM TWO ENITITIES
SELECT 
    users.name,
    orders.id AS order_id,
    orders.status
FROM users
JOIN orders ON users.id = orders.user_id;

-- UPDATE RECORDS FROM TWO ENITITIES

UPDATE orders
JOIN users ON orders.user_id = users.id
SET 
    orders.status = 'approved',
    orders.approved_by = 1
WHERE users.email = 'dave@gmail.com';

-- DELETE RECORDS FROM TWO ENITITIES

DELETE order_items
FROM order_items
JOIN orders ON order_items.order_id = orders.id
WHERE orders.id = 1;


-- QUERY FROM MULTIPLE TABLES USING JOINS


SELECT 
    u.name AS customer_name,
    i.name AS item_name,
    oi.quantity,
    oi.unit_price,
    o.status
FROM orders o
JOIN users u ON o.user_id = u.id
JOIN order_items oi ON o.id = oi.order_id
JOIN items i ON oi.item_id = i.id;






