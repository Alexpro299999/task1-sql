-- Output the top 3 actors who have appeared the most in movies in the “Children” category. 
-- If several actors have the same number of movies, output all of them.
WITH actor_ranks AS (
    SELECT actor.first_name, actor.last_name, COUNT(film.film_id) AS film_count,
        DENSE_RANK() OVER (ORDER BY COUNT(film.film_id) DESC) as actor_rank
    FROM actor
    JOIN film_actor ON actor.actor_id = film_actor.actor_id
    JOIN film ON film_actor.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    WHERE category.name = 'Children'
    GROUP BY actor.actor_id, actor.first_name, actor.last_name
)
SELECT first_name, last_name, film_count
FROM actor_ranks
WHERE actor_rank <= 3;