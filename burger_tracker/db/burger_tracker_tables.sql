DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS burgers;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS addresses;

-- the following table is named to work with the access routines which assume
-- a mapping of ruby object Class 'name' to SQL table 'names'
-- unfortunately normal english breaks this for the case of address

CREATE TABLE addresss (
  id SERIAL4 PRIMARY KEY,
  street_addr VARCHAR(255),
  street VARCHAR(255),
  area VARCHAR(255),
  city VARCHAR(255),
  post_code VARCHAR(255),
  telephone VARCHAR(255)
);