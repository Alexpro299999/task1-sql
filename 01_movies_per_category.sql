--Output the number of movies in each category, sorted descending.
SELECT category.name, COUNT(film_category.film_id) AS film_count
FROM category 
LEFT JOIN film_category ON category.category_id = film_category.category_id 
JOIN film ON film_category.film_id = film.film_id
GROUP BY category.name
ORDER BY COUNT(film_category.film_id) DESC
