/*
Project: Bank Customer Churn Analysis
Author: Indu Kandikanti
Tools Used: MySQL

Description:
This project analyzes customer churn patterns for a retail bank using SQL.
The objective is to identify key drivers of churn and generate insights
that support data-driven customer retention strategies.
*/

create database customer_churn_analysis;
use customer_churn_analysis;
select * from `customer-churn-records`;
--Data cleaning and validation
select distinct customer_id from `customer-churn-records`;
select Exited,count(Customer_Id) from `customer-churn-records`
group by Exited;

select count(*) from `customer-churn-records`
where Geography is null or age is null or 
	  tenure is null or balance is null or
      Is_Active_Member is null or exited is null;

select count(*) from `customer-churn-records`
where Credit_Score < 300 or Credit_Score > 900;
select count(*) from `customer-churn-records`
where tenure between 0 and 10;
select min(`Satisfaction_ Score`) as min_score,
       max(`Satisfaction_ Score`) as max_score
from `customer-churn-records`;

--Churn analysis
-- Churn rate by geography 
select Geography,Count(customer_Id) as total_customers,
sum(exited) as churned_customers,round(sum(exited)/count(customer_id)*100,1) as churn_rate_percentage
from `customer-churn-records`
group by Geography;

-- Churn rate by customer activity  
select Is_active_member, count(customer_id) as total_customers,
sum(exited) as churned_customers,round(sum(exited)/count(customer_id)*100,1) as churn_rate_percentage
from `customer-churn-records`
group by Is_active_member;

-- churn rate by credit score
select count(*) as total_customer,
sum(exited) as churned_customers,round(sum(exited)/count(customer_id)*100,1) as churn_rate_percentage,
    case    when credit_score<=579 then 'Poor'
            when credit_score<=669 then 'Fair'
            when credit_score<=739 then 'Good'
            when credit_score<=799 then 'Very Good'
		else 'Excellent'
	end as 'Credit_category'
from `customer-churn-records`
group by Credit_category;

-- churn rate by tenure level
select count(*) as total_customers,
sum(exited) as churned_customers,round(sum(exited)/count(customer_id)*100,1) as churn_rate_percentage,
	case when tenure <= 3 then 'New'
		 when tenure <= 7 then 'Mid'
       else 'Loyal'
	end as 'Tenure_range'
from `customer-churn-records`
group by Tenure_range;

-- churn rate by satisfaction_score
select count(*) as total_customers,Is_Active_Member,
sum(exited) as churned_customers,round(sum(exited)/count(customer_id)*100,1) as churn_rate_percentage,
	case when `Satisfaction_ Score` <= 2 then 'Unhappy'
		 when `Satisfaction_ Score` = 3 then 'Neutral'
       else 'Happy'
	end as 'Satisfaction'
from `customer-churn-records`
group by Is_Active_Member,satisfaction;
