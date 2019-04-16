DROP TABLE IF EXISTS real_estate_properties;

CREATE TABLE real_estate_properties(
  id SERIAL8 PRIMARY KEY,
  value INT4,
  number_of_bedrooms INT2,
  buy_let_status VARCHAR(255),
  build VARCHAR(255)
);

SELECT * FROM real_estate_properties;
