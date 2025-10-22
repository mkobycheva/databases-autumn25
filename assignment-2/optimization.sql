USE A02;

ALTER TABLE taxi1 
ADD PRIMARY KEY (id);

ALTER TABLE taxi2
ADD PRIMARY KEY (id);

ALTER TABLE taxi3
ADD PRIMARY KEY (id);
  
-- generated query  
EXPLAIN
SELECT
    t1.id,
    t1.VendorID,
    t1.passenger_count,
    t1.trip_distance,
    t2.fare_amount,
    t2.tip_amount,
    t3.tolls_amount,
    t3.airport_fee
FROM taxi1 t1
JOIN taxi2 t2 ON t1.id = t2.id
JOIN taxi3 t3 ON t1.id = t3.id
WHERE t1.passenger_count > 2
  AND t2.fare_amount > 
        (SELECT AVG(t2b.fare_amount)
         FROM taxi2 t2b
         WHERE t2b.id = t2.id)
  AND t2.tip_amount >
        (SELECT AVG(t2b.tip_amount)
         FROM taxi2 t2b
         WHERE t2b.id = t2.id)
  AND t1.trip_distance >
        (SELECT AVG(t1b.trip_distance)
         FROM taxi1 t1b
         WHERE t1b.VendorID = t1.VendorID);

-- adding indexes
CREATE INDEX idx_taxi1_passenger_count ON taxi1 (passenger_count);
CREATE INDEX idx_taxi1_trip_distance ON taxi1 (trip_distance);
CREATE INDEX idx_taxi2_fare_amount ON taxi2 (fare_amount);
CREATE INDEX idx_taxi2_tip_amount ON taxi2 (tip_amount);

-- optimized query
EXPLAIN ANALYZE        
WITH avg_fare AS (
	SELECT id, AVG(fare_amount) AS avg_f
    FROM taxi2
    GROUP BY id
), avg_tip AS (
	SELECT id, AVG(tip_amount) AS avg_t
	FROM taxi2 
	GROUP BY id
), avg_dist AS (
	SELECT VendorID, AVG(trip_distance) AS avg_d
	FROM taxi1
    GROUP BY VendorID
)
SELECT
    t1.id,
    t1.VendorID,
    t1.passenger_count,
    t1.trip_distance,
    t2.fare_amount,
    t2.tip_amount,
    t3.tolls_amount,
    t3.airport_fee
FROM taxi1 t1
JOIN taxi2 t2 ON t1.id = t2.id
JOIN taxi3 t3 ON t1.id = t3.id
JOIN avg_fare f ON t2.id = f.id
JOIN avg_tip t ON t2.id = t.id
JOIN avg_dist d ON t1.VendorID = d.VendorID
WHERE t1.passenger_count > 2
  AND t2.fare_amount > avg_f
  AND t2.tip_amount > avg_t
  AND t1.trip_distance > avg_d;
