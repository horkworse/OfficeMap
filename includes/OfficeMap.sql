-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 24 2020 г., 19:44
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
-- Структура таблицы `employees`
--

CREATE TABLE `employees` (
  `id` int(8) UNSIGNED NOT NULL,
  `surname` varchar(30) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `patronymic` varchar(30) DEFAULT NULL,
  `post` enum('Директор','Программист','Тестировщик','Аналитик') NOT NULL COMMENT 'Должность',
  `social` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL DEFAULT '1.jpg',
  `phone` varchar(20) NOT NULL DEFAULT '',
  `status` enum('Работает','В отпуске','Болеет','Командировка') DEFAULT 'Работает' COMMENT 'Статус работника',
  `email` varchar(60) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `employees`
--

INSERT INTO `employees` (`id`, `surname`, `name`, `patronymic`, `post`, `social`, `image`, `phone`, `status`, `email`, `password`) VALUES
(1, 'Зиновьев', 'Бронислав ', 'Анатольевич', 'Программист', '@aojv', 'default.png', '7(495)870-78-64', 'Работает', 'aojv@mail.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(2, 'Лазарев ', 'Дональд ', 'Викторович', 'Директор', '@kggfpxw', 'default.png', '7(495)933-15-61', 'В отпуске', 'kggfpxw@yandex.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(3, 'Устинов ', 'Архип ', 'Владимирович', 'Аналитик', '@oxxv', 'default.png', '7(495)331-04-03', 'Работает', 'oxxv@yandex.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(4, 'Панов ', 'Яков ', 'Лукьянович', 'Тестировщик', '@f9jxjd14', 'default.png', '7(495)723-99-98', 'Болеет', 'f9jxjd14@gmail.com', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6'),
(5, 'Мельников ', 'Платон ', 'Михаилович', 'Программист', '@p24a', 'default.png', '7(495)795-65-95', 'Болеет', 'p24a@mail.ru', '$2y$10$qCzTSyZNZgbF0E307esJx.XMt6PLre2f2VbiNeaTsl.6b.kvovyK6');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `employees`
--
ALTER TABLE `employees`
  ADD UNIQUE KEY `id` (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
