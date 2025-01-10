select  distinct(hotel)
from `2018`;
select  distinct(is_canceled)
from `2018`;
select  distinct(meal)
from `2018`;
select  distinct(country)
from `2018`;
select  distinct(market_segment)
from `2018`;
select  distinct(is_repeated_guest)
from `2018`;
select  distinct(reserved_room_type)
from `2018`;
select  distinct(deposit_type)
from `2018`;
select  distinct(customer_type)
from `2018`;
select  distinct(arrival_date_year)
from `2018`;
select  distinct(arrival_date_month)
from `2018`;

select * 
from `2018`;

select *
from `2018`
where hotel is null ;
select *
from `2018`
where is_canceled is null ;
select *
from `2018`
where lead_time is null ;
select *
from `2018`
where arrival_date_year is null ;
select *
from `2018`
where arrival_date_month is null ;
select *
from `2018`
where arrival_date_week_number is null ;
select *
from `2018`
where arrival_date_day_of_month is null ;
select *
from `2018`
where stays_in_weekend_nights is null ;
select *
from `2018`
where stays_in_week_nights is null ;
select *
from `2018`
where meal is null ;
select *
from `2018`
where country is null ;
select *
from `2018`
where market_segment is null ;
select *
from `2018`
where is_repeated_guest is null ;
select *
from `2018`
where reserved_room_type is null ;
select *
from `2018`
where deposit_type is null ;
select *
from `2018`
where customer_type is null ;
select *
from `2018`
where adr is null ;

-- ********************************************************************************************

select  distinct(hotel)
from `2019`;
select  distinct(is_canceled)
from `2019`;
select  distinct(meal)
from `2019`;
select  distinct(country)
from `2019`;
select  distinct(market_segment)
from `2019`;
select  distinct(is_repeated_guest)
from `2019`;
select  distinct(reserved_room_type)
from `2019`;
select  distinct(deposit_type)
from `2019`;
select  distinct(customer_type)
from `2019`;
select  distinct(arrival_date_year)
from `2019`;
select  distinct(arrival_date_month)
from `2019`;

select * 
from `2019`
where hotel  = 'hotel';

-- the result of the previous query was 4 rows. two of them were duplicated and the others will not affect the analysis
delete 
from `2019`
where hotel  = 'hotel';

update  `2019`
set is_canceled = 1
where is_canceled = 'is_canceled';

select *
from `2019`
where hotel is null ;
select *
from `2019`
where is_canceled is null ;
select *
from `2019`
where lead_time is null ;
select *
from `2019`
where arrival_date_year is null ;
select *
from `2019`
where arrival_date_month is null ;
select *
from `2019`
where arrival_date_week_number is null ;
select *
from `2019`
where arrival_date_day_of_month is null ;
select *
from `2019`
where stays_in_weekend_nights is null ;
select *
from `2019`
where stays_in_week_nights is null ;
select *
from `2019`
where meal is null ;
select *
from `2019`
where country is null ;
select *
from `2019`
where market_segment is null ;
select *
from `2019`
where is_repeated_guest is null ;
select *
from `2019`
where reserved_room_type is null ;
select *
from `2019`
where deposit_type is null ;
select *
from `2019`
where customer_type is null ;
select *
from `2019`
where adr is null ;

-- *****************************************************************************************

select  distinct(hotel)
from `2020`;
select  distinct(is_canceled)
from `2020`;
select  distinct(meal)
from `2020`;
select  distinct(country)
from `2020`;
select  distinct(market_segment)
from `2020`;
select  distinct(is_repeated_guest)
from `2020`;
select  distinct(reserved_room_type)
from `2020`;
select  distinct(deposit_type)
from `2020`;
select  distinct(customer_type)
from `2020`;
select  distinct(arrival_date_year)
from `2020`;
select  distinct(arrival_date_month)
from `2020`;

select * 
from `2020`;

select *
from `2020`
where hotel is null ;
select *
from `2020`
where is_canceled is null ;
select *
from `2020`
where lead_time is null ;
select *
from `2020`
where arrival_date_year is null ;
select *
from `2020`
where arrival_date_month is null ;
select *
from `2020`
where arrival_date_week_number is null ;
select *
from `2020`
where arrival_date_day_of_month is null ;
select *
from `2020`
where stays_in_weekend_nights is null ;
select *
from `2020`
where stays_in_week_nights is null ;
select *
from `2020`
where meal is null ;
select *
from `2020`
where country is null ;
select *
from `2020`
where market_segment is null ;
select *
from `2020`
where is_repeated_guest is null ;
select *
from `2020`
where reserved_room_type is null ;
select *
from `2020`
where deposit_type is null ;
select *
from `2020`
where customer_type is null ;
select *
from `2020`
where adr is null ;





