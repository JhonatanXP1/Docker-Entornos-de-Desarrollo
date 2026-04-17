-- phpMyAdmin SQL Dump
-- version 5.2.3-1.el10_1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Tiempo de generación: 17-04-2026 a las 19:59:56
-- Versión del servidor: 10.11.15-MariaDB
-- Versión de PHP: 8.3.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `adminMultipleMail`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aliases`
--

CREATE TABLE `aliases` (
  `id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `source_email` varchar(190) NOT NULL,
  `destination_email` varchar(190) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `aliases`
--

INSERT INTO `aliases` (`id`, `domain_id`, `source_email`, `destination_email`, `is_active`, `created_at`) VALUES
(1, 1, 'info@goodev.com.mx', 'jhonatan@goodev.com.mx', 1, '2026-04-06 16:53:31');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domains`
--

CREATE TABLE `domains` (
  `id` int(11) NOT NULL,
  `name` varchar(190) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `domains`
--

INSERT INTO `domains` (`id`, `name`, `is_active`, `created_at`) VALUES
(1, 'goodev.com.mx', 1, '2026-04-05 20:30:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `domain_history`
--

CREATE TABLE `domain_history` (
  `id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `event_date` datetime NOT NULL DEFAULT current_timestamp(),
  `event_type` varchar(100) NOT NULL,
  `reason` varchar(1250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mailboxes`
--

CREATE TABLE `mailboxes` (
  `id` int(11) NOT NULL,
  `domain_id` int(11) NOT NULL,
  `email` varchar(190) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `maildir` varchar(255) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `quota` varchar(30) DEFAULT NULL,
  `domain_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `quota`, `domain_id`) VALUES
(1, 'jhonatan@goodev.com.mx', '{SHA512-CRYPT}$6$d9aSF8T33deI/na5$keAJWRsYAt5H0yf.R3TuYVbP.mnaU388tHJ2zt4i23vIwIPct8B5yiEt4xq4942N3VeIQYbagloDfH0zpWLJQ.', '', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aliases`
--
ALTER TABLE `aliases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_alias_pair` (`source_email`,`destination_email`),
  ADD KEY `idx_aliases_source_email` (`source_email`),
  ADD KEY `idx_aliases_domain_id` (`domain_id`);

--
-- Indices de la tabla `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_domains_name` (`name`);

--
-- Indices de la tabla `domain_history`
--
ALTER TABLE `domain_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_domain_history_domain_id` (`domain_id`);

--
-- Indices de la tabla `mailboxes`
--
ALTER TABLE `mailboxes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_mailboxes_email` (`email`),
  ADD KEY `idx_mailboxes_domain_id` (`domain_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `domain_id` (`domain_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aliases`
--
ALTER TABLE `aliases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `domains`
--
ALTER TABLE `domains`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `domain_history`
--
ALTER TABLE `domain_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mailboxes`
--
ALTER TABLE `mailboxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `aliases`
--
ALTER TABLE `aliases`
  ADD CONSTRAINT `fk_aliases_domain` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `domain_history`
--
ALTER TABLE `domain_history`
  ADD CONSTRAINT `fk_domain_history_domain` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mailboxes`
--
ALTER TABLE `mailboxes`
  ADD CONSTRAINT `fk_mailboxes_domain` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domains` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
