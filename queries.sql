USE A01;

WITH dogs_w_names AS (
	SELECT 
		d.id,
		d.breed,
		d.color,
		dn.name,
		d.owner_id,
		dr.room_id,
		dr.num_per_room,
        o.owner_name,
		o.phone
	FROM dog_names dn
	LEFT JOIN dogs d 
	ON d.id = dn.id
	INNER JOIN (
		SELECT *
		FROM dog_rooms
		WHERE num_per_room <> 1
	) dr
	ON d.id = dr.dog_id
    LEFT JOIN owners o
	ON d.owner_id = o.id
)
SELECT 
    GROUP_CONCAT(dwn.id, ',') as d_id,
    GROUP_CONCAT(dwn.breed, ',') as d_breed,
    GROUP_CONCAT(dwn.color, ',') as d_color,
    GROUP_CONCAT(dwn.name, ',') as d_name,
    MIN(dwn.owner_name) AS ow_name,
    MIN(dwn.phone) AS ow_phone,
    MIN(dwn.room_id) AS r_id,
	MIN(dwn.num_per_room) AS n_per_room,
    COUNT(u.dog_id) AS total_dogs_unpaid,
    MIN(u.check_out_day) as mn_check_out,
	MIN(num_per_room) - COUNT(id) AS free_space
FROM dogs_w_names dwn
INNER JOIN (
    SELECT dog_id, check_out_day, owner_id
	FROM check_in
	WHERE paid <=> 0
) u
ON dwn.owner_id = u.owner_id
GROUP BY dwn.owner_id
HAVING free_space > 0
ORDER BY total_dogs_unpaid DESC
LIMIT 5;
