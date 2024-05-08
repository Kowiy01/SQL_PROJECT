SELECT *
FROM FASHION_PRODUCTS;

--Know the distinct category in the dataset
SELECT DISTINCT CATEGORY
FROM FASHION_PRODUCTS;

---Know the unique brands
SELECT DISTINCT BRAND
FROM FASHION_PRODUCTS;

---Know the unique product name
SELECT DISTINCT PRODUCT_NAME
FROM FASHION_PRODUCTS;

--Unique Brand
SELECT COUNT(DISTINCT BRAND) AS BRAND
FROM FASHION_PRODUCTS;

---Know the rank of brands with the highest transaction
WITH TOP_PRO AS (
				SELECT BRAND, COUNT(*) AS T_P
				FROM FASHION_PRODUCTS
				GROUP BY BRAND
				) 
SELECT BRAND, T_P
FROM TOP_PRO
ORDER BY T_P DESC;


--Check for the varieties of color and size
SELECT SIZE, COUNT(COLOR) AS S
FROM FASHION_PRODUCTS
GROUP BY SIZE
ORDER BY S DESC; 

SELECT *
FROM fashion_products;

--Get the average price for each category
WITH CAT_AVG_PRICE AS (
    SELECT CATEGORY, AVG(PRICE) AS AVG_Price
    FROM FASHION_PRODUCTS
    GROUP BY Category
)
SELECT CATEGORY, AVG_Price
FROM CAT_AVG_PRICE;

--Get the product_name, Brand with the avg_rating
SELECT DISTINCT PRODUCT_NAME, AVG(RATING) AS AVGRATING
FROM FASHION_PRODUCTS
WHERE RATING > (
				SELECT AVG(RATING) AS AVG_RATING
				FROM FASHION_PRODUCTS
				)
GROUP BY PRODUCT_NAME;


--Join two tables to see side by side product,brand & category
SELECT PRODUCT_NAME,BRAND,CATEGORY
FROM fashion_products AS F
JOIN (
		SELECT USER_ID
		FROM  FASHION_PRODUCTS
		WHERE RATING = (
						SELECT MAX(RATING) AS RAT
						FROM FASHION_PRODUCTS
						)
	) AS SUBQUERY 
ON F.USER_ID = SUBQUERY.USER_ID

--Get the most size demanded for
SELECT SIZE,COUNT(*) AS D_S
FROM FASHION_PRODUCTS
GROUP BY SIZE
ORDER BY D_S DESC;

--Get the most color demanded for
SELECT COLOR, COUNT(*) AS C
FROM fashion_products
GROUP BY COLOR
ORDER BY C;

--The brands with the lowest price(s)
WITH MIN_PRICE AS 
				(
				 SELECT BRAND, MIN(PRICE) AS MIN_P
				 FROM FASHION_PRODUCTS
				 GROUP BY BRAND
				 )
SELECT BRAND, MIN_P
FROM MIN_PRICE;
