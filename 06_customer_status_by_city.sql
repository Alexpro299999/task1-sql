-- Output cities with the number of active and inactive customers (active - customer.active = 1). 
-- Sort by the number of inactive customers in descending order.
SELECT
    city.city,
    COUNT(customer.customer_id) FILTER (WHERE customer.active = 1) AS active_count,
    COUNT(customer.customer_id) FILTER (WHERE customer.active = 0) AS inactive_count
FROM city
JOIN address ON city.city_id = address.city_id
JOIN customer ON address.address_id = customer.address_id
GROUP BY city.city
ORDER BY inactive_count DESC