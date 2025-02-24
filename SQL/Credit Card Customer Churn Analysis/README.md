# 📂 Project: Credit Card Customer Churn Analysis

## 📝 Business Situation:
The bank is experiencing a rise in customer churn, where a significant number of customers are closing their credit card accounts. This is a serious concern as it directly impacts revenue and the bank's customer base. The business manager wants to understand why customers are leaving, and ideally, be able to predict which customers are at risk of churning in the future. By identifying these customers early, the bank can take proactive measures, such as offering promotions, improving customer service, or addressing common issues that lead to churn.

### 📌 Objective:
The goal of this project is to perform data analysis to identify and understand patterns that contribute to customer churn. SQL will be used for data exploration, aggregation, and insight extraction, followed by Power BI for visualization and reporting. The insights derived will help in identifying at-risk customers and recommending strategies for customer retention.

### 🛠️ Tools:
- Microsoft SQL Server
- Power BI

### ⚡ Skills:
- SQL (Querying, Aggregation, Data Cleaning)
- Data Analysis (EDA, Identifying Trends)
- Data Visualization (Charts, Dashboards)
- DAX (Calculated Measures in Power BI)

### 📊 Project Pipeline:
**1. Data Collection & Import**
  - Import the dataset (CSV file) into Microsoft SQL Server.
  - Verify data integrity and structure before analysis.

**2. Data Cleaning & Preparation**
  - Clean and explore the dataset to understand its structure, missing values, and basic statistics.
  - Identify any relationships or correlations between features and churn.

**3. Exploratory Data Analysis (EDA)**
  - Use SQL queries to explore customer demographics, transaction behavior, and churn patterns.
  - Calculated churn rate and analyzed key factors contributing to churn.
  - Identify trends in age, income, credit limit, utilization ratio, and spending patterns.

**4. Data Aggregation & Insights**
  - Write SQL queries to aggregate data and calculate key metrics for churn analysis.
  - Segmented customers based on demographics and spending behavior.
  - Compared churned vs. retained customers using SQL aggregations.
  - Generated summary statistics to highlight key business insights.

**5. Data Visualization & Reporting**
  - Create reports and visualizations showing churn by demographic categories (e.g., income, marital status, card type).
  - Use Power BI to build an interactive dashboard summarizing key findings.

**6. Business Insights & Recommendations**
  - Provide actionable insights for the bank:
    - Which demographics should the bank target for retention?
    - What factors contribute most to churn, and how can they be addressed?
    - How can certain customer behaviors be improved to reduce churn?
- Suggest strategies for retention, such as targeted promotions and customer engagement improvements.
- Provide data-backed insights to help reduce customer churn.

### 🎯 Dashboard (Power BI)
![image](https://github.com/user-attachments/assets/68f173c9-d46f-4ae6-90c4-962355ec2ca5)

### 📝 Summary

**Business Insights**

The analysis reveals that low-income customers (earning <$40K) and middle-aged customers (45-54) are at the highest risk of churn, with churn rates of 17.19% and 16.49%, respectively. The Blue credit card, which has the most customers, also sees significant churn (16.10% churn rate, 1,519 customers lost), making it a key area of focus. Additionally, medium-spending customers ($5,000-$9,999) with credit limits between $8,600 and $20K have the highest churn rate (30.32%), indicating that spending behavior plays a crucial role in customer retention. Moreover, female customers churn at a slightly higher rate (17.36%) than males (14.62%), suggesting the need for gender-targeted engagement strategies.

**Recommendations**

To reduce churn, the bank should implement personalized retention programs for low-income and middle-aged customers, including financial guidance, targeted offers, and loyalty rewards. For medium-spending customers, increasing engagement through cashback incentives, rewards, and exclusive benefits can help retain them. Since the Blue credit card has the most churned customers, enhancing its benefits, promotions, and customer service will be crucial. For female customers, offering exclusive rewards, referral programs, and financial education initiatives can improve retention. Finally, low-spending customers (spending < $5000, with low credit limits), who make up a significant portion of the churned base, could benefit from lower transaction fees, micro-loans, or credit-building programs to encourage continued usage. Implementing these data-driven strategies will help the bank proactively retain customers and reduce overall churn.
