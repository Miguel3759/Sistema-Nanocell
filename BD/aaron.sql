-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.30 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para aaron
CREATE DATABASE IF NOT EXISTS `aaron` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aaron`;

-- Volcando estructura para procedimiento aaron.actualizar_precio_producto
DELIMITER //
CREATE PROCEDURE `actualizar_precio_producto`(IN `n_cantidad` INT, IN `n_precio` DECIMAL(10,2), IN `codigo` INT)
BEGIN
DECLARE nueva_existencia int;
DECLARE nuevo_total decimal(10,2);
DECLARE nuevo_precio decimal(10,2);

DECLARE cant_actual int;
DECLARE pre_actual decimal(10,2);

DECLARE actual_existencia int;
DECLARE actual_precio decimal(10,2);

SELECT precio, existencia INTO actual_precio, actual_existencia FROM producto WHERE codproducto = codigo;

SET nueva_existencia = actual_existencia + n_cantidad;
SET nuevo_total = n_precio;
SET nuevo_precio = nuevo_total;

UPDATE producto SET existencia = nueva_existencia, precio = nuevo_precio WHERE codproducto = codigo;

SELECT nueva_existencia, nuevo_precio;
END//
DELIMITER ;

-- Volcando estructura para procedimiento aaron.add_detalle_temp
DELIMITER //
CREATE PROCEDURE `add_detalle_temp`(`codigo` INT, `cantidad` INT, `token_user` VARCHAR(50))
BEGIN
DECLARE precio_actual decimal(10,2);
SELECT precio INTO precio_actual FROM producto WHERE codproducto = codigo;
INSERT INTO detalle_temp(token_user, codproducto, cantidad, precio_venta) VALUES (token_user, codigo, cantidad, precio_actual);
SELECT tmp.correlativo, tmp.codproducto, p.descripcion, tmp.cantidad, tmp.precio_venta FROM detalle_temp tmp INNER JOIN producto p ON tmp.codproducto = p.codproducto WHERE tmp.token_user = token_user;
END//
DELIMITER ;

-- Volcando estructura para tabla aaron.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `idcliente` int NOT NULL AUTO_INCREMENT,
  `ci` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `telefono` int NOT NULL,
  `direccion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`idcliente`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.cliente: ~33 rows (aproximadamente)
INSERT INTO `cliente` (`idcliente`, `ci`, `nombre`, `telefono`, `direccion`, `usuario_id`) VALUES
	(1, 45484445, 'ESTEFANY MAMANI ESTRADA', 74787579, 'CALLE OLMOS N° 14', 11),
	(2, 10561508, 'ADRIAN MILLARES MANTOJA', 74757678, 'CALLE SAAVEDRA N° 14', 11),
	(3, 10561517, 'PILAR CHUMACERO ANDRADE', 74747442, 'CALLE LAPAZ N° 2', 11),
	(4, 10515100, 'MARCELO TABORGA GUTIERREZ', 63647478, 'AV. ILUSTRES N° 41', 11),
	(5, 56585442, 'SHIRLEY ROCIO RUIZ ROJAS', 74757679, 'AV. MURILLO N° 814', 11),
	(6, 56599871, 'MARIBEL TATIANA CONDE LLANOS', 74757879, 'CALLE TAPIA N° 540', 11),
	(9, 45102526, 'ROBERTO LOPEZ QUENTAZI', 75412526, 'AV. CIRCUNVACION N° 104', 1),
	(10, 45265359, 'PEDRO MURILLO SANDOVAL', 65584524, 'CALLE PERU N° 510', 1),
	(11, 54565952, 'MARGOT RODAS ROJAS', 66021245, 'AV. ITALINA N° 122', 1),
	(12, 10254114, 'EUGENIO TOMAS LOAIZA TORREZ', 74550011, 'CALLE INDEPENDENCIA N° 045', 1),
	(13, 1223335, 'LEONARADA MIRARDA ALEJO', 78520011, 'AV. BOLIVIA N° 14', 1),
	(14, 41251523, 'JUAN PEREZ GOMEZ', 71234567, 'CALLE CHUQUISACA N° 123', 1),
	(15, 10102566, 'MARIA RODRIGUEZ LOPEZ', 71234568, 'CALLE BOLIVAR N° 456', 1),
	(16, 54152654, 'PEDRO GARCIA MARTINEZ', 71234569, 'CALLE SUCRE N° 789', 1),
	(17, 63958745, 'LUCIA FERNANDEZ GONZALEZ', 71234570, 'CALLE LITORAL N° 1011', 1),
	(18, 58550011, 'CARLOS RAMIREZ HERNANDEZ', 71234571, 'CALLE TUPAC AMARU N° 1213', 1),
	(19, 10564411, 'ANA TORRES DIAZ', 71234572, 'CALLE COCHABAMBA #1415', 1),
	(20, 12114488, 'JORGE SANCHEZ PEREZ', 71234573, 'CALLE ORURO N°1617', 1),
	(21, 65251544, 'SILVIA MARTINEZ RODRIGUEZ', 71234574, 'CALLE LA PAZ N° 1819', 1),
	(22, 66102555, 'RAUL LOPEZ GARCIA', 71234575, 'CALLE POTOSI N° 2021', 1),
	(23, 10220011, 'ELENA GONZALEZ FERNANDEZ', 71234576, 'CALLE SANTA CRUZ #2223', 1),
	(24, 10894788, 'MIGUEL HERNANDEZ RAMIREZ', 71234577, 'CALLE BENI N° 2425', 1),
	(25, 11008877, 'PATRICIA GOMEZ TORRES', 71234578, 'CALLE PANDO N° 2627', 1),
	(26, 10102288, 'MANUEL DIAZ SANCHEZ', 71234579, 'CALLE ITURRALDE N° 2829', 1),
	(27, 55447185, 'ROSA PEREZ MARTINEZ', 71234580, 'CALLE MADRE DE DIOS N° 3031', 1),
	(28, 10564877, 'OSCAR HERNANDEZ LOPEZ', 71234581, 'CALLE ALTIPLANO N° 3233', 1),
	(29, 10235645, 'LAURA GONZALEZ RAMIREZ', 71234582, 'CALLE CINTI N° 3435', 1),
	(30, 56550011, 'FERNANDO MARTINEZ GARCIA', 71234583, 'CALLE JUANA AZURDUY N° 3637', 1),
	(31, 45895522, 'GLORIA RODRIGUEZ HERNANDEZ', 71234584, 'CALLE CHACO N° 3839', 1),
	(32, 12459555, 'DIEGO SANCHEZ GOMEZ', 71234585, 'CALLE TARIJA N° 4041', 1),
	(33, 15658800, 'ANGELICA FERNANDEZ TORRES', 71234586, 'CALLE VICTOR HUGO N° 4243', 1),
	(34, 12155544, 'VILMA ESTRADA QUISPE', 74768945, 'CALLE LUCAS JAIMES N° 42', 1),
	(35, 10255684, 'MARISOL MONICA DORIAN LOPEZ', 62567400, 'CALLE CAMARGO N° 14', 1);

-- Volcando estructura para tabla aaron.configuracion
CREATE TABLE IF NOT EXISTS `configuracion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ci` int NOT NULL,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `telefono` int NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `direccion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `igv` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.configuracion: ~1 rows (aproximadamente)
INSERT INTO `configuracion` (`id`, `ci`, `nombre`, `telefono`, `email`, `direccion`, `igv`) VALUES
	(1, 1010109999, 'MOISES AARON CHOQUE VALVERDE', 63710855, 'nanocell@gmail.com', 'Potosi - Bolivia', 1.10);

-- Volcando estructura para procedimiento aaron.data
DELIMITER //
CREATE PROCEDURE `data`()
BEGIN
DECLARE usuarios int;
DECLARE clientes int;
DECLARE proveedores int;
DECLARE productos int;
DECLARE ventas int;
SELECT COUNT(*) INTO usuarios FROM usuario;
SELECT COUNT(*) INTO clientes FROM cliente;
SELECT COUNT(*) INTO proveedores FROM proveedor;
SELECT COUNT(*) INTO productos FROM producto;
SELECT COUNT(*) INTO ventas FROM factura WHERE fecha > CURDATE();

SELECT usuarios, clientes, proveedores, productos, ventas;

END//
DELIMITER ;

-- Volcando estructura para procedimiento aaron.del_detalle_temp
DELIMITER //
CREATE PROCEDURE `del_detalle_temp`(`id_detalle` INT, `token` VARCHAR(50))
BEGIN
DELETE FROM detalle_temp WHERE correlativo = id_detalle;
SELECT tmp.correlativo, tmp.codproducto, p.descripcion, tmp.cantidad, tmp.precio_venta FROM detalle_temp tmp INNER JOIN producto p ON tmp.codproducto = p.codproducto WHERE tmp.token_user = token;
END//
DELIMITER ;

-- Volcando estructura para tabla aaron.detallefactura
CREATE TABLE IF NOT EXISTS `detallefactura` (
  `correlativo` bigint NOT NULL AUTO_INCREMENT,
  `nofactura` bigint NOT NULL,
  `codproducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`correlativo`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.detallefactura: ~61 rows (aproximadamente)
INSERT INTO `detallefactura` (`correlativo`, `nofactura`, `codproducto`, `cantidad`, `precio_venta`) VALUES
	(1, 1, 2, 2, 2500.00),
	(2, 2, 6, 2, 750.00),
	(3, 3, 1, 2, 1560.00),
	(4, 4, 6, 2, 750.00),
	(5, 5, 1, 1, 1560.00),
	(6, 6, 1, 3, 1560.00),
	(7, 7, 6, 2, 750.00),
	(8, 8, 1, 1, 1560.00),
	(9, 9, 6, 1, 750.00),
	(10, 10, 1, 1, 1560.00),
	(11, 11, 1, 1, 1560.00),
	(12, 12, 1, 1, 1560.00),
	(13, 13, 1, 1, 1560.00),
	(14, 14, 1, 1, 1560.00),
	(15, 15, 1, 1, 1560.00),
	(16, 16, 1, 2, 1560.00),
	(17, 17, 1, 1, 1560.00),
	(18, 18, 2, 1, 2500.00),
	(19, 19, 1, 1, 1560.00),
	(20, 20, 1, 1, 1560.00),
	(21, 21, 6, 2, 750.00),
	(22, 22, 1, 5, 1560.00),
	(23, 23, 2, 2, 2500.00),
	(24, 23, 1, 1, 1560.00),
	(25, 23, 6, 1, 750.00),
	(26, 24, 8, 1, 4800.00),
	(27, 24, 1, 2, 1560.00),
	(28, 24, 6, 4, 750.00),
	(29, 24, 1, 7, 1560.00),
	(30, 24, 2, 10, 2500.00),
	(33, 25, 2, 2, 2500.00),
	(34, 26, 1, 1, 1560.00),
	(35, 27, 1, 1, 1560.00),
	(36, 28, 1, 2, 1560.00),
	(37, 29, 1, 1, 1560.00),
	(38, 30, 1, 1, 1560.00),
	(39, 31, 9, 2, 4800.00),
	(40, 32, 1, 1, 1560.00),
	(41, 32, 8, 2, 4800.00),
	(42, 32, 9, 1, 4800.00),
	(43, 33, 1, 1, 1560.00),
	(44, 34, 1, 1, 1560.00),
	(45, 35, 1, 3, 1560.00),
	(46, 36, 1, 3, 1560.00),
	(47, 37, 2, 12, 2500.00),
	(48, 38, 1, 1, 1560.00),
	(49, 39, 2, 1, 8000.00),
	(50, 39, 36, 1, 40.00),
	(51, 39, 62, 2, 2000.00),
	(52, 40, 2, 3, 8000.00),
	(53, 41, 6, 3, 1700.00),
	(54, 42, 13, 1, 2800.00),
	(55, 42, 35, 2, 120.00),
	(56, 42, 41, 1, 150.00),
	(57, 42, 38, 3, 60.00),
	(58, 42, 8, 1, 4800.00),
	(61, 43, 5, 1, 2300.00),
	(62, 43, 12, 1, 1800.00),
	(63, 43, 22, 1, 1000.00),
	(64, 43, 1, 1, 4500.00),
	(65, 43, 30, 2, 1200.00);

-- Volcando estructura para tabla aaron.detalle_temp
CREATE TABLE IF NOT EXISTS `detalle_temp` (
  `correlativo` int NOT NULL AUTO_INCREMENT,
  `token_user` varchar(50) NOT NULL,
  `codproducto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  PRIMARY KEY (`correlativo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla aaron.detalle_temp: ~0 rows (aproximadamente)

-- Volcando estructura para tabla aaron.entradas
CREATE TABLE IF NOT EXISTS `entradas` (
  `correlativo` int NOT NULL AUTO_INCREMENT,
  `codproducto` int NOT NULL,
  `fecha` datetime NOT NULL,
  `cantidad` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`correlativo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla aaron.entradas: ~0 rows (aproximadamente)

-- Volcando estructura para tabla aaron.factura
CREATE TABLE IF NOT EXISTS `factura` (
  `nofactura` int NOT NULL AUTO_INCREMENT,
  `fecha` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `usuario` int NOT NULL,
  `codcliente` int NOT NULL,
  `totalfactura` decimal(10,2) NOT NULL,
  `estado` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`nofactura`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.factura: ~43 rows (aproximadamente)
INSERT INTO `factura` (`nofactura`, `fecha`, `usuario`, `codcliente`, `totalfactura`, `estado`) VALUES
	(1, '2024-06-22 19:05:52', 9, 2, 5000.00, 1),
	(2, '2024-06-22 19:14:12', 9, 1, 1500.00, 1),
	(3, '2024-06-22 19:16:31', 11, 2, 3120.00, 1),
	(4, '2024-06-22 19:38:55', 11, 1, 1500.00, 1),
	(5, '2024-06-22 21:06:32', 11, 1, 1560.00, 1),
	(6, '2024-06-22 21:38:17', 11, 1, 4680.00, 1),
	(7, '2024-06-22 21:39:30', 11, 1, 1500.00, 1),
	(8, '2024-06-22 21:47:43', 11, 1, 1560.00, 1),
	(9, '2024-06-22 21:54:10', 11, 1, 750.00, 1),
	(10, '2024-06-22 22:01:34', 11, 1, 1560.00, 1),
	(11, '2024-06-22 22:05:12', 11, 1, 1560.00, 1),
	(12, '2024-06-22 23:01:15', 11, 1, 1560.00, 1),
	(13, '2024-06-22 23:20:00', 11, 1, 1560.00, 1),
	(14, '2024-06-23 00:07:26', 11, 1, 1560.00, 1),
	(15, '2024-06-23 00:08:17', 11, 1, 1560.00, 1),
	(16, '2024-06-23 00:09:42', 11, 1, 3120.00, 1),
	(17, '2024-06-23 00:10:35', 11, 1, 1560.00, 1),
	(18, '2024-06-23 00:11:48', 11, 1, 2500.00, 1),
	(19, '2024-06-23 01:18:25', 11, 1, 1560.00, 1),
	(20, '2024-06-23 01:46:22', 11, 4, 1560.00, 1),
	(21, '2024-06-23 01:47:28', 11, 6, 1500.00, 1),
	(22, '2024-06-23 01:50:48', 11, 4, 7800.00, 1),
	(23, '2024-06-23 02:06:19', 11, 4, 7310.00, 1),
	(24, '2024-06-23 02:09:03', 11, 7, 46840.00, 1),
	(25, '2024-06-23 02:16:00', 11, 5, 5000.00, 1),
	(26, '2024-06-23 02:21:23', 11, 5, 1560.00, 1),
	(27, '2024-06-23 11:50:42', 11, 5, 1560.00, 1),
	(28, '2024-06-23 12:24:45', 11, 4, 3120.00, 1),
	(29, '2024-06-23 13:41:10', 11, 4, 1560.00, 1),
	(30, '2024-06-23 15:09:47', 11, 5, 1560.00, 1),
	(31, '2024-06-23 16:36:40', 11, 8, 9600.00, 1),
	(32, '2024-06-23 16:39:23', 11, 8, 15960.00, 1),
	(33, '2024-06-23 16:47:10', 11, 4, 1560.00, 1),
	(34, '2024-06-23 17:10:06', 11, 4, 1560.00, 1),
	(35, '2024-06-23 17:23:01', 11, 5, 4680.00, 1),
	(36, '2024-06-23 17:35:40', 11, 3, 4680.00, 1),
	(37, '2024-06-23 17:37:43', 11, 4, 30000.00, 1),
	(38, '2024-06-23 17:42:52', 15, 4, 1560.00, 1),
	(39, '2024-06-23 19:48:56', 1, 5, 12040.00, 1),
	(40, '2024-06-23 21:25:47', 1, 1, 24000.00, 1),
	(41, '2024-06-23 22:00:57', 1, 6, 5100.00, 1),
	(42, '2024-06-23 22:05:58', 1, 12, 8170.00, 1),
	(43, '2024-06-23 22:45:20', 1, 10, 12000.00, 1);

-- Volcando estructura para procedimiento aaron.procesar_venta
DELIMITER //
CREATE PROCEDURE `procesar_venta`(IN `cod_usuario` INT, IN `cod_cliente` INT, IN `token` VARCHAR(50))
BEGIN
DECLARE factura INT;
DECLARE registros INT;
DECLARE total DECIMAL(10,2);
DECLARE nueva_existencia int;
DECLARE existencia_actual int;

DECLARE tmp_cod_producto int;
DECLARE tmp_cant_producto int;
DECLARE a int;
SET a = 1;

CREATE TEMPORARY TABLE tbl_tmp_tokenuser(
	id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cod_prod BIGINT,
    cant_prod int);
SET registros = (SELECT COUNT(*) FROM detalle_temp WHERE token_user = token);
IF registros > 0 THEN
INSERT INTO tbl_tmp_tokenuser(cod_prod, cant_prod) SELECT codproducto, cantidad FROM detalle_temp WHERE token_user = token;
INSERT INTO factura (usuario,codcliente) VALUES (cod_usuario, cod_cliente);
SET factura = LAST_INSERT_ID();

INSERT INTO detallefactura(nofactura,codproducto,cantidad,precio_venta) SELECT (factura) AS nofactura, codproducto, cantidad,precio_venta FROM detalle_temp WHERE token_user = token;
WHILE a <= registros DO
	SELECT cod_prod, cant_prod INTO tmp_cod_producto,tmp_cant_producto FROM tbl_tmp_tokenuser WHERE id = a;
    SELECT existencia INTO existencia_actual FROM producto WHERE codproducto = tmp_cod_producto;
    SET nueva_existencia = existencia_actual - tmp_cant_producto;
    UPDATE producto SET existencia = nueva_existencia WHERE codproducto = tmp_cod_producto;
    SET a=a+1;
END WHILE;
SET total = (SELECT SUM(cantidad * precio_venta) FROM detalle_temp WHERE token_user = token);
UPDATE factura SET totalfactura = total WHERE nofactura = factura;
DELETE FROM detalle_temp WHERE token_user = token;
TRUNCATE TABLE tbl_tmp_tokenuser;
SELECT * FROM factura WHERE nofactura = factura;
ELSE
SELECT 0;
END IF;
END//
DELIMITER ;

-- Volcando estructura para tabla aaron.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `codproducto` int NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `proveedor` int NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `existencia` int NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`codproducto`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.producto: ~53 rows (aproximadamente)
INSERT INTO `producto` (`codproducto`, `descripcion`, `proveedor`, `precio`, `existencia`, `usuario_id`) VALUES
	(1, 'SAMSUNG GALAXY S22', 2, 4500.00, 11, 1),
	(2, 'IPHONE 13 PRO', 3, 8000.00, 6, 1),
	(3, 'XIAOMI REDMI NOTE 11', 2, 1500.00, 8, 1),
	(4, 'SAMSUNG GALAXY A52S', 2, 2500.00, 15, 1),
	(5, 'IPHONE SE (2022)', 3, 2300.00, 8, 1),
	(6, 'MOTOROLA MOTO G STYLUS', 2, 1700.00, 9, 1),
	(7, 'GOOGLE PIXEL 7', 2, 3900.00, 7, 1),
	(8, 'ONEPLUS 9 PRO', 2, 4800.00, 12, 1),
	(9, 'SAMSUNG GALAXY Z FLIP 3', 2, 6000.00, 15, 1),
	(10, 'IPHONE 12 MINI ', 3, 3500.00, 4, 1),
	(11, 'XIAOMI MI 11 LITE', 2, 1900.00, 20, 1),
	(12, 'SAMSUNG GALAXY A32', 2, 1800.00, 5, 1),
	(13, 'IPHONE 11', 3, 2800.00, 2, 1),
	(14, 'GOOGLE PIXEL 5A', 2, 3000.00, 4, 1),
	(15, 'SAMSUNG GALAXY S21 ULTRA', 2, 5800.00, 2, 1),
	(16, 'MOTOROLA EDGE 20', 2, 2600.00, 4, 1),
	(17, 'ONEPLUS NORD 2', 2, 3100.00, 2, 1),
	(18, 'XIAOMI POCO X3 PRO', 2, 1700.00, 6, 1),
	(19, 'SAMSUNG GALAXY A12', 2, 1300.00, 5, 1),
	(20, 'IPHONE XR', 3, 2400.00, 4, 1),
	(21, 'GOOGLE PIXEL 4A', 2, 2000.00, 7, 1),
	(22, 'SAMSUNG GALAXY A02S', 3, 1000.00, 5, 1),
	(23, 'MOTOROLA MOTO G POWER (2021)', 2, 1500.00, 8, 1),
	(24, 'ONEPLUS 8T', 2, 3400.00, 8, 1),
	(25, 'XIAOMI REDMI NOTE 10', 2, 1600.00, 9, 1),
	(26, 'SAMSUNG GALAXY S20 FE', 2, 3200.00, 7, 1),
	(27, 'IPHONE SE (2020) ', 2, 1900.00, 3, 1),
	(28, 'GOOGLE PIXEL 4 XL', 2, 2800.00, 5, 1),
	(29, 'SAMSUNG GALAXY A22', 2, 2000.00, 8, 1),
	(30, 'MOTOROLA MOTO G9 PLAY', 2, 1200.00, 2, 1),
	(31, 'FUNDA PROTECTORA', 1, 50.00, 60, 1),
	(32, 'VIDRIO TEMPLADO', 1, 30.00, 45, 1),
	(33, 'CARGADOR INALÁMBRICO', 1, 100.00, 12, 1),
	(34, 'AURICULARES BLUETOOTH', 1, 80.00, 12, 1),
	(35, 'BATERÍA EXTERNA', 1, 120.00, 4, 1),
	(36, 'ESTUCHE PARA AURICULARES', 1, 40.00, 11, 1),
	(37, 'CABLE USB-C', 1, 20.00, 17, 1),
	(38, 'ADAPTADOR DE CARGA RÁPIDA', 1, 60.00, 22, 1),
	(39, 'SOPORTE PARA CELULAR EN AUTO', 1, 70.00, 10, 1),
	(40, 'BOLSA ESTANCA PARA CELULAR', 1, 50.00, 14, 1),
	(41, 'TECLADO BLUETOOTH', 1, 150.00, 9, 1),
	(42, 'MOCHILA ANTIRROBO CON CARGADOR USB', 1, 200.00, 4, 1),
	(43, 'ALTAVOZ PORTÁTIL', 1, 100.00, 8, 1),
	(44, 'LÁPIZ ÓPTICO', 1, 30.00, 9, 1),
	(45, 'BASE DE CARGA', 1, 80.00, 14, 1),
	(46, 'LENTES PARA CELULAR', 1, 50.00, 2, 1),
	(47, 'MICRÓFONO EXTERNO', 1, 80.00, 4, 1),
	(48, 'ADAPTADOR DE AUDIO USB-C A 3.5MM', 1, 40.00, 7, 1),
	(49, 'ESTUCHE PARA DISCO DURO EXTERNO', 1, 60.00, 7, 1),
	(50, 'BASE REFRIGERANTE PARA LAPTOP', 1, 100.00, 5, 1),
	(62, 'TECNO POVA 20 PRO', 2, 2000.00, 2, 1),
	(63, 'REDMI RENO 40 PLUS', 2, 4500.00, 3, 1),
	(64, 'MEMORIA FLASH 32GB', 1, 180.00, 5, 1);

-- Volcando estructura para tabla aaron.proveedor
CREATE TABLE IF NOT EXISTS `proveedor` (
  `codproveedor` int NOT NULL AUTO_INCREMENT,
  `proveedor` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `contacto` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `telefono` int NOT NULL,
  `direccion` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`codproveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.proveedor: ~3 rows (aproximadamente)
INSERT INTO `proveedor` (`codproveedor`, `proveedor`, `contacto`, `telefono`, `direccion`, `usuario_id`) VALUES
	(1, 'PROVEEDOR DE ACCESORIOS', '9852456623', 74757897, 'CALLE ALARGON N° 10 LA PAZ', 2),
	(2, 'PROVEEDOR DE CELULARES ANDROID', '1415121614', 637418525, 'CALLE LAS FLORES N° 520 CHILE-EQUIQUE', 9),
	(3, 'PROVEDOR DE CELULARES IPHONE', '1056154875', 4585867, 'STATE STREET N° 520 EE.UU', 11);

-- Volcando estructura para tabla aaron.rol
CREATE TABLE IF NOT EXISTS `rol` (
  `idrol` int NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  PRIMARY KEY (`idrol`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.rol: ~2 rows (aproximadamente)
INSERT INTO `rol` (`idrol`, `rol`) VALUES
	(1, 'Administrador'),
	(2, 'Vendedor');

-- Volcando estructura para tabla aaron.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `idusuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `correo` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `usuario` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `clave` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish_ci NOT NULL,
  `rol` int NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish_ci;

-- Volcando datos para la tabla aaron.usuario: ~1 rows (aproximadamente)
INSERT INTO `usuario` (`idusuario`, `nombre`, `correo`, `usuario`, `clave`, `rol`) VALUES
	(1, 'MOISES AARON CHOQUE VALVERDE', 'moises@gmail.com', 'moises', '2000b7287e012511c77a7b2517e838ba', 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
