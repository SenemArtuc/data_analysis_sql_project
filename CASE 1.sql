--Question1: Examine the monthly order distribution. Order_approved_at should be used for date data.
WITH aylik_siparis as (
SELECT to_char(order_approved_at, 'YYYY-MM') as tarih,
		COUNT (DISTINCT order_id) as top_sip
FROM olist_orders
GROUP BY 1
ORDER BY 1)
SELECT CASE WHEN tarih IS NULL THEN 'unknow_date' ELSE tarih END,
		top_sip
FROM aylik_siparis

--Question2: Examine the number of orders in order status breakdown on a monthly basis. 
--Visualize the output of the query with excel. 
--Are there any months with a dramatic fall or rise? Analyze and interpret the data.
SELECT to_char(order_approved_at, 'YYYY-MM') as tarih,
		order_status,
		COUNT (DISTINCT order_id) as top_sip
FROM olist_orders
GROUP BY 1,2
ORDER BY 1,2

--Question3: Please see the number of orders by product category. 
--What are the categories that stand out on special occasions? For example, Christmas, Valentine's Day...
WITH kategori_siparis as 
(
SELECT to_char(order_approved_at, 'MM') as tarih,
		op.product_category_name,
		COUNT (DISTINCT o.order_id) as top_sip
FROM olist_orders o
LEFT JOIN olist_order_items oi ON o.order_id=oi.order_id
LEFT JOIN olist_products op ON oi.product_id=op.product_id
GROUP BY 1,2
ORDER BY 1,3 DESC
),
sip_siralama as (
	SELECT 	*,
		RANK () OVER (PARTITION BY tarih ORDER BY top_sip DESC) as rank 
	FROM kategori_siparis
)
SELECT * FROM sip_siralama
WHERE rank in (1,2,3)

--Question4: Examine the number of orders on the basis of days of the week (Monday, Thursday, ....) and days of the month (such as the 1st, 2nd of the month). 
--Create and interpret a visual in excel with the output of the query you wrote.
SELECT to_char(order_approved_at, 'dd') kacinci_gun,
		to_char(order_approved_at, 'day') gun,
		COUNT (DISTINCT order_id) as toplam
FROM olist_orders
GROUP BY 1,2
ORDER BY 1,2
