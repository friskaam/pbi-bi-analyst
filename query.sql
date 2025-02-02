-- add primary key --
-- table Customers
ALTER TABLE `pbi_biAnalyst_bankMuamalat.Customers` ADD PRIMARY KEY (CustomerID) NOT ENFORCED;

-- table Products
ALTER TABLE `pbi_biAnalyst_bankMuamalat.Products` ADD PRIMARY KEY (ProdNumber) NOT ENFORCED;

-- table Orders
ALTER TABLE `pbi_biAnalyst_bankMuamalat.Orders` ADD PRIMARY KEY (OrdersID) NOT ENFORCED;

-- table ProductCategory
ALTER TABLE `pbi_biAnalyst_bankMuamalat.ProductCategory` ADD PRIMARY KEY (CategoryID) NOT ENFORCED;

-- add foreign key --
-- table Orders
ALTER TABLE `pbi_biAnalyst_bankMuamalat.Orders`
ADD CONSTRAINT CustomerID FOREIGN KEY (CustomerID)
REFERENCES `pbi_biAnalyst_bankMuamalat.Customers`(CustomerID) NOT ENFORCED;

ALTER TABLE `pbi_biAnalyst_bankMuamalat.Orders`
ADD CONSTRAINT ProdNumber FOREIGN KEY (ProdNumber)
REFERENCES `pbi_biAnalyst_bankMuamalat.Products`(ProdNumber) NOT ENFORCED;

-- table Product
ALTER TABLE `pbi_biAnalyst_bankMuamalat.Orders`
ADD CONSTRAINT Category FOREIGN KEY (Category)
REFERENCES `pbi_biAnalyst_bankMuamalat.ProductCategory`(CategoryID) NOT ENFORCED;

-- make table master (Transactions) --
CREATE OR REPLACE TABLE `pbi_biAnalyst_bankMuamalat.Transaction` AS
SELECT 
    o.Date AS order_date,
    pc.CategoryName AS category_name,
    p.ProdName AS product_name,
    p.Price AS product_price,
    o.Quantity AS order_qty,
    (o.Quantity * p.Price) AS total_sales,
    c.CustomerEmail AS cust_email,
    c.CustomerCity AS cust_city
FROM `pbi_biAnalyst_bankMuamalat.Orders` o
JOIN `pbi_biAnalyst_bankMuamalat.Customers` c
    ON o.CustomerID = c.CustomerID
JOIN `pbi_biAnalyst_bankMuamalat.Products` p
    ON o.ProdNumber = p.ProdNumber
JOIN `pbi_biAnalyst_bankMuamalat.ProductCategory` pc
    ON p.Category = pc.CategoryID
ORDER BY o.Date ASC, o.Quantity ASC;