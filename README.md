# Assignments for course "CS310 Databases"

## Assignment 1

I simulated a database for a dog hotel. There are 5 tables:

1) **Dogs** - with their ids, ids of the owners, breeds etc.
2) **Dog names** - with dogs' names
3) **Owners** - with owners' contact information
4) **Rooms** - with dogs that are located in the certain room and the number of dogs that can live in the room in general
5) **Check in** - with information of dogs' arrival, payment etc.

I was looking for information about owners of the dogs whose stay was not payed. There were also other criterias: I was looking for rooms for 2+ dogs that had free space when the "unpaid" dogs were living there. I ordered the final list in the descending order and took first 5 entries.

### Logic within the query:
- *dogs_w_names CTE*: here I combined dogs with their names, owners and rooms
- *join with subselect*: then I inner-joined "dogs with names" with information about their stay in the hotel: check-out day and payment verification
- *grouping*: next I grouped the table by owners, concatenating dogs' names, breeds, colors etc. and preserving owners' contacts
- *getting TOP-5*: finally, I sorted table by number of "unpaid" dogs per owner in descending order and took first 5 entries

## Assignment 2

I took **NYC Taxi Data** that we worked with on "R for Data Science" course, slice-sampled 1 000 000 rows and splitted it into 3 tables with different columns, adding id.

My tables are:

1) *taxi1:*

```
  id INT,
  VendorID INT,
  tpep_pickup_datetime DATETIME,
  tpep_dropoff_datetime DATETIME,
  passenger_count INT,
  trip_distance DOUBLE
```

3) *taxi2:*

```
  id INT,
  PULocationID INT,
  DOLocationID INT,
  fare_amount DOUBLE,
  tip_amount DOUBLE
```

4) *taxi3:*

```
  id INT,
  payment_type INT,
  airport_fee DOUBLE,
  tolls_amount DOUBLE
```

Chat GPT generated me a random query based on this data and I was optimizing it. 
What I did:

- Firstly, I added primary key indexes to each table
- Then I added secondary indexes based on filters for different tables:
  
**idx_taxi1_passenger_count** and **idx_taxi1_trip_distance** for *taxi1* (passenger_count and trip_distance)

**idx_taxi2_fare_amount** and **idx_taxi2_tip_amount** for *taxi2* (fare_amount, tip_amount)

- Lastly, I turned subselects into CTE's:

```
SELECT AVG(t2b.fare_amount)
FROM taxi2 t2b                    -->   avg_fare
WHERE t2b.id = t2.id
```

```
SELECT AVG(t2b.tip_amount)
FROM taxi2 t2b                    -->   avg_tip
WHERE t2b.id = t2.id
```

```
SELECT AVG(t1b.trip_distance)
FROM taxi1 t1b                    -->   avg_dist
WHERE t1b.VendorID = t1.VendorID
```
