--Question1: Who are the vendors that deliver orders to customers the fastest? 
--Bring the Top 5. Examine and comment on the number of orders of these sellers and the reviews and ratings of their products.
WITH hizli_saticilar as (
WITH temp as (
SELECT olist_sellers.seller_id,
		olist_orders.order_id,
		order_delivered_customer_date - order_purchase_timestamp as teslim_suresi
FROM olist_sellers
LEFT JOIN olist_order_items ON olist_sellers.seller_id=olist_order_items.seller_id
LEFT JOIN olist_orders ON olist_order_items.order_id=olist_orders.order_id)
SELECT seller_id,
		AVG (teslim_suresi) as ort_teslim_suresi
FROM temp
GROUP BY 1
ORDER BY 2
LIMIT 5)

SELECT	hizli_saticilar.seller_id,
		olist_order_items.order_id,
		review_score,
		review_comment_message
FROM hizli_saticilar
LEFT JOIN olist_order_items ON olist_order_items.seller_id=hizli_saticilar.seller_id
LEFT JOIN olist_order_reviews ON olist_order_items.order_id=olist_order_reviews.order_id



--Question 2: Which sellers sell products from more categories? 
--Do sellers with more categories also have more orders? 
WITH satici_kategori as (
SELECT os.seller_id,
		COUNT (DISTINCT product_category_name) as kategori_sayisi
FROM olist_sellers os
LEFT JOIN olist_order_items oi ON os.seller_id=oi.seller_id
LEFT JOIN olist_products op ON oi.product_id=op.product_id
GROUP BY 1
ORDER BY 2 DESC),
satici_siparis as (
SELECT os.seller_id,
		COUNT (DISTINCT oi.order_id) as siparis_sayisi
FROM olist_sellers os
LEFT JOIN olist_order_items oi ON os.seller_id=oi.seller_id
LEFT JOIN olist_orders oo ON oi.order_id=oo.order_id
GROUP BY 1
ORDER BY 2 DESC)
SELECT satici_kategori.*,
		satici_siparis.siparis_sayisi
FROM satici_kategori
LEFT JOIN satici_siparis USING (seller_id)
WHERE kategori_sayisi >=1
ORDER BY 2








