# Create an SQL stored procedure that will allow you to obtain the average male and female 
# salary per department within a certain salary range. 
# Let this range be defined by two values the user can insert when calling the procedure.

# Finally, visualize the obtained result-set in Tableau as a double bar chart. 

DROP PROCEDURE IF EXISTS male_female_avg_salary;

DELIMITER $$
CREATE PROCEDURE male_female_avg_salary(IN p_min_salary FLOAT, IN p_max_salary FLOAT)
BEGIN
SELECT 
    e.gender,
    d.dept_name,
    ROUND(AVG(s.salary), 2) AS average_salary
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON s.emp_no = de.emp_no
        JOIN
    t_departments d ON de.dept_no = d.dept_no
WHERE
    s.salary BETWEEN p_min_salary AND p_max_salary
GROUP BY d.dept_name , e.gender
ORDER BY d.dept_no;
END $$
DELIMITER ;

CALL male_female_avg_salary(50000,90000);