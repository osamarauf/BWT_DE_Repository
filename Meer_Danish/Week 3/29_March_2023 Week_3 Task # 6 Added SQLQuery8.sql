/*29_March_2023 Task # 6 Added*/
/*MEER DANISH*/


/* Write a query to retrieve the names of all products that have been ordered more than 50 time.*/

Select  ProductName, Order_Count from 
Products join (
Select ProductID, Count(*) As Order_Count
From [Order Details]
Group By ProductID
Having count(*) > 50) As OrderCount
ON Products.ProductID = OrderCount.ProductID


/* Write a query to retrieve the names of all products that have been ordered at least once. */

Select  ProductName, Order_Count from 
Products join (
Select ProductID, Count(*) As Order_Count
From [Order Details]
Group By ProductID
Having count(*) >= 1) As OrderCount
ON Products.ProductID = OrderCount.ProductID

/* Create a view that shows the total revenue generated by each category. */

select ProductID , count (*)from [Order Details] group by ProductID
select * from Orders
select * from Products
select * from [Order Subtotals]
select * from [Orders Qry]

Create VIEW total_revenue_each_category As
select  Categories.CategoryName , sum([Order Details].UnitPrice*Quantity) As Revenue from
Products Join Categories
ON Products.CategoryID = Categories.CategoryID
join [Order Details]
ON [Order Details].ProductID = Products.ProductID
group by Categories.CategoryName

/* Now call The View and check */
select * from total_revenue_each_category