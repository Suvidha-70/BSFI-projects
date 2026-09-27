/* NO 1 Using database + table name */
Select * From churn_analysis.`bank customer churn prediction`;
/*             */
/* NO 2  Select the database first*/
Use churn_analysis;
Select * From `bank customer churn prediction`;
/* NO 3 Using backticks for both */
Select * From `churn_analysis`.`bank customer churn prediction`;
/*  Aata New shikuu ki count total no of chrun people from chrun col          */
Select Churn ,count(*) as total_Customer from churn_analysis.`bank customer churn prediction`
where churn =1 group  by churn;
/* Question no 1    hwo many customers there in tabel        */
Select Count(*) as total_Customer from churn_analysis.`bank customer churn prediction`;
/* Question 2 how many customer are churn*/
Select churn, count(*) as total_customer_churn from churn_analysis.`bank customer churn prediction` where churn=1 group by churn;
/* Question 3 how many customer are not churn*/
Select churn, count(*) as total_customer_not_churn from churn_analysis.`bank customer churn prediction` where churn=0 group by churn;
/* Question 4 how many customer are there for each  churn*/
Select churn, count(*) as total_customer_not_churn from churn_analysis.`bank customer churn prediction`  group by churn;
/* Question 4 how many customer are there for each  geogaphy*/
Select country, count(*) as total_customer_by_country from churn_analysis.`bank customer churn prediction`  group by country;
/* EX no 5 how many customer have chrun in each geography             */
Select gender, churn,count(*) ascustomer_churn from churn_analysis.`bank customer churn prediction`where churn=1 group by gender,churn;
/* EX no 5 how many customer have chrun in each geography  another way           */
Select gender,count(*) as customer_churn from churn_analysis.`bank customer churn prediction`where churn=1 group by gender,churn;
/* EX no 6 show no of cust in each gergraphy by high to low numbers          */
Select country, count(*) as count_of_Country from churn_analysis.`bank customer churn prediction` group by country order by count_of_country ;
/* EX no 7 How many customer churn in each gender          */
Select gender, churn ,count(*) as Acount  from churn_analysis.`bank customer churn prediction` where churn =1  group by gender, Churn;
/* EX no 7 How many customer churn in each geography         */
Select country, churn ,count(*) from churn_analysis.`bank customer churn prediction` where churn=1 group by country, Churn;
/*  ****CASE****           */
/* EX NO 8 create a colum of churn status      */
Select customer_id,churn,
		CASE
			WHEN churn=1 THEN 'Churned'
            ELSE 'stayed'
            END as Churn_status
from churn_analysis.`bank customer churn prediction`;
/* EX NO 9 create a colum of Age status      */
Select gender, customer_id,
       CASE
       WHEN age <= 25 THEN 'Younger'
         WHEN age <= 35  THEN 'Matured'
         WHEN age <= 45 THEN 'oldder'
         else 'Retried'
		END as Age_satus	
from churn_analysis.`bank customer churn prediction`;
/* EX NO 9 16/8/25 create  a colum based on credit score      */
Select customer_id, credit_score,
Case
WHEN credit_score <=600	THEN 'bad'	
WHEN credit_score <=700	THEN 'Medium'
WHEN credit_score <=800	THEN 'good'
ELSE 'very_good'
END as Credit_score
from churn_analysis.`bank customer churn prediction`;
/* EX NO 10 create  how many customer are there who have age more than 40    */
Select count(*) as age_40  from churn_analysis.`bank customer churn prediction` where age>= 40;
/* EX NO 11 find pepople who are more in nos of 3000 count for each country wise   */
select country, count(*) as customer_count
from churn_analysis.`bank customer churn prediction`
group by country
 having count(*) <= 3000;
 /* EX NO 12 the total balance more than 1 cror country wise   */
 select country,round(sum(balance),2) as Total_balance
 from churn_analysis.`bank customer churn prediction`
 group by country
 having Total_balance >100000000;
 
 select customer_id, avg (balance) as avgbalace from  churn_analysis.`bank customer churn prediction`;
 /* EX NO 12 the avg balance is eaul to 50,000 country wise   */
 select customer_id, avg(balance) as Avg_balance
 from churn_analysis.`bank customer churn prediction`
 where  balance >50000;
  /* where+ grby+having EX 13 count the churned cust for each country and disply the only countries that have more than 100 chured customer  */
  Select country,  count(*) as Total_churn
  from churn_analysis.`bank customer churn prediction`
 where churn = 1
  group by country
  having total_churn>100;
    /*    EX14 find avg balance for each coutry considering only customer whose age is greater than 40,
    and disply those countries where the avg bal is greter than 50,000*/
    select country, ROUND (avg(balance),2) as Avg_balance
    from churn_analysis.`bank customer churn prediction`
    Where age>=40
    group by country
    having avg(balance)>50000;
    /*    EX15 rank the customer with each churn category based on their estimated salary in dec order   */
    select
    churn, estimated_salary,
    rank() over(
    partition by churn
    order by estimated_salary desc
    ) as rank_salary
from churn_analysis.`bank customer churn prediction`;
    /* EX 16 in each cust balance is more or less of revious cust   */
select customer_id, balance,
  LAG (balance) over(
  order by customer_id
  ) as Previos_balance,
  CASE
  WHEN balance >LAG (balance) over(order by customer_id) THEN 'Increase'
    WHEN balance <  LAG (balance) over(order by customer_id) THEN 'Decrease'
    ELSE 'same'
    END as balance_satus
from churn_analysis.`bank customer churn prediction`;
    /* EX 17 which country have hifgest cust  churn rate    */
SELECT 
    Country,
    COUNT(*) AS Country_wise_customers,
    SUM(churn) AS churn_customers,
    SUM(churn) * 100.0 / COUNT(*) AS rate_churn
FROM
    `bank customer churn prediction`
GROUP BY country;
    /* calcualte total churn customer */
    select sum(churn) from churn_analysis.`bank customer churn prediction`;
       /* calcualte churn rate */
       select round ( sum(churn) / count(*) * 100 ,2 )from churn_analysis.`bank customer churn prediction`;
       /*  active member *\
   Select count(active_member)  from `bank customer churn prediction` where churn= 0;
