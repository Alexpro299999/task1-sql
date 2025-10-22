-- Output the category of movies that have the highest number of total rental hours in the city 
-- (customer.address_id in this city) and that start with the letter “a”. 
-- Do the same for cities that have a “-” in them. Write everything in one query.
WITH category_rental_hours AS (
    SELECT
        CASE
            WHEN city.city ILIKE 'a%' THEN 'Cities starting with "a"'
            WHEN city.city LIKE '%-%' THEN 'Cities with a "-"'
        END AS city_group,
        category.name AS category_name,
        SUM(EXTRACT(EPOCH FROM (rental.return_date - rental.rental_date))) / 3600 AS total_rental_hours
    FROM
        rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN film ON inventory.film_id = film.film_id
    JOIN film_category ON film.film_id = film_category.film_id
    JOIN category ON film_category.category_id = category.category_id
    JOIN customer ON rental.customer_id = customer.customer_id
    JOIN address ON customer.address_id = address.address_id
    JOIN city ON address.city_id = city.city_id
    WHERE
        city.city ILIKE 'a%' OR city.city LIKE '%-%'
    GROUP BY
        city_group, category.name
),

ranked_categories AS (
    SELECT
        city_group,
        category_name,
        total_rental_hours,
        RANK() OVER (PARTITION BY city_group ORDER BY total_rental_hours DESC) as rnk
    FROM
        category_rental_hours
)

SELECT
    city_group,
    category_name,
    total_rental_hours
FROM
    ranked_categories
WHERE
    rnk = 1;