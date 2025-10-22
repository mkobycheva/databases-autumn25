library(duckdb)
library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)

con <- dbConnect(duckdb(), shutdown = TRUE)

taxi <- tbl(con, "read_parquet('nyc-taxi-2024/**/*.parquet', hive_partitioning = true)") |> 
  filter(month == 1) |> 
  slice_sample(n = 1000000) |> 
  collect() |> 
  mutate(id = row_number()) |>
  relocate(id)
  

taxi1 <- taxi |> 
  select(VendorID, tpep_pickup_datetime, tpep_dropoff_datetime, passenger_count, trip_distance) |> 
  write.csv(file = "taxi1.csv")
  
taxi2 <- taxi |> 
  select(PULocationID, DOLocationID, fare_amount, tip_amount) |> 
  write.csv(file = "taxi2.csv")

taxi3 <- taxi |> 
  select(payment_type, Airport_fee, tolls_amount) |> 
  write.csv(file = "taxi3.csv")
