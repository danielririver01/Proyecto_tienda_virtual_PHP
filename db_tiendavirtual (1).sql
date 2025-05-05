-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 27-05-2024 a las 16:59:42
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `db_tiendavirtual`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idcategoria` bigint(20) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `portada` varchar(100) NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp(),
  `ruta` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idcategoria`, `nombre`, `descripcion`, `portada`, `datecreated`, `ruta`, `status`) VALUES
(1, 'Perfumeria', 'Deja tu esencia', 'img_125e45445bd33723d025d7f815ca29f7.jpg', '2021-08-20 03:04:04', 'perfumeria', 1),
(3, 'Maquillaje', 'Color de inspira,belleza que transforma', 'img_423c748c20e279feb22e30045ac811f0.jpg', '2024-03-19 14:27:26', 'maquillaje', 1),
(4, 'Joyeria', 'Deslumbra y comparte', 'img_714fdd5a16ca86300377f87dff20767f.jpg', '2024-03-19 14:34:28', 'joyeria', 1),
(5, 'Cuidado de la Piel', 'Piel radiante,Confianza brillante', 'img_2bdffefc011fe0f5f4c3fb51d1ccfd43.jpg', '2024-03-19 14:35:12', 'cuidado-de-la-piel', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `id` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `mensaje` text NOT NULL,
  `ip` varchar(15) NOT NULL,
  `dispositivo` varchar(25) NOT NULL,
  `useragent` text NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`id`, `nombre`, `email`, `mensaje`, `ip`, `dispositivo`, `useragent`, `datecreated`) VALUES
(1, 'Jhoan Daniel', 'cualquieracoreo@hotmail.com', 'Los 2 errores presentan la misma concidencia?', '::1', 'PC', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', '2024-05-04 09:39:30'),
(2, 'Jhoan Daniel', 'dr4140485@gmail.com', 'No tengo ninguna solo estoy feliz por haber echo el codigo funcional', '::1', 'PC', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', '2024-05-04 15:34:57'),
(4, 'Fernando', 'dr4140485@gmail.com', 'Tengo un problema en la compra ayuda', '::1', 'PC', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36', '2024-05-06 10:46:02'),
(5, 'Andres', 'bejagix113@cgbird.com', 'no recibí la compra', '127.0.0.1', 'PC', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36 Edg/124.0.0.0', '2024-05-17 11:05:19');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id` bigint(20) NOT NULL,
  `pedidoid` bigint(20) NOT NULL,
  `productoid` bigint(20) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `cantidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id`, `pedidoid`, `productoid`, `precio`, `cantidad`) VALUES
(1, 1, 2, 200.00, 1),
(2, 1, 1, 100.00, 2),
(3, 2, 1, 100.00, 3),
(4, 3, 6, 25.80, 1),
(5, 4, 10, 12.22, 1),
(6, 5, 12, 4.44, 1),
(7, 6, 10, 12.22, 1),
(8, 7, 9, 4.88, 1),
(9, 8, 12, 4.44, 1),
(10, 9, 8, 36.87, 1),
(11, 10, 8, 36.87, 1),
(12, 11, 11, 6.63, 1),
(13, 12, 10, 12.22, 1),
(14, 13, 13, 49.11, 1),
(15, 14, 8, 36.87, 1),
(16, 15, 7, 34.29, 1),
(17, 16, 6, 25.80, 1),
(18, 17, 8, 36.87, 1),
(19, 18, 8, 36.87, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_temp`
--

CREATE TABLE `detalle_temp` (
  `id` bigint(20) NOT NULL,
  `personaid` bigint(20) NOT NULL,
  `productoid` bigint(20) NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `transaccionid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagen`
--

CREATE TABLE `imagen` (
  `id` bigint(20) NOT NULL,
  `productoid` bigint(20) NOT NULL,
  `img` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `imagen`
--

INSERT INTO `imagen` (`id`, `productoid`, `img`) VALUES
(1, 4, 'pro_a8dd46f1eb7c9981fcaa56d824c2740a.jpg'),
(2, 4, 'pro_14f4068973393f826d60d3e2ef7e434a.jpg'),
(3, 5, 'pro_7989c5b54f679dff499a54077df821b9.jpg'),
(4, 5, 'pro_7ebbb66049fa816af1aaefa6e58b6807.jpg'),
(5, 5, 'pro_74e4a1f7a17b1f718c598d0efec38877.jpg'),
(6, 6, 'pro_795984b5c6b1481a759d39586ee96fce.jpg'),
(7, 6, 'pro_93d3b61be2eb4b121bae962099b41a0e.jpg'),
(8, 7, 'pro_905358731c02c3f8631fba89192f6e42.jpg'),
(9, 8, 'pro_748cd505b8ca11d6457856ac52f83019.jpg'),
(10, 8, 'pro_095b2044ce2ed756b86dc706c268e992.jpg'),
(11, 8, 'pro_09f5f209acd04700d1f06d8843e27390.jpg'),
(12, 8, 'pro_c89a23b288dffd1127dd6519b6d59a21.jpg'),
(13, 9, 'pro_66aa29004e878172dc25f0a9354c76c7.jpg'),
(14, 9, 'pro_3c258a853a4f533121c5a2d6c0b525ca.jpg'),
(15, 9, 'pro_86800e282dd54d2b558a0b197a436198.jpg'),
(16, 9, 'pro_56d96a6e71f7b2427980e5b2ef1fef7e.jpg'),
(17, 9, 'pro_e3a6f62bbf56641ee7c32414c356c604.jpg'),
(18, 9, 'pro_c9ffadad725cf310aac7f4bdd40f474e.jpg'),
(19, 9, 'pro_463ac0a24eb91e8363ccdbd83f3abc18.jpg'),
(20, 9, 'pro_4112db8915aa518138fcbc265881653a.jpg'),
(21, 9, 'pro_1f0447d9d277436041d4b0b85072adaf.jpg'),
(22, 10, 'pro_188441a574da9acc9c9f5757c40023db.jpg'),
(23, 10, 'pro_a59751043d2681bc799c604be4129f49.jpg'),
(24, 10, 'pro_82eb4f62c3e0f281249c3a80a490aae8.jpg'),
(25, 10, 'pro_ced0519a18bfacae5e0968b58153ae3d.jpg'),
(26, 10, 'pro_252ed4f156bff82c0524645047397294.jpg'),
(32, 13, 'pro_4567fb58e45efb3717c440328c2ba235.jpg'),
(33, 13, 'pro_86a732a4937c4cb786053322cd325dca.jpg'),
(34, 13, 'pro_ba55f62ad0b6e3ec26c134026fc59780.jpg'),
(35, 13, 'pro_ba55f62ad0b6e3ec26c134026fc59780.jpg'),
(36, 13, 'pro_68c907746ef5b582dcacea6601159995.jpg'),
(37, 13, 'pro_29d26fa2bd6655e90e9875868abb53ce.jpg'),
(38, 13, 'pro_0d47da17cb8da241d48598fc010159a7.jpg'),
(40, 12, 'pro_ead6b786cf5be4ff7a8e980835e1b6b4.jpg'),
(41, 12, 'pro_145de0f2f7d4965570243ee9cf61ceb1.jpg'),
(42, 12, 'pro_ee14400033336ba87bf73700fdb02999.jpg'),
(43, 12, 'pro_bfd72863fa6e5a323fcba3deb5b7be2e.jpg'),
(45, 12, 'pro_44b713e78a14158e4ce1e58fae297540.jpg'),
(46, 12, 'pro_493133a02571b3bb0043ffeade419bf5.jpg'),
(47, 12, 'pro_660b74db03db11617c0eefa4c7255986.jpg'),
(48, 11, 'pro_474c1133cdaa73cd1d1610657ddf5fd5.jpg'),
(49, 11, 'pro_c2d7f8ef9e69cb75a1a1e780fee3b770.jpg'),
(50, 11, 'pro_5bec9997177e8c1047763321a78739a9.jpg'),
(51, 11, 'pro_4c10afb895bfcac8663a440b6bb258ff.jpg'),
(52, 11, 'pro_10939bc6127e2922aea9a0f9fe006d78.jpg'),
(53, 11, 'pro_6a0b64b6d4d39d06ee7e97d341cca81d.jpg'),
(54, 11, 'pro_ea7e4dd52536c369180bbc71b858678d.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulo`
--

CREATE TABLE `modulo` (
  `idmodulo` bigint(20) NOT NULL,
  `titulo` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `modulo`
--

INSERT INTO `modulo` (`idmodulo`, `titulo`, `descripcion`, `status`) VALUES
(1, 'Dashboard', 'Dashboard', 1),
(2, 'Usuarios', 'Usuarios del sistema', 1),
(3, 'Clientes', 'Clientes de tienda', 1),
(4, 'Productos', 'Todos los productos', 1),
(5, 'Pedidos', 'Pedidos', 1),
(6, 'Caterogías', 'Caterogías Productos', 1),
(7, 'Suscriptores', 'Suscriptores del sitio web', 1),
(8, 'Contactos', 'Mensajes del formulario contacto', 1),
(9, 'Páginas', 'Páginas del sitio web', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `idpedido` bigint(20) NOT NULL,
  `referenciacobro` varchar(255) DEFAULT NULL,
  `idtransaccionpaypal` varchar(255) DEFAULT NULL,
  `datospaypal` text DEFAULT NULL,
  `personaid` bigint(20) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `costo_envio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `monto` decimal(11,2) NOT NULL,
  `tipopagoid` bigint(20) NOT NULL,
  `direccion_envio` text NOT NULL,
  `status` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`idpedido`, `referenciacobro`, `idtransaccionpaypal`, `datospaypal`, `personaid`, `fecha`, `costo_envio`, `monto`, `tipopagoid`, `direccion_envio`, `status`) VALUES
(1, '4561654687', NULL, NULL, 3, '2021-08-20 03:41:57', 50.00, 450.00, 3, 'Antigua Guatemala, Antigua Guatemala', 'Completo'),
(2, NULL, '8XD37465755620710', '{\"id\":\"4S6284553D668511R\",\"intent\":\"CAPTURE\",\"status\":\"COMPLETED\",\"purchase_units\":[{\"reference_id\":\"default\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"350.00\"},\"payee\":{\"email_address\":\"sb-6z0da4580133@business.example.com\",\"merchant_id\":\"ULNZF7CTTE748\"},\"description\":\"Compra de artículos en Tienda Virtual por $350 \",\"soft_descriptor\":\"PAYPAL *JOHNDOESTES\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Guatemala City\",\"admin_area_1\":\"Guatemala City\",\"postal_code\":\"01001\",\"country_code\":\"GT\"}},\"payments\":{\"captures\":[{\"id\":\"8XD37465755620710\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"350.00\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"create_time\":\"2021-08-20T09:48:38Z\",\"update_time\":\"2021-08-20T09:48:38Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-iimwo4579006@personal.example.com\",\"payer_id\":\"ZTA3QXTY5JS6Q\",\"address\":{\"country_code\":\"GT\"}},\"create_time\":\"2021-08-20T09:46:25Z\",\"update_time\":\"2021-08-20T09:48:38Z\",\"links\":[{\"href\":\"https://api.sandbox.paypal.com/v2/checkout/orders/4S6284553D668511R\",\"rel\":\"self\",\"method\":\"GET\"}]}', 3, '2021-08-20 03:48:39', 50.00, 350.00, 1, 'Guatemala, Guatemala', 'Completo'),
(3, NULL, NULL, NULL, 1, '2024-05-03 17:50:22', 5.00, 30.80, 2, 'Calle 7 Avenida los fundadores subiendo el cerro, Riosucio/choco', 'Pendiente'),
(4, NULL, NULL, NULL, 1, '2024-05-04 09:38:48', 5.00, 17.22, 4, 'Calle 9, Anserma/caldas', 'Pendiente'),
(5, NULL, NULL, NULL, 1, '2024-05-04 10:03:06', 5.00, 9.44, 5, 'Calle 80 avenida a italia, roma//Italia', 'Pendiente'),
(6, NULL, NULL, NULL, 1, '2024-05-04 10:20:29', 5.00, 17.22, 2, 'Calle 9, Avenida/Italia', 'Pendiente'),
(7, NULL, NULL, NULL, 1, '2024-05-04 10:57:22', 5.00, 9.88, 2, 'Calle 7, Avenida/Riosucio Caldas', 'Pendiente'),
(8, NULL, NULL, NULL, 1, '2024-05-04 11:12:57', 5.00, 9.44, 2, 'calle 791, Manizales/Caldas', 'Pendiente'),
(9, NULL, NULL, NULL, 1, '2024-05-04 11:16:07', 5.00, 41.87, 2, 'Calle 691, Medellin/Antioqua', 'Pendiente'),
(10, NULL, NULL, NULL, 1, '2024-05-04 14:32:47', 5.00, 41.87, 2, 'Calle 691 avenida a los fundadores, Medellin/Antioqua', 'Pendiente'),
(11, '4AC04667BJ252173H', NULL, NULL, 1, '2024-05-04 14:38:58', 5.00, 11.63, 3, 'Calle 691 avenida a los fundadores, Medellin/Antioqua', 'Completo'),
(12, NULL, '6DC03558BJ141362H', '{\"id\":\"3N205161HH929164G\",\"intent\":\"CAPTURE\",\"status\":\"COMPLETED\",\"purchase_units\":[{\"reference_id\":\"default\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"17.22\"},\"payee\":{\"email_address\":\"sb-skrqd27887640@business.example.com\",\"merchant_id\":\"8R28P2BS82HAC\"},\"description\":\"Compra de artículos en JHOJHO por $17.22 \",\"soft_descriptor\":\"PAYPAL *TEST STORE\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Bogota\",\"admin_area_1\":\"Bogota\",\"postal_code\":\"110111\",\"country_code\":\"CO\"}},\"payments\":{\"captures\":[{\"id\":\"6DC03558BJ141362H\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"17.22\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"create_time\":\"2024-05-04T20:29:07Z\",\"update_time\":\"2024-05-04T20:29:07Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-iq83z27941752@personal.example.com\",\"payer_id\":\"6WPNGJ4JCZVKL\",\"address\":{\"country_code\":\"CO\"}},\"create_time\":\"2024-05-04T20:28:52Z\",\"update_time\":\"2024-05-04T20:29:07Z\",\"links\":[{\"href\":\"https://api.sandbox.paypal.com/v2/checkout/orders/3N205161HH929164G\",\"rel\":\"self\",\"method\":\"GET\"}]}', 1, '2024-05-04 15:29:08', 5.00, 17.22, 1, 'Calle 565 avenida a los fundadores, Medellin/Antioqua', 'Completo'),
(13, NULL, NULL, NULL, 1, '2024-05-06 10:44:19', 5.00, 54.11, 2, 'Calle 691 avenida a los fundadores, Medellin/Antioqua', 'Pendiente'),
(14, NULL, '578121728N3058733', '{\"id\":\"4639228839750632X\",\"intent\":\"CAPTURE\",\"status\":\"COMPLETED\",\"purchase_units\":[{\"reference_id\":\"default\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"41.87\"},\"payee\":{\"email_address\":\"sb-skrqd27887640@business.example.com\",\"merchant_id\":\"8R28P2BS82HAC\"},\"description\":\"Compra de artículos en JHOJHO por $41.87 \",\"soft_descriptor\":\"PAYPAL *TEST STORE\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Bogota\",\"admin_area_1\":\"Bogota\",\"postal_code\":\"110111\",\"country_code\":\"CO\"}},\"payments\":{\"captures\":[{\"id\":\"578121728N3058733\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"41.87\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"create_time\":\"2024-05-10T16:04:23Z\",\"update_time\":\"2024-05-10T16:04:23Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-iq83z27941752@personal.example.com\",\"payer_id\":\"6WPNGJ4JCZVKL\",\"address\":{\"country_code\":\"CO\"}},\"create_time\":\"2024-05-10T16:03:07Z\",\"update_time\":\"2024-05-10T16:04:23Z\",\"links\":[{\"href\":\"https://api.sandbox.paypal.com/v2/checkout/orders/4639228839750632X\",\"rel\":\"self\",\"method\":\"GET\"}]}', 1, '2024-05-10 11:04:24', 5.00, 41.87, 1, 'Calle 565 avenida a los fundadores, Medellin/Antioqua', 'Completo'),
(15, NULL, '2CJ10742HH8645449', '{\"id\":\"3VE12759YJ6425353\",\"intent\":\"CAPTURE\",\"status\":\"COMPLETED\",\"purchase_units\":[{\"reference_id\":\"default\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"39.29\"},\"payee\":{\"email_address\":\"sb-skrqd27887640@business.example.com\",\"merchant_id\":\"8R28P2BS82HAC\"},\"description\":\"Compra de artículos en JHOJHO por $39.29 \",\"soft_descriptor\":\"PAYPAL *TEST STORE\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Bogota\",\"admin_area_1\":\"Bogota\",\"postal_code\":\"110111\",\"country_code\":\"CO\"}},\"payments\":{\"captures\":[{\"id\":\"2CJ10742HH8645449\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"39.29\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"create_time\":\"2024-05-13T14:32:24Z\",\"update_time\":\"2024-05-13T14:32:24Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-iq83z27941752@personal.example.com\",\"payer_id\":\"6WPNGJ4JCZVKL\",\"address\":{\"country_code\":\"CO\"}},\"create_time\":\"2024-05-13T14:32:04Z\",\"update_time\":\"2024-05-13T14:32:24Z\",\"links\":[{\"href\":\"https://api.sandbox.paypal.com/v2/checkout/orders/3VE12759YJ6425353\",\"rel\":\"self\",\"method\":\"GET\"}]}', 37, '2024-05-13 09:32:28', 5.00, 39.29, 1, 'Calle 6 avenida a Supia, Supia/Caldas', 'Completo'),
(16, NULL, NULL, NULL, 1, '2024-05-16 13:29:49', 5.00, 30.80, 5, 'kakak, ajajaj', 'Pendiente'),
(17, '53683', NULL, NULL, 81, '2024-05-17 10:34:05', 5.00, 41.87, 5, 'calllj, gfdufud', 'Completo'),
(18, NULL, '1UM87467YN262480K', '{\"id\":\"6U491197H4520763F\",\"intent\":\"CAPTURE\",\"status\":\"COMPLETED\",\"purchase_units\":[{\"reference_id\":\"default\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"78.74\"},\"payee\":{\"email_address\":\"sb-skrqd27887640@business.example.com\",\"merchant_id\":\"8R28P2BS82HAC\"},\"description\":\"Compra de artículos en JHOJHO por $78.74 \",\"soft_descriptor\":\"PAYPAL *TEST STORE\",\"shipping\":{\"name\":{\"full_name\":\"John Doe\"},\"address\":{\"address_line_1\":\"Free Trade Zone\",\"admin_area_2\":\"Bogota\",\"admin_area_1\":\"Bogota\",\"postal_code\":\"110111\",\"country_code\":\"CO\"}},\"payments\":{\"captures\":[{\"id\":\"1UM87467YN262480K\",\"status\":\"COMPLETED\",\"amount\":{\"currency_code\":\"USD\",\"value\":\"78.74\"},\"final_capture\":true,\"seller_protection\":{\"status\":\"ELIGIBLE\",\"dispute_categories\":[\"ITEM_NOT_RECEIVED\",\"UNAUTHORIZED_TRANSACTION\"]},\"create_time\":\"2024-05-17T15:57:47Z\",\"update_time\":\"2024-05-17T15:57:47Z\"}]}}],\"payer\":{\"name\":{\"given_name\":\"John\",\"surname\":\"Doe\"},\"email_address\":\"sb-iq83z27941752@personal.example.com\",\"payer_id\":\"6WPNGJ4JCZVKL\",\"address\":{\"country_code\":\"CO\"}},\"create_time\":\"2024-05-17T15:56:59Z\",\"update_time\":\"2024-05-17T15:57:47Z\",\"links\":[{\"href\":\"https://api.sandbox.paypal.com/v2/checkout/orders/6U491197H4520763F\",\"rel\":\"self\",\"method\":\"GET\"}]}', 82, '2024-05-17 10:57:50', 5.00, 78.74, 1, 'beja calle 13, España valencia', 'Completo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permisos`
--

CREATE TABLE `permisos` (
  `idpermiso` bigint(20) NOT NULL,
  `rolid` bigint(20) NOT NULL,
  `moduloid` bigint(20) NOT NULL,
  `r` int(11) NOT NULL DEFAULT 0,
  `w` int(11) NOT NULL DEFAULT 0,
  `u` int(11) NOT NULL DEFAULT 0,
  `d` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `permisos`
--

INSERT INTO `permisos` (`idpermiso`, `rolid`, `moduloid`, `r`, `w`, `u`, `d`) VALUES
(21, 3, 1, 0, 0, 0, 0),
(22, 3, 2, 0, 0, 0, 0),
(23, 3, 3, 0, 0, 0, 0),
(24, 3, 4, 0, 0, 0, 0),
(25, 3, 5, 1, 0, 0, 0),
(26, 3, 6, 0, 0, 0, 0),
(27, 3, 7, 0, 0, 0, 0),
(28, 3, 8, 0, 0, 0, 0),
(29, 3, 9, 0, 0, 0, 0),
(66, 1, 1, 1, 1, 1, 1),
(67, 1, 2, 1, 1, 1, 1),
(68, 1, 3, 1, 0, 1, 1),
(69, 1, 4, 1, 1, 1, 1),
(70, 1, 5, 1, 1, 1, 1),
(71, 1, 6, 1, 1, 1, 1),
(72, 1, 7, 1, 1, 1, 1),
(73, 1, 8, 1, 1, 1, 1),
(74, 1, 9, 1, 1, 1, 1),
(75, 2, 1, 1, 1, 1, 1),
(76, 2, 2, 0, 0, 0, 0),
(77, 2, 3, 1, 0, 1, 0),
(78, 2, 4, 1, 1, 1, 0),
(79, 2, 5, 1, 1, 1, 0),
(80, 2, 6, 1, 1, 1, 0),
(81, 2, 7, 1, 0, 0, 0),
(82, 2, 8, 1, 0, 0, 0),
(83, 2, 9, 1, 1, 1, 1),
(84, 4, 1, 1, 0, 0, 0),
(85, 4, 2, 0, 0, 0, 0),
(86, 4, 3, 1, 0, 1, 0),
(87, 4, 4, 1, 0, 0, 0),
(88, 4, 5, 1, 0, 1, 0),
(89, 4, 6, 0, 0, 0, 0),
(90, 4, 7, 1, 0, 0, 0),
(91, 4, 8, 1, 0, 0, 0),
(92, 4, 9, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `idpersona` bigint(20) NOT NULL,
  `identificacion` varchar(30) DEFAULT NULL,
  `nombres` varchar(80) NOT NULL,
  `apellidos` varchar(100) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `email_user` varchar(100) NOT NULL,
  `password` varchar(75) NOT NULL,
  `nit` varchar(20) DEFAULT NULL,
  `nombrefiscal` varchar(80) DEFAULT NULL,
  `direccionfiscal` varchar(100) DEFAULT NULL,
  `token` varchar(100) DEFAULT NULL,
  `rolid` bigint(20) NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp(),
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`idpersona`, `identificacion`, `nombres`, `apellidos`, `telefono`, `email_user`, `password`, `nit`, `nombrefiscal`, `direccionfiscal`, `token`, `rolid`, `datecreated`, `status`) VALUES
(1, '24091989', 'Jhoan Daniel', 'Rivera Ortiz', 123456, 'daniel412river.ortiz@hotmail.com', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', 'CF', 'JHOJHO', 'Ciudad', 'c35493992838d8aefa6d-f37e767d5100c26223d0-dbb3f9a23e52c1c407f0-4391abd3841fe7c3f104', 1, '2021-08-20 01:34:15', 1),
(2, '24091990', 'Alex', 'Arana', 456878977, 'alex@info.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 2, '2021-08-20 02:58:47', 1),
(3, '84654864', 'Ricardo', 'Hernández Pérez', 4687987, 'hr@info.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '468798', 'Ricardo HP', 'Ciudad de Guatemala', NULL, 3, '2021-08-20 03:41:28', 0),
(4, '798465877', 'Fernando', 'Guerra', 468498, 'fer@info.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 4, '2021-08-21 18:07:00', 1),
(28, '2091898', 'Jhon', 'Gabri', 921929, 'info312q@hotmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '34918291', 'JHOJHO', 'alalalal', NULL, 3, '2024-05-11 11:12:04', 0),
(29, '34918291', 'Jhon', 'Gabri', 921929, 'dr4140485@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 1, '2024-05-11 12:04:15', 1),
(37, '91827173', 'Maria Velez', 'Trejos', 341981742, 'info@hotmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', '809182981', 'Maria Velez', 'Calle 6 avenida a Supia', NULL, 3, '2024-05-11 16:19:48', 1),
(38, '1029929219', 'Akkakak', 'Mamamam', 2221212335, 'maria@hotmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 3, '2024-05-11 17:32:30', 0),
(80, '1998128381', 'Lucas', 'Say', 3210931343, 'info@jhojho.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, NULL, 3, '2024-05-16 13:25:43', 0),
(81, NULL, 'Andres', 'Ramirz', 434221113, 'tijidi2184@huleos.com', '486db44e7d6df252d81c528c42d6aa4a9cf89a9a993e49709dc4f6d8e23bbbc4', NULL, NULL, NULL, NULL, 3, '2024-05-17 10:25:42', 1),
(82, NULL, 'Prueba', 'Bolivar', 31298411, 'bejagix113@cgbird.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', NULL, NULL, NULL, '', 3, '2024-05-17 10:54:14', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `post`
--

CREATE TABLE `post` (
  `idpost` bigint(20) NOT NULL,
  `titulo` varchar(255) NOT NULL,
  `contenido` text NOT NULL,
  `portada` varchar(100) DEFAULT NULL,
  `datecreate` datetime NOT NULL DEFAULT current_timestamp(),
  `ruta` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `post`
--

INSERT INTO `post` (`idpost`, `titulo`, `contenido`, `portada`, `datecreate`, `ruta`, `status`) VALUES
(1, 'Inicio', '<div class=\"p-t-80\"> <h3 class=\"ltext-103 cl5\">Nuestras marcas</h3> </div> <div> <p>Trabajamos con las mejores marcas del mundo ...</p> </div> <div class=\"row\"> <div class=\"col-md-3\"><img src=\"Assets/images/m1.png\" alt=\"Marca 1\" width=\"110\" height=\"110\" /></div> <div class=\"col-md-3\"><img src=\"Assets/images/m2.png\" alt=\"Marca 2\" /></div> <div class=\"col-md-3\"><img src=\"Assets/images/m3.png\" alt=\"Marca 3\" /></div> <div class=\"col-md-3\"><img src=\"Assets/images/m4.png\" alt=\"Marca 4\" /></div> </div>', '', '2021-07-20 02:40:15', 'inicio', 1),
(2, 'Tienda', '<p>Contenido p&aacute;gina!</p>', '', '2021-08-06 01:21:27', 'tienda', 1),
(3, 'Carrito', '<p>Contenido p&aacute;gina!</p>', '', '2021-08-06 01:21:52', 'carrito', 1),
(4, 'Nosotros', '<section class=\"bg0 p-t-75 p-b-120\"> <div class=\"container\"> <div class=\"row p-b-148\"> <div class=\"col-md-7 col-lg-8\"> <div class=\"p-t-7 p-r-85 p-r-15-lg p-r-0-md\"> <h3 class=\"mtext-111 cl2 p-b-16\">Historia</h3> <p>En las profundidades de la Sierra Nevada, en un peque&ntilde;o pueblo llamado Riosucio, un grupo de visionarios emprendedores se reuni&oacute; con un sue&ntilde;o com&uacute;n: crear JHOJHO, una plataforma revolucionaria de comercio electr&oacute;nico para productos cosm&eacute;ticos y del hogar. Inspirados por la rica biodiversidad de su entorno y la necesidad de una experiencia de compra segura y accesible, estos pioneros se embarcaron en una aventura que cambiar&iacute;a el rostro del comercio en su regi&oacute;n.</p> <p><strong>La concepci&oacute;n de JHOJHO:</strong>&nbsp;La idea naci&oacute; de un informe detallado que delineaba las necesidades de los clientes y las capacidades de la tecnolog&iacute;a actual. El informe hablaba de una plataforma intuitiva, dise&ntilde;ada para ser el puente entre los artesanos locales y un mercado global. Se imagin&oacute; un lugar donde la belleza natural de Colombia pudiera ser compartida con el mundo, y donde cada compra fuera una experiencia memorable.</p> </div> </div> <div class=\"col-11 col-md-5 col-lg-4 m-lr-auto\"> <div class=\"how-bor1 \"> <div class=\"hov-img0\"><img src=\"https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849825_1280.jpg\" alt=\"IMG\" width=\"500\" height=\"333\" /></div> </div> </div> </div> <div class=\"row\"> <div class=\"order-md-2 col-md-7 col-lg-8 p-b-30\"> <div class=\"p-t-7 p-l-85 p-l-15-lg p-l-0-md\"> <h2 class=\"mtext-111 cl2 p-b-16\"><span style=\"color: #236fa1;\">Nuestra Misi&oacute;n</span></h2> <p>es revolucionar la experiencia de compra en l&iacute;nea, ofreciendo una plataforma segura y accesible que conecta la riqueza natural de Colombia con el mundo. Nos comprometemos a proporcionar una selecci&oacute;n de productos cosm&eacute;ticos y para el hogar de la m&aacute;s alta calidad, elaborados con el cuidado y la tradici&oacute;n de los artesanos locales.</p> <p>Nos esforzamos por garantizar una experiencia de usuario excepcional, donde cada cliente pueda encontrar y adquirir f&aacute;cilmente lo que necesita, respaldado por un servicio al cliente que entiende y valora la importancia de cada compra. Nuestro objetivo es crear un espacio donde la belleza y la funcionalidad se encuentren, y donde cada transacci&oacute;n sea una oportunidad para fortalecer la confianza y la satisfacci&oacute;n del cliente.</p> </div> </div> <div class=\"order-md-1 col-11 col-md-5 col-lg-4 m-lr-auto p-b-30\"> <div class=\"how-bor2\"> <div class=\"hov-img0\"><img src=\"https://cdn.pixabay.com/photo/2015/07/17/22/43/student-849822_1280.jpg\" alt=\"IMG\" width=\"500\" height=\"333\" /></div> </div> </div> </div> </div> </section>', 'img_2f644b056a9fd3624c7595d24b1d9273.jpg', '2021-08-09 03:09:44', 'nosotros', 1),
(5, 'Contacto', '<div class=\"map\"><iframe style=\"border: 0;\" src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3861.685802352331!2d-90.73646108521129!3d14.559951589828378!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x85890e74b3771e19%3A0x68ec9eeea79fd9a7!2sEl%20Arco%20de%20Santa%20Catalina!5e0!3m2!1ses!2sgt!4v1624005005655!5m2!1ses!2sgt\" width=\"100%\" height=\"600\" allowfullscreen=\"allowfullscreen\" loading=\"lazy\"></iframe></div>', 'img_3024f13dc010ffab8c22da05ac6a32b9.jpg', '2021-08-09 03:11:08', 'contacto', 1),
(6, 'Preguntas frecuentes', '<p><strong>&iquest;Cu&aacute;l es el tiempo de entrega de los productos?</strong><br />El tiempo de entrega var&iacute;a dependiendo de la ubicaci&oacute;n y el tipo de env&iacute;o seleccionado. Generalmente, los pedidos nacionales se entregan en un plazo de 3 a 7 d&iacute;as h&aacute;biles, mientras que los env&iacute;os internacionales pueden tardar entre 10 a 15 d&iacute;as h&aacute;biles. Para m&aacute;s detalles, consulte nuestras pol&iacute;ticas de env&iacute;o.</p> <p><strong>&iquest;C&oacute;mo es la forma de env&iacute;o de los productos?</strong><br />Ofrecemos varias opciones de env&iacute;o para adaptarnos a sus necesidades. Utilizamos servicios de mensajer&iacute;a confiables como DHL, FedEx y el servicio postal local. Los m&eacute;todos de env&iacute;o disponibles se muestran al momento de realizar la compra, permiti&eacute;ndole elegir la opci&oacute;n m&aacute;s conveniente para usted.</p> <p><strong>&iquest;Cu&aacute;l es el tiempo m&aacute;ximo para solicitar un reembolso?</strong><br />Puede solicitar un reembolso dentro de los 30 d&iacute;as posteriores a la recepci&oacute;n de su pedido. Para ser elegible para un reembolso, los productos deben estar sin usar y en la misma condici&oacute;n en que los recibi&oacute;, con su empaque original. Consulte nuestra pol&iacute;tica de devoluciones para m&aacute;s detalles.</p> <hr /> <h3>&nbsp;</h3> <p><strong>&iquest;Qu&eacute; formas de pago aceptan?</strong><br />Aceptamos varias formas de pago para su conveniencia, incluyendo PayPal, transferencias bancarias y algunos m&eacute;todos de pago locales. Todas las transacciones est&aacute;n protegidas y se procesan a trav&eacute;s de pasarelas de pago seguras.</p>', '', '2021-08-11 01:24:19', 'preguntas-frecuentes', 1),
(7, 'Términos y Condiciones', '<p>&nbsp;</p> <p><strong>Pol&iacute;tica Uno: Compromiso con la Seguridad</strong>&nbsp;En JHOJHO, la seguridad de nuestros usuarios es primordial. Nos comprometemos a proteger su informaci&oacute;n personal mediante el uso de tecnolog&iacute;a de encriptaci&oacute;n avanzada y protocolos de seguridad estrictos.</p> <p><strong>T&eacute;rmino Dos: Transparencia en las Transacciones</strong>&nbsp;Todas las transacciones realizadas en la plataforma JHOJHO ser&aacute;n transparentes y claras. No habr&aacute; cargos ocultos, y cada usuario tendr&aacute; acceso completo a los detalles de sus compras y movimientos dentro de la plataforma.</p> <p><strong>Condici&oacute;n Tres: Respeto por la Privacidad</strong>&nbsp;Respetamos la privacidad de nuestros usuarios. Ninguna informaci&oacute;n personal ser&aacute; compartida con terceros sin el consentimiento expl&iacute;cito del usuario, excepto en los casos requeridos por ley.</p> <p><strong>Derechos de Autor y Propiedad Intelectual</strong>&nbsp;Todos los contenidos presentados en la plataforma, incluyendo textos, gr&aacute;ficos, logos, iconos, im&aacute;genes y software, son propiedad de JHOJHO o de sus respectivos due&ntilde;os y est&aacute;n protegidos por leyes de derechos de autor internacionales.</p> <p><strong>Limitaci&oacute;n de Responsabilidad</strong>&nbsp;JHOJHO no ser&aacute; responsable por da&ntilde;os indirectos, incidentales, especiales o consecuentes que resulten del uso o la incapacidad de usar nuestros servicios, incluso si JHOJHO ha sido advertido de la posibilidad de tales da&ntilde;os.</p> <p><strong>Modificaciones a los T&eacute;rminos y Condiciones</strong>&nbsp;JHOJHO se reserva el derecho de modificar estos t&eacute;rminos y condiciones en cualquier momento. Es responsabilidad del usuario revisar peri&oacute;dicamente estos t&eacute;rminos y condiciones para estar al tanto de cualquier cambio.</p> <p><strong>Aceptaci&oacute;n de los T&eacute;rminos</strong>&nbsp;Al utilizar la plataforma JHOJHO, usted acepta estar vinculado por estos t&eacute;rminos y condiciones. Si no est&aacute; de acuerdo con alguno de los t&eacute;rminos, por favor no utilice esta plataforma.</p> <p><strong>Contacto</strong>&nbsp;Para cualquier consulta o aclaraci&oacute;n sobre estos t&eacute;rminos y condiciones, por favor cont&aacute;ctenos a trav&eacute;s de nuestro formulario de contacto en la plataforma.</p>', '', '2021-08-11 01:51:06', 'terminos-y-condiciones', 1),
(8, 'Sucursales', '<section class=\"py-5 text-center\"> <div class=\"container\"> <p>Visitanos y obten los mejores precios del mercado, cualquier art&iacute;culo que necestas para vivir mejor</p> <a class=\"btn btn-info\" href=\"../../tienda_virtual/tienda\">VER PRODUCTOS</a></div> </section> <div class=\"py-5 bg-light\"> <div class=\"container\"> <div class=\"row\"> <div class=\"col-md-4\"> <div class=\"card mb-4 box-shadow hov-img0\"><img src=\"https://abelosh.com/tienda_virtual/Assets/images/s1.jpg\" alt=\"Tienda Uno\" width=\"100%\" height=\"100%\" /> <div class=\"card-body\"> <p class=\"card-text\">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quaerat necessitatibus eligendi, soluta ipsa natus, at earum qui enim, illum doloremque, accusantium autem nemo est esse nulla neque eaque repellendus amet.</p> <p>Direcci&oacute;n: Antigua Gautemala <br />Tel&eacute;fono: 4654645 <br />Correo: info@abelosh.com</p> </div> </div> </div> <div class=\"col-md-4\"> <div class=\"card mb-4 box-shadow hov-img0\"><img src=\"https://abelosh.com/tienda_virtual/Assets/images/s2.jpg\" alt=\"Sucural dos\" width=\"100%\" height=\"100%\" /> <div class=\"card-body\"> <p class=\"card-text\">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quaerat necessitatibus eligendi, soluta ipsa natus, at earum qui enim, illum doloremque, accusantium autem nemo est esse nulla neque eaque repellendus amet.</p> <p>Direcci&oacute;n: Antigua Gautemala <br />Tel&eacute;fono: 4654645 <br />Correo: info@abelosh.com</p> </div> </div> </div> <div class=\"col-md-4\"> <div class=\"card mb-4 box-shadow hov-img0\"><img src=\"https://abelosh.com/tienda_virtual/Assets/images/s3.jpg\" alt=\"Sucural tres\" width=\"100%\" height=\"100%\" /> <div class=\"card-body\"> <p class=\"card-text\">Lorem ipsum dolor, sit amet consectetur adipisicing elit. Quaerat necessitatibus eligendi, soluta ipsa natus, at earum qui enim, illum doloremque, accusantium autem nemo est esse nulla neque eaque repellendus amet.</p> <p>Direcci&oacute;n: Antigua Gautemala <br />Tel&eacute;fono: 4654645 <br />Correo: info@abelosh.com</p> </div> </div> </div> </div> </div> </div>', 'img_d72cb5712933863e051dc9c7fac5e253.jpg', '2021-08-11 02:26:45', 'sucursales', 0),
(9, 'Not Found', '<h1>Error 404: P&aacute;gina no encontrada</h1> <p>No se encuentra la p&aacute;gina que ha solicitado.</p>', '', '2021-08-12 02:30:49', 'not-found', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `idproducto` bigint(20) NOT NULL,
  `categoriaid` bigint(20) NOT NULL,
  `codigo` varchar(30) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `descripcion` text NOT NULL,
  `precio` decimal(11,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp(),
  `ruta` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`idproducto`, `categoriaid`, `codigo`, `nombre`, `descripcion`, `precio`, `stock`, `imagen`, `datecreated`, `ruta`, `status`) VALUES
(1, 1, '2417984565', 'Chaqueta Azul', '<p><strong style=\"margin: 0px; padding: 0px; color: #000000; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">Lorem Ipsum</strong><span style=\"color: #000000; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 100.00, 50, NULL, '2021-08-20 03:12:14', 'chaqueta-azul', 0),
(2, 1, '456879878', 'Reloj', '<p><strong style=\"margin: 0px; padding: 0px; color: #000000; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\">Lorem Ipsum</strong><span style=\"color: #000000; font-family: \'Open Sans\', Arial, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: justify; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\">&nbsp;is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</span></p>', 200.00, 100, NULL, '2021-08-20 03:14:10', 'reloj', 0),
(4, 1, '1897602', 'Solo Parfum', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p>Descubre una fragancia que captura la esencia de la masculinidad con una intensidad que no pasa desapercibida. Este perfume para hombre se define por su car&aacute;cter maderoso y c&iacute;trico, una combinaci&oacute;n audaz que abre con el frescor chispeante de la c&aacute;scara de mandarina. El coraz&oacute;n revela un toque especiado de jengibre, que se entrelaza con la robustez del cuero, creando un aroma impactante y poderoso. Es una fragancia que promete dejar una impresi&oacute;n duradera, ideal para el hombre que desea destacar en cualquier ocasi&oacute;n.</p> </div> </div> </div>', 20.61, 200, NULL, '2024-03-18 09:34:20', 'solo-parfum', 1),
(5, 1, '8918129', 'Temptation Eau de Parfum Mujer', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><em>D&eacute;jate envolver por un aroma que es la quintaesencia de la feminidad y el misterio. Este perfume floral especiado es una sinfon&iacute;a de elegancia, donde la rosa b&uacute;lgara, la gardenia y el clavo de olor se entrelazan en una danza de fragancias. Su intensidad no solo captura la atenci&oacute;n, sino que celebra la sensualidad de la mujer que lo lleva, dejando una estela de admiraci&oacute;n a su paso. Es la fragancia de la mujer irresistible, aquella cuya presencia no se olvida y cuyo recuerdo perdura en el aire.</em></p> </div> </div> </div>', 22.11, 200, NULL, '2024-03-18 09:43:25', 'temptation-eau-de-parfum-mujer', 1),
(6, 1, '21091293', 'Ohm Black Parfum', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><sup>Sum&eacute;rgete en una experiencia olfativa inolvidable con este perfume para hombre de aroma herbal c&iacute;trico. Las notas de naranja dulce se despliegan al primer contacto, invitando a descubrir un coraz&oacute;n de t&eacute; negro que aporta un toque sofisticado y misterioso. La pimienta negra emerge con su car&aacute;cter picante, a&ntilde;adiendo profundidad y una intensidad vibrante que promete una noche extraordinaria. Es el compa&ntilde;ero perfecto para aventuras nocturnas, donde cada momento se convierte en una celebraci&oacute;n de la amistad y la vida.</sup></p> </div> </div> </div>', 25.80, 200, NULL, '2024-03-18 09:51:40', 'ohm-black-parfum', 1),
(7, 1, '3169184', 'Ohm Soul Parfum', '<p>&nbsp;</p> <div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><em>Explora la profundidad y el car&aacute;cter del hombre Ohm con este perfume maderoso arom&aacute;tico. Una fragancia que comienza con la frescura c&iacute;trica de la bergamota, se enriquece con el ex&oacute;tico cardamomo de Guatemala y culmina con la nobleza del cedro puro. Cada nota se une para reflejar una personalidad compleja y vibrante, creando un perfume que es tanto exquisito como inolvidable, un verdadero reflejo del alma de un hombre que deja huella.</em></p> </div> </div> </div>', 34.29, 200, NULL, '2024-03-18 10:06:11', 'ohm-soul-parfum', 1),
(8, 1, '68328132', 'Ohm Parfum', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><sub>D&eacute;jate seducir por un perfume para hombre que es una oda a la frescura y vitalidad. La toronja rosada, con su jugosa dulzura, se une a la salvia, aportando un toque herbal que despierta los sentidos. Los acentos de cuero a&ntilde;aden una profundidad &uacute;nica, evocando la elegancia y el esp&iacute;ritu aventurero. Este aroma herbal c&iacute;trico es una invitaci&oacute;n a disfrutar de la vida con plenitud, celebrando cada momento con una fragancia tan viva como t&uacute;.</sub></p> </div> </div> </div>', 36.87, 200, NULL, '2024-03-18 10:11:42', 'ohm-parfum', 1),
(9, 3, '74620487', 'Labial COLORFIX Duo Tattoo', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><sub>Descubre el labial dual que redefine las reglas del maquillaje: con <strong>36 horas</strong> de color vibrante y una f&oacute;rmula innovadora que garantiza <strong>cero transferencia</strong>, podr&aacute;s vivir tu d&iacute;a a plenitud sin preocupaciones. Enriquecido con manteca de karit&eacute;, no solo embellece tus labios, sino que los mima con una hidrataci&oacute;n profunda y duradera. Es el aliado perfecto para una mujer que valora la durabilidad y el cuidado en cada aspecto de su vida.</sub></p> </div> </div> </div>', 4.88, 400, NULL, '2024-03-18 10:25:26', 'labial-colorfix-duo-tattoo', 1),
(10, 3, '4022120', 'Natural Matte Base de Maquillaje', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><sup>Experimenta la revoluci&oacute;n en maquillaje con la <strong>Base Natural Matte</strong>, dise&ntilde;ada para otorgarte una piel perfectamente <strong>mate</strong> y una cobertura digna de un acabado profesional. Su f&oacute;rmula enriquecida con <strong>vitamina E</strong> no solo cubre imperfecciones, sino que tambi&eacute;n nutre tu piel, dej&aacute;ndola suave y saludable. Ideal para quienes buscan un look impecable y cuidado integral de la piel.​</sup></p> </div> </div> </div>', 12.22, 400, NULL, '2024-03-18 10:36:27', 'natural-matte-base-de-maquillaje', 1),
(11, 3, '406394', 'Máscara de pestañas Mega Full Size a prueba de agua', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p><sup>Descubre la m&aacute;scara de pesta&ntilde;as que lidera el mercado de &eacute;sika, con un efecto de longitud insuperable que desaf&iacute;a los l&iacute;mites. Su f&oacute;rmula a prueba de agua asegura una mirada impactante y pesta&ntilde;as que se extienden hacia el infinito, sin importar las condiciones. Ya sea un d&iacute;a lluvioso o una noche de fiesta, mant&eacute;n tus pesta&ntilde;as perfectas y disfruta de un efecto largo que dura todo el d&iacute;a.</sup></p> </div> </div> </div>', 6.63, 400, NULL, '2024-03-18 10:47:15', 'mascara-de-pestanas-mega-full-size-a-prueba-de-agua', 1),
(12, 3, '40321620', 'Delineador Líquido Punta Pincel Eye PRO', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p>El delineador l&iacute;der en ventas de &eacute;sika redefine lo que esperas de un cosm&eacute;tico de ojos. Con una <strong>alta pigmentaci&oacute;n</strong> que promete una intensidad sin igual y una <strong>m&aacute;xima duraci&oacute;n</strong> que resiste el paso del tiempo, este delineador es la clave para una mirada que captura todas las miradas. Fija un color intenso y definido que enmarca tus ojos con precisi&oacute;n y estilo, asegurando que cada gui&ntilde;o sea tan impactante como el primero.</p> </div> </div> </div>', 4.44, 400, NULL, '2024-03-18 11:02:07', 'delineador-liquido-punta-pincel-eye-pro', 1),
(13, 3, '1901103', 'Set Color Diva', '<div class=\"content\" tabindex=\"0\" aria-description=\"\"> <div class=\"ac-container ac-adaptiveCard\"> <div class=\"ac-textBlock\"> <p>Con el look Color Diva de &eacute;sika, cada d&iacute;a es una oportunidad para brillar. Los productos favoritos de la marca se unen para crear un estilo que resalta tu belleza natural y te convierte en el centro de todas las miradas. S&eacute; la mujer que todos recuerdan: radiante, atractiva y siempre en tendencia con &eacute;sika. Vive la experiencia de ser una diva, todos los d&iacute;as.</p> </div> </div> </div>', 49.11, 600, NULL, '2024-03-18 11:12:02', 'set-color-diva', 0),
(14, 1, '101010', 'Pruebas unitarias', '<p>Probando de que todo funcione</p>', 1.00, 1, NULL, '2024-03-19 14:22:35', 'pruebas-unitarias', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reembolso`
--

CREATE TABLE `reembolso` (
  `id` bigint(20) NOT NULL,
  `pedidoid` bigint(20) NOT NULL,
  `idtransaccion` varchar(255) NOT NULL,
  `datosreembolso` text NOT NULL,
  `observacion` text NOT NULL,
  `status` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `idrol` bigint(20) NOT NULL,
  `nombrerol` varchar(50) NOT NULL,
  `descripcion` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`idrol`, `nombrerol`, `descripcion`, `status`) VALUES
(1, 'Administrador', 'Acceso a todo el sistema', 1),
(2, 'Supervisor', 'Supervisor de tiendas', 1),
(3, 'Cliente', 'Clientes en general', 1),
(4, 'Vendedor', 'Operador de tienda', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suscripciones`
--

CREATE TABLE `suscripciones` (
  `idsuscripcion` bigint(20) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `datecreated` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `suscripciones`
--

INSERT INTO `suscripciones` (`idsuscripcion`, `nombre`, `email`, `datecreated`) VALUES
(1, 'Roberto', 'toolsfordeveloper@gmail.com', '2024-05-03 04:05:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipopago`
--

CREATE TABLE `tipopago` (
  `idtipopago` bigint(20) NOT NULL,
  `tipopago` varchar(100) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_swedish_ci;

--
-- Volcado de datos para la tabla `tipopago`
--

INSERT INTO `tipopago` (`idtipopago`, `tipopago`, `status`) VALUES
(1, 'PayPal', 1),
(2, 'Efectivo', 1),
(3, 'Tarjeta', 1),
(4, 'Cheque', 1),
(5, 'Despósito Bancario', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idcategoria`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedidoid` (`pedidoid`),
  ADD KEY `productoid` (`productoid`);

--
-- Indices de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productoid` (`productoid`),
  ADD KEY `personaid` (`personaid`);

--
-- Indices de la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productoid` (`productoid`);

--
-- Indices de la tabla `modulo`
--
ALTER TABLE `modulo`
  ADD PRIMARY KEY (`idmodulo`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`idpedido`),
  ADD KEY `personaid` (`personaid`),
  ADD KEY `tipopagoid` (`tipopagoid`);

--
-- Indices de la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`idpermiso`),
  ADD KEY `rolid` (`rolid`),
  ADD KEY `moduloid` (`moduloid`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`idpersona`),
  ADD KEY `rolid` (`rolid`);

--
-- Indices de la tabla `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`idpost`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `categoriaid` (`categoriaid`);

--
-- Indices de la tabla `reembolso`
--
ALTER TABLE `reembolso`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedidoid` (`pedidoid`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`idrol`);

--
-- Indices de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  ADD PRIMARY KEY (`idsuscripcion`);

--
-- Indices de la tabla `tipopago`
--
ALTER TABLE `tipopago`
  ADD PRIMARY KEY (`idtipopago`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idcategoria` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagen`
--
ALTER TABLE `imagen`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `modulo`
--
ALTER TABLE `modulo`
  MODIFY `idmodulo` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `idpedido` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `permisos`
--
ALTER TABLE `permisos`
  MODIFY `idpermiso` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `idpersona` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `post`
--
ALTER TABLE `post`
  MODIFY `idpost` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `idproducto` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `reembolso`
--
ALTER TABLE `reembolso`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `idrol` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `suscripciones`
--
ALTER TABLE `suscripciones`
  MODIFY `idsuscripcion` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `tipopago`
--
ALTER TABLE `tipopago`
  MODIFY `idtipopago` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`pedidoid`) REFERENCES `pedido` (`idpedido`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`productoid`) REFERENCES `producto` (`idproducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_temp`
--
ALTER TABLE `detalle_temp`
  ADD CONSTRAINT `detalle_temp_ibfk_1` FOREIGN KEY (`productoid`) REFERENCES `producto` (`idproducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `imagen`
--
ALTER TABLE `imagen`
  ADD CONSTRAINT `imagen_ibfk_1` FOREIGN KEY (`productoid`) REFERENCES `producto` (`idproducto`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`personaid`) REFERENCES `persona` (`idpersona`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`tipopagoid`) REFERENCES `tipopago` (`idtipopago`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `permisos`
--
ALTER TABLE `permisos`
  ADD CONSTRAINT `permisos_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `permisos_ibfk_2` FOREIGN KEY (`moduloid`) REFERENCES `modulo` (`idmodulo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`rolid`) REFERENCES `rol` (`idrol`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`categoriaid`) REFERENCES `categoria` (`idcategoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reembolso`
--
ALTER TABLE `reembolso`
  ADD CONSTRAINT `reembolso_ibfk_1` FOREIGN KEY (`pedidoid`) REFERENCES `pedido` (`idpedido`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
