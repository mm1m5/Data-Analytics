USE credit_card_db;
SELECT * FROM dbo.BankChurners$;

--1.	Identify the total number of customers and which of those customers have churned.
--Percentage of churned from total customer
SELECT 
    COUNT(CLIENTNUM) AS Total_Customers,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(CLIENTNUM) AS DECIMAL(10,2)) AS Churn_Rate_Percentage
FROM dbo.BankChurners$;

--2.	What is the distribution of churned vs. non-churned customers?
SELECT Attrition_Flag, COUNT(*) AS num_customers
FROM dbo.BankChurners$
GROUP BY Attrition_Flag;

--3.	Which customer demographics (age, income, marital status, etc.) are the best indicators of churn?
--Age sorted from least to greatest
SELECT * 
FROM (
    SELECT 
        CASE 
            WHEN Customer_Age < 25 THEN 'Under 25'
            WHEN Customer_Age BETWEEN 25 AND 34 THEN '25-34'
            WHEN Customer_Age BETWEEN 35 AND 44 THEN '35-44'
            WHEN Customer_Age BETWEEN 45 AND 54 THEN '45-54'
            ELSE '55+'
        END AS Age_Group,
        COUNT(*) AS Total_Customers,
        SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
        CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS Churn_Rate
    FROM dbo.BankChurners$
    GROUP BY 
        CASE 
            WHEN Customer_Age < 25 THEN 'Under 25'
            WHEN Customer_Age BETWEEN 25 AND 34 THEN '25-34'
            WHEN Customer_Age BETWEEN 35 AND 44 THEN '35-44'
            WHEN Customer_Age BETWEEN 45 AND 54 THEN '45-54'
            ELSE '55+'
        END
) AS AgeData
ORDER BY 
    CASE 
        WHEN Age_Group = 'Under 25' THEN 1
        WHEN Age_Group = '25-34' THEN 2
        WHEN Age_Group = '35-44' THEN 3
        WHEN Age_Group = '45-54' THEN 4
        WHEN Age_Group = '55+' THEN 5
        ELSE 999
    END;

--Gender
SELECT 
	Gender,
	COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(CLIENTNUM) AS DECIMAL(10,2)) AS Churn_Rate_Percentage
FROM dbo.BankChurners$
GROUP BY Gender;

--Marital
SELECT 
	Marital_Status,
    COUNT(CLIENTNUM) AS Total_Customers,
    COUNT(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 END) AS Churned_Customers,
    CAST(COUNT(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 END) * 100.0 / COUNT(CLIENTNUM) AS DECIMAL(10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY Marital_Status;

--Education
SELECT 
    Education_Level,
    COUNT(CLIENTNUM) AS Total_Customers,
    COUNT(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 END) AS Churned_Customers,
    CAST(COUNT(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 END) * 100.0 / COUNT(CLIENTNUM) AS DECIMAL(10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY Education_Level;

--Income
SELECT 
	Income_Category,
	COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
	CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL (10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY Income_Category;

--4.	What percentage of churned customers have a high credit utilization ratio (e.g., > 80%)?
--Utilization Ratio & Churn The Utilization Ratio is calculated as Total_Trans_Amt / Credit_Limit.
SELECT
    CASE 
        WHEN (Total_Trans_Amt / Credit_Limit) < 0.3 THEN 'Low Utilization (<30%)'
        WHEN (Total_Trans_Amt / Credit_Limit) BETWEEN 0.3 AND 0.8 THEN 'Medium Utilization (30-80%)'
        ELSE 'High Utilization (>80%)'
    END AS Utilization_Category,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY 
    CASE 
        WHEN (Total_Trans_Amt / Credit_Limit) < 0.3 THEN 'Low Utilization (<30%)'
        WHEN (Total_Trans_Amt / Credit_Limit) BETWEEN 0.3 AND 0.8 THEN 'Medium Utilization (30-80%)'
        ELSE 'High Utilization (>80%)'
    END
ORDER BY Churn_Rate DESC;

--5.	Which customer behaviors (e.g., transaction amounts, credit limit, card usage) are the most predictive of churn?
--credit limit and total_trans_amount
SELECT 
    Credit_Trans_Category,
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
    CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS Churn_Rate
FROM (
    SELECT 
        CASE 
            WHEN Credit_Limit < 8600 THEN 'Low Credit'
            WHEN Credit_Limit BETWEEN 8600 AND 20000 THEN 'Medium Credit'
            ELSE 'High Credit'
        END 
        + ' & ' + 
        CASE 
            WHEN Total_Trans_Amt < 5000 THEN 'Low Spend'
            WHEN Total_Trans_Amt BETWEEN 5000 AND 9999 THEN 'Medium Spend'
            ELSE 'High Spend'
        END AS Credit_Trans_Category,
        Attrition_Flag
    FROM dbo.BankChurners$
) AS subquery
GROUP BY Credit_Trans_Category
ORDER BY Churn_Rate DESC;

--categorize customers base on credit limit
SELECT
	CASE
		WHEN Credit_Limit < 8600 THEN 'Low'
		WHEN Credit_Limit BETWEEN 8600 AND 20000 THEN 'Medium'
		WHEN Credit_Limit > 20000 THEN 'High'
	END AS Credit_Category,
	COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churn_Customers,
	CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL (10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY
	CASE
		WHEN Credit_Limit < 8600 THEN 'Low'
		WHEN Credit_Limit BETWEEN 8600 AND 20000 THEN 'Medium'
		WHEN Credit_Limit > 20000 THEN 'High'
	END;

--total spending vs churn
SELECT
	CASE
		WHEN Total_Trans_Amt < 5000 THEN 'Low'
		WHEN Total_Trans_Amt BETWEEN 5000 AND 9999 THEN 'Medium'
		WHEN Total_Trans_Amt > 10000 THEN 'High'
	END AS Trans_Category,
	COUNT(*) AS Total_Customers,
	SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_customers,
	CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL (10,2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY
		CASE
		WHEN Total_Trans_Amt < 5000 THEN 'Low'
		WHEN Total_Trans_Amt BETWEEN 5000 AND 9999 THEN 'Medium'
		WHEN Total_Trans_Amt > 10000 THEN 'High'
	END;

--6.	Which credit card types have the highest churn rates?
--credit card type vs churn
SELECT 
	Card_Category,
	COUNT(*) AS Total_Customers, 
	SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS Churned_Customers,
	CAST(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) * 100.0 / COUNT(CLIENTNUM) AS DECIMAL(10, 2)) AS Churn_Rate
FROM dbo.BankChurners$
GROUP BY Card_Category;