-- 1 - amount of movies in each category, descending 
SELECT 
	c.name,
	COUNT(f.category_id) AS film_count
FROM category c
JOIN film_category f
	ON f.category_id = c.category_id
GROUP BY c.category_id, c.name, f.category_id
ORDER BY film_count DESC

-- 2 - 10 actors with most rented films, descending 
SELECT
	a.actor_id,
 	a.first_name AS actor_first_name,
	a.last_name AS actor_last_name,
    SUM(p.amount) AS total
FROM payment p
JOIN rental r 
	ON p.rental_id = r.rental_id
JOIN inventory i 
	ON r.inventory_id = i.inventory_id
JOIN film f 
	ON i.film_id = f.film_id
JOIN film_actor fa
	ON f.film_id = fa.film_id
JOIN actor a
	ON fa.actor_id = a.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total DESC
LIMIT 10

-- 3 - film category people spent the most money on
SELECT 
 	c.name AS category,
    SUM(p.amount) AS total_sales
FROM payment p
JOIN rental r 
	ON p.rental_id = r.rental_id
JOIN inventory i 
	ON r.inventory_id = i.inventory_id
JOIN film f 
	ON i.film_id = f.film_id
JOIN film_category fc 
	ON f.film_id = fc.film_id
JOIN category c 
	ON fc.category_id = c.category_id
GROUP BY c.name
LIMIT 1

-- 4 - films that are not in INVENTORY(without IN operator)
SELECT f.film_id, f.title 
FROM film f 
WHERE 
	(SELECT COUNT(*) 
	 FROM inventory i 
	 WHERE f.film_id=i.film_id) = 0

-- 5 - top 3 actors who appeared most frequently in CHILDREN category
--   - (case when the amount of movies is the same, show all)
SELECT 
	a.first_name || ' ' || a.last_name AS actor_name,
	COUNT(f.film_id) AS amount
FROM film f
JOIN film_category fc
	ON f.film_id = fc.film_id
JOIN category c
	ON fc.category_id = c.category_id
	AND c.name='Children'
JOIN film_actor fa
	ON f.film_id = fa.film_id
JOIN actor a
	ON fa.actor_id = a.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY amount DESC 
FETCH FIRST 3 ROWS with TIES

-- 6 - amount of active/inactive customers in each city, sort -> descending inactive
SELECT 
	c.city AS city,
	SUM(CASE WHEN ct.active=1 THEN 1 ELSE 0 END) AS active,
	SUM(CASE WHEN ct.active=0 THEN 1 ELSE 0 END) AS inactive
FROM city c
JOIN address a
	ON c.city_id = a.city_id
JOIN customer ct 
	ON a.address_id = ct.address_id
GROUP BY city
ORDER BY inactive DESC

