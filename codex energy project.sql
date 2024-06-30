use food_beverage;  
select * from dim_cities;
select count(*) from dim_repondents;
select * from fact_survey_responses;

 -- demographics insights 
 -- Who prefers energy drink more?  (male/female/non-binary?)                     -- male consume more  about 60% ,female - about 34%,nonbinary - about 0.5
 with cte as (select 
			  case when gender = "Male" then 1 else 0 end as total_male,
              case when gender = "Female" then 1 else 0 end as total_female,
              case when gender = "Non-binary" then 1 else 0 end as total_nonbinary
			from dim_repondents)
 select sum(total_male) as total_male,sum(total_female) as total_female,sum(total_nonbinary)  as total_non_binary      
 from cte;
                                              -- can be written as also
 select gender,count(gender)
 from dim_repondents
 group by gender
 order by count(gender);
 
 -- Which age group prefers energy drinks more?                                                           --age between 19-45 consume more
 with my_cte as (select
				 case when Age = "15-18" then 1 else 0 end as bw_15_to_18,
                 case when Age = "19-30" then 1 else 0 end as bw_19_to_30,
                 case when Age = "31-45" then 1 else 0 end as bw_31_to_45,
                 case when Age = "46-65" then 1 else 0 end as bw_46_to_65,
                 case when Age = "65+" then 1 else 0 end as above_65
                 from  dim_repondents)
 select sum(bw_15_to_18),sum(bw_19_to_30),sum(bw_31_to_45),sum(bw_46_to_65),sum(above_65)    
 from my_cte;
                                       -- can be also written also
 select age , count(age)
 from dim_repondents
 group by age 
 order by age desc;
 
 -- Which type of marketing reaches the most Youth (15-30)?     --- people knwo more about this product through online ads followed by tv commercial and less by print media

select f.Marketing_channels,count(f.Marketing_channels)
from dim_repondents as r
inner join fact_survey_responses as f
on r.Respondent_ID = f.Respondent_ID
where r.age in("15-18","19-30")
group by f.Marketing_channels
order by count(f.Marketing_channels) desc;

-- Consumer Preferences:
-- What are the preferred ingredients of energy drinks among respondents?                                                    -- caffiene,vitamins,sugar,guarana
select Ingredients_expected,count(Ingredients_expected) as responses
from fact_survey_responses
group by Ingredients_expected
order by responses desc;

-- What packaging preferences do respondents have for energy drinks?          -- 3984 prefer'Compact and portable cans' and 'Innovative bottle design' preferred by 3047 people

select Packaging_preference,count(Packaging_preference) as total_responses
from fact_survey_responses
group by Packaging_preference
order by total_responses desc;

-- Competition Analysis: 
--  Who are the current market leaders?                                                        -- cococola ,pepsi,Gangster are market leader

select Current_brands,count(Current_brands) as response_by_people
from fact_survey_responses
group by  Current_brands
order by response_by_people desc;

-- What are the primary reasons consumers prefer those brands over ours?               --'Brand reputation','Taste/flavor preference','Availability','Effectiveness' then other

select Reasons_for_choosing_brands ,count(Reasons_for_choosing_brands) as total_response
from fact_survey_responses
group by Reasons_for_choosing_brands
order by total_response desc;

-- Marketing Channels and Brand Awareness: 
-- a. Which marketing channel can be used to reach more customers?     -- online ads  and tv commercial are two brand
select Marketing_channels,count(Marketing_channels) 
from  fact_survey_responses 
group by Marketing_channels
order by count(Marketing_channels) desc;

-- How effective are different marketing strategies and channels in reaching our customers? 

-- Brand Penetration: 
-- a. What do people think about our brand? (overall rating) 

select avg(taste_experience)
from fact_survey_responses
where tried_before ="Yes";



-- Which cities do we need to focus more on? 
SELECT d.City, COUNT(*) AS ResponseCount, d.Tier
FROM dim_cities d
JOIN dim_repondents r ON d.City_ID = r.City_ID
GROUP BY d.City, Tier
ORDER BY ResponseCount desc ;

-- Purchase Behavior: 
-- a. Where do respondents prefer to purchase energy drinks?  
select Purchase_location ,count(Purchase_location) 
from fact_survey_responses
group by Purchase_location
order by count(Purchase_location) desc ;

-- What are the typical consumption situations for energy drinks among respondents? 
select Typical_consumption_situations,count(Typical_consumption_situations)
from fact_survey_responses
group by Typical_consumption_situations
order by count(Typical_consumption_situations) desc;

-- What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Price_range,count(Price_range)
from fact_survey_responses                                          --  42% want price etween price between 50-99
group by Price_range
order by count(Price_range) desc;

select Limited_edition_packaging,count(Limited_edition_packaging)
from fact_survey_responses
group by Limited_edition_packaging                                -- about 40$ says yes while same amount says no
order by count(Limited_edition_packaging);


-- Product Development 
-- a. Which area of business should we focus more on our product development? (Branding/taste/availability)

select brand_perception,count(brand_perception)
from fact_survey_responses                                   -- only 20% people have positive brandd, while taste experience is  3.3 on an average,
group by brand_perception
order by count(brand_perception);

select Reasons_for_choosing_brands,count(Reasons_for_choosing_brands)
from fact_survey_responses                                     
group by Reasons_for_choosing_brands
order by count(Reasons_for_choosing_brands) desc;



