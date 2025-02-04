create table customer_address
(
    ca_address_sk             int               ,
    ca_address_id             text              ,
    ca_street_number          text                      ,
    ca_street_name            text                   ,
    ca_street_type            text                      ,
    ca_suite_number           text                      ,
    ca_city                   text                   ,
    ca_county                 text                   ,
    ca_state                  text                       ,
    ca_zip                    text                      ,
    ca_country                text                   ,
    ca_gmt_offset             decimal                  ,
    ca_location_type          text                      ,
    primary key (ca_address_sk)
);
COPY customer_address(ca_address_sk,ca_address_id,ca_street_number,ca_street_name,ca_street_type,ca_suite_number,ca_city,ca_county,ca_state,ca_zip,ca_country,ca_gmt_offset,ca_location_type)
FROM '/data/customer_address.csv'
WITH NULL='';

