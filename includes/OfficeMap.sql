-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 12 2020 г., 22:56
-- Версия сервера: 5.7.20-log
-- Версия PHP: 7.0.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `OfficeMap`
--

-- --------------------------------------------------------

--
-- Структура таблицы `desks`
--

CREATE TABLE `desks` (
  `id` int(8) UNSIGNED NOT NULL,
  `image` enum('angled.png','rectangled.png') DEFAULT NULL,
  `id_floor` int(8) UNSIGNED NOT NULL,
  `id_employee` int(8) UNSIGNED NOT NULL,
  `x` int(10) NOT NULL DEFAULT '0',
  `y` int(10) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `desks`
--

INSERT INTO `desks` (`id`, `image`, `id_floor`, `id_employee`, `x`, `y`) VALUES
(1, 'rectangled.png', 1, 1, 25, 20),
(2, 'angled.png', 1, 2, 25, 0),
(3, 'rectangled.png', 1, 3, 45, 20),
(4, 'rectangled.png', 1, 4, 45, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `id` int(8) UNSIGNED NOT NULL,
  `surname` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `patronymic` varchar(30) DEFAULT NULL,
  `post` enum('Директор','Программист','Тестировщик','Аналитик') NOT NULL COMMENT 'Должность',
  `image` varchar(100) NOT NULL DEFAULT '1.jpg',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `status` enum('Работает','В отпуске','Болеет','Командировка') DEFAULT 'Работает' COMMENT 'Статус работника',
  `email` varchar(60) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `post`, `image`, `phone`, `status`, `email`, `password`) VALUES
(1, 'Зиновьев', 'Бронислав ', 'Анатольевич', 'Программист', '1.jpg', '7(495)870-78-64', 'Работает', 'aojv@mail.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(2, 'Лазарев ', 'Дональд ', 'Викторович', 'Директор', '1.jpg', '7(495)933-15-61', 'В отпуске', 'kggfpxw@yandex.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(3, 'Устинов ', 'Архип ', 'Владимирович', 'Аналитик', '1.jpg', '7(495)331-04-03', 'Работает', 'oxxv@yandex.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(4, 'Панов ', 'Яков ', 'Лукьянович', 'Тестировщик', '1.jpg', '7(495)723-99-98', 'Болеет', 'f9jxjd14@gmail.com', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(5, 'Мельников ', 'Платон ', 'Михаилович', 'Программист', '1.jpg', '7(495)795-65-95', 'Болеет', 'p24a@mail.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6');

-- --------------------------------------------------------

--
-- Структура таблицы `floors`
--

CREATE TABLE `floors` (
  `id` int(8) UNSIGNED NOT NULL,
  `floor` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `floors`
--

INSERT INTO `floors` (`id`, `floor`) VALUES
(1, '1 этаж');

-- --------------------------------------------------------

--
-- Структура таблицы `floor_coordinates`
--

CREATE TABLE `floor_coordinates` (
  `id` int(8) UNSIGNED NOT NULL,
  `x` int(8) NOT NULL,
  `y` int(8) NOT NULL,
  `id_floor` int(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `floor_coordinates`
--

INSERT INTO `floor_coordinates` (`id`, `x`, `y`, `id_floor`) VALUES
(1, -90, -80, 1),
(2, -85, -80, 1),
(3, -35, -80, 1),
(4, -35, -75, 1),
(5, 100, -75, 1),
(6, 100, -80, 1),
(7, 160, -80, 1),
(8, 160, 40, 1),
(9, 90, 40, 1),
(10, 90, 35, 1),
(11, -110, 35, 1),
(12, -110, 30, 1),
(13, -130, 30, 1),
(14, -130, 0, 1),
(15, -125, 0, 1),
(16, -125, 25, 1),
(17, -105, 25, 1),
(18, -105, 30, 1),
(19, 95, 30, 1),
(20, 95, 35, 1),
(21, 155, 35, 1),
(22, 155, -75, 1),
(23, 105, -75, 1),
(24, 105, -70, 1),
(25, -40, -70, 1),
(26, -40, -75, 1),
(27, -87, -75, 1),
(28, -125, 0, 1),
(29, -130, 0, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `rooms`
--

CREATE TABLE `rooms` (
  `id` int(8) UNSIGNED NOT NULL,
  `room` varchar(30) NOT NULL,
  `description` varchar(100) NOT NULL,
  `id_floor` int(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `rooms`
--

INSERT INTO `rooms` (`id`, `room`, `description`, `id_floor`) VALUES
(1, 'R1', '576', 1),
(2, 'R2', '576', 1),
(3, 'R3', '412', 1),
(4, 'R4', '412', 1),
(5, 'R5', '412', 1),
(6, 'R6', '412', 1),
(7, 'R7', '412', 1),
(8, 'Stairs', '257', 1),
(9, 'R8', '412', 1),
(10, 'R9', '412', 1),
(11, 'R10', '412', 1),
(12, 'R11', '412', 1),
(13, 'R12', '412', 1),
(14, 'R13', '412', 1),
(15, 'R14', '412', 1),
(16, 'R15', '412', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `room_coordinates`
--

CREATE TABLE `room_coordinates` (
  `id` int(8) UNSIGNED NOT NULL,
  `x` int(10) NOT NULL,
  `y` int(10) NOT NULL,
  `id_room` int(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `room_coordinates`
--

INSERT INTO `room_coordinates` (`id`, `x`, `y`, `id_room`) VALUES
(1, 125, -15, 1),
(2, 125, 35, 1),
(3, 155, 35, 1),
(4, 155, -15, 1),
(5, 95, -15, 2),
(6, 95, 35, 2),
(7, 125, 35, 2),
(8, 125, -15, 2),
(9, 55, -15, 3),
(10, 55, 30, 3),
(11, 95, 30, 3),
(12, 95, -15, 3),
(13, 15, -15, 4),
(14, 15, 30, 4),
(15, 55, 30, 4),
(16, 55, -15, 4),
(17, -25, -15, 5),
(18, -25, 30, 5),
(19, 15, 30, 5),
(20, 15, -15, 5),
(21, -65, -15, 6),
(22, -65, 30, 6),
(23, -25, 30, 6),
(24, -25, -15, 6),
(25, -105, -15, 7),
(26, -105, 30, 7),
(27, -65, 30, 7),
(28, -65, -15, 7),
(29, -125, 0, 8),
(30, -125, 25, 8),
(31, -105, 25, 8),
(32, -105, -15, 8),
(33, -110, -30, 9),
(34, -88, -75, 9),
(35, -65, -75, 9),
(36, -65, -30, 9),
(37, -65, -30, 10),
(38, -65, -75, 10),
(39, -40, -75, 10),
(40, -40, -30, 10),
(41, -40, -30, 11),
(42, -40, -70, 11),
(43, 0, -70, 11),
(44, 0, -30, 11),
(45, 0, -30, 12),
(46, 0, -70, 12),
(47, 40, -70, 12),
(48, 40, -30, 12),
(49, 40, -30, 13),
(50, 40, -70, 13),
(51, 80, -70, 13),
(52, 80, -30, 13),
(53, 80, -30, 14),
(54, 80, -70, 14),
(55, 105, -70, 14),
(56, 105, -30, 14),
(57, 105, -30, 15),
(58, 105, -75, 15),
(59, 130, -75, 15),
(60, 130, -30, 15),
(61, 130, -30, 16),
(62, 130, -75, 16),
(63, 155, -75, 16),
(64, 155, -30, 16);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `desks`
--
ALTER TABLE `desks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_floor` (`id_floor`),
  ADD KEY `id_employee` (`id_employee`);

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `floors`
--
ALTER TABLE `floors`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `floor_coordinates`
--
ALTER TABLE `floor_coordinates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_object` (`id_floor`);

--
-- Индексы таблицы `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD KEY `rooms_ibfk_1` (`id_floor`);

--
-- Индексы таблицы `room_coordinates`
--
ALTER TABLE `room_coordinates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rooms` (`id_room`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `desks`
--
ALTER TABLE `desks`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `floors`
--
ALTER TABLE `floors`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `floor_coordinates`
--
ALTER TABLE `floor_coordinates`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT для таблицы `room_coordinates`
--
ALTER TABLE `room_coordinates`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `desks`
--
ALTER TABLE `desks`
  ADD CONSTRAINT `desks_ibfk_1` FOREIGN KEY (`id_floor`) REFERENCES `floors` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `desks_ibfk_2` FOREIGN KEY (`id_employee`) REFERENCES `employees` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `floor_coordinates`
--
ALTER TABLE `floor_coordinates`
  ADD CONSTRAINT `floor_coordinates_ibfk_1` FOREIGN KEY (`id_floor`) REFERENCES `floors` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`id_floor`) REFERENCES `floors` (`id`) ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `room_coordinates`
--
ALTER TABLE `room_coordinates`
  ADD CONSTRAINT `room_coordinates_ibfk_1` FOREIGN KEY (`id_room`) REFERENCES `rooms` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
