/*

solutions to 
dataV3_Lesson_2.7_lab, JOIN 1
*/

use sakila;

-- 1. How many films are there for each of the categories in the category table. 
   -- Use appropriate join to write this query.

SELECT c.name AS cat_name, count(*) AS num_categories
FROM sakila.category as c
JOIN sakila.film as f 
ON c.category_id = f.film_id
group by f.title
ORDER BY num_categories DESC;

-- 2. Display the total amount rung up by each staff member in August of 2005.
-- rental ids and the staff ids that rung up sales are important here from payment table ..
SELECT staff_id, round(SUM(amount),2) AS total_amount
FROM sakila.payment
WHERE payment_date LIKE '%2005-08%'
GROUP BY staff_id;

/* 
3. Which actor has appeared in the most films?
*/

select * from sakila.film;
select * from sakila.actor;

SELECT CONCAT(a.first_name, ' ', a.last_name) AS 'Most acted' 
FROM sakila.actor a 
join sakila.film_actor fa
on a.actor_id = fa.actor_id
having COUNT(fa.film_id)
order by fa.film_id;

/*
4. Most active customer (the customer that has rented the most number of films)
*/

SELECT CONCAT(c.first_name, ' ', c.last_name) AS 'customer name', COUNT(DISTINCT rental.rental_id) as "total_rentals"
from sakila.customer c
join sakila.rental rental
on c.customer_id = rental.rental_id
order by "customer name";

/*
5. Display the first and last names, as well as the address, of each staff member.
*/
-- select first_name,last_name,address_id from sakila.staff;
-- select manager_staff_id,address_id from sakila.store;

SELECT staff.first_name as 'staff_first_name',staff.last_name as 'staff_last_name', staff.staff_id as "staff_member", store.store_id,store.address_id
from sakila.staff staff
join sakila.store store
on staff.store_id = store.store_id
group by "staff_member"
order by staff_id;

/*
6. List each film and the number of actors who are listed for that film.
*/
select * from sakila.film;
select * from sakila.film_actor;
--  i assume we need to join 3 tables, actor, film actor and film
-- i tried multiple Joins. I need further information about solving this please..

select f.title, fa.actor_id
from sakila.film f 
inner join sakila.film fa 
on f.film_id = fa.film_id 
inner join sakila.actor actor
on fa.actor_id = actor.actor_id
group by actor.actor_id;


-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
SELECT * FROM payment;
SELECT p.customer_id, c.last_name, round(SUM(p.amount),2) AS total_paid
FROM sakila.payment AS p
INNER JOIN customer as c
ON p.customer_id = c.customer_id
GROUP BY customer_id
ORDER BY c.last_name ASC;

-- 8. List number of films per category.