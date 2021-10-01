-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 08-Maio-2017 às 21:56
-- Versão do servidor: 5.6.24
-- PHP Version: 5.5.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `uniplast`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE IF NOT EXISTS `produtos` (
  `CD_PRODUTO` int(11) NOT NULL,
  `DS_PRODUTO` varchar(100) NOT NULL,
  `DS_LINHA` varchar(100) NOT NULL,
  `DS_COR` varchar(100) NOT NULL,
  `DS_MATERIAL` varchar(100) NOT NULL,
  `DS_APLIC_PRODUTO` varchar(100) NOT NULL,
  `DS_DETALHES` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`CD_PRODUTO`, `DS_PRODUTO`, `DS_LINHA`, `DS_COR`, `DS_MATERIAL`, `DS_APLIC_PRODUTO`, `DS_DETALHES`) VALUES
(416, 'Eliminador de Cantos co-extrusão', 'Construção Civil, Perfis Plásticos', 'Branco', 'PFC Ativo', 'Camaras Frigoríficas, Furgões Frigoríficos, Hospitais, Salas Limpas', 'Desenvolvido para fazer um acabamento em diversos tipos de cantos, este perfil tem as pontas das abas flexíveis que facilitam o encaixe e acabamento evitando o acumulo de sujeira e proporcionando um visual de acabamento muito agradável.'),
(431, 'Acabamento p/ revestimento Cerâmico', 'Construção Civil, Perfis Plásticos', 'Branco', 'PFC Ativo', 'Aplicações de revestimento', 'Excelente para acabamentos onde os cantos de pisos e revestimentos ficam aparentes ou com o visual prejudicado, este produto tem fácil aplicação e como o próprio nome sugere proporciona um ótimo acabamento além de trazer leveza ao ambiente onde é aplicado. Desenvolvido especialmente para a construção civil a superfície de contato é estampada em formato “U” para aderir melhor a massa e se enquadrar bem a sua função.'),
(461, 'Cantoneira PVC 58x58x3,5 mm', 'Construção Civil, Cantoneiras de PVC, Perfis Plásticos', 'Branco', 'Plástico', 'Camaras Frigoríficas, Colunas, Escadas, Furgões Frigoríficos, Salas Limpas', 'Utilizado para acabamento em cantos de câmaras frias e furgões frigoríficos, o perfil cantoneira é de fácil aplicação e também elimina os cantos vivos, facilitando a limpeza do local onde será instalado.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`CD_PRODUTO`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
