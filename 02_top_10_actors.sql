--Output the 10 actors whose movies rented the most, sorted in descending order.
WITH actor_ranks AS (
    SELECT
        actor.first_name,
        actor.last_name,
        COUNT(rental.rental_id) AS rental_count,
        DENSE_RANK() OVER (ORDER BY COUNT(rental.rental_id) DESC) as actor_rank
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    JOIN inventory ON film_actor.film_id = inventory.film_id
    JOIN rental ON inventory.inventory_id = rental.inventory_id
    GROUP BY actor.actor_id, actor.first_name, actor.last_name
)
SELECT first_name, last_name, rental_count
FROM actor_ranks
WHERE actor_rank <= 10;