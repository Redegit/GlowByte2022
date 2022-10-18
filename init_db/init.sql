DROP TABLE IF EXISTS dwh_voronezh.fact_rides;
DROP TABLE IF EXISTS dwh_voronezh.fact_waybills;
DROP TABLE IF EXISTS dwh_voronezh.dim_clients;
DROP TABLE IF EXISTS dwh_voronezh.dim_drivers;
DROP TABLE IF EXISTS dwh_voronezh.dim_cars;
DROP TABLE IF EXISTS dwh_voronezh.fact_payments;

CREATE TABLE dwh_voronezh.fact_payments
(
 transaction_id  integer NOT NULL UNIQUE,
 card_num        varchar(16) NOT NULL,
 transaction_amt numeric(7,2) NOT NULL,
 transaction_dt  timestamp(0) NOT NULL,
 PRIMARY KEY ( transaction_id )
);

CREATE TABLE dwh_voronezh.dim_cars
(
 plate_num    char(9) NOT NULL UNIQUE,
 start_dt     date NOT NULL,
 model_name   varchar(30) NOT NULL,
 revision_dt  date NOT NULL,
 deleted_flag char(1) NOT NULL,
 end_dt       date,
 PRIMARY KEY ( plate_num, start_dt )
);

CREATE TABLE dwh_voronezh.dim_drivers
(
 personnel_num      integer NOT NULL UNIQUE,
 start_dt           date NOT NULL,
 last_name          varchar(50) NOT NULL,
 first_name         varchar(50) NOT NULL,
 middle_name        varchar(50) NOT NULL,
 birth_dt           date NOT NULL,
 card_num           char(19) NOT NULL,
 driver_license_num char(12) NOT NULL,
 driver_license_dt  date NOT NULL,
 deleted_flag       char(1) NOT NULL,
 end_dt             date,
 PRIMARY KEY ( personnel_num, start_dt )
);

CREATE TABLE dwh_voronezh.dim_clients
(
 phone_num    varchar(25) NOT NULL UNIQUE,
 start_dt     date NOT NULL,
 card_num     varchar(16) NOT NULL,
 deleted_flag char(1) NOT NULL,
 end_dt       date,
 PRIMARY KEY ( phone_num, start_dt )
);

CREATE TABLE dwh_voronezh.fact_rides
(
 ride_id             integer NOT NULL UNIQUE,
 point_from_txt      varchar(200) NOT NULL,
 point_to_txt        varchar(200) NOT NULL,
 distance_val        numeric(5,2) NOT NULL,
 price_amt           numeric(7,2) NOT NULL,
 client_phone_num    varchar(25) REFERENCES dwh_voronezh.dim_clients(phone_num),
 driver_pers_num     integer REFERENCES dwh_voronezh.dim_drivers(personnel_num),
 car_plate_num       char(9) REFERENCES dwh_voronezh.dim_cars(plate_num),
 ride_start_dt       timestamp(0),
 ride_arrival_dt     timestamp(0) NOT NULL,
 ride_end_dt         timestamp(0) NOT NULL,
 PRIMARY KEY ( ride_id )
);

/* CREATE INDEX FK_2 ON dwh_voronezh.fact_rides
(
 car_plate
);

CREATE INDEX FK_3 ON dwh_voronezh.fact_rides
(
 driver_pers_num
);

CREATE INDEX FK_4 ON dwh_voronezh.fact_rides
(
 client_phone_num
);
*/

CREATE TABLE dwh_voronezh.fact_waybills
(
 waybill_num     varchar(6) NOT NULL,
 driver_pers_num integer REFERENCES dwh_voronezh.dim_drivers(personnel_num),
 car_plate_num   char(9) REFERENCES dwh_voronezh.dim_cars(plate_num),
 work_start_dt   timestamp(0) NOT NULL,
 work_end_dt     timestamp(0) NOT NULL,
 issue_dt        timestamp(0) NOT NULL,
 PRIMARY KEY ( waybill_num )
);

/*
CREATE INDEX FK_2 ON dwh_voronezh.fact_waybills
(
 driver_pers_num
);

CREATE INDEX FK_3 ON dwh_voronezh.fact_waybills
(
 car_plate_num
);
*/
