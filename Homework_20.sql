USE hr;

/* Выведите количество сотрудников в базе */
SELECT 
COUNT(employee_id) AS count_employee
FROM employees;

/* Выведите количество департаментов (отделов) в базе */
SELECT department_id,
COUNT(*) AS count_department
FROM employees
GROUP BY department_id;

/* подключение к базу данных World */
USE world;
SELECT * FROM city;

/* Выведите среднее население в городах Индии (таблица City, код Индии - IND) */
SELECT CountryCode,
AVG(Population) AS avg_population_in_IND
FROM city
WHERE CountryCode= "IND";

/* Выведите минимальное население в индийском городе и максимальное. */
SELECT MIN(Population) AS min_population_in_INDIA
FROM city
WHERE CountryCode= "IND";

/* Выведите самую большую площадь территории. */
SELECT * FROM country c;

SELECT Region,
MAX(SurfaceArea) max_area_by_country
FROM country;

/* Выведите среднюю продолжительность жизни по странам */
SELECT Name,
AVG(LifeExpectancy) AS avg_age_by_country
FROM country
GROUP BY Name;

/* Найдите самый населенный город (подсказка: использовать подзапросы) */
SELECT * FROM city;
SELECT Name, Population
FROM city
WHERE Population = (
	SELECT MAX(Population)
	FROM city
);

-- без подзапроса
SELECT Name, Population
FROM city
ORDER BY Population DESC
LIMIT 1;
