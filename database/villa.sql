-- phpMyAdmin SQL Dump
-- version 5.3.0-dev+20221024.fd16af9f6a
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 10, 2023 at 09:45 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `villa`
--

-- --------------------------------------------------------

--
-- Table structure for table `data_villa`
--

CREATE TABLE `data_villa` (
  `id_villa` varchar(10) NOT NULL,
  `nama_villa` varchar(20) NOT NULL,
  `kamar` int(11) NOT NULL,
  `kolam` int(11) NOT NULL,
  `alamat` text NOT NULL,
  `nohp` varchar(15) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `data_villa`
--

INSERT INTO `data_villa` (`id_villa`, `nama_villa`, `kamar`, `kolam`, `alamat`, `nohp`, `harga`) VALUES
('V001', 'Melati', 4, 1, 'Jl.Melati Timur', '085885463153', 2500000);

-- --------------------------------------------------------

--
-- Stand-in structure for view `laporan`
-- (See below for the actual view)
--
CREATE TABLE `laporan` (
`id_trans` varchar(10)
,`id_villa` varchar(10)
,`id_sewa` varchar(10)
,`nama` varchar(20)
,`nama_villa` varchar(20)
,`harga` int(11)
,`tgl_awal` date
,`tgl_akhir` date
,`hari` int(11)
,`total` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `penyewa`
--

CREATE TABLE `penyewa` (
  `id_sewa` varchar(10) NOT NULL,
  `nama` varchar(20) NOT NULL,
  `notlpn` varchar(15) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penyewa`
--

INSERT INTO `penyewa` (`id_sewa`, `nama`, `notlpn`, `alamat`) VALUES
('S001', 'Ahamd Bedul', '085582928774', 'Jl.Pancoran Barat IV D'),
('S002', 'Ronalfin', '085582928774', 'Jl.Kemana aja karna gabut');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_trans` varchar(10) NOT NULL,
  `id_villa` varchar(10) NOT NULL,
  `id_sewa` varchar(10) NOT NULL,
  `tgl_awal` date NOT NULL,
  `tgl_akhir` date NOT NULL,
  `harga` int(11) NOT NULL,
  `hari` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_trans`, `id_villa`, `id_sewa`, `tgl_awal`, `tgl_akhir`, `harga`, `hari`, `total`) VALUES
('T001', 'V001', 'S001', '2023-06-08', '2023-06-10', 2500000, 3, 7500000),
('T002', 'V001', 'S001', '2023-06-10', '2023-06-11', 2500000, 2, 5000000),
('T003', 'V001', 'S001', '2023-07-01', '2023-07-02', 2500000, 2, 5000000),
('T005', 'V001', 'S002', '2023-06-10', '2023-06-12', 2500000, 3, 7500000);

-- --------------------------------------------------------

--
-- Structure for view `laporan`
--
DROP TABLE IF EXISTS `laporan`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `laporan`  AS SELECT `transaksi`.`id_trans` AS `id_trans`, `transaksi`.`id_villa` AS `id_villa`, `transaksi`.`id_sewa` AS `id_sewa`, `penyewa`.`nama` AS `nama`, `data_villa`.`nama_villa` AS `nama_villa`, `transaksi`.`harga` AS `harga`, `transaksi`.`tgl_awal` AS `tgl_awal`, `transaksi`.`tgl_akhir` AS `tgl_akhir`, `transaksi`.`hari` AS `hari`, `transaksi`.`total` AS `total` FROM ((`transaksi` join `penyewa` on(`transaksi`.`id_sewa` = `penyewa`.`id_sewa`)) join `data_villa` on(`transaksi`.`id_villa` = `data_villa`.`id_villa`))  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data_villa`
--
ALTER TABLE `data_villa`
  ADD PRIMARY KEY (`id_villa`);

--
-- Indexes for table `penyewa`
--
ALTER TABLE `penyewa`
  ADD PRIMARY KEY (`id_sewa`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_trans`),
  ADD KEY `id_villa` (`id_villa`),
  ADD KEY `id_sewa` (`id_sewa`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_villa`) REFERENCES `data_villa` (`id_villa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_sewa`) REFERENCES `penyewa` (`id_sewa`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
