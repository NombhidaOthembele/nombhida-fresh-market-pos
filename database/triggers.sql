DELIMITER $$

-- Reduce stock after a sale
CREATE TRIGGER trg_reduce_stock
AFTER INSERT ON sale_items
FOR EACH ROW
BEGIN
    UPDATE products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.product_id;

    INSERT INTO stock_logs (product_id, change_quantity, reason)
    VALUES (NEW.product_id, -NEW.quantity, 'Sale');
END$$

-- Restock when item is returned
CREATE TRIGGER trg_return_stock
AFTER INSERT ON returns
FOR EACH ROW
BEGIN
    DECLARE prod_id INT;

    SELECT product_id INTO prod_id
    FROM sale_items
    WHERE sale_item_id = NEW.sale_item_id;

    UPDATE products
    SET stock_quantity = stock_quantity + NEW.return_quantity
    WHERE product_id = prod_id;

    INSERT INTO stock_logs (product_id, change_quantity, reason)
    VALUES (prod_id, NEW.return_quantity, 'Return');
END$$

-- Prevent selling more than stock
CREATE TRIGGER trg_check_stock
BEFORE INSERT ON sale_items
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;
    SELECT stock_quantity INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough stock available';
    END IF;
END$$

DELIMITER ;
