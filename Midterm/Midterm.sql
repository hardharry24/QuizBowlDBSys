DECLARE @storeId int = 1


alter procedure sp_getStoreOrderInfoById @storeId int
as
SELECT       CONCAT('StoreId-',stores.store_id,'-', stores.store_name) 'Store Info', CONCAT(staffs.last_name,', ' ,staffs.first_name) 'Staff Attendee', CONCAT(customers.last_name,', ', customers.first_name) 'Customer Name', 
(CASE order_status 
	WHEN 1 THEN CONCAT('OR#',orders.order_id,'-PENDING')
	WHEN 2 THEN CONCAT('OR#',orders.order_id,'-PAID')
	WHEN 3 THEN CONCAT('OR#',orders.order_id,'-FOR DELIVERY')
	WHEN 4 THEN CONCAT('OR#',orders.order_id,'-DELIVERED')
END) 'Order Status',
 orders.order_date 'Order Date'
FROM            stores INNER JOIN
                         staffs ON stores.store_id = staffs.store_id 
						 JOIN
                         orders ON staffs.staff_id = orders.staff_id 
						 JOIN
                         customers ON orders.customer_id = customers.customer_id
						 WHERE stores.store_id = @storeId
						 ORDER BY orders.order_date DESC

--Write a script that will return the list of order by storeId, Staff fullname(Attendee), Customer Fullname


--EXECUTE PROCEDURE
sp_getStoreOrderInfoById 1