-- Week 5 - Wednesday Questions

-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name, address.district
FROM customer
JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas'
ORDER BY customer.last_name;
-- There are 5 customers who live in Texas.

-- 2. Get all payments above $6.99 with the Customer's FullName
SELECT customer.first_name, customer.last_name, payment.amount
FROM customer
JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99
ORDER BY amount;
-- There were 1,423 payments made above $6.99.

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer_id IN (
    SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id
    HAVING SUM(amount) > 175
);
-- There are 7 customers who made payments over $175.

-- 4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, country.country
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';
-- 'Kevin Schuler' is the only customer that lives in Nepal.

-- 5. Which staff member had the most transactions?
SELECT staff.first_name, staff.last_name, COUNT(payment.rental_id) AS total_rentals
FROM staff
JOIN payment 
ON staff.staff_id = payment.staff_id
GROUP BY staff.first_name, staff.last_name
-- 'Jon Stephens' had the most transactions (7304).

-- 6. How many movies of each rating are there?
SELECT film.rating, COUNT(*) AS number_of_movies
FROM film
GROUP BY film.rating;
-- There are 178 'G', 194 'PG', 223 'PG-13', 210 'NC-17', and 195 'R' ratings.

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT customer.first_name, customer.last_name
FROM customer
WHERE customer_id IN (
    SELECT payment.customer_id
    FROM payment
    GROUP BY payment.customer_id, payment.amount
    HAVING payment.amount > 6.99
);
-- There are 539 customers who have made a single payment above $6.99.

-- 8. How many free rentals did our stores give away?
SELECT COUNT(DISTINCT rental.rental_id) AS total_free_rentals
FROM rental
JOIN payment 
ON rental.rental_id = payment.rental_id
WHERE payment.amount = 0;
-- There are 24 free rentals.