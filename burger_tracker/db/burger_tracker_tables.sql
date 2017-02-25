DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS burgers;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS addresses;

-- the following table is named to work with the access routines which assume
-- a mapping of ruby object Class 'Name' to SQL table 'names'
-- unfortunately normal English breaks this for the case of address...  alternative would be to change name to Location 

CREATE TABLE addresss (
  id SERIAL4 PRIMARY KEY,
  street_addr VARCHAR(255),
  street VARCHAR(255),
  area VARCHAR(255),
  city VARCHAR(255),
  post_code VARCHAR(255),
  telephone VARCHAR(255)
);

CREATE TABLE restaurants (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  address_id INT4 REFERENCES addresss(id)
  );

CREATE TABLE burgers (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  price DECIMAL(8,2),
  restaurant_id INT4 REFERENCES restaurants(id),
  preference INT4
);