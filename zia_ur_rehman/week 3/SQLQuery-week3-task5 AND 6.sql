-- TASK 5 --

-- SUBQUERIES --

-- SINGLE ROW SUBQUERY
SELECT * FROM Products;
SELECT ProductName, (SELECT AVG(UnitPrice) FROM products) AS avg_price
FROM products;


-- MULTI ROW SUBQUERY
SELECT ProductName, UnitPrice
FROM products
WHERE UnitPrice IN (SELECT UnitPrice FROM products WHERE CategoryID = '2')

UPDATE Products
SET UnitPrice = UnitPrice * 1.2
WHERE CategoryID = (SELECT CategoryID FROM Categories WHERE CategoryName = 'Beverages');

-- NESTED SUBQUERY


SELECT ProductName, UnitPrice
FROM Products
WHERE ProductID IN (
    SELECT ProductID
    FROM [Order Details]
    WHERE OrderID IN (
        SELECT OrderID
        FROM Orders
        WHERE CustomerID IN (
            SELECT CustomerID
            FROM Customers
            WHERE Country = 'spain'
        )
    )
);

-- CO RELATED SUBQUERY

SELECT c.CustomerID, c.CompanyName, (
    SELECT COUNT(*)
    FROM Orders o
    WHERE o.CustomerID = c.CustomerID
) AS TotalOrders
FROM Customers c;

-- VIEWS
CREATE VIEW BEVERAGE_PRODUCTS
AS
SELECT ProductName FROM Products WHERE CategoryID = '1';

SELECT * FROM BEVERAGE_PRODUCTS;

ALTER VIEW BEVERAGE_PRODUCTS
AS
SELECT ProductName, UnitPrice 
FROM Products 
WHERE CategoryID = 1;

SELECT * FROM BEVERAGE_PRODUCTS;

DROP VIEW BEVERAGE_PRODUCTS;

-- COMPLEX VIEWS

CREATE VIEW [Order Details with Product and Customer] AS
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice, OD.Quantity, 
       P.ProductName, P.CategoryID, P.SupplierID, 
       C.CustomerID, C.CompanyName, C.ContactName, C.Country
FROM [Order Details] OD
INNER JOIN Products P ON OD.ProductID = P.ProductID
INNER JOIN Orders O ON OD.OrderID = O.OrderID
INNER JOIN Customers C ON O.CustomerID = C.CustomerID;
-- NEED FURTHER PRACTICE**

-- INDEXES

-- understand indexes a little bit but hard time creating indexes. WILL DIVE DEEP INTO THIS AND GET BACK TO IT.


--- TASK 6

-- Write a query to retrieve the names of all products that have been ordered more than 50 time.

SELECT Products.ProductName
FROM Products 
INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName
HAVING COUNT(*) > 50

-- Write a query to retrieve the names of all products that have been ordered at least once.

SELECT Products.ProductName
FROM Products 
INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName
HAVING COUNT(*) > 0

-- Create a view that shows the total revenue generated by each category.

CREATE VIEW RevenueBYcategory AS
SELECT Categories.CategoryName, SUM([Order Details].UnitPrice * [Order Details].Quantity) AS TotalRevenue
FROM Categories 
INNER JOIN Products p ON Categories.CategoryID = p.CategoryID
INNER JOIN [Order Details] ON p.ProductID = [Order Details].ProductID
GROUP BY Categories.CategoryName;

SELECT * FROM RevenueBYcategory;

