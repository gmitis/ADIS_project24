create keyspace adis with replication={'class':'SimpleStrategy', 'replication_factor': 1};
use adis;

-- Create the table `call_center` in Cassandra
CREATE TABLE IF NOT EXISTS call_center (
    cc_call_center_sk         INT,
    cc_call_center_id         TEXT,
    cc_rec_start_date         DATE,
    cc_rec_end_date           DATE,
    cc_closed_date_sk         INT,
    cc_open_date_sk           INT,
    cc_name                   TEXT,
    cc_class                  TEXT,
    cc_employees              INT,
    cc_sq_ft                  INT,
    cc_hours                  TEXT,
    cc_manager                TEXT,
    cc_mkt_id                 INT,
    cc_mkt_class              TEXT,
    cc_mkt_desc               TEXT,
    cc_market_manager         TEXT,
    cc_division               INT,
    cc_division_name          TEXT,
    cc_company                INT,
    cc_company_name           TEXT,
    cc_street_number          TEXT,
    cc_street_name            TEXT,
    cc_street_type            TEXT,
    cc_suite_number           TEXT,
    cc_city                   TEXT,
    cc_county                 TEXT,
    cc_state                  TEXT,
    cc_zip                    TEXT,
    cc_country                TEXT,
    cc_gmt_offset             DECIMAL,
    cc_tax_percentage         DECIMAL,
    PRIMARY KEY(cc_call_center_sk)
);

COPY call_center(cc_call_center_sk, cc_call_center_id, cc_rec_start_date, cc_rec_end_date, cc_closed_date_sk, cc_open_date_sk, cc_name, cc_class, cc_employees, cc_sq_ft, cc_hours, cc_manager, cc_mkt_id, cc_mkt_class, cc_mkt_desc, cc_market_manager, cc_division, cc_company_name, cc_street_number, cc_street_name, cc_street_type, cc_suite_number, cc_city, cc_county, cc_state, cc_zip, cc_country, cc_gmt_offset, cc_tax_percentage) 
FROM '/data/call_center.csv'
WITH HEADER=TRUE AND NULL='';
