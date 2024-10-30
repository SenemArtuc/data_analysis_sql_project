--Question1: In which region do users who pay in more installments live the most? Comment on this output.
WITH musteri_taksit as (
SELECT DISTINCT customer_unique_id,
		payment_installments,
		customer_city,
		customer_state
FROM olist_order_payments op
LEFT JOIN olist_orders oo ON op.order_id=oo.order_id
LEFT JOIN olist_customers oc ON oo.customer_id=oc.customer_id
ORDER BY 2 DESC
LIMIT 100)
SELECT customer_city,
		COUNT (customer_unique_id)
FROM musteri_taksit
GROUP BY 1
ORDER BY 2 DESC


--Question 2: Calculate the number of successful orders and total amount of successful payments by payment type. 
--Order from most to least used payment type.
WITH yeni as (
SELECT *
FROM olist_orders 
LEFT JOIN olist_order_payments  USING (order_id)
)
SELECT payment_type,
		COUNT (order_id) basarili_odeme_sayisi,
		ROUND(SUM (payment_value)::int,2) odeme_tutari
FROM yeni
WHERE order_status <> 'unavailable' AND order_status <>'canceled'
GROUP BY 1
ORDER BY 2 desc


--Question3: Make category-based analysis of orders paid in single check and installments. 
--Which categories use installment payments the most?
WITH temp as (
SELECT oo.order_id,
		(oo.order_id::varchar || oo.payment_sequential::varchar) as payment_id,
		oo.payment_installments,
		op.product_category_name
FROM olist_order_payments oo
LEFT JOIN olist_order_items oi ON oo.order_id=oi.order_id
LEFT JOIN olist_products op ON oi.product_id=op.product_id
WHERE payment_type='credit_card'),

taksit_sayisina_gore as (
SELECT	payment_installments,
		product_category_name,
		COUNT(payment_id) as odeme_sayisi
FROM temp
GROUP BY 1,2
ORDER BY 1,2),

taksit_durumuna_gore as (
SELECT CASE WHEN payment_installments=0 OR payment_installments=1 THEN 'taksitsiz'
			ELSE 'taksitli' END taksit_durumu,
			product_category_name,
			odeme_sayisi
FROM taksit_sayisina_gore)

SELECT taksit_durumu,
		product_category_name,
		SUM (odeme_sayisi)
FROM taksit_durumuna_gore
WHERE taksit_durumu='taksitli'
GROUP BY 1,2
ORDER BY 3 DESC





