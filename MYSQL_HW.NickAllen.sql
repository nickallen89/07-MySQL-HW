USE sakila;

SELECT first_name, last_name FROM actor;

SELECT CONCAT(first_name, ' ', last_name) AS Actor_Name FROM actor;

SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'joe';

Select first_name, last_name From actor WHERE last_name LIKE '%GEN%';

SELECT last_name, first_name FROM actor WHERE last_name LIKE '%LI';

SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor ADD middle_name VARCHAR(255) AFTER first_name;

ALTER TABLE actor MODIFY middle_name BLOB; 

ALTER TABLE actor DROP COLUMN middle_name;

SELECT last_name, COUNT(last_name) AS name_count FROM actor 
GROUP BY last_name; 

SELECT last_name, COUNT(last_name) AS name_count FROM actor 
GROUP BY last_name
HAVING name_count >= 2

update  actor set first_name = 'HARPO" where last_name=''WILLIAMS' AND first_name='GROUCHO' ;

UPDATE actor SET first_name = 'GROUCHO' WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

 CREATE TABLE address2
	(  address_id smallint UNSIGNED NOT NULL AUTO_INCREMENT, address VARCHAR(50),
		address2 VARCHAR(50), district VARCHAR(20), city_id smallint UNSIGNED, 
        postal_code VARCHAR(10), phone VARCHAR(20), location GEOMETRY, last_update TIMESTAMP );
        
SELECT staff.first_name, staff. last_name, address.adress
FROM staff JOIN address ON staff.address_id = address.adress_id;

SELECT staff.first_name, staff.last_name, SUM(payment.amount) AS total_sales
FROM staff JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment.payment_date LIKE '2005-08%'
GROUP BY username;

SELECT title, COUNT(actor_id) AS actors_in_film
FROM film_actor INNER JOIN film ON film_actor.film_id = film.film_id
GROUP BY title;

SELECT title, COUNT(inventory.film_id) AS copies
FROM inventory INNER JOIN film ON inventory.film_id = film.film_id 
WHERE title = 'Hunchback Impossible' 
GROUP BY title;

SELECT first_name, last_name, SUM(amount) AS total_paid
FROM payment JOIN custome ON customer.customer_id = payment.customer_id
GROUP BY last_name;

SELECT title FROM film
WHERE title LIKE 'K%' OR title LIKE 'Q%' 
AND language_id=(SELECT language_id FROM language WHERE name='English');
        
        SELECT first_name, last_name 
        FROM actor
        WHERE actor_id IN
				(SELECT actor_id
			FROM film_actor
            WHERE film_id IN
								(SELECT film_id
					FROM film
					WHERE title = 'ALONE TRIP'));
                    
select first_name, last_name, email
FROM customer 
JOIN adress ON customer.adress_id=adress.adress_id
JOIN city ON address.city_id=city.city_id
JOIN country ON city.country_id=country.country.id
WHERE country = 'Canada';

SELECT title, name
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';

SELECT title, COUNT(rental_id) as 'Times Rented'
FROM film f
JOIN inventory i on i.film_id = f.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
GROUP BY title
ORDER BY COUNT(rental_id) DESC;

SELECT store.store_id, SUM(amount) AS 'Total sales' FROM store
JOIN staff on store.store_id = payment.staff_id
JOIN payment ON staff.staff_id = payment.staff_id
GROUP BY store_id;

SELECT store_id, address, city, country
FROM store s
JOIN adress a ON s.adress_id = a.adress_id
JOIN city c ON c.city_id = a.city_id
JOIN country ON county.country_id = c.country_id;

SELECT name, SUM(amount) as 'Gross' FROM category c
JOIN film_category fc ON fc.category_id = c.categpory_id
JOIN inventory ON inventory.film_id=film_category.film_id
JOIN rental r ON r.inventory_id = i.inventory_id
JOIN payment ON payment.rental_id=rental.rental_id
GROUP BY name
ORDER BY SUM(amount) DESC LIMIT 5;

CREATE VIEW TOP_5 AS
				SELECT name, SUM(amount) as 'Gross' FROM category c
                JOIN film_catefory fc ON fc.category_id = fc.film_id 
                JOIN inventory i ON i.film_id = i.inventory_id
				JOIN rental r ON r.inventory_id = i.inventory_id
				JOIN payment ON payment.rental_id=rental.rental_id
                GROUP BY name
                ORDER BY SUM (amount) DESC LIMIT 5;
                
                SELECT * FROM  TOP_5;
                
                DROP VIEW TOP_5;
                