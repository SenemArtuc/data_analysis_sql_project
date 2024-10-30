--Question 1 : In which cities do customers shop more? 
--Identify the customer's city as the city where they place the most orders and analyze accordingly. 
--For example, Sibel orders from 3 different cities: 3 orders from Çanakkale, 8 orders from Muğla and 10 orders from Istanbul. 
--You should select Sibel's city as Istanbul, the city where Sibel orders the most, and Sibel's orders should appear as 21 orders from Istanbul.
WITH temp as (
SELECT*FROM olist_orders
LEFT JOIN olist_customers USING (customer_id)),

temp2 as (
SELECT customer_unique_id,
		customer_city,
		COUNT (order_id) OVER (PARTITION BY customer_unique_id ORDER BY customer_city) as sip_sayisi
FROM temp
ORDER BY 1),

temp3 as (
SELECT	*,
		ROW_NUMBER() OVER (PARTITION BY customer_unique_id ORDER BY sip_sayisi DESC)
FROM temp2),

temp4 as (
SELECT*, 
		SUM (sip_sayisi) OVER (PARTITION BY customer_unique_id) as sip_say
FROM temp3
WHERE row_number=1)

SELECT customer_city,
		SUM (sip_say) as top_sip
FROM temp4
GROUP BY 1
ORDER BY 2 DESC




