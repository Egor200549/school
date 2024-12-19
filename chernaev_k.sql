-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Дек 19 2024 г., 12:53
-- Версия сервера: 10.11.10-MariaDB-ubu2204
-- Версия PHP: 8.2.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `chernaev_k`
--

-- --------------------------------------------------------

--
-- Структура таблицы `access_status`
--

CREATE TABLE `access_status` (
  `id_access_status` int(11) NOT NULL,
  `status_name` varchar(255) NOT NULL,
  `status_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `access_status`
--

INSERT INTO `access_status` (`id_access_status`, `status_name`, `status_code`) VALUES
(1, 'Запрошено', 'requested'),
(2, 'Зачислен', 'enrolled'),
(3, 'Исключен', 'expelled');

-- --------------------------------------------------------

--
-- Структура таблицы `category`
--

CREATE TABLE `category` (
  `id_category` int(11) NOT NULL,
  `category_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `category`
--

INSERT INTO `category` (`id_category`, `category_name`, `created_at`, `updated_at`) VALUES
(1, 'Animals', '2024-11-26 21:13:15', NULL),
(2, 'Appearance', '2024-12-01 18:24:14', NULL),
(3, 'Body', '2024-12-01 18:24:14', NULL),
(4, 'Colors and Shapes', '2024-12-01 18:24:14', NULL),
(5, 'Clothes and Fashion', '2024-12-01 18:24:14', NULL),
(6, 'Linguistics', '2024-12-01 18:24:14', NULL),
(7, 'Arts and Crafts', '2024-12-01 18:24:14', NULL),
(8, 'Cinema and Theater', '2024-12-01 18:24:14', NULL),
(9, 'Literature', '2024-12-01 18:24:14', NULL),
(10, 'Music', '2024-12-01 18:24:14', NULL),
(11, 'Media and Communication', '2024-12-01 18:24:14', NULL),
(12, 'Foods and Drinks', '2024-12-01 18:24:14', NULL),
(13, 'Agreement and Disagreement', '2024-12-01 18:24:14', NULL),
(14, 'Opinion and Argument', '2024-12-01 18:24:14', NULL),
(15, 'Certainty and Doubt', '2024-12-01 18:24:14', NULL),
(16, 'Health and Sickness', '2024-12-01 18:24:14', NULL),
(17, 'Medical Science', '2024-12-01 18:24:14', NULL),
(18, 'Architecture', '2024-12-01 18:24:14', NULL),
(19, 'Games', '2024-12-01 18:24:14', NULL),
(20, 'Home and Garden', '2024-12-01 18:24:14', NULL),
(21, 'Education', '2024-12-01 18:24:14', NULL),
(22, 'Sports', '2024-12-01 18:24:14', NULL),
(23, 'Transportation', '2024-12-01 18:24:14', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `course`
--

CREATE TABLE `course` (
  `id_course` int(11) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_description` varchar(255) NOT NULL,
  `level_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `author` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `course`
--

INSERT INTO `course` (`id_course`, `course_name`, `course_description`, `level_id`, `category_id`, `author`, `created_at`, `updated_at`) VALUES
(2, 'Введение в английский язык', 'Курс для начинающих', 1, NULL, 16, '2024-12-09 10:44:51', NULL),
(3, 'Курс английского 2.0', 'Курс для продвинутых', 3, NULL, 16, '2024-12-09 11:17:42', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `course_access`
--

CREATE TABLE `course_access` (
  `id_course_access` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `status_id` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `course_access`
--

INSERT INTO `course_access` (`id_course_access`, `course_id`, `student`, `status_id`, `created_at`, `updated_at`) VALUES
(6, 2, 18, 2, '2024-12-18 12:19:12', '2024-12-18 09:21:24');

-- --------------------------------------------------------

--
-- Структура таблицы `done`
--

CREATE TABLE `done` (
  `id_done` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `st_answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`st_answer`)),
  `feedback` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `mark` int(11) DEFAULT NULL,
  `time_start` datetime NOT NULL,
  `time_end` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `done`
--

INSERT INTO `done` (`id_done`, `lesson_id`, `student`, `st_answer`, `feedback`, `mark`, `time_start`, `time_end`, `created_at`, `updated_at`) VALUES
(7, 8, 20, '{\"excercises\":[{\"id\":1,\"description\":\"Переведите письменно следующие предложения на английский язык:\",\"tasks\":[{\"question\":\"У меня есть (а) друг.\",\"st_answer\":\"Ответ студента\",\"maxScore\":1}],\"maxOverallScore\":7},{\"id\":2,\"description\":\"Поставьте в отрицательную форму следующие предложения на английском языке.\",\"tasks\":[{\"question\":\"У нас есть (а) дом.\",\"st_answer\":\"Ответ студента\",\"maxScore\":1}],\"maxOverallScore\":5},{\"id\":3,\"description\":\"Переведите письменно следующие предложения на английский язык.\",\"tasks\":[{\"question\":\"У твоей сестры много друзей? — Нет, у моей сестры не много друзей.\",\"st_answer\":\"Ответ студента\",\"maxScore\":1}],\"maxOverallScore\":12},{\"id\":4,\"description\":\"Описание задания 4\",\"tasks\":[{\"question\":\"Has your mother a new саг? (дайте положительный ответ)\",\"st_answer\":\"Ответ студента\",\"maxScore\":1}],\"maxOverallScore\":6}]}', '{\"excercises\":[{\"id\":1,\"description\":\"Переведите письменно следующие предложения на английский язык:\",\"tasks\":[{\"question\":\"У меня есть (а) друг.\",\"st_answer\":\"Ответ студента\",\"comment\":\"Комментарий преподавателя\",\"maxScore\":1,\"score\":1}],\"maxOverallScore\":7,\"overallScore\":7},{\"id\":2,\"description\":\"Поставьте в отрицательную форму следующие предложения на английском языке.\",\"tasks\":[{\"question\":\"У нас есть (а) дом.\",\"st_answer\":\"Ответ студента\",\"comment\":\"Комментарий преподавателя\",\"maxScore\":1,\"score\":1}],\"maxOverallScore\":5,\"overallScore\":5},{\"id\":3,\"description\":\"Переведите письменно следующие предложения на английский язык.\",\"tasks\":[{\"question\":\"У твоей сестры много друзей? — Нет, у моей сестры не много друзей.\",\"st_answer\":\"Ответ студента\",\"comment\":\"Комментарий преподавателя\",\"maxScore\":1,\"score\":1}],\"maxOverallScore\":12,\"overallScore\":12},{\"id\":4,\"description\":\"Описание задания 4\",\"tasks\":[{\"question\":\"Has your mother a new саг? (дайте положительный ответ)\",\"st_answer\":\"Ответ студента\",\"comment\":\"Комментарий преподавателя\",\"maxScore\":1,\"score\":1}],\"maxOverallScore\":6,\"overallScore\":6}]}', 5, '2024-12-18 11:46:21', '2024-12-18 11:46:21', '2024-12-18 14:46:21', '2024-12-18 11:48:12');

-- --------------------------------------------------------

--
-- Структура таблицы `lesson`
--

CREATE TABLE `lesson` (
  `id_lesson` int(11) NOT NULL,
  `lesson_number` int(11) NOT NULL,
  `lesson_name` varchar(255) NOT NULL,
  `lesson_description` varchar(255) NOT NULL,
  `lesson_body` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`lesson_body`)),
  `course_id` int(11) NOT NULL,
  `lesson_status` int(11) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `lesson`
--

INSERT INTO `lesson` (`id_lesson`, `lesson_number`, `lesson_name`, `lesson_description`, `lesson_body`, `course_id`, `lesson_status`, `created_at`, `updated_at`) VALUES
(8, 4, 'Название урока', 'Описание урока', '{\"lesson_words\":[{\"id\":1,\"word\":\"and\",\"transcription\":\"[and]\",\"translation\":\"а, и\"},{\"id\":2,\"word\":\"must\",\"transcription\":\"[mʌst]\",\"translation\":\"должен\"},{\"id\":3,\"word\":\"go\",\"transcription\":\"[gəʊ]\",\"translation\":\"идти\"},{\"id\":4,\"word\":\"have\",\"transcription\":\"[hæv]\",\"translation\":\"иметь\"},{\"id\":5,\"word\":\"picture\",\"transcription\":\"ˈpɪkʧə\",\"translation\":\"картина\"},{\"id\":6,\"word\":\"like\",\"transcription\":\"[laɪk]\",\"translation\":\"любить, нравиться\"},{\"id\":7,\"word\":\"boy\",\"transcription\":\"[bɔɪ]\",\"translation\":\"мальчик\"},{\"id\":8,\"word\":\"many\",\"transcription\":\"[ˈmenɪ]\",\"translation\":\"много\"},{\"id\":9,\"word\":\"milk\",\"transcription\":\"[mɪlk]\",\"translation\":\"молоко\"},{\"id\":10,\"word\":\"but\",\"transcription\":\"[bʌt]\",\"translation\":\"но\"},{\"id\":11,\"word\":\"sugar\",\"transcription\":\"[ˈʃʊgə]\",\"translation\":\"сахар\"},{\"id\":12,\"word\":\"now\",\"transcription\":\"[nau]\",\"translation\":\"сейчас\"},{\"id\":13,\"word\":\"dog\",\"transcription\":\"[dɒg]\",\"translation\":\"собака\"},{\"id\":14,\"word\":\"three\",\"transcription\":\"[θriː]\",\"translation\":\"три\"},{\"id\":14,\"word\":\"flower\",\"transcription\":\"[ˈflaʊə]\",\"translation\":\"цветок\"}],\"partOne\":{\"head\":\"Глагол to have (have got) - иметь\",\"text\":\"Рассмотрим спряжение глагола to have ( got ) в настоящем простом времени…\",\"theory\":\"Форма have got является разговорным эквивалентом глагола have.\",\"additionalText\":\"\",\"additionalTheory\":\"\",\"exercise\":{\"id\":1,\"description\":\"Переведите письменно следующие предложения на английский язык:\",\"tasks\":[{\"question\":\"У меня есть (а) друг.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У него есть (а) друг.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У Кати есть (а) цветок.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас есть (д) большая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) маленькая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У вас есть молоко.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У моей бабушки есть много книг.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":7}},\"partTwo\":{\"head\":\"ОБРАЗОВАНИЕ ОТРИЦАНИЯ\",\"text\":\"Отрицательное предложение образуется путем…\",\"exercise\":{\"id\":2,\"description\":\"Поставьте в отрицательную форму следующие предложения на английском языке.\",\"tasks\":[{\"question\":\"У нас есть (а) дом.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У Кати есть (а) красная машина.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас есть много друзей.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) черный кот.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У моих друзей есть (а) картина.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":5}},\"partThree\":{\"head\":\"ОБРАЗОВАНИЕ ВОПРОСА\",\"text\":\"Вопросительное предложение образуется путем …\",\"exercises\":[{\"id\":3,\"description\":\"Переведите письменно следующие предложения на английский язык.\",\"tasks\":[{\"question\":\"У твоей сестры много друзей? — Нет, у моей сестры не много друзей.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эти чашки зеленые? — Нет, они не зеленые, они синие.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\" У твоего друга есть (а) синяя машина? — Нет, у него нет (а) синей машины, у него есть (а) желтая машина.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эти книги интересные? — Нет, они не интересные. — А те книги интересные? — Да, те книги интересные.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Какая у них собака? — У них (а) большая белая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) кот? — Нет, у них нет (а) кота.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эта собака не маленькая, эта собака большая.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У твоего сына много игрушек? — Нет, у него не много игрушек.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Тот дом высокий? - Нет, тот дом не высокий.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Те дома высокие.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас много высоких домов в (in) (the) городе.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У вас есть высокие дома в (in) (the) городе? — Нет, у нас нет высоких домов в (in) (the) городе.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":12},{\"id\":4,\"description\":\"Описание задания 4\",\"tasks\":[{\"question\":\"Has your mother a new саг? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Is this a red pen? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Have you got a cat? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Have you many friends? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Is this pen red? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Are those houses white? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":6}]},\"reading\":{\"head\":\"Диалог\",\"task\":\"Прочитайте диалог.\",\"title\":\"Знакомство\",\"author\":\"\",\"text\":\"— Good morning.\\n— Morning.\\n— How are you?\\n— I am all right. And you?\\n— I am fine, too. What is your name?\\n— My name is Anna. And what is your name?\\n— My name is Tom. Nice to meet you, Anna. Where are you from?\\n— I am from London. And you?\\n— I am from New York. How old are you?\\n— I am 16 years old. And you?\\n— I am 17. Have you got a brother or a sister?\\n— I\'ve got a sister, but I haven\'t got a brother.\\n— How old is your sister?\\n— My sister is 19 years old.\\n— What is her name?\\n— Her name is Tanya.\\n— What does she do?\\n— She is a student.\\n— Very nice. OK. I must go now.\\n— OK. See you later.\\n— Bye.\"},\"dictionary\":[]}', 2, 2, '2024-12-16 16:59:28', '2024-12-18 11:44:40'),
(10, 5, 'Название урока', 'Описание урока', '{\"lesson_words\":[{\"id\":1,\"word\":\"and\",\"transcription\":\"[and]\",\"translation\":\"а, и\"},{\"id\":2,\"word\":\"must\",\"transcription\":\"[mʌst]\",\"translation\":\"должен\"},{\"id\":3,\"word\":\"go\",\"transcription\":\"[gəʊ]\",\"translation\":\"идти\"},{\"id\":4,\"word\":\"have\",\"transcription\":\"[hæv]\",\"translation\":\"иметь\"},{\"id\":5,\"word\":\"picture\",\"transcription\":\"ˈpɪkʧə\",\"translation\":\"картина\"},{\"id\":6,\"word\":\"like\",\"transcription\":\"[laɪk]\",\"translation\":\"любить, нравиться\"},{\"id\":7,\"word\":\"boy\",\"transcription\":\"[bɔɪ]\",\"translation\":\"мальчик\"},{\"id\":8,\"word\":\"many\",\"transcription\":\"[ˈmenɪ]\",\"translation\":\"много\"},{\"id\":9,\"word\":\"milk\",\"transcription\":\"[mɪlk]\",\"translation\":\"молоко\"},{\"id\":10,\"word\":\"but\",\"transcription\":\"[bʌt]\",\"translation\":\"но\"},{\"id\":11,\"word\":\"sugar\",\"transcription\":\"[ˈʃʊgə]\",\"translation\":\"сахар\"},{\"id\":12,\"word\":\"now\",\"transcription\":\"[nau]\",\"translation\":\"сейчас\"},{\"id\":13,\"word\":\"dog\",\"transcription\":\"[dɒg]\",\"translation\":\"собака\"},{\"id\":14,\"word\":\"three\",\"transcription\":\"[θriː]\",\"translation\":\"три\"},{\"id\":14,\"word\":\"flower\",\"transcription\":\"[ˈflaʊə]\",\"translation\":\"цветок\"}],\"partOne\":{\"head\":\"Глагол to have (have got) - иметь\",\"text\":\"Рассмотрим спряжение глагола to have ( got ) в настоящем простом времени…\",\"theory\":\"Форма have got является разговорным эквивалентом глагола have.\",\"additionalText\":\"\",\"additionalTheory\":\"\",\"exercise\":{\"id\":1,\"description\":\"Переведите письменно следующие предложения на английский язык:\",\"tasks\":[{\"question\":\"У меня есть (а) друг.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У него есть (а) друг.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У Кати есть (а) цветок.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас есть (д) большая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) маленькая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У вас есть молоко.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У моей бабушки есть много книг.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":7}},\"partTwo\":{\"head\":\"ОБРАЗОВАНИЕ ОТРИЦАНИЯ\",\"text\":\"Отрицательное предложение образуется путем…\",\"exercise\":{\"id\":2,\"description\":\"Поставьте в отрицательную форму следующие предложения на английском языке.\",\"tasks\":[{\"question\":\"У нас есть (а) дом.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У Кати есть (а) красная машина.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас есть много друзей.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) черный кот.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У моих друзей есть (а) картина.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":5}},\"partThree\":{\"head\":\"ОБРАЗОВАНИЕ ВОПРОСА\",\"text\":\"Вопросительное предложение образуется путем …\",\"exercises\":[{\"id\":3,\"description\":\"Переведите письменно следующие предложения на английский язык.\",\"tasks\":[{\"question\":\"У твоей сестры много друзей? — Нет, у моей сестры не много друзей.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эти чашки зеленые? — Нет, они не зеленые, они синие.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\" У твоего друга есть (а) синяя машина? — Нет, у него нет (а) синей машины, у него есть (а) желтая машина.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эти книги интересные? — Нет, они не интересные. — А те книги интересные? — Да, те книги интересные.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Какая у них собака? — У них (а) большая белая собака.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У них есть (а) кот? — Нет, у них нет (а) кота.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Эта собака не маленькая, эта собака большая.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У твоего сына много игрушек? — Нет, у него не много игрушек.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Тот дом высокий? - Нет, тот дом не высокий.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Те дома высокие.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У нас много высоких домов в (in) (the) городе.\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"У вас есть высокие дома в (in) (the) городе? — Нет, у нас нет высоких домов в (in) (the) городе.\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":12},{\"id\":4,\"description\":\"Описание задания 4\",\"tasks\":[{\"question\":\"Has your mother a new саг? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Is this a red pen? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Have you got a cat? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Have you many friends? (дайте положительный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Is this pen red? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1},{\"question\":\"Are those houses white? (дайте отрицательный ответ)\",\"answer\":\"\",\"maxScore\":1}],\"maxOverallScore\":6}]},\"reading\":{\"head\":\"Диалог\",\"task\":\"Прочитайте диалог.\",\"title\":\"Знакомство\",\"author\":\"\",\"text\":\"— Good morning.\\n— Morning.\\n— How are you?\\n— I am all right. And you?\\n— I am fine, too. What is your name?\\n— My name is Anna. And what is your name?\\n— My name is Tom. Nice to meet you, Anna. Where are you from?\\n— I am from London. And you?\\n— I am from New York. How old are you?\\n— I am 16 years old. And you?\\n— I am 17. Have you got a brother or a sister?\\n— I\'ve got a sister, but I haven\'t got a brother.\\n— How old is your sister?\\n— My sister is 19 years old.\\n— What is her name?\\n— Her name is Tanya.\\n— What does she do?\\n— She is a student.\\n— Very nice. OK. I must go now.\\n— OK. See you later.\\n— Bye.\"},\"dictionary\":[]}', 2, 1, '2024-12-18 14:42:07', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `lesson_status`
--

CREATE TABLE `lesson_status` (
  `id_status` int(11) NOT NULL,
  `status_code` varchar(255) NOT NULL,
  `status_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `lesson_status`
--

INSERT INTO `lesson_status` (`id_status`, `status_code`, `status_name`) VALUES
(1, 'unpublished', 'неопубликованный'),
(2, 'published', 'опубликованный');

-- --------------------------------------------------------

--
-- Структура таблицы `level`
--

CREATE TABLE `level` (
  `id_level` int(11) NOT NULL,
  `level_code` varchar(255) NOT NULL,
  `level_title` varchar(255) NOT NULL,
  `level_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `level`
--

INSERT INTO `level` (`id_level`, `level_code`, `level_title`, `level_name`) VALUES
(1, 'A1', 'Beginner', 'Начальный уровень'),
(2, 'A2', 'Elementary', 'Элементарный уровень'),
(3, 'B1', 'Pre-Intermediate', 'Уровень ниже среднего'),
(4, 'B2', 'Intermediate', 'Средний уровень'),
(5, 'C1', 'Upper-Intermediate', 'Уровень выше среднего'),
(6, 'C2', 'Advanced', 'Продвинутый уровень');

-- --------------------------------------------------------

--
-- Структура таблицы `role`
--

CREATE TABLE `role` (
  `id_role` int(11) NOT NULL,
  `role_code` varchar(255) NOT NULL,
  `role_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `role`
--

INSERT INTO `role` (`id_role`, `role_code`, `role_name`) VALUES
(1, 'student', 'Ученик'),
(2, 'teacher', 'Преподаватель'),
(3, 'admin', 'Администратор');

-- --------------------------------------------------------

--
-- Структура таблицы `user`
--

CREATE TABLE `user` (
  `id_user` int(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `level_id` int(11) DEFAULT NULL,
  `role_id` int(255) NOT NULL DEFAULT 1,
  `token` varchar(255) DEFAULT NULL,
  `check_email` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `user`
--

INSERT INTO `user` (`id_user`, `first_name`, `last_name`, `middle_name`, `phone`, `email`, `password`, `photo`, `level_id`, `role_id`, `token`, `check_email`, `created_at`, `updated_at`) VALUES
(16, 'Иван', 'Петров', 'Иванович', '+79112345678', 'newmail@user.ru', '$2y$13$IcGdn9uJYu3RLKm5RwogaOLSAvoXH14RvGE.4ufr3J8Tvt9ZubRA6', NULL, NULL, 2, 'CruAepiG4mnX7MZSDfo0NQzUVjm5FUSo', 0, '2024-12-04 12:06:38', NULL),
(18, 'Павел', 'Павлов', 'Павлович', '+79998887744', 'pavlov@email.com', '$2y$13$PszqwV4aYkqHZk9Foj1Q5e3r07pJP9k8.wQmW2HyuA6KWoFgAxWNK', NULL, 1, 1, 'qQ0DH9ZxPtVeGxIi58qnJdix6Ggqm2lf', 0, '2024-12-09 13:47:53', NULL),
(19, 'Алексей', 'Алексеев', 'Алексеевич', '+73336665544', 'alekseev@email.com', '$2y$13$O.dkUfJ2EAWVa9A/u/IsOuTwt6rQvVyDv8rCW/8YS7tneY2RY9luO', NULL, NULL, 1, '1nYRI0h2VOYiHnERxsdNaNnnR6B1wSpX', 0, '2024-12-09 13:52:02', NULL),
(20, 'Евгений', 'Смирнов', 'Евгеньевич', '+71245558800', 'smirnov@email.com', '$2y$13$vIciRGPdc57e0f0SKgmiRu07cSXwwTdy3t5gBh8DgAVmLePCfR80i', NULL, NULL, 1, 'Fb7El04hNeWpFvEix6vzVqrZDZW1cBA-', 0, '2024-12-10 11:35:12', NULL),
(22, 'Сергей', 'Андреев', 'Евгеньевич', '+71245558800', 'admin@email.com', '$2y$13$eb/u.kfYWiB7IlIzGSAjUug/ID8sU/wZyGEsoVLPtYFz/AGe8nIHu', NULL, NULL, 3, 'DePq60hGXbSHJci9MpY4WRBon-H26hBe', 0, '2024-12-18 12:09:57', NULL);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `access_status`
--
ALTER TABLE `access_status`
  ADD PRIMARY KEY (`id_access_status`);

--
-- Индексы таблицы `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id_category`);

--
-- Индексы таблицы `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`id_course`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `course_ibfk_4` (`level_id`),
  ADD KEY `course_ibfk_3` (`author`);

--
-- Индексы таблицы `course_access`
--
ALTER TABLE `course_access`
  ADD PRIMARY KEY (`id_course_access`),
  ADD KEY `course_id` (`course_id`),
  ADD KEY `user_id` (`student`),
  ADD KEY `status_id` (`status_id`);

--
-- Индексы таблицы `done`
--
ALTER TABLE `done`
  ADD PRIMARY KEY (`id_done`),
  ADD KEY `lesson_id` (`lesson_id`),
  ADD KEY `user_id` (`student`);

--
-- Индексы таблицы `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`id_lesson`),
  ADD KEY `lesson_status` (`lesson_status`),
  ADD KEY `lesson_ibfk_1` (`course_id`);

--
-- Индексы таблицы `lesson_status`
--
ALTER TABLE `lesson_status`
  ADD PRIMARY KEY (`id_status`);

--
-- Индексы таблицы `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id_level`);

--
-- Индексы таблицы `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id_role`);

--
-- Индексы таблицы `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `user_ibfk_4` (`level_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `access_status`
--
ALTER TABLE `access_status`
  MODIFY `id_access_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `category`
--
ALTER TABLE `category`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `course`
--
ALTER TABLE `course`
  MODIFY `id_course` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `course_access`
--
ALTER TABLE `course_access`
  MODIFY `id_course_access` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `done`
--
ALTER TABLE `done`
  MODIFY `id_done` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `lesson`
--
ALTER TABLE `lesson`
  MODIFY `id_lesson` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `lesson_status`
--
ALTER TABLE `lesson_status`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `level`
--
ALTER TABLE `level`
  MODIFY `id_level` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `role`
--
ALTER TABLE `role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `course`
--
ALTER TABLE `course`
  ADD CONSTRAINT `course_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id_category`),
  ADD CONSTRAINT `course_ibfk_3` FOREIGN KEY (`author`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_ibfk_4` FOREIGN KEY (`level_id`) REFERENCES `level` (`id_level`);

--
-- Ограничения внешнего ключа таблицы `course_access`
--
ALTER TABLE `course_access`
  ADD CONSTRAINT `course_access_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id_course`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_access_ibfk_2` FOREIGN KEY (`student`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `course_access_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `access_status` (`id_access_status`);

--
-- Ограничения внешнего ключа таблицы `done`
--
ALTER TABLE `done`
  ADD CONSTRAINT `done_ibfk_1` FOREIGN KEY (`lesson_id`) REFERENCES `lesson` (`id_lesson`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `done_ibfk_2` FOREIGN KEY (`student`) REFERENCES `user` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `lesson`
--
ALTER TABLE `lesson`
  ADD CONSTRAINT `lesson_ibfk_1` FOREIGN KEY (`course_id`) REFERENCES `course` (`id_course`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `lesson_ibfk_2` FOREIGN KEY (`lesson_status`) REFERENCES `lesson_status` (`id_status`);

--
-- Ограничения внешнего ключа таблицы `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_3` FOREIGN KEY (`role_id`) REFERENCES `role` (`id_role`),
  ADD CONSTRAINT `user_ibfk_4` FOREIGN KEY (`level_id`) REFERENCES `level` (`id_level`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
