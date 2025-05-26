/* 1. Подключитесь к своей базе данных созданной на уроке */

USE 131224_Kontsiialova;

/* 2. Создайте таблицу, которая отражает погоду в Вашем городе за последние 5 дней 
и включает следующее столбцы:
Id - первичный ключ, заполняется автоматически
Дата - не может быть пропуском
Дневная температура - целое число, принимает значения от -30 до 30
Ночная температура - целое число, принимает значения от -30 до 30
Скорость ветра - подумайте какой тип данных и ограничения необходимы для этого столбца */

CREATE TABLE weather (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    day_temp INT CHECK(day_temp BETWEEN -30 AND 30),
    night_temp INT CHECK(night_temp BETWEEN -30 AND 30),
    wind_speed DECIMAL(4, 1) CHECK(wind_speed >= 0)
);

/* 3. Заполните таблицу 5 строками - за последние 5 дней */

INSERT INTO weather (date, day_temp, night_temp, wind_speed)
VALUES
(CURDATE() - INTERVAL 4 DAY, 12, 4, 3.0),
(CURDATE() - INTERVAL 3 DAY, 15, 10, 5.0),
(CURDATE() - INTERVAL 2 DAY, 16, 8, 12.0),
(CURDATE() - INTERVAL 1 DAY, 10, 10, 7.0),
(CURDATE(), 17, 5, 13.0);

/* 4. Увеличьте значения ночной температуры на градус если скорость ветра не превышала 10 м/с */

UPDATE weather 
SET 
    night_temp = night_temp + 1
WHERE
    wind_speed <= 10.0;

/* 5. На основе полученной таблицы создайте представление в своей базе данных - включите все строки 
Вашей таблицы и дополнительно рассчитанные столбцы
Средняя суточная температура - среднее арифметическое между ночной и дневной температурами
Столбец на основе скорости ветра - если скорость ветра не превышала 5 м/с то значение ‘штиль’, 
от 6 включительно до 10 - ‘умеренный ветер’, в остальных случаях - ‘сильный ветер’ */
DROP VIEW IF EXISTS weather_view;
CREATE VIEW weather_view AS
SELECT 
	*, 
	(day_temp + night_temp) / 2.0 AS avg_temp,
	CASE WHEN wind_speed <= 5 THEN 'штиль'
		 WHEN wind_speed >5 AND wind_speed <= 10 THEN 'умеренный ветер'
		 ELSE 'сильный ветер'
	END AS wind_description
FROM weather;