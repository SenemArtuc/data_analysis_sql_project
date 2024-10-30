CREATE TABLE olist_customers
(
	customer_id varchar (32) primary key,
	customer_unique_id varchar (32),
	customer_zip_code_prefix int,
	customer_city varchar (40),
	customer_state varchar (2)
);

COPY olist_customers FROM 'C:\olist_customers_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_products
(
	product_id varchar(32) primary key,
	product_category_name varchar (50),
	product_name_lenght smallint,
	product_description_lenght smallint,
	product_photos_qty smallint,
	product_weight_g int,
	product_length_cm smallint,
	product_height_cm smallint,
	product_width_cm smallint
);

COPY olist_products FROM 'C:\olist_products_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_sellers
(
	seller_id varchar (32) primary key,
	seller_zip_code_prefix int,
	seller_city varchar (50),
	seller_state varchar (5)
);

COPY olist_sellers FROM 'C:\olist_sellers_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_order_payments
(
	order_id varchar (32),
	payment_sequential smallint,
	payment_type varchar (20),
	payment_installments smallint,
	payment_value float
);

COPY olist_order_payments FROM 'C:\olist_order_payments_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE product_category_name_translation
(
	product_category_name varchar (50),
	product_category_name_english varchar (50)
);

COPY product_category_name_translation FROM 'C:\product_category_name_translation.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_order_items
(
	order_id varchar (32),
	order_item_id varchar (3),
	product_id varchar (32),
	seller_id varchar (32),
	shipping_limit_date timestamp,
	price float,
	freight_value float
);

COPY olist_order_items FROM 'C:\olist_order_items_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_orders
(
	order_id varchar (32) primary key,
	customer_id varchar (32),
	order_status varchar (15),
	order_purchase_timestamp timestamp,
	order_approved_at timestamp,
	order_delivered_carrier_date timestamp,
	order_delivered_customer_date timestamp,
	order_estimated_delivery_date timestamp
);

COPY olist_orders FROM 'C:\olist_orders_dataset.csv' DELIMITER ';' CSV HEADER;


CREATE TABLE olist_order_reviews
(
	review_id varchar (32),
	order_id varchar (32),
	review_score smallint,
	review_comment_title varchar,
	review_comment_message varchar,
	review_creation_date timestamp,
	review_answer_timestamp timestamp
);

COPY olist_order_reviews FROM 'C:\olist_order_reviews_dataset2.txt' DELIMITER ',' CSV HEADER;


CREATE TABLE olist_geolocation
(
	geolocation_zip_code_prefix	int,
	geolocation_lat	varchar,
	geolocation_lng	varchar,
	geolocation_city varchar,	
	geolocation_state varchar
);

COPY olist_geolocation FROM 'C:\olist_geolocation_dataset.csv' DELIMITER ';' CSV HEADER;




