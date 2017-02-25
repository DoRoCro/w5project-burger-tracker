DROP TABLE IF EXISTS deals;
DROP TABLE IF EXISTS burgers;
DROP TABLE IF EXISTS restaurants;
DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses (
  id SERIAL4 PRIMARY KEY,
  street_addr VARCHAR(255),
  street VARCHAR(255),
  area VARCHAR(255),
  city VARCHAR(255),
  post_code VARCHAR(255),
  telephone VARCHAR(255)
);