WITH monthly_counts AS (
    SELECT 
        u.id AS customer_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS month_year,
        COUNT(s.id) AS transaction_count
    FROM users_customuser u
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, DATE_FORMAT(s.transaction_date, '%Y-%m')
),
customer_stats AS (
    SELECT 
        customer_id,
        AVG(transaction_count) AS avg_transactions_per_month
    FROM monthly_counts
    GROUP BY customer_id
)
SELECT 
    CASE 
        WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
        WHEN avg_transactions_per_month >= 3 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM customer_stats
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;
