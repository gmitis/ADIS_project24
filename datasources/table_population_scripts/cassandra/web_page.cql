create table web_page
(
    wp_web_page_sk            int               ,
    wp_web_page_id            text              ,
    wp_rec_start_date         timestamp                          ,
    wp_rec_end_date           timestamp                          ,
    wp_creation_date_sk       int                       ,
    wp_access_date_sk         int                       ,
    wp_autogen_flag           text                       ,
    wp_customer_sk            int                       ,
    wp_url                    text                  ,
    wp_type                   text                      ,
    wp_char_count             int                       ,
    wp_link_count             int                       ,
    wp_image_count            int                       ,
    wp_max_ad_count           int                       ,
    primary key (wp_web_page_sk)
);
COPY web_page(wp_web_page_sk,wp_web_page_id,wp_rec_start_date,wp_rec_end_date,wp_creation_date_sk,wp_access_date_sk,wp_autogen_flag,wp_customer_sk,wp_url,wp_type,wp_char_count,wp_link_count,wp_image_count,wp_max_ad_count)
FROM '/data/web_page.csv'
WITH HEADER=TRUE AND NULL='';

