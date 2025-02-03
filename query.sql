CREATE OR REPLACE TABLE `pbi_biAnalyst_bankMuamalat.master_table_Transactions` AS
SELECT 
    o.Date AS order_date,
    pc.CategoryName AS category_name,
    p.ProdName AS product_name,
    p.Price AS product_price,
    o.Quantity AS order_qty,
    (o.Quantity * p.Price) AS total_sales,
    REGEXP_REPLACE(c.CustomerEmail, r'#.*$', '') AS cust_email,
    c.CustomerCity AS cust_city
FROM `pbi_biAnalyst_bankMuamalat.Orders` o
JOIN `pbi_biAnalyst_bankMuamalat.Customers` c
    ON o.CustomerID = c.CustomerID
JOIN `pbi_biAnalyst_bankMuamalat.Products` p
    ON o.ProdNumber = p.ProdNumber
JOIN `pbi_biAnalyst_bankMuamalat.ProductCategory` pc
    ON p.Category = pc.CategoryID
ORDER BY o.Date ASC, o.Quantity ASC;