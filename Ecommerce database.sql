-- 🏷️ Brand Table
CREATE TABLE brand (
    brand_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 🗂️ Product Category Table
CREATE TABLE product_category (
    product_categoryid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- 📦 Product Table
CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    base_price DECIMAL(10, 2) NOT NULL,
    brand_id INTEGER REFERENCES brand(brand_id),
    product_categoryid INTEGER REFERENCES product_category(product_categoryid)
);

-- 🖼️ Product Image Table
CREATE TABLE product_image (
    product_imageid SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(product_id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    alt_text VARCHAR(255)
);

-- 🎨 Color Table
CREATE TABLE color (
    colorid SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hex_code VARCHAR(7)
);

-- 📏 Size Category Table
CREATE TABLE size_category (
    categoryid SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- 📐 Size Option Table
CREATE TABLE size_option (
    size_optionid SERIAL PRIMARY KEY,
    categoryid INTEGER REFERENCES size_category(categoryid),
    label VARCHAR(10) NOT NULL
);

-- 🧾 Product Item Table (a specific purchasable item)
CREATE TABLE product_item (
    product_itemid SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(product_id),
    sku VARCHAR(100) UNIQUE NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX idx_sku ON product_item(sku);


-- 🔄 Product Variation Table (links product_item with color and size)
CREATE TABLE product_variation (
    product_variationid SERIAL PRIMARY KEY,
    product_item_id INTEGER REFERENCES product_item(product_itemid) ON DELETE CASCADE,
    color_id INTEGER REFERENCES color(colorid),
    sizeoption_id INTEGER REFERENCES size_option(size_optionid)
);

-- 📚 Attribute Category Table
CREATE TABLE attribute_category (
    attr_categoryid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- 🧪 Attribute Type Table
CREATE TABLE attribute_type (
    attr_typeid SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    data_type VARCHAR(20) NOT NULL 
);

-- 🧵 Product Attribute Table
CREATE TABLE product_attribute (
    product_attributeid SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES product(product_id) ON DELETE CASCADE,
    attr_categoryid INTEGER REFERENCES attribute_category(attr_categoryid),
    attr_typeid INTEGER REFERENCES attribute_type(attr_typeid),
    name VARCHAR(100) NOT NULL,
    value TEXT NOT NULL
);

-- 📥 Sample Data for the database.

-- Brand
INSERT INTO brand (name, description) VALUES
('Nike', 'Leading sportswear brand'),
('Apple', 'Innovative electronics manufacturer'),
('Samsung', 'Global electronics company');

-- Product Category
INSERT INTO product_category (name, description) VALUES
('Clothing', 'Apparel for men and women'),
('Electronics', 'Gadgets and electronic devices'),
('Footwear', 'Shoes and sandals');

-- Product
INSERT INTO product (name, description, base_price, brand_id, product_categoryid) VALUES
('iPhone 14', 'Latest iPhone model', 999.99, 2, 2),
('Nike Air Max', 'Comfortable running shoes', 149.99, 1, 3),
('Galaxy Watch', 'Smartwatch by Samsung', 199.99, 3, 2);

-- Product Image
INSERT INTO product_image (product_id, image_url, alt_text) VALUES
(1, 'https://image.com/images/iphone14.jpg', 'iPhone 14 Front View'),
(2, 'https://image.com/images/nike_airmax.jpg', 'Nike Air Max Shoe'),
(3, 'https://image.com/images/galaxy_watch.jpg', 'Samsung Galaxy Watch');

-- Color
INSERT INTO color (name, hex_code) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Blue', '#0000FF');

-- Size Category
INSERT INTO size_category (name) VALUES
('Clothing Sizes'),
('Shoe Sizes');

-- Size Option
INSERT INTO size_option (size_category_id, label) VALUES
(1, 'S'),
(1, 'M'),
(1, 'L'),
(2, '40'),
(2, '42');

-- Product Item
INSERT INTO product_item (product_id, sku, price, stock_quantity) VALUES
(1, 'IP14-128GB', 999.99, 10),
(2, 'NAIRMAX-BLK42', 149.99, 25),
(3, 'GWATCH-BLUE', 199.99, 15);

-- Product Variation
INSERT INTO product_variation (product_item_id, color_id, sizeoption_id) VALUES
(2, 1, 5),  -- Nike Air Max, Black, Size 42
(3, 3, NULL);  -- Galaxy Watch, Blue, No size

-- Attribute Category
INSERT INTO attribute_category (name) VALUES
('Physical Attributes'),
('Technical Specifications');

-- Attribute Type
INSERT INTO attribute_type (name, data_type) VALUES
('Material', 'text'),
('Battery Life', 'text'),
('Waterproof', 'boolean');

-- Product Attribute
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES
(2, 1, 1, 'Material', 'Mesh and Rubber'),
(1, 2, 2, 'Battery Life', '24 hours'),
(3, 2, 3, 'Waterproof', 'true');


--Commands to output content from a table.
SELECT * FROM product_attribute
