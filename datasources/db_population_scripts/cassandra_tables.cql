create keyspace adis with replication={'class':'SimpleStrategy', 'replication_factor': 1};
use adis;

-- Create the table `web_page` in Cassandra
CREATE TABLE web_page (
    wp_web_page_sk            INT, 
    wp_web_page_id            TEXT,                     
    wp_rec_start_date         TIMESTAMP,                       
    wp_rec_end_date           TIMESTAMP,
    wp_creation_date_sk       INT,
    wp_access_date_sk         INT,
    wp_autogen_flag           TEXT,                      
    wp_customer_sk            INT,
    wp_url                    TEXT,                      
    wp_type                   TEXT,
    wp_char_count             INT,
    wp_link_count             INT,
    wp_image_count            INT,
    wp_max_ad_count           INT,
    PRIMARY KEY(wp_web_page_sk)
);

COPY web_page(wp_web_page_sk, wp_web_page_id, wp_rec_start_date, wp_rec_end_date, wp_creation_date_sk, wp_access_date_sk, wp_autogen_flag, wp_customer_sk, wp_url, wp_type, wp_char_count, wp_link_count, wp_image_count, wp_max_ad_count) 
FROM '/data/web_page.csv'
WITH HEADER=TRUE AND NULL='';
