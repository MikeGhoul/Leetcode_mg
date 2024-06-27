SQL QUESTION 7: What do stored procedures do?
Stored procedures are a lot like functions in programming. 
Theyre used to encapsulate and organize business logic into one unit of code, 
and they can accept multiple input parameters and return multiple output values.

For example, if you were a Data Analyst at Google working on a HR analytics project, 
you might create a stored procedure to calculate the average salary for a given department:


# Example of a stored procedure:
CREATE FUNCTION get_avg_salary(department_name TEXT)
RETURNS NUMERIC AS
$BODY$
BEGIN
  RETURN (SELECT AVG(salary) FROM google_employees WHERE department = department_name);
END;
$BODY$
LANGUAGE 'plpgsql';

#To call this stored procedure and find the average salary for the Data Analytics department you'd write the following query:

SELECT get_avg_salary('Data Analytics');


# Answer from ChatGPT:

Stored procedures in SQL are precompiled SQL code that you can save, reuse, and execute on demand. They are stored on the database server and can be called by applications, other stored procedures, or by users directly.

Here is what stored procedures can do:

Encapsulate Logic: Stored procedures allow you to encapsulate complex SQL logic, 
business rules, or calculations into a single unit. 
This helps improve code modularity, readability, and maintenance.

Promote Reusability: Once created, stored procedures can be reused across multiple applications 
or modules within a database. This reduces code duplication and promotes consistency.

Enhance Security: Stored procedures can provide a security layer by allowing controlled access to database objects. 
Users can be granted permissions to execute specific stored procedures without directly accessing underlying tables or views.

Improve Performance: Stored procedures can enhance performance by reducing network traffic. 
Since the entire procedure is executed on the database server, only the results are sent back to the client, 
rather than sending multiple SQL statements over the network.

Transaction Management: Stored procedures can include transaction management commands to ensure data integrity. 
They can begin, commit, or roll back transactions, allowing for complex operations to be performed atomically.

Parameterized Execution: Stored procedures support parameterized execution, allowing you to pass input parameters to the procedure. 
This enables dynamic query generation and customization based on user input or application requirements.

Reduce Code Complexity: By moving complex SQL queries and business logic into stored procedures, application code can be simplified. 
This separation of concerns makes the application easier to develop, debug, and maintain.

Overall, stored procedures offer a powerful mechanism for implementing business logic and database operations in a centralized and efficient manner within a relational database management system (RDBMS).

