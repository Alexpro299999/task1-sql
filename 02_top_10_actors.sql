--Output the 10 actors whose movies rented the most, sorted in descending order.
SELECT ac.first_name, ac.last_name, COUNT(ren.rental_id) AS reantal_count
FROM actor AS ac
LEFT JOIN film_actor AS fa ON ac.actor_id = fa.actor_id
JOIN inventory AS inv ON fa.film_id = inv.film_id
JOIN rental AS ren ON inv.inventory_id = ren.inventory_id
GROUP BY ac.first_name, ac.last_name
ORDER BY COUNT(ren.rental_id) DESC
LIMIT 10