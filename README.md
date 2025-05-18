# Data Analyst Assessment
 

---

## Overview  
This repository contains SQL solutions to four business problems focused on customer segmentation, transaction analysis, account monitoring, and customer lifetime value estimation. The solutions are optimized for **MySQL**.

---

## Question Explanations  

### 1. High-Value Customers with Multiple Products  
**Objective:** Identify customers with both funded savings and investment plans.  
**Approach:**  
- Joined `users_customuser`, `plans_plan`, and `savings_savingsaccount` to track deposits per plan type.  
- Used `CASE` statements to count savings (`is_regular_savings = 1`) and investment (`is_a_fund = 1`) plans.  
- Formatted `total_deposits` to 2 decimal places (kobo to Naira).  

**Challenge:** The original `name` field was empty, so `first_name` and `last_name` were concatenated.  

---

### 2. Transaction Frequency Analysis  
**Objective:** Categorize customers by monthly transaction frequency.  
**Approach:**  
- Calculated monthly transaction counts using `DATE_FORMAT`.  
- Used CTEs to first aggregate averages, then assign frequency categories.  
- Resolved **MySQL Error 1056** by restructuring the query to avoid grouping by aliases.  

**Challenge:** MySQL’s restriction on grouping by aliases required nested CTEs.  

---

### 3. Account Inactivity Alert  
**Objective:** Flag accounts with no deposits in the last 365 days.  
**Approach:**  
- Joined `plans_plan` and `savings_savingsaccount` to find the latest transaction date.  
- Used `DATEDIFF` to calculate inactivity days.  

**Challenge:** Ensuring only *funded* accounts were included.  

---

### 4. Customer Lifetime Value (CLV) Estimation  
**Objective:** Estimate CLV based on tenure and transaction volume.  
**Approach:**  
- Derived tenure with `TIMESTAMPDIFF(MONTH)`.  
- CLV formula:  `CLV = (total_transactions / tenure) * 12 * (SUM(confirmed_amount) * 0.001 / 100.0)`
- Avoided division-by-zero errors using `NULLIF`.  

**Challenge:** Handling edge cases for new customers with zero tenure.  

---
