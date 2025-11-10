
/*BANK LOAN REPORT | SUMMARY*/
/*Total Loan Applications*/
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data

/*MTD Loan Applications*/
SELECT COUNT(id) AS MTD_Loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date)=2021;

/*PMTD Loan Applications*/
SELECT COUNT(id) AS MTD_Loan_Applications FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date)=2021;


/*Total Funded Amount*/
SELECT SUM(loan_amount) as Total_Funded_Amount FROM bank_loan_data

/*MTD Total Funded Amount*/
SELECT SUM(loan_amount) as Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

/*PMTD Total Funded Amount*/
SELECT SUM(loan_amount) as Total_Funded_Amount FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

/*Total Amount Received*/
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data

/*MTD Total Amount Received*/
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 12


/*PMTD Total Amount Received*/
SELECT SUM(total_payment) AS Total_Amount_Received FROM bank_loan_data
WHERE MONTH(issue_date) = 11

/*Average Interest Rate*/
SELECT AVG(int_rate)*100 AS Average_Interest_Rate FROM bank_loan_data


/*MTD Average Interest*/
SELECT AVG(int_rate)*100 AS MTD_Average_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date)=12

/*PMTD Average Interest*/
SELE PMTD_Average_Interest_Rate FROM bank_loan_data
WHERE MONTH(issue_date)=11


/*Average Debt-to-Income Ratio*/
SELECT AVG(dti)*100 AS AVG_Debt_To_Income FROM bank_loan_data

/*MTD Average Debt-to-Income Ratio:*/
SELECT AVG(dti)*100 AS MTD_AVG_Debt_To_Income FROM bank_loan_data
WHERE MONTH(issue_date)=12

/*PMTD Average Debt-to-Income Ratio*/
SELECT AVG(dti)*100 AS PMTD_AVG_Debt_To_Income FROM bank_loan_data
WHERE MONTH(issue_date)=11

/*Average Loan Size per Grade*/
SELECT grade, AVG(loan_amount) AS Average_Loan_Size
FROM bank_loan_data
GROUP BY grade
ORDER BY grade;

/*Average Loan Size per Grade by Quarter (every 3 months)*/
SELECT CONCAT ('Q',DATEPART(QUARTER, issue_date)) AS Quarter,
grade, AVG(loan_amount) as avg_loan_size
FROM bank_loan_data
GROUP BY DATEPART(QUARTER, issue_date), grade
ORDER BY DATEPART(QUARTER, issue_date), grade;

/*Top 5 States by Total Funding:*/
SELECT TOP 5 address_state, FORMAT(SUM(loan_amount), 'N0') as Total_Funding
FROM bank_loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC


/*Average Income per Employment Length*/
SELECT emp_length, FORMAT(AVG(annual_income), 'N2') AS avg_income_by_length
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

/*GOOD LOAN ISSUED
Good Loan Percentage*/
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current'
THEN id END)*100.0)/COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

/*Good Loan Applications*/
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Good Loan Funded Amount*/
SELECT SUM(loan_amount) AS Good_Loan_Fundered_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

/*Good Loan Amount Received*/
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'


/*BAD LOAN ISSUED
Bad Loan Percentage*/
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0)/
COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

/*Bad Loan Applications*/
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

/*Bad Loan Funded Amount*/
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'


/*Bad Loan Amount Received*/
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data
WHERE loan_status = 'Charged Off'

/*LOAN STATUS*/
SELECT loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate*100) AS Interest_Rate,
AVG(dti*100) AS DTI
FROM bank_loan_data
GROUP BY loan_status

Select loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status


/*BANK LOAN REPORT | OVERVIEW*/
SELECT MONTH(issue_date) AS Month_Number,
DATENAME(MONTH, issue_date) AS Month_name,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

/*State*/
SELECT address_state AS State,
Count(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state



/*TERM*/
SELECT term as Term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY term

/*EMPLOYEE LENGTH*/
SELECT emp_length AS Employee_Length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length


/*PURPOSE*/
SELECT purpose AS PURPOSE,
COUNT(id) as Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose



/*HOME OWNERSHIP*/
SELECT home_ownership AS Home_Ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership

/*purpose*/
SELECT purpose AS PURPOSE,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose

