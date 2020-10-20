-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Окт 20 2020 г., 08:14
-- Версия сервера: 10.3.22-MariaDB
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `editor`
--

CREATE TABLE `editor` (
  `e_id` int(11) NOT NULL,
  `editor` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `editor`
--

INSERT INTO `editor` (`e_id`, `editor`) VALUES
(1, 'добрый бухгалтер'),
(2, 'злой бухгалтер'),
(3, 'NULL');

-- --------------------------------------------------------

--
-- Структура таблицы `name`
--

CREATE TABLE `name` (
  `n_id` int(11) NOT NULL,
  `name1` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name2` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `surname` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `name`
--

INSERT INTO `name` (`n_id`, `name1`, `name2`, `surname`) VALUES
(1, 'Иван', 'Иванович', 'Иванов'),
(2, 'Петр', 'Петрович', 'Петров'),
(5, 'Сидор', 'Сидорович', 'Сидоров'),
(7, 'Василий', 'Васильевич', 'Васильев');

-- --------------------------------------------------------

--
-- Структура таблицы `position`
--

CREATE TABLE `position` (
  `p_id` int(11) NOT NULL,
  `position` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `salary` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `position`
--

INSERT INTO `position` (`p_id`, `position`, `salary`) VALUES
(1, 'начальник отдела ИТ', 30000),
(2, 'программист', 25000),
(3, 'администратор сети', 28000);

-- --------------------------------------------------------

--
-- Структура таблицы `salary`
--

CREATE TABLE `salary` (
  `s_ind` int(11) NOT NULL,
  `n_ind` int(11) NOT NULL,
  `e_ind` int(11) NOT NULL,
  `p_ind` int(11) NOT NULL,
  `zp` double DEFAULT NULL,
  `payroll` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `total_day` int(11) NOT NULL COMMENT 'отработано дней',
  `rk` float NOT NULL DEFAULT 1 COMMENT 'районный коэффицент',
  `pk` float NOT NULL COMMENT 'премиальные %'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `salary`
--

INSERT INTO `salary` (`s_ind`, `n_ind`, `e_ind`, `p_ind`, `zp`, `payroll`, `total_day`, `rk`, `pk`) VALUES
(1, 2, 3, 1, 115028.57, '2020-10-20 01:28:58', 14, 2, 22),
(2, 7, 3, 3, 52668, '2020-10-20 01:07:07', 20, 1.5, 14),
(3, 1, 3, 2, NULL, '2020-10-01 00:00:00', 15, 1, 1),
(4, 5, 3, 2, NULL, '2020-10-01 00:00:00', 22, 1, 1),
(5, 2, 3, 3, NULL, '2020-10-01 00:00:00', 22, 1, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `editor`
--
ALTER TABLE `editor`
  ADD PRIMARY KEY (`e_id`);

--
-- Индексы таблицы `name`
--
ALTER TABLE `name`
  ADD PRIMARY KEY (`n_id`);

--
-- Индексы таблицы `position`
--
ALTER TABLE `position`
  ADD PRIMARY KEY (`p_id`);

--
-- Индексы таблицы `salary`
--
ALTER TABLE `salary`
  ADD PRIMARY KEY (`s_ind`),
  ADD KEY `n_ind` (`n_ind`),
  ADD KEY `p_ind` (`p_ind`),
  ADD KEY `e_ind` (`e_ind`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `editor`
--
ALTER TABLE `editor`
  MODIFY `e_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `name`
--
ALTER TABLE `name`
  MODIFY `n_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `position`
--
ALTER TABLE `position`
  MODIFY `p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `salary`
--
ALTER TABLE `salary`
  MODIFY `s_ind` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `salary`
--
ALTER TABLE `salary`
  ADD CONSTRAINT `salary_ibfk_1` FOREIGN KEY (`e_ind`) REFERENCES `editor` (`e_id`),
  ADD CONSTRAINT `salary_ibfk_2` FOREIGN KEY (`n_ind`) REFERENCES `name` (`n_id`),
  ADD CONSTRAINT `salary_ibfk_3` FOREIGN KEY (`p_ind`) REFERENCES `position` (`p_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
