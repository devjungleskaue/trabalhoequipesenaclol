-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: pdv_cafeteria
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `caixa`
--

DROP TABLE IF EXISTS `caixa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `caixa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int NOT NULL,
  `data_abertura` timestamp NOT NULL,
  `data_fechamento` timestamp NULL DEFAULT NULL,
  `valor_abertura` decimal(10,2) NOT NULL,
  `valor_fechamento` decimal(10,2) DEFAULT NULL,
  `total_vendas` decimal(10,2) DEFAULT NULL,
  `total_descontos` decimal(10,2) DEFAULT NULL,
  `total_quebras` decimal(10,2) DEFAULT NULL,
  `status` enum('aberto','fechado') DEFAULT 'aberto',
  `observacoes` text,
  PRIMARY KEY (`id`),
  KEY `usuario_id` (`usuario_id`),
  KEY `idx_caixa_status` (`status`),
  CONSTRAINT `caixa_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `caixa`
--

LOCK TABLES `caixa` WRITE;
/*!40000 ALTER TABLE `caixa` DISABLE KEYS */;
/*!40000 ALTER TABLE `caixa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` text,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Bebidas Quentes','Cafés, chás e chocolate quente',1,'2026-06-16 00:29:29'),(2,'Bebidas Geladas','Sucos, refrigerantes e drinks gelados',1,'2026-06-16 00:29:29'),(3,'Salgados','Pães, sanduíches e salgados em geral',1,'2026-06-16 00:29:29'),(4,'Doces','Bolos, tortas e sobremesas',1,'2026-06-16 00:29:29'),(5,'Café Especial','Cafés especiais e gourmet',1,'2026-06-16 00:29:29');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `endereco` text,
  `pontos_fidelidade` int DEFAULT '0',
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `cpf` (`cpf`),
  KEY `idx_clientes_cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configuracoes`
--

DROP TABLE IF EXISTS `configuracoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configuracoes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chave` varchar(50) NOT NULL,
  `valor` text,
  `descricao` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `chave` (`chave`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configuracoes`
--

LOCK TABLES `configuracoes` WRITE;
/*!40000 ALTER TABLE `configuracoes` DISABLE KEYS */;
INSERT INTO `configuracoes` VALUES (1,'nome_empresa','Cafeteria Gourmet','Nome da empresa'),(2,'cnpj','00.000.000/0001-00','CNPJ da empresa'),(3,'taxa_servico','10','Taxa de serviço em porcentagem'),(4,'imprimir_pedido','true','Imprimir pedido automaticamente'),(5,'prazo_fiado','30','Prazo para pagamento fiado em dias');
/*!40000 ALTER TABLE `configuracoes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formas_pagamento`
--

DROP TABLE IF EXISTS `formas_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formas_pagamento` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `descricao` text,
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formas_pagamento`
--

LOCK TABLES `formas_pagamento` WRITE;
/*!40000 ALTER TABLE `formas_pagamento` DISABLE KEYS */;
INSERT INTO `formas_pagamento` VALUES (1,'Dinheiro',NULL,1),(2,'Cartão de Crédito',NULL,1),(3,'Cartão de Débito',NULL,1),(4,'PIX',NULL,1),(5,'Vale Refeição',NULL,1),(6,'Fiado',NULL,1);
/*!40000 ALTER TABLE `formas_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itens_pedido`
--

DROP TABLE IF EXISTS `itens_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pedido_id` int NOT NULL,
  `produto_id` int NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL,
  `desconto_item` decimal(10,2) DEFAULT '0.00',
  `subtotal_item` decimal(10,2) NOT NULL,
  `observacoes_item` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_itens_pedido_pedido` (`pedido_id`),
  KEY `idx_itens_pedido_produto` (`produto_id`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movimentacoes_caixa`
--

DROP TABLE IF EXISTS `movimentacoes_caixa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `movimentacoes_caixa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `caixa_id` int NOT NULL,
  `pedido_id` int DEFAULT NULL,
  `tipo` enum('entrada','saida') NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `valor` decimal(10,2) NOT NULL,
  `forma_pagamento_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `caixa_id` (`caixa_id`),
  KEY `pedido_id` (`pedido_id`),
  KEY `forma_pagamento_id` (`forma_pagamento_id`),
  CONSTRAINT `movimentacoes_caixa_ibfk_1` FOREIGN KEY (`caixa_id`) REFERENCES `caixa` (`id`),
  CONSTRAINT `movimentacoes_caixa_ibfk_2` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  CONSTRAINT `movimentacoes_caixa_ibfk_3` FOREIGN KEY (`forma_pagamento_id`) REFERENCES `formas_pagamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movimentacoes_caixa`
--

LOCK TABLES `movimentacoes_caixa` WRITE;
/*!40000 ALTER TABLE `movimentacoes_caixa` DISABLE KEYS */;
/*!40000 ALTER TABLE `movimentacoes_caixa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero_pedido` varchar(20) DEFAULT NULL,
  `cliente_id` int DEFAULT NULL,
  `status_id` int NOT NULL,
  `forma_pagamento_id` int DEFAULT NULL,
  `subtotal` decimal(10,2) NOT NULL DEFAULT '0.00',
  `desconto` decimal(10,2) DEFAULT '0.00',
  `taxa_servico` decimal(10,2) DEFAULT '0.00',
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `valor_pago` decimal(10,2) DEFAULT '0.00',
  `troco` decimal(10,2) DEFAULT '0.00',
  `observacoes` text,
  `tipo_pedido` enum('local','entrega','retirada') DEFAULT 'local',
  `data_pedido` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numero_pedido` (`numero_pedido`),
  KEY `cliente_id` (`cliente_id`),
  KEY `forma_pagamento_id` (`forma_pagamento_id`),
  KEY `idx_pedidos_status` (`status_id`),
  KEY `idx_pedidos_data` (`data_pedido`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`status_id`) REFERENCES `status_pedido` (`id`),
  CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`forma_pagamento_id`) REFERENCES `formas_pagamento` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) DEFAULT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text,
  `preco_custo` decimal(10,2) DEFAULT NULL,
  `preco_venda` decimal(10,2) NOT NULL,
  `estoque` int DEFAULT '0',
  `estoque_minimo` int DEFAULT '5',
  `categoria_id` int DEFAULT NULL,
  `imagem` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo` (`codigo`),
  KEY `idx_produtos_codigo` (`codigo`),
  KEY `idx_produtos_categoria` (`categoria_id`),
  CONSTRAINT `produtos_ibfk_1` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,'BQ001','Café Expresso','Café expresso tradicional',2.50,6.00,100,20,1,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(2,'BQ002','Café com Leite','Café com leite vaporizado',3.00,8.00,100,20,1,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(3,'BQ003','Cappuccino','Cappuccino com canela e chocolate',4.00,12.00,80,15,1,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(4,'BQ004','Chocolate Quente','Chocolate quente cremoso',3.50,10.00,50,10,1,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(5,'BG001','Suco de Laranja','Suco natural de laranja',3.00,8.00,30,10,2,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(6,'BG002','Limonada Suíça','Limonada com gelo',2.00,7.00,40,10,2,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(7,'SL001','Pão de Queijo','Pão de queijo mineiro',2.00,5.00,60,15,3,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(8,'SL002','Croissant','Croissant francês',3.50,9.00,40,10,3,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(9,'DC001','Bolo de Chocolate','Fatia de bolo de chocolate',4.00,12.00,20,5,4,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29'),(10,'DC002','Torta de Limão','Fatia de torta de limão',3.50,11.00,15,5,4,NULL,1,'2026-06-16 00:29:29','2026-06-16 00:29:29');
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status_pedido`
--

DROP TABLE IF EXISTS `status_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `status_pedido` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `cor` varchar(7) DEFAULT '#000000',
  `ativo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status_pedido`
--

LOCK TABLES `status_pedido` WRITE;
/*!40000 ALTER TABLE `status_pedido` DISABLE KEYS */;
INSERT INTO `status_pedido` VALUES (1,'Novo','#3498db',1),(2,'Em Preparo','#f39c12',1),(3,'Pronto','#2ecc71',1),(4,'Entregue','#27ae60',1),(5,'Cancelado','#e74c3c',1);
/*!40000 ALTER TABLE `status_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha_hash` varchar(255) NOT NULL,
  `perfil` enum('admin','gerente','atendente','caixa') NOT NULL,
  `ativo` tinyint(1) DEFAULT '1',
  `ultimo_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Administrador','admin@cafeteria.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','admin',1,NULL,'2026-06-16 00:29:29');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `vw_produtos_mais_vendidos`
--

DROP TABLE IF EXISTS `vw_produtos_mais_vendidos`;
/*!50001 DROP VIEW IF EXISTS `vw_produtos_mais_vendidos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_produtos_mais_vendidos` AS SELECT 
 1 AS `produto`,
 1 AS `categoria`,
 1 AS `quantidade_vendida`,
 1 AS `total_vendas`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `vw_vendas_diarias`
--

DROP TABLE IF EXISTS `vw_vendas_diarias`;
/*!50001 DROP VIEW IF EXISTS `vw_vendas_diarias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `vw_vendas_diarias` AS SELECT 
 1 AS `data`,
 1 AS `total_pedidos`,
 1 AS `total_vendas`,
 1 AS `total_descontos`,
 1 AS `ticket_medio`,
 1 AS `forma_pagamento`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_produtos_mais_vendidos`
--

/*!50001 DROP VIEW IF EXISTS `vw_produtos_mais_vendidos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_produtos_mais_vendidos` AS select `pr`.`nome` AS `produto`,`c`.`nome` AS `categoria`,count(`ip`.`id`) AS `quantidade_vendida`,sum(`ip`.`subtotal_item`) AS `total_vendas` from (((`itens_pedido` `ip` join `produtos` `pr` on((`ip`.`produto_id` = `pr`.`id`))) join `categorias` `c` on((`pr`.`categoria_id` = `c`.`id`))) join `pedidos` `p` on((`ip`.`pedido_id` = `p`.`id`))) where (`p`.`status_id` <> 5) group by `pr`.`id`,`pr`.`nome`,`c`.`nome` order by `quantidade_vendida` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_vendas_diarias`
--

/*!50001 DROP VIEW IF EXISTS `vw_vendas_diarias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_vendas_diarias` AS select cast(`p`.`data_pedido` as date) AS `data`,count(distinct `p`.`id`) AS `total_pedidos`,sum(`p`.`total`) AS `total_vendas`,sum(`p`.`desconto`) AS `total_descontos`,avg(`p`.`total`) AS `ticket_medio`,`fp`.`nome` AS `forma_pagamento` from (`pedidos` `p` join `formas_pagamento` `fp` on((`p`.`forma_pagamento_id` = `fp`.`id`))) where (`p`.`status_id` <> 5) group by cast(`p`.`data_pedido` as date),`fp`.`nome` order by `data` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-15 21:32:18
