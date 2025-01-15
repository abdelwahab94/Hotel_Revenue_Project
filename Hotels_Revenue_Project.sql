
drop table hotel ; 

CREATE TABLE hotel (
  `hotel` text,
  `is_canceled` int DEFAULT NULL,
  `lead_time` int DEFAULT NULL,
  `arrival_date_year` int DEFAULT NULL,
  `arrival_date_month` text,
  `arrival_date_week_number` int DEFAULT NULL,
  `arrival_date_day_of_month` int DEFAULT NULL,
  `stays_in_weekend_nights` int DEFAULT NULL,
  `stays_in_week_nights` int DEFAULT NULL,
  `adults` int DEFAULT NULL,
  `children` int DEFAULT NULL,
  `babies` int DEFAULT NULL,
  `meal` text,
  `country` text,
  `market_segment` text,
  `distribution_channel` text,
  `is_repeated_guest` int DEFAULT NULL,
  `previous_cancellations` int DEFAULT NULL,
  `previous_bookings_not_canceled` int DEFAULT NULL,
  `reserved_room_type` text,
  `assigned_room_type` text,
  `booking_changes` int DEFAULT NULL,
  `deposit_type` text,
  `agent` text,
  `company` text,
  `days_in_waiting_list` int DEFAULT NULL,
  `customer_type` text,
  `adr` double DEFAULT NULL,
  `required_car_parking_spaces` int DEFAULT NULL,
  `total_of_special_requests` int DEFAULT NULL,
  `reservation_status` text,
  `reservation_status_date` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- we will use union to neglect duplicated data
insert into hotel
select *
from `2018`
union
select *
from `2019`
union
select *
from `2020`;



select *
from hotel;

select * 
from meal_cost;


-- What is the profit percentage for each month across all years?
   
   
   -- firstly, we calculate the total revenue off all hotels per all years
   
select round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
   on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
       is_canceled = 1 and deposit_type = 'Non Refund'
     ) ; 


  -- here we use the previous caluculation  to get the profit percentage of each hotel per months by deviding "total_revenue_per_month' over the previuos query multiplying by 100  
  
select *, round((total_revenue_per_month/(
                                           select round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
                                           from hotel
                                           join meal_cost
                                             on  hotel.meal = meal_cost.meal
                                           where is_canceled = 0
                                              or
                                                (
                                                     is_canceled = 1 and deposit_type = 'Non Refund'
                                                ) 
                                         )
                )*100,2) as profit_percentage
from(
      select hotel,
             arrival_date_year,
             arrival_date_month,
             round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue_per_month
      from hotel
      join meal_cost
        on  hotel.meal = meal_cost.meal
      where is_canceled = 0
         or
           (
             is_canceled = 1 and deposit_type = 'Non Refund'
           )
      group by hotel,arrival_date_year,arrival_date_month
      order by 1,2,3 asc
    ) as total_revenue_table
group by hotel,arrival_date_year,arrival_date_month;


-- Which meals and market segments (e.g., families, corporate clients, etc.) contribute the most to the total revenue for each hotel annually?




  -- here is the descending order of the tolal annual revenue for each hotel according to market_segment

select *, round((total_revenue_per_year/(
                                           select round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
                                           from hotel
                                           join meal_cost
                                             on  hotel.meal = meal_cost.meal
                                           where is_canceled = 0
                                              or
                                                (
                                                  is_canceled = 1 and deposit_type = 'Non Refund'
                                                ) 
                                        )
                )*100,2) as profit_percentage
from
  (
    select hotel,
           market_segment,
           arrival_date_year,
           round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue_per_year
    from hotel
    join meal_cost
      on  hotel.meal = meal_cost.meal
    where is_canceled = 0
       or
         (
           is_canceled = 1 and deposit_type = 'Non Refund'
         )
    group by hotel,market_segment,arrival_date_year
    order by 1,3,4 desc
  ) as total_revenue_table
group by hotel,market_segment,arrival_date_year;



  -- here is the descending order of the tolal annyal revenue for each hotel according to meal

select *,
       round((total_revenue_per_year/(
                                        select round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
                                        from hotel
                                        join meal_cost
                                          on  hotel.meal = meal_cost.meal
                                        where is_canceled = 0
                                           or
                                             (
                                               is_canceled = 1 and deposit_type = 'Non Refund'
                                             ) 
                                     )
             )*100,2) as profit_percentage
from
   (
     select hotel,
            hotel.meal,arrival_date_year,
            round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue_per_year
     from hotel
     join meal_cost
       on  hotel.meal = meal_cost.meal
     where is_canceled = 0
        or
          (
            is_canceled = 1 and deposit_type = 'Non Refund'
          )
     group by hotel,hotel.meal,arrival_date_year
     order by 1,3,4 desc
   ) as total_revenue_table
group by hotel,meal,arrival_date_year;



-- How does revenue compare between public holidays and regular days each year?

select regular_days_revenue.hotel,
       total_revenue_per_holidays,total_revenue_per_regular_days

from
   (
     select hotel,
            round(sum(((stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue_per_regular_days
     from hotel 
     join meal_cost
       on  hotel.meal = meal_cost.meal
     where is_canceled = 0
        or
          (
            is_canceled = 1 and deposit_type = 'Non Refund'
          )
     group by hotel
     order by 1
   ) as regular_days_revenue

join
  (
    select hotel,
           round(sum(((stays_in_weekend_nights)*(adr+meal_cost.Cost))),2) as total_revenue_per_holidays
    from hotel 
    join meal_cost
       on  hotel.meal = meal_cost.meal
    where is_canceled = 0
       or
         (
           is_canceled = 1 and deposit_type = 'Non Refund'
         )
    group by hotel
    order by 1
  ) as holidays_revenue

 on holidays_revenue.hotel = regular_days_revenue.hotel;


-- What are the key factors (e.g., hotel type, market type, meals offered, number of nights booked) significantly impact hotel revenue annually?



  -- 1-hotel type effect

select hotel,
       round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
  on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
       is_canceled = 1 and deposit_type = 'Non Refund'
     )
group by hotel
order by 2 desc ; 


  -- 2-meals type effect

select hotel.meal,
       round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
  on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
       is_canceled = 1 and deposit_type = 'Non Refund'
     )
group by hotel.meal
order by 2 desc; 


  -- 3-market type effect

select market_segment,
       round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
  on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
        is_canceled = 1 and deposit_type = 'Non Refund'
     )
group by market_segment
order by 2 desc ; 


  -- 4-booked days effect

select (stays_in_weekend_nights+stays_in_week_nights) as booked_days,
        round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
   on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
       is_canceled = 1 and deposit_type = 'Non Refund'
     )
group by booked_days
order by 2 desc; 



-- Based on stay data, what are the yearly trends in customer preferences for room types (e.g., family rooms vs. single rooms), and how do these preferences influence revenue?



  -- most prefered room type
  
select reserved_room_type,
       count(reserved_room_type)
from hotel
group by reserved_room_type
order by 2 desc;


  -- effect of room type

select reserved_room_type,
       round(sum(((stays_in_weekend_nights+stays_in_week_nights)*(adr+meal_cost.Cost))),2) as total_revenue
from hotel
join meal_cost
  on  hotel.meal = meal_cost.meal
where is_canceled = 0
   or
     (
       is_canceled = 1 and deposit_type = 'Non Refund'
     )
group by reserved_room_type
order by 2 desc ;   


-- percentage of cancelig reservation

select hotel,is_canceled,
       count(is_canceled),
       (count(is_canceled)/(select count(is_canceled) from hotel )) as canceling_percentage
from hotel
group by hotel,is_canceled
order by 1,2 asc;


-- effect of months on cancelation

select arrival_date_month,
       count(is_canceled) as no_of_cancellation,
       ((count(is_canceled)/(select count(is_canceled) from hotel where is_canceled = 1))*100)as percentage
from hotel 
where is_canceled = 1
group by arrival_date_month
order by 2 desc ;


-- effect of customer type on cancelation

select customer_type ,
       count(is_canceled) as no_of_cancellation,
       ((count(is_canceled)/(select count(is_canceled) from hotel where is_canceled = 1))*100)as percentage
from hotel
where is_canceled = 1 
group by customer_type
order by 2 desc;

-- effect of room type on cancellation

select reserved_room_type ,
       count(is_canceled) as no_of_cancellation,
       ((count(is_canceled)/(select count(is_canceled) from hotel where is_canceled = 1))*100)as percentage
from hotel
where is_canceled = 1 
group by reserved_room_type
order by 2 desc;

-- effect of lead time on cancellation

select 'less than 400' as lead_time,
        (select count(is_canceled) from hotel where hotel.lead_time <= 400 and is_canceled = 1) as no_of_cancellation
from hotel
union
select 'more than 400' as lead_time,
       (select count(is_canceled) from hotel where hotel.lead_time > 400  and is_canceled = 1) as no_of_cancellation
from hotel
;
 
-- effect of repeated and non repeated guest on cancellation

select is_repeated_guest ,
       count(is_canceled) as no_of_cancellation,
       ((count(is_canceled)/(select count(is_canceled) from hotel where is_canceled = 1))*100)as percentage
from hotel
where is_canceled = 1 
group by is_repeated_guest
order by 2 desc;


-- countries that have high cancellation rate

select * , 
       (no_of_cancellation/(select count(is_canceled) from hotel where is_canceled = 1))*100 as percentage 
from
   (
     select country , count(is_canceled) as no_of_cancellation
     from hotel
     where is_canceled = 1 
     group by country
     order by 2 desc
   ) as countries_percentage ;
