--Output the category of movies on which the most money was spent.
SELECT category.name, SUM(payment.amount) AS total_spent
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name
ORDER BY total_spent DESC
LIMIT 1;