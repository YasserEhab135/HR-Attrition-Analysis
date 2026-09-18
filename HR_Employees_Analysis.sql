USE HR_Analytics;

SELECT top 10 * 
FROM [HR-Employee-Attrition];

--How many employees left vs stayed
SELECT 
    Attrition,
    COUNT(*) AS Employee_Count,
    CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM [HR-Employee-Attrition]) AS DECIMAL(5,2)) AS Percentage
FROM [HR-Employee-Attrition]
GROUP BY Attrition;

--How many employees left  by department
SELECT 
    Department,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Attrition_Rate
FROM [HR-Employee-Attrition]
GROUP BY Department
ORDER BY Attrition_Rate DESC;


-- compare average salary and average work experience between employees who left and those who stayed

SELECT attrition,
       AVG(MonthlyIncome) AS Avg_Monthly_Income,
      CAST(AVG(TotalWorkingYears*1.0) AS DECIMAL(5,2)) AS Avg_Working_Years
FROM [HR-Employee-Attrition]
GROUP BY  Attrition;


--check whether working overtime is linked to a higher attrition rate
SELECT OverTime,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) as Attrition_Count,
       CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) *100.0 /COUNT(*) AS DECIMAL(5,2)) as Attrition_Rate

FROM [HR-Employee-Attrition]
GROUP BY OverTime;


--rank job roles by their attrition rate, from highest to lowest
SELECT 
       JobRole,
       COUNT(*) AS Total_Employees,
       SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
       CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Attrition_Rate ,
       RANK() OVER(ORDER BY SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) DESC) AS Attrition_Rank
FROM [HR-Employee-Attrition]
GROUP BY JobRole


--check whether lower job satisfaction is linked to a higher attrition rate
SELECT 
    JobSatisfaction,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) AS Attrition_Count,
    CAST(SUM(CASE WHEN Attrition = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS DECIMAL(5,2)) AS Attrition_Rate
FROM [HR-Employee-Attrition]
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

