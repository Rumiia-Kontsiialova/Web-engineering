/* 1. Вывести id департамента , в котором работает сотрудник, в зависимости от Id сотрудника */

SELECT department_id
FROM employees
WHERE id = id;

/* 2. Создайте хранимую процедуру get_employee_age, которая принимает id сотрудника (IN-параметр) и возвращает его возраст через OUT-параметр. */

DELIMITER //

CREATE PROCEDURE get_employee_age (
    IN emp_id INT,
    OUT emp_age INT
)
BEGIN
    SELECT age
    INTO emp_age
    FROM employees
    WHERE id = emp_id;
END;
//

DELIMITER ;

/* 3. Создайте хранимую процедуру increase_salary, которая принимает зарплату сотрудника (INOUT-параметр) и уменьшает ее на 10% */

DELIMITER //

CREATE PROCEDURE increase_salary (
    INOUT salary DOUBLE
)
BEGIN
    SET salary = salary * 0.9;
END;
//

DELIMITER ;
