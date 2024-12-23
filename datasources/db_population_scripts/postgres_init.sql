-- DROP DATABASE adis;
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'adis') THEN
        CREATE DATABASE adis;
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'root') THEN
        CREATE USER root WITH PASSWORD 'root';
    END IF;
END $$;

DO $$
BEGIN
    IF EXISTS (SELECT FROM pg_database WHERE datname = 'adis')
       AND EXISTS (SELECT FROM pg_roles WHERE rolname = 'root') THEN
        GRANT ALL PRIVILEGES ON DATABASE adis TO root;
    END IF;
END $$;


CREATE TABLE web_site (
    web_site_sk               INTEGER               NOT NULL,
    web_site_id               CHAR(16)              NOT NULL,
    web_rec_start_date        DATE                          ,
    web_rec_end_date          DATE                          ,
    web_name                  VARCHAR(50)                   ,
    web_open_date_sk          INTEGER                       ,
    web_close_date_sk         INTEGER                       ,
    web_class                 VARCHAR(50)                   ,
    web_manager               VARCHAR(40)                   ,
    web_mkt_id                INTEGER                       ,
    web_mkt_class             VARCHAR(255)                   ,
    web_mkt_desc              VARCHAR(255)                  ,
    web_market_manager        VARCHAR(40)                   ,
    web_company_id            INTEGER                       ,
    web_company_name          CHAR(50)                      ,
    web_street_number         CHAR(10)                      ,
    web_street_name           VARCHAR(60)                   ,
    web_street_type           CHAR(15)                      ,
    web_suite_number          CHAR(10)                      ,
    web_city                  VARCHAR(60)                   ,
    web_county                VARCHAR(30)                   ,
    web_state                 CHAR(2)                       ,
    web_zip                   CHAR(10)                      ,
    web_country               VARCHAR(20)                   ,
    web_gmt_offset            decimal(5,2)                  ,
    web_tax_percentage        decimal(5,2)                  ,
    primary key (web_site_sk)
);

-- Create the table `web_page`
CREATE TABLE web_page (
    wp_web_page_sk            INTEGER               NOT NULL,
    wp_web_page_id            CHAR(16)             NOT NULL,
    wp_rec_start_date         DATE                          ,
    wp_rec_end_date           DATE                          ,
    wp_creation_date_sk       INTEGER                      ,
    wp_access_date_sk         INTEGER                      ,
    wp_autogen_flag           CHAR(1)                      ,
    wp_customer_sk            INTEGER                      ,
    wp_url                    VARCHAR(100)                 ,
    wp_type                   CHAR(50)                     ,
    wp_char_count             INTEGER                      ,
    wp_link_count             INTEGER                      ,
    wp_image_count            INTEGER                      ,
    wp_max_ad_count           INTEGER                      ,
    PRIMARY KEY (wp_web_page_sk)
);

-- Create the table `web_returns`
CREATE TABLE web_returns (
    wr_returned_date_sk       INTEGER                      ,
    wr_returned_time_sk       INTEGER                      ,
    wr_item_sk                INTEGER               NOT NULL,
    wr_refunded_customer_sk   INTEGER                      ,
    wr_refunded_cdemo_sk      INTEGER                      ,
    wr_refunded_hdemo_sk      INTEGER                      ,
    wr_refunded_addr_sk       INTEGER                      ,
    wr_returning_customer_sk  INTEGER                      ,
    wr_returning_cdemo_sk     INTEGER                      ,
    wr_returning_hdemo_sk     INTEGER                      ,
    wr_returning_addr_sk      INTEGER                      ,
    wr_web_page_sk            INTEGER                      ,
    wr_reason_sk              INTEGER                      ,
    wr_order_number           INTEGER               NOT NULL,
    wr_return_quantity        INTEGER                      ,
    wr_return_amt             DECIMAL(7,2)                 ,
    wr_return_tax             DECIMAL(7,2)                 ,
    wr_return_amt_inc_tax     DECIMAL(7,2)                 ,
    wr_fee                    DECIMAL(7,2)                 ,
    wr_return_ship_cost       DECIMAL(7,2)                 ,
    wr_refunded_cash          DECIMAL(7,2)                 ,
    wr_reversed_charge        DECIMAL(7,2)                 ,
    wr_account_credit         DECIMAL(7,2)                 ,
    wr_net_loss               DECIMAL(7,2)                 ,
    PRIMARY KEY (wr_item_sk, wr_order_number)
);

-- Create the table `web_sales`
CREATE TABLE web_sales (
    ws_sold_date_sk           INTEGER                      ,
    ws_sold_time_sk           INTEGER                      ,
    ws_ship_date_sk           INTEGER                      ,
    ws_item_sk                INTEGER               NOT NULL,
    ws_bill_customer_sk       INTEGER                      ,
    ws_bill_cdemo_sk          INTEGER                      ,
    ws_bill_hdemo_sk          INTEGER                      ,
    ws_bill_addr_sk           INTEGER                      ,
    ws_ship_customer_sk       INTEGER                      ,
    ws_ship_cdemo_sk          INTEGER                      ,
    ws_ship_hdemo_sk          INTEGER                      ,
    ws_ship_addr_sk           INTEGER                      ,
    ws_web_page_sk            INTEGER                      ,
    ws_web_site_sk            INTEGER                      ,
    ws_ship_mode_sk           INTEGER                      ,
    ws_warehouse_sk           INTEGER                      ,
    ws_promo_sk               INTEGER                      ,
    ws_order_number           INTEGER               NOT NULL,
    ws_quantity               INTEGER                      ,
    ws_wholesale_cost         DECIMAL(7,2)                 ,
    ws_list_price             DECIMAL(7,2)                 ,
    ws_sales_price            DECIMAL(7,2)                 ,
    ws_ext_discount_amt       DECIMAL(7,2)                 ,
    ws_ext_sales_price        DECIMAL(7,2)                 ,
    ws_ext_wholesale_cost     DECIMAL(7,2)                 ,
    ws_ext_list_price         DECIMAL(7,2)                 ,
    ws_ext_tax                DECIMAL(7,2)                 ,
    ws_coupon_amt             DECIMAL(7,2)                 ,
    ws_ext_ship_cost          DECIMAL(7,2)                 ,
    ws_net_paid               DECIMAL(7,2)                 ,
    ws_net_paid_inc_tax       DECIMAL(7,2)                 ,
    ws_net_paid_inc_ship      DECIMAL(7,2)                 ,
    ws_net_paid_inc_ship_tax  DECIMAL(7,2)                 ,
    ws_net_profit             DECIMAL(7,2)                 ,
    PRIMARY KEY (ws_item_sk, ws_order_number)
);

-- Load data into tables using .dat files
COPY web_page FROM '/data/web_page.csv' WITH (FORMAT csv, DELIMITER ',');
-- COPY web_site FROM '/data/web_site.csv' WITH (FORMAT csv, DELIMITER ',');
-- COPY web_returns FROM '/data/web_returns.csv' WITH (FORMAT csv, DELIMITER ',');
-- COPY web_sales FROM '/data/web_sales.csv' WITH (FORMAT csv, DELIMITER ',');
