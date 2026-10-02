SELECT *
FROM User_Events project
order by 1,2;



SELECT 
traffic_source,
SUM(cast(amount as float)) as total_leads
FROM User_Events project
GROUP BY traffic_source;

SELECT DISTINCT
event_type 
FROM User_Events project;

--Overall Conversion Rate

SELECT 
    COUNT(DISTINCT CASE 
        WHEN event_type = 'purchase' THEN user_id 
    END) * 100.0
    / COUNT(DISTINCT CASE 
        WHEN event_type = 'page_view' THEN user_id 
    END)  AS conversion_rate
    
FROM user_events;

--conversion rate by traffic source

SELECT
    traffic_source,
    COUNT(DISTINCT CASE 
        WHEN event_type = 'purchase' THEN user_id 
    END) AS purchasing_users,
    COUNT(DISTINCT CASE 
        WHEN event_type = 'page_view' THEN user_id 
    END) AS visitors,
    ROUND(
        COUNT(DISTINCT CASE 
            WHEN event_type = 'purchase' THEN user_id 
        END) * 100.0
        / NULLIF(
            COUNT(DISTINCT CASE 
                WHEN event_type = 'page_view' THEN user_id 
            END), 0
        ),
        2
    ) AS conversion_rate
FROM user_events
GROUP BY traffic_source
ORDER BY conversion_rate DESC;