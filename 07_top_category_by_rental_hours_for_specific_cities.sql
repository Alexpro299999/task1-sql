-- Output the category of movies that have the highest number of total rental hours in the city 
-- (customer.address_id in this city) and that start with the letter “a”. 
-- Do the same for cities that have a “-” in them. Write everything in one query.
(
  SELECT
      'Cities starting with "a"' AS city_group,
      category.name,
      SUM(EXTRACT(EPOCH FROM (rental.return_date - rental.rental_date))) / 3600 AS total_rental_hours
  FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film_category ON inventory.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  JOIN customer ON rental.customer_id = customer.customer_id
  JOIN address ON customer.address_id = address.address_id
  JOIN city ON address.city_id = city.city_id
  WHERE city.city ILIKE 'a%'
  GROUP BY category.name
  ORDER BY total_rental_hours DESC
  LIMIT 1
)
UNION ALL
(
  SELECT
      'Cities with a "-"' AS city_group,
      category.name,
      SUM(EXTRACT(EPOCH FROM (rental.return_date - rental.rental_date))) / 3600 AS total_rental_hours
  FROM rental
  JOIN inventory ON rental.inventory_id = inventory.inventory_id
  JOIN film_category ON inventory.film_id = film_category.film_id
  JOIN category ON film_category.category_id = category.category_id
  JOIN customer ON rental.customer_id = customer.customer_id
  JOIN address ON customer.address_id = address.address_id
  JOIN city ON address.city_id = city.city_id
  WHERE city.city LIKE '%-%'
  GROUP BY category.name
  ORDER BY total_rental_hours DESC
  LIMIT 1
);