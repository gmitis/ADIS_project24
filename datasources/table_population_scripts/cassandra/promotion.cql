create table promotion
(
    p_promo_sk                int               ,
    p_promo_id                text              ,
    p_start_date_sk           int                       ,
    p_end_date_sk             int                       ,
    p_item_sk                 int                       ,
    p_cost                    decimal                 ,
    p_response_target         int                       ,
    p_promo_name              text                      ,
    p_channel_dmail           text                       ,
    p_channel_email           text                       ,
    p_channel_catalog         text                       ,
    p_channel_tv              text                       ,
    p_channel_radio           text                       ,
    p_channel_press           text                       ,
    p_channel_event           text                       ,
    p_channel_demo            text                       ,
    p_channel_details         text                  ,
    p_purpose                 text                      ,
    p_discount_active         text                       ,
    primary key (p_promo_sk)
);
COPY promotion(p_promo_sk,p_promo_id,p_start_date_sk,p_end_date_sk,p_item_sk,p_cost,p_response_target,p_promo_name,p_channel_dmail,p_channel_email,p_channel_catalog,p_channel_tv,p_channel_radio,p_channel_press,p_channel_event,p_channel_demo,p_channel_details,p_purpose,p_discount_active)
FROM '/data/promotion.csv'
WITH NULL='';

