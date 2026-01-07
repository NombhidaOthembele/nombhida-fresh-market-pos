-- Users
INSERT INTO users (full_name, role) VALUES
('Othembele Nombhida', 'admin'),
('Sipho Mkhize', 'cashier'),
('Lerato Molefe', 'cashier');

-- Products
INSERT INTO products (product_name, price, stock_quantity) VALUES
('Bread', 15.00, 120),
('Milk 2L', 28.00, 90),
('Rice 5kg', 90.00, 30),
('Eggs 18 Pack', 55.00, 50),
('Cold Drink 2L', 22.00, 100);

-- Customers
INSERT INTO customers (customer_name, phone) VALUES
('Nomsa Khumalo', '0711111111'),
('Mandla Zulu', '0722222222'),
('Precious Dube', '0733333333');

-- Sales
INSERT INTO sales (customer_id, user_id) VALUES
(1,2),(2,3),(3,2);

-- Sale Items
INSERT INTO sale_items (sale_id, product_id, quantity, price_at_sale) VALUES
(1,1,2,15),(1,2,1,28),
(2,3,1,90),(2,5,2,22),
(3,4,1,55),(3,1,1,15);
