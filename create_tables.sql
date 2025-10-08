CREATE DATABASE IF NOT EXISTS A01;
USE A01;

DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS dogs;
DROP TABLE IF EXISTS dog_names;
DROP TABLE IF EXISTS dog_rooms;
DROP TABLE IF EXISTS check_in;

CREATE TABLE owners (
  id INT,
  owner_name VARCHAR(50),
  age INT,
  email VARCHAR(100),
  phone VARCHAR(20)
);

CREATE TABLE dogs (
	id INT PRIMARY KEY,
    owner_id INT,
    breed VARCHAR (50),
    year_of_birth INT,
    color VARCHAR (50)
);

CREATE TABLE dog_names (
	id INT,
    name VARCHAR (50)
);

CREATE TABLE dog_rooms (
	room_id INT,
    dog_id INT,
    num_per_room INT
);

CREATE TABLE check_in (
	room_id INT,
    dog_id INT,
    owner_id INT,
    paid BOOLEAN,
    check_in_day DATETIME,
    check_out_day DATETIME
);