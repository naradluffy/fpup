-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 23 Agu 2016 pada 02.33
-- Versi Server: 5.6.20
-- PHP Version: 5.5.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `transaksi_asosiasi`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `ekstrak_transaksi`
--

CREATE TABLE IF NOT EXISTS `ekstrak_transaksi` (
`id_trans` int(11) NOT NULL,
  `no_bill` int(11) NOT NULL,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_menu` int(11) NOT NULL,
  `no_trans` int(11) NOT NULL,
  `id_upload` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `hasil_rekomendasi`
--

CREATE TABLE IF NOT EXISTS `hasil_rekomendasi` (
`id` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `json` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `header`
--

CREATE TABLE IF NOT EXISTS `header` (
`id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `insert_item`
--

CREATE TABLE IF NOT EXISTS `insert_item` (
`id` int(11) NOT NULL,
  `id_barang` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `itemset`
--

CREATE TABLE IF NOT EXISTS `itemset` (
`id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `parent` int(11) NOT NULL,
  `urutan` int(11) NOT NULL,
  `node` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `itemset_detail`
--

CREATE TABLE IF NOT EXISTS `itemset_detail` (
`id` int(11) NOT NULL,
  `no_itemset` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `item` int(11) NOT NULL,
  `urutan` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `koresponden`
--

CREATE TABLE IF NOT EXISTS `koresponden` (
  `id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `no_trans` int(11) NOT NULL,
  `id_upload` int(11) NOT NULL,
  `no_bill` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
`id_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Dumping data untuk tabel `menu`
--

INSERT INTO `menu` (`id_menu`, `nama_menu`) VALUES
(12, 'Almond Chocolate'),
(18, 'Asem-Asem Iga'),
(14, 'Chocolate Almond Latte'),
(10, 'French Fries'),
(1, 'Frozen Avocado'),
(3, 'Frozen Cappucino'),
(25, 'Frozen Caramel'),
(17, 'Frozen Cookies & Cream'),
(11, 'Frozen Green Tea'),
(9, 'Frozen Tiramisu'),
(13, 'Hot/Ice Black Forest Coffee'),
(2, 'Hot/Ice Cappucino'),
(5, 'Hot/Ice Chocolate'),
(24, 'Hot/Ice Coffee Latte'),
(16, 'Ice Macchiato Caramel'),
(22, 'Ice Milo'),
(15, 'Kentang Sosis'),
(21, 'Kiwi Berry Squash'),
(8, 'Kopi Bandrek'),
(6, 'Lemon Lime'),
(19, 'Mango Tango Jumbo'),
(4, 'Milo Shakes'),
(20, 'Nasi Grg Katsu Hot Plate'),
(23, 'Roti Bakar'),
(7, 'Wedang Sueger');

-- --------------------------------------------------------

--
-- Struktur dari tabel `min_sup`
--

CREATE TABLE IF NOT EXISTS `min_sup` (
  `id_upload` int(11) NOT NULL,
  `frequent` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `new_support`
--

CREATE TABLE IF NOT EXISTS `new_support` (
`id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `rescan_item`
--

CREATE TABLE IF NOT EXISTS `rescan_item` (
`id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `support`
--

CREATE TABLE IF NOT EXISTS `support` (
`id` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `frequent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `temp_tree`
--

CREATE TABLE IF NOT EXISTS `temp_tree` (
  `id` int(11) NOT NULL DEFAULT '0',
  `id_trans` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `parent` int(11) NOT NULL,
  `node` int(11) DEFAULT NULL,
  `urutan` int(11) DEFAULT NULL,
  `id_upload` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `transaksi`
--

CREATE TABLE IF NOT EXISTS `transaksi` (
  `no_trans` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `no_table` varchar(100) NOT NULL,
  `no_bill` varchar(100) NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` time(6) NOT NULL,
  `waiters` varchar(30) NOT NULL,
  `orderan` varchar(30) NOT NULL,
  `qty` int(30) NOT NULL,
`id` int(11) NOT NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=348 ;

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`no_trans`, `nama_menu`, `no_table`, `no_bill`, `tanggal`, `waktu`, `waiters`, `orderan`, `qty`, `id`) VALUES
(1, 'Frozen Caramel', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 1, 1),
(1, 'Hot/Ice Coffee Latte', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 1, 2),
(1, 'Roti Bakar', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 2, 3),
(1, 'Ice Milo', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 1, 4),
(1, 'Kiwi Berry Squash', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 1, 5),
(1, 'Nasi Grg Katsu Hot Plate', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 2, 6),
(1, 'Mango Tango Jumbo', '102', '109001', '2015-04-09', '12:07:00.000000', 'Widya', 'DineIn', 1, 7),
(2, 'Nasi Grg Katsu Hot Plate', '701', '109002', '2015-04-09', '12:13:00.000000', 'Widya', 'DineIn', 2, 8),
(2, 'Frozen Caramel', '701', '109002', '2015-04-09', '12:13:00.000000', 'Widya', 'DineIn', 1, 9),
(2, 'Hot/Ice Coffee Latte', '701', '109002', '2015-04-09', '12:13:00.000000', 'Widya', 'DineIn', 1, 10),
(2, 'Asem-Asem Iga', '701', '109002', '2015-04-09', '12:13:00.000000', 'Widya', 'DineIn', 1, 11),
(3, 'Frozen Cookies & Cream', '108', '109003', '2015-04-09', '12:22:00.000000', 'Widya', 'DineIn', 2, 12),
(4, 'Ice Macchiato Caramel', '406', '109004', '2015-04-09', '12:37:00.000000', 'Widya', 'DineIn', 3, 13),
(5, 'Frozen Caramel', '112', '109005', '2015-04-09', '12:49:00.000000', 'Widya', 'DineIn', 1, 14),
(5, 'Kentang Sosis', '112', '109005', '2015-04-09', '12:49:00.000000', 'Widya', 'DineIn', 1, 15),
(5, 'Chocolate Almond Latte', '112', '109005', '2015-04-09', '12:49:00.000000', 'Widya', 'DineIn', 1, 16),
(5, 'Hot/Ice Black Forest Coffee', '112', '109005', '2015-04-09', '12:49:00.000000', 'Widya', 'DineIn', 1, 17),
(5, 'Frozen Cookies & Cream', '112', '109005', '2015-04-09', '12:49:00.000000', 'Widya', 'DineIn', 2, 18),
(6, 'Ice Macchiato Caramel', '701', '109006', '2015-04-09', '13:02:00.000000', 'Widya', 'DineIn', 4, 19),
(7, 'Frozen Caramel', '503', '109007', '2015-04-09', '13:20:00.000000', 'Widya', 'DineIn', 2, 20),
(8, 'Almond Chocolate', '703', '109008', '2015-04-09', '13:31:00.000000', 'Widya', 'DineIn', 1, 21),
(9, 'Chocolate Almond Latte', '506', '109009', '2015-04-09', '13:33:00.000000', 'Widya', 'DineIn', 1, 22),
(9, 'Frozen Green Tea', '506', '109009', '2015-04-09', '13:33:00.000000', 'Widya', 'DineIn', 2, 23),
(9, 'French Fries', '506', '109009', '2015-04-09', '13:33:00.000000', 'Widya', 'DineIn', 1, 24),
(9, 'Frozen Tiramisu', '506', '109009', '2015-04-09', '13:33:00.000000', 'Widya', 'DineIn', 1, 25),
(10, 'Kiwi Berry Squash', '601', '109010', '2015-04-09', '13:35:00.000000', 'Widya', 'DineIn', 1, 26),
(11, 'Mango Tango Jumbo', 'T1', '109011', '2015-04-10', '14:23:00.000000', 'Widya', 'TakeAway', 1, 27),
(12, 'Almond Chocolate', '303', '109012', '2015-04-10', '14:24:00.000000', 'Widya', 'DineIn', 3, 28),
(13, 'Chocolate Almond Latte', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 1, 29),
(13, 'Frozen Caramel', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 1, 30),
(13, 'Hot/Ice Coffee Latte', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 1, 31),
(13, 'Roti Bakar', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 2, 32),
(13, 'Ice Macchiato Caramel', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 1, 33),
(13, 'Mango Tango Jumbo', '117', '109013', '2015-04-10', '14:28:00.000000', 'Widya', 'DineIn', 1, 34),
(14, 'Nasi Grg Katsu Hot Plate', '203', '109014', '2015-04-10', '14:39:00.000000', 'Widya', 'DineIn', 2, 35),
(14, 'Almond Chocolate', '203', '109014', '2015-04-10', '14:39:00.000000', 'Widya', 'DineIn', 1, 36),
(14, 'Frozen Caramel', '203', '109014', '2015-04-10', '14:39:00.000000', 'Widya', 'DineIn', 2, 37),
(14, 'Kentang Sosis', '203', '109014', '2015-04-10', '14:39:00.000000', 'Widya', 'DineIn', 1, 38),
(15, 'Frozen Tiramisu', '109', '109015', '2015-04-10', '14:44:00.000000', 'Widya', 'DineIn', 2, 39),
(16, 'Chocolate Almond Latte', '401', '109016', '2015-04-10', '14:44:00.000000', 'Widya', 'DineIn', 2, 40),
(17, 'Frozen Caramel', '118', '109017', '2015-04-10', '15:09:00.000000', 'Nirma', 'DineIn', 1, 41),
(17, 'Hot/Ice Coffee Latte', '118', '109017', '2015-04-10', '15:09:00.000000', 'Nirma', 'DineIn', 1, 42),
(17, 'Roti Bakar', '118', '109017', '2015-04-10', '15:09:00.000000', 'Nirma', 'DineIn', 1, 43),
(17, 'Ice Milo', '118', '109017', '2015-04-10', '15:09:00.000000', 'Nirma', 'DineIn', 1, 44),
(17, 'Kiwi Berry Squash', '118', '109017', '2015-04-10', '15:09:00.000000', 'Nirma', 'DineIn', 1, 45),
(18, 'Chocolate Almond Latte', '305', '109018', '2015-04-10', '15:17:00.000000', 'Nirma', 'DineIn', 1, 46),
(18, 'Hot/Ice Black Forest Coffee', '305', '109018', '2015-04-10', '15:17:00.000000', 'Nirma', 'DineIn', 1, 47),
(18, 'Frozen Cookies & Cream', '305', '109018', '2015-04-10', '15:17:00.000000', 'Nirma', 'DineIn', 2, 48),
(18, 'Frozen Tiramisu', '305', '109018', '2015-04-10', '15:17:00.000000', 'Nirma', 'DineIn', 2, 49),
(19, 'Hot/Ice Black Forest Coffee', '404', '109019', '2015-04-10', '15:27:00.000000', 'Nirma', 'DineIn', 1, 50),
(20, 'Frozen Tiramisu', '212', '109020', '2015-04-10', '15:37:00.000000', 'Nirma', 'DineIn', 2, 51),
(21, 'Frozen Green Tea', 'T1', '109021', '2015-04-11', '15:40:00.000000', 'Nirma', 'TakeAway', 2, 52),
(22, 'Chocolate Almond Latte', '509', '109022', '2015-04-11', '15:51:00.000000', 'Nirma', 'DineIn', 1, 53),
(22, 'Frozen Caramel', '509', '109022', '2015-04-11', '15:51:00.000000', 'Nirma', 'DineIn', 1, 54),
(22, 'Hot/Ice Coffee Latte', '509', '109022', '2015-04-11', '15:51:00.000000', 'Nirma', 'DineIn', 1, 55),
(22, 'Roti Bakar', '509', '109022', '2015-04-11', '15:51:00.000000', 'Nirma', 'DineIn', 1, 56),
(23, 'Kopi Bandrek', '119', '109023', '2015-04-11', '16:07:00.000000', 'Nirma', 'DineIn', 2, 57),
(24, 'Ice Macchiato Caramel', '501', '109024', '2015-04-11', '16:15:00.000000', 'Nirma', 'DineIn', 1, 58),
(25, 'Frozen Tiramisu', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 2, 59),
(25, 'Ice Macchiato Caramel', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 1, 60),
(25, 'Mango Tango Jumbo', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 1, 61),
(25, 'Frozen Caramel', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 2, 62),
(25, 'Hot/Ice Coffee Latte', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 2, 63),
(25, 'Roti Bakar', '201', '109025', '2015-04-11', '16:16:00.000000', 'Nirma', 'DineIn', 2, 64),
(26, 'Nasi Grg Katsu Hot Plate', '108', '109026', '2015-04-11', '16:21:00.000000', 'Nirma', 'DineIn', 2, 65),
(26, 'Frozen Green Tea', '108', '109026', '2015-04-11', '16:21:00.000000', 'Nirma', 'DineIn', 3, 66),
(26, 'Frozen Tiramisu', '108', '109026', '2015-04-11', '16:21:00.000000', 'Nirma', 'DineIn', 1, 67),
(26, 'Asem-Asem Iga', '108', '109026', '2015-04-11', '16:21:00.000000', 'Nirma', 'DineIn', 3, 68),
(27, 'Frozen Cookies & Cream', '116', '109027', '2015-04-11', '16:24:00.000000', 'Nirma', 'DineIn', 1, 69),
(27, 'Frozen Green Tea', '116', '109027', '2015-04-11', '16:24:00.000000', 'Nirma', 'DineIn', 1, 70),
(27, 'French Fries', '116', '109027', '2015-04-11', '16:24:00.000000', 'Nirma', 'DineIn', 1, 71),
(27, 'Frozen Tiramisu', '116', '109027', '2015-04-11', '16:24:00.000000', 'Nirma', 'DineIn', 1, 72),
(28, 'Frozen Green Tea', '703', '109028', '2015-04-11', '16:31:00.000000', 'Nirma', 'DineIn', 2, 73),
(29, 'Frozen Cookies & Cream', 'T1', '109029', '2015-04-11', '16:34:00.000000', 'Nirma', 'TakeAway', 1, 74),
(30, 'Hot/Ice Coffee Latte', '114', '109030', '2015-04-11', '16:44:00.000000', 'Nirma', 'DineIn', 2, 75),
(31, 'Wedang Sueger', '209', '109031', '2015-04-11', '16:51:00.000000', 'Nirma', 'DineIn', 2, 76),
(32, 'Nasi Grg Katsu Hot Plate', '702', '109032', '2015-04-12', '17:09:00.000000', 'Nirma', 'DineIn', 2, 77),
(32, 'Mango Tango Jumbo', '702', '109032', '2015-04-12', '17:09:00.000000', 'Nirma', 'DineIn', 2, 78),
(33, 'Frozen Cookies & Cream', '402', '109033', '2015-04-12', '17:14:00.000000', 'Nirma', 'DineIn', 1, 79),
(33, 'Frozen Green Tea', '402', '109033', '2015-04-12', '17:14:00.000000', 'Nirma', 'DineIn', 1, 80),
(33, 'Frozen Tiramisu', '402', '109033', '2015-04-12', '17:14:00.000000', 'Nirma', 'DineIn', 1, 81),
(34, 'Hot/Ice Black Forest Coffee', '118', '109034', '2015-04-12', '17:33:00.000000', 'Nirma', 'DineIn', 1, 82),
(34, 'Frozen Tiramisu', '118', '109034', '2015-04-12', '17:33:00.000000', 'Nirma', 'DineIn', 1, 83),
(34, 'Frozen Green Tea', '118', '109034', '2015-04-12', '17:33:00.000000', 'Nirma', 'DineIn', 1, 84),
(34, 'French Fries', '118', '109034', '2015-04-12', '17:33:00.000000', 'Nirma', 'DineIn', 1, 85),
(34, 'Mango Tango Jumbo', '118', '109034', '2015-04-12', '17:33:00.000000', 'Nirma', 'DineIn', 1, 86),
(35, 'Mango Tango Jumbo', '607', '109035', '2015-04-12', '17:35:00.000000', 'Nirma', 'DineIn', 2, 87),
(36, 'Chocolate Almond Latte', 'T1', '109036', '2015-04-12', '17:36:00.000000', 'Nirma', 'TakeAway', 1, 88),
(37, 'Lemon Lime', '705', '109037', '2015-04-12', '17:45:00.000000', 'Nirma', 'DineIn', 2, 89),
(38, 'Kopi Bandrek', '201', '109038', '2015-04-12', '17:57:00.000000', 'Nirma', 'DineIn', 3, 90),
(39, 'Nasi Grg Katsu Hot Plate', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 1, 91),
(39, 'Ice Macchiato Caramel', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 1, 92),
(39, 'Mango Tango Jumbo', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 1, 93),
(39, 'Ice Milo', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 2, 94),
(39, 'Kiwi Berry Squash', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 1, 95),
(39, 'Asem-Asem Iga', '112', '109039', '2015-04-12', '18:01:00.000000', 'Nirma', 'DineIn', 4, 96),
(40, 'Frozen Caramel', '119', '109040', '2015-04-12', '18:10:00.000000', 'Nirma', 'DineIn', 2, 97),
(41, 'Asem-Asem Iga', '304', '109041', '2015-04-13', '18:18:00.000000', 'Nirma', 'DineIn', 2, 98),
(41, 'Frozen Tiramisu', '304', '109041', '2015-04-13', '18:18:00.000000', 'Nirma', 'DineIn', 2, 99),
(42, 'Frozen Green Tea', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 1, 100),
(42, 'Frozen Tiramisu', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 1, 101),
(42, 'Nasi Grg Katsu Hot Plate', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 4, 102),
(42, 'Frozen Caramel', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 1, 103),
(42, 'Hot/Ice Coffee Latte', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 1, 104),
(42, 'Mango Tango Jumbo', '212', '109042', '2015-04-13', '18:19:00.000000', 'Nirma', 'DineIn', 1, 105),
(43, 'Ice Macchiato Caramel', '112', '109043', '2015-04-13', '18:30:00.000000', 'Nirma', 'DineIn', 1, 106),
(43, 'Frozen Green Tea', '112', '109043', '2015-04-13', '18:30:00.000000', 'Nirma', 'DineIn', 1, 107),
(43, 'French Fries', '112', '109043', '2015-04-13', '18:30:00.000000', 'Nirma', 'DineIn', 1, 108),
(43, 'Nasi Grg Katsu Hot Plate', '112', '109043', '2015-04-13', '18:30:00.000000', 'Nirma', 'DineIn', 1, 109),
(44, 'Frozen Green Tea', '706', '109044', '2015-04-13', '18:35:00.000000', 'Nirma', 'DineIn', 1, 110),
(45, 'Kopi Bandrek', '511', '109045', '2015-04-13', '18:37:00.000000', 'Nirma', 'DineIn', 2, 111),
(46, 'Wedang Sueger', '210', '109046', '2015-04-13', '18:46:00.000000', 'Nirma', 'DineIn', 2, 112),
(47, 'Ice Macchiato Caramel', '409', '109047', '2015-04-13', '18:58:00.000000', 'Nirma', 'DineIn', 1, 113),
(47, 'Almond Chocolate', '409', '109047', '2015-04-13', '18:58:00.000000', 'Nirma', 'DineIn', 1, 114),
(47, 'Frozen Caramel', '409', '109047', '2015-04-13', '18:58:00.000000', 'Nirma', 'DineIn', 1, 115),
(47, 'Hot/Ice Coffee Latte', '409', '109047', '2015-04-13', '18:58:00.000000', 'Nirma', 'DineIn', 1, 116),
(47, 'Roti Bakar', '409', '109047', '2015-04-13', '18:58:00.000000', 'Nirma', 'DineIn', 1, 117),
(48, 'Wedang Sueger', '505', '109048', '2015-04-13', '19:13:00.000000', 'Nirma', 'DineIn', 2, 118),
(48, 'Asem-Asem Iga', '505', '109048', '2015-04-13', '19:13:00.000000', 'Nirma', 'DineIn', 1, 119),
(48, 'Ice Macchiato Caramel', '505', '109048', '2015-04-13', '19:13:00.000000', 'Nirma', 'DineIn', 1, 120),
(48, 'Mango Tango Jumbo', '505', '109048', '2015-04-13', '19:13:00.000000', 'Nirma', 'DineIn', 1, 121),
(48, 'Nasi Grg Katsu Hot Plate', '505', '109048', '2015-04-13', '19:13:00.000000', 'Nirma', 'DineIn', 3, 122),
(49, 'Ice Macchiato Caramel', '112', '109049', '2015-04-13', '19:17:00.000000', 'Nirma', 'DineIn', 1, 123),
(50, 'Lemon Lime', '707', '109050', '2015-04-13', '19:21:00.000000', 'Nirma', 'DineIn', 1, 124),
(51, 'Hot/Ice Coffee Latte', '515', '109051', '2015-04-14', '19:24:00.000000', 'Nirma', 'DineIn', 2, 125),
(52, 'Frozen Green Tea', '103', '109052', '2015-04-14', '19:28:00.000000', 'Nirma', 'DineIn', 2, 126),
(52, 'French Fries', '103', '109052', '2015-04-14', '19:28:00.000000', 'Nirma', 'DineIn', 1, 127),
(52, 'Ice Macchiato Caramel', '103', '109052', '2015-04-14', '19:28:00.000000', 'Nirma', 'DineIn', 1, 128),
(53, 'Kiwi Berry Squash', '212', '109053', '2015-04-14', '19:33:00.000000', 'Nirma', 'DineIn', 2, 129),
(54, 'Asem-Asem Iga', '117', '109054', '2015-04-14', '19:37:00.000000', 'Nirma', 'DineIn', 2, 130),
(54, 'Frozen Caramel', '117', '109054', '2015-04-14', '19:37:00.000000', 'Nirma', 'DineIn', 1, 131),
(54, 'Kentang Sosis', '117', '109054', '2015-04-14', '19:37:00.000000', 'Nirma', 'DineIn', 1, 132),
(54, 'Hot/Ice Black Forest Coffee', '117', '109054', '2015-04-14', '19:37:00.000000', 'Nirma', 'DineIn', 1, 133),
(55, 'Frozen Cookies & Cream', 'T1', '109055', '2015-04-14', '19:55:00.000000', 'Nirma', 'TakeAway', 2, 134),
(56, 'Chocolate Almond Latte', '701', '109056', '2015-04-14', '20:00:00.000000', 'Nirma', 'DineIn', 1, 135),
(56, 'Frozen Green Tea', '701', '109056', '2015-04-14', '20:00:00.000000', 'Nirma', 'DineIn', 1, 136),
(56, 'French Fries', '701', '109056', '2015-04-14', '20:00:00.000000', 'Nirma', 'DineIn', 1, 137),
(56, 'Frozen Tiramisu', '701', '109056', '2015-04-14', '20:00:00.000000', 'Nirma', 'DineIn', 1, 138),
(56, 'Kentang Sosis', '701', '109056', '2015-04-14', '20:00:00.000000', 'Nirma', 'DineIn', 1, 139),
(57, 'Ice Milo', '112', '109057', '2015-04-14', '20:14:00.000000', 'Nirma', 'DineIn', 2, 140),
(58, 'Hot/Ice Chocolate', '101', '109058', '2015-04-14', '20:16:00.000000', 'Nirma', 'DineIn', 3, 141),
(59, 'Ice Macchiato Caramel', '301', '109059', '2015-04-14', '20:27:00.000000', 'Nirma', 'DineIn', 1, 142),
(59, 'Kopi Bandrek', '301', '109059', '2015-04-14', '20:27:00.000000', 'Nirma', 'DineIn', 2, 143),
(60, 'Wedang Sueger', '708', '109060', '2015-04-14', '20:45:00.000000', 'Nirma', 'DineIn', 1, 144),
(61, 'Wedang Sueger', '202', '109061', '2015-04-15', '20:46:00.000000', 'Nirma', 'DineIn', 2, 145),
(61, 'Mango Tango Jumbo', '202', '109061', '2015-04-15', '20:46:00.000000', 'Nirma', 'DineIn', 1, 146),
(61, 'Frozen Caramel', '202', '109061', '2015-04-15', '20:46:00.000000', 'Nirma', 'DineIn', 1, 147),
(61, 'Kentang Sosis', '202', '109061', '2015-04-15', '20:46:00.000000', 'Nirma', 'DineIn', 1, 148),
(62, 'Frozen Green Tea', 'T1', '109062', '2015-04-15', '20:48:00.000000', 'Nirma', 'TakeAway', 1, 149),
(63, 'Chocolate Almond Latte', '112', '109063', '2015-04-15', '20:51:00.000000', 'Nirma', 'DineIn', 1, 150),
(63, 'Hot/Ice Black Forest Coffee', '112', '109063', '2015-04-15', '20:51:00.000000', 'Nirma', 'DineIn', 1, 151),
(63, 'Frozen Cookies & Cream', '112', '109063', '2015-04-15', '20:51:00.000000', 'Nirma', 'DineIn', 1, 152),
(64, 'Frozen Caramel', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 153),
(64, 'Hot/Ice Coffee Latte', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 154),
(64, 'Roti Bakar', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 155),
(64, 'Chocolate Almond Latte', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 156),
(64, 'Hot/Ice Black Forest Coffee', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 157),
(64, 'Frozen Cookies & Cream', '504', '109064', '2015-04-15', '21:05:00.000000', 'Nirma', 'DineIn', 1, 158),
(65, 'Asem-Asem Iga', '501', '109065', '2015-04-15', '21:23:00.000000', 'Nirma', 'DineIn', 1, 159),
(65, 'Almond Chocolate', '501', '109065', '2015-04-15', '21:23:00.000000', 'Nirma', 'DineIn', 1, 160),
(66, 'Milo Shakes', '113', '109066', '2015-04-15', '22:00:00.000000', 'Nirma', 'DineIn', 3, 161),
(67, 'Almond Chocolate', 'T1', '109067', '2015-04-15', '22:18:00.000000', 'Nirma', 'TakeAway', 2, 162),
(68, 'Frozen Caramel', '705', '109068', '2015-04-15', '08:10:00.000000', 'Widya', 'DineIn', 1, 163),
(69, 'Chocolate Almond Latte', '511', '109069', '2015-04-15', '08:51:00.000000', 'Widya', 'DineIn', 3, 164),
(70, 'Hot/Ice Chocolate', '302', '109070', '2015-04-15', '09:11:00.000000', 'Widya', 'DineIn', 2, 165),
(71, 'Kopi Bandrek', '211', '109071', '2015-04-15', '09:13:00.000000', 'Widya', 'DineIn', 1, 166),
(72, 'Frozen Caramel', '102', '109072', '2015-04-16', '09:33:00.000000', 'Widya', 'DineIn', 2, 167),
(72, 'Kentang Sosis', '102', '109072', '2015-04-16', '09:33:00.000000', 'Widya', 'DineIn', 1, 168),
(72, 'Chocolate Almond Latte', '102', '109072', '2015-04-16', '09:33:00.000000', 'Widya', 'DineIn', 1, 169),
(72, 'Hot/Ice Black Forest Coffee', '102', '109072', '2015-04-16', '09:33:00.000000', 'Widya', 'DineIn', 1, 170),
(73, 'Frozen Cappucino', '703', '109073', '2015-04-16', '09:50:00.000000', 'Widya', 'DineIn', 2, 171),
(74, 'Chocolate Almond Latte', '304', '109074', '2015-04-16', '10:26:00.000000', 'Widya', 'DineIn', 1, 172),
(74, 'Hot/Ice Black Forest Coffee', '304', '109074', '2015-04-16', '10:26:00.000000', 'Widya', 'DineIn', 1, 173),
(74, 'Frozen Cookies & Cream', '304', '109074', '2015-04-16', '10:26:00.000000', 'Widya', 'DineIn', 1, 174),
(75, 'Frozen Caramel', '108', '109075', '2015-04-16', '10:28:00.000000', 'Widya', 'DineIn', 1, 175),
(75, 'Hot/Ice Coffee Latte', '108', '109075', '2015-04-16', '10:28:00.000000', 'Widya', 'DineIn', 2, 176),
(75, 'Lemon Lime', '108', '109075', '2015-04-16', '10:28:00.000000', 'Widya', 'DineIn', 1, 177),
(75, 'Almond Chocolate', '108', '109075', '2015-04-16', '10:28:00.000000', 'Widya', 'DineIn', 2, 178),
(76, 'Hot/Ice Cappucino', '403', '109076', '2015-04-16', '10:31:00.000000', 'Widya', 'DineIn', 3, 179),
(77, 'Frozen Green Tea', '201', '109077', '2015-04-16', '10:41:00.000000', 'Widya', 'DineIn', 3, 180),
(78, 'Almond Chocolate', '405', '109078', '2015-04-16', '10:42:00.000000', 'Widya', 'DineIn', 1, 181),
(79, 'Nasi Grg Katsu Hot Plate', '118', '109079', '2015-04-16', '10:58:00.000000', 'Widya', 'DineIn', 1, 182),
(79, 'Frozen Green Tea', '118', '109079', '2015-04-16', '10:58:00.000000', 'Widya', 'DineIn', 1, 183),
(79, 'French Fries', '118', '109079', '2015-04-16', '10:58:00.000000', 'Widya', 'DineIn', 1, 184),
(79, 'Lemon Lime', '118', '109079', '2015-04-16', '10:58:00.000000', 'Widya', 'DineIn', 1, 185),
(80, 'Chocolate Almond Latte', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 1, 186),
(80, 'Hot/Ice Black Forest Coffee', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 1, 187),
(80, 'Frozen Cookies & Cream', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 1, 188),
(80, 'Nasi Grg Katsu Hot Plate', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 1, 189),
(80, 'Almond Chocolate', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 1, 190),
(80, 'Lemon Lime', '504', '109080', '2015-04-16', '11:00:00.000000', 'Widya', 'DineIn', 2, 191),
(81, 'Hot/Ice Chocolate', '212', '109081', '2015-04-17', '11:10:00.000000', 'Widya', 'DineIn', 1, 192),
(82, 'Kopi Bandrek', '501', '109082', '2015-04-17', '11:12:00.000000', 'Widya', 'DineIn', 3, 193),
(82, 'Ice Macchiato Caramel', '501', '109082', '2015-04-17', '11:12:00.000000', 'Widya', 'DineIn', 2, 194),
(82, 'Almond Chocolate', '501', '109082', '2015-04-17', '11:12:00.000000', 'Widya', 'DineIn', 2, 195),
(83, 'Kentang Sosis', '201', '109083', '2015-04-17', '11:30:00.000000', 'Widya', 'DineIn', 2, 196),
(83, 'Ice Macchiato Caramel', '201', '109083', '2015-04-17', '11:30:00.000000', 'Widya', 'DineIn', 1, 197),
(84, 'Frozen Avocado', '312', '109084', '2015-04-17', '11:40:00.000000', 'Widya', 'DineIn', 1, 198),
(85, 'Asem-Asem Iga', '701', '109085', '2015-04-17', '11:59:00.000000', 'Widya', 'DineIn', 1, 199),
(85, 'Frozen Green Tea', '701', '109085', '2015-04-17', '11:59:00.000000', 'Widya', 'DineIn', 1, 200),
(85, 'French Fries', '701', '109085', '2015-04-17', '11:59:00.000000', 'Widya', 'DineIn', 1, 201),
(85, 'Almond Chocolate', '701', '109085', '2015-04-17', '11:59:00.000000', 'Widya', 'DineIn', 2, 202),
(86, 'Frozen Cookies & Cream', '310', '109086', '2015-04-17', '12:25:00.000000', 'Widya', 'DineIn', 2, 203),
(87, 'Hot/Ice Cappucino', '601', '109087', '2015-04-17', '12:30:00.000000', 'Widya', 'DineIn', 2, 204),
(88, 'Frozen Caramel', '118', '109088', '2015-04-17', '12:34:00.000000', 'Widya', 'DineIn', 1, 205),
(89, 'Chocolate Almond Latte', 'T1', '109089', '2015-04-17', '12:39:00.000000', 'Widya', 'TakeAway', 1, 206),
(90, 'Ice Macchiato Caramel', '112', '109090', '2015-04-18', '12:48:00.000000', 'Widya', 'DineIn', 1, 207),
(90, 'Almond Chocolate', '112', '109090', '2015-04-18', '12:48:00.000000', 'Widya', 'DineIn', 2, 208),
(90, 'Kentang Sosis', '112', '109090', '2015-04-18', '12:48:00.000000', 'Widya', 'DineIn', 1, 209),
(91, 'Kopi Bandrek', '509', '109091', '2015-04-18', '13:08:00.000000', 'Widya', 'DineIn', 1, 210),
(91, 'Frozen Tiramisu', '509', '109091', '2015-04-18', '13:08:00.000000', 'Widya', 'DineIn', 1, 211),
(91, 'Frozen Green Tea', '509', '109091', '2015-04-18', '13:08:00.000000', 'Widya', 'DineIn', 1, 212),
(91, 'French Fries', '509', '109091', '2015-04-18', '13:08:00.000000', 'Widya', 'DineIn', 1, 213),
(91, 'Lemon Lime', '509', '109091', '2015-04-18', '13:08:00.000000', 'Widya', 'DineIn', 1, 214),
(92, 'Hot/Ice Chocolate', 'T1', '109092', '2015-04-18', '13:14:00.000000', 'Widya', 'TakeAway', 2, 215),
(93, 'Chocolate Almond Latte', '109', '109093', '2015-04-18', '13:22:00.000000', 'Widya', 'DineIn', 1, 216),
(93, 'Hot/Ice Black Forest Coffee', '109', '109093', '2015-04-18', '13:22:00.000000', 'Widya', 'DineIn', 2, 217),
(93, 'Frozen Cookies & Cream', '109', '109093', '2015-04-18', '13:22:00.000000', 'Widya', 'DineIn', 1, 218),
(93, 'Lemon Lime', '109', '109093', '2015-04-18', '13:22:00.000000', 'Widya', 'DineIn', 1, 219),
(94, 'Almond Chocolate', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 220),
(94, 'Lemon Lime', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 221),
(94, 'Wedang Sueger', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 222),
(94, 'Ice Milo', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 223),
(94, 'Frozen Caramel', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 224),
(94, 'Frozen Green Tea', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 1, 225),
(94, 'Nasi Grg Katsu Hot Plate', '503', '109094', '2015-04-19', '13:34:00.000000', 'Widya', 'DineIn', 6, 226),
(95, 'Lemon Lime', '210', '109094', '2015-04-19', '13:41:00.000000', 'Widya', 'DineIn', 2, 227),
(95, 'Almond Chocolate', '210', '109095', '2015-04-19', '13:41:00.000000', 'Widya', 'DineIn', 1, 228),
(95, 'Roti Bakar', '210', '109095', '2015-04-19', '13:41:00.000000', 'Widya', 'DineIn', 3, 229),
(95, 'Wedang Sueger', '210', '109095', '2015-04-19', '13:41:00.000000', 'Widya', 'DineIn', 1, 230),
(95, 'Frozen Caramel', '210', '109095', '2015-04-19', '13:41:00.000000', 'Widya', 'DineIn', 2, 231),
(96, 'Lemon Lime', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 3, 232),
(96, 'Mango Tango Jumbo', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 1, 233),
(96, 'Kentang Sosis', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 3, 234),
(96, 'Frozen Caramel', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 1, 235),
(96, 'Frozen Cookies & Cream', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 1, 236),
(96, 'Hot/Ice Coffee Latte', '104', '109096', '2015-04-19', '14:02:00.000000', 'Widya', 'DineIn', 1, 237),
(97, 'Chocolate Almond Latte', 'T1', '109097', '2015-04-19', '14:09:00.000000', 'Widya', 'TakeAway', 3, 238),
(98, 'Almond Chocolate', '403', '109098', '2015-04-19', '14:21:00.000000', 'Widya', 'DineIn', 1, 239),
(98, 'Lemon Lime', '403', '109098', '2015-04-19', '14:21:00.000000', 'Widya', 'DineIn', 1, 240),
(98, 'Roti Bakar', '403', '109098', '2015-04-19', '14:21:00.000000', 'Widya', 'DineIn', 1, 241),
(98, 'Frozen Caramel', '403', '109098', '2015-04-19', '14:21:00.000000', 'Widya', 'DineIn', 1, 242),
(99, 'Hot/Ice Black Forest Coffee', '711', '109099', '2015-04-19', '14:27:00.000000', 'Widya', 'DineIn', 2, 243),
(100, 'Frozen Cookies & Cream', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 1, 244),
(100, 'Kentang Sosis', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 2, 245),
(100, 'Mango Tango Jumbo', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 1, 246),
(100, 'Nasi Grg Katsu Hot Plate', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 3, 247),
(100, 'Almond Chocolate', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 2, 248),
(100, 'Roti Bakar', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 2, 249),
(100, 'Wedang Sueger', '112', '109100', '2015-04-20', '14:33:00.000000', 'Widya', 'DineIn', 1, 250),
(101, 'Frozen Tiramisu', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 1, 251),
(101, 'Lemon Lime', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 1, 252),
(101, 'Almond Chocolate', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 1, 253),
(101, 'Roti Bakar', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 2, 254),
(101, 'Wedang Sueger', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 1, 255),
(101, 'Frozen Caramel', '118', '109101', '2015-04-20', '14:42:00.000000', 'Widya', 'DineIn', 1, 256),
(102, 'Frozen Cookies & Cream', 'T1', '109102', '2015-04-20', '14:52:00.000000', 'Widya', 'TakeAway', 1, 257),
(103, 'Frozen Green Tea', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 1, 258),
(103, 'Chocolate Almond Latte', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 1, 259),
(103, 'Lemon Lime', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 1, 260),
(103, 'Frozen Caramel', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 1, 261),
(103, 'Hot/Ice Coffee Latte', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 1, 262),
(103, 'Kopi Bandrek', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 3, 263),
(103, 'French Fries', '704', '109103', '2015-04-20', '15:12:00.000000', 'Widya', 'DineIn', 2, 264),
(104, 'Almond Chocolate', 'T1', '109104', '2015-04-20', '15:23:00.000000', 'Alit', 'TakeAway', 1, 265),
(105, 'Lemon Lime', '301', '109105', '2015-04-20', '15:26:00.000000', 'Alit', 'DineIn', 1, 266),
(105, 'Kentang Sosis', '301', '109105', '2015-04-20', '15:26:00.000000', 'Alit', 'DineIn', 2, 267),
(105, 'Almond Chocolate', '301', '109105', '2015-04-20', '15:26:00.000000', 'Alit', 'DineIn', 1, 268),
(105, 'Roti Bakar', '301', '109105', '2015-04-20', '15:26:00.000000', 'Alit', 'DineIn', 1, 269),
(105, 'Wedang Sueger', '301', '109105', '2015-04-20', '15:26:00.000000', 'Alit', 'DineIn', 1, 270),
(106, 'Lemon Lime', '212', '109106', '2015-04-20', '15:44:00.000000', 'Alit', 'DineIn', 1, 271),
(106, 'Roti Bakar', '212', '109106', '2015-04-20', '15:44:00.000000', 'Alit', 'DineIn', 1, 272),
(106, 'Hot/Ice Coffee Latte', '212', '109106', '2015-04-20', '15:44:00.000000', 'Alit', 'DineIn', 1, 273),
(106, 'Kopi Bandrek', '212', '109106', '2015-04-20', '15:44:00.000000', 'Alit', 'DineIn', 1, 274),
(106, 'Kentang Sosis', '212', '109106', '2015-04-20', '15:44:00.000000', 'Alit', 'DineIn', 1, 275),
(107, 'Almond Chocolate', '207', '109107', '2015-04-20', '15:53:00.000000', 'Alit', 'DineIn', 1, 276),
(107, 'Roti Bakar', '207', '109107', '2015-04-20', '15:53:00.000000', 'Alit', 'DineIn', 1, 277),
(107, 'Wedang Sueger', '207', '109107', '2015-04-20', '15:53:00.000000', 'Alit', 'DineIn', 1, 278),
(107, 'Frozen Caramel', '207', '109107', '2015-04-20', '15:53:00.000000', 'Alit', 'DineIn', 1, 279),
(108, 'Almond Chocolate', '109', '109108', '2015-04-21', '16:01:00.000000', 'Alit', 'DineIn', 1, 280),
(108, 'Roti Bakar', '109', '109108', '2015-04-21', '16:01:00.000000', 'Alit', 'DineIn', 1, 281),
(108, 'Wedang Sueger', '109', '109108', '2015-04-21', '16:01:00.000000', 'Alit', 'DineIn', 1, 282),
(108, 'Frozen Cookies & Cream', '109', '109108', '2015-04-21', '16:01:00.000000', 'Alit', 'DineIn', 2, 283),
(109, 'Frozen Caramel', '501', '109109', '2015-04-21', '16:15:00.000000', 'Alit', 'DineIn', 3, 284),
(109, 'Kentang Sosis', '501', '109109', '2015-04-21', '16:15:00.000000', 'Alit', 'DineIn', 2, 285),
(109, 'Frozen Green Tea', '501', '109109', '2015-04-21', '16:15:00.000000', 'Alit', 'DineIn', 1, 286),
(109, 'Lemon Lime', '501', '109109', '2015-04-21', '16:15:00.000000', 'Alit', 'DineIn', 1, 287),
(109, 'Mango Tango Jumbo', '501', '109109', '2015-04-21', '16:15:00.000000', 'Alit', 'DineIn', 1, 288),
(110, 'Frozen Caramel', '412', '109110', '2015-04-21', '16:25:00.000000', 'Alit', 'DineIn', 1, 289),
(110, 'Roti Bakar', '412', '109110', '2015-04-21', '16:25:00.000000', 'Alit', 'DineIn', 1, 290),
(110, 'Almond Chocolate', '412', '109110', '2015-04-21', '16:25:00.000000', 'Alit', 'DineIn', 2, 291),
(110, 'Lemon Lime', '412', '109110', '2015-04-21', '16:25:00.000000', 'Alit', 'DineIn', 1, 292),
(111, 'Frozen Cookies & Cream', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 1, 293),
(111, 'Asem-Asem Iga', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 3, 294),
(111, 'Kiwi Berry Squash', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 3, 295),
(111, 'Almond Chocolate', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 1, 296),
(111, 'Roti Bakar', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 2, 297),
(111, 'Wedang Sueger', '123', '109111', '2015-04-21', '16:28:00.000000', 'Alit', 'DineIn', 1, 298),
(112, 'Hot/Ice Coffee Latte', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 299),
(112, 'Kopi Bandrek', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 300),
(112, 'Hot/Ice Black Forest Coffee', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 301),
(112, 'Ice Milo', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 2, 302),
(112, 'Kiwi Berry Squash', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 303),
(112, 'Hot/Ice Coffee Latte', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 304),
(112, 'Frozen Cookies & Cream', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 2, 305),
(112, 'Kopi Bandrek', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 3, 306),
(112, 'Chocolate Almond Latte', '112', '109112', '2015-04-22', '16:49:00.000000', 'Alit', 'DineIn', 1, 307),
(113, 'Frozen Tiramisu', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 2, 308),
(113, 'Almond Chocolate', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 1, 309),
(113, 'Roti Bakar', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 2, 310),
(113, 'Asem-Asem Iga', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 4, 311),
(113, 'Wedang Sueger', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 1, 312),
(113, 'Hot/Ice Coffee Latte', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 1, 313),
(113, 'Kopi Bandrek', '705', '109113', '2015-04-22', '17:12:00.000000', 'Alit', 'DineIn', 1, 314),
(114, 'Kiwi Berry Squash', '602', '109114', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 1, 315),
(114, 'Ice Macchiato Caramel', '602', '109114', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 2, 316),
(114, 'Ice Milo', '602', '109114', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 1, 317),
(115, 'Roti Bakar', '211', '109115', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 1, 318),
(115, 'Almond Chocolate', '211', '109115', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 2, 319),
(115, 'Frozen Caramel', '211', '109115', '2015-04-22', '17:23:00.000000', 'Alit', 'DineIn', 3, 320),
(116, 'Frozen Caramel', '312', '109116', '2015-04-22', '17:27:00.000000', 'Alit', 'DineIn', 2, 321),
(116, 'Roti Bakar', '312', '109116', '2015-04-22', '17:27:00.000000', 'Alit', 'DineIn', 1, 322),
(116, 'Lemon Lime', '312', '109116', '2015-04-22', '17:27:00.000000', 'Alit', 'DineIn', 1, 323),
(117, 'Frozen Tiramisu', '101', '109117', '2015-04-22', '17:34:00.000000', 'Alit', 'DineIn', 1, 324),
(118, 'Hot/Ice Chocolate', 'T1', '109118', '2015-04-22', '17:41:00.000000', 'Alit', 'TakeAway', 2, 325),
(119, 'Frozen Tiramisu', '703', '109119', '2015-04-22', '17:47:00.000000', 'Alit', 'DineIn', 2, 326),
(120, 'Ice Macchiato Caramel', 'T1', '109120', '2015-04-23', '18:03:00.000000', 'Alit', 'TakeAway', 2, 327),
(121, 'Frozen Caramel', '405', '109121', '2015-04-23', '18:16:00.000000', 'Alit', 'DineIn', 1, 328),
(121, 'Kopi Bandrek', '405', '109121', '2015-04-23', '18:16:00.000000', 'Alit', 'DineIn', 2, 329),
(121, 'Lemon Lime', '405', '109121', '2015-04-23', '18:16:00.000000', 'Alit', 'DineIn', 1, 330),
(121, 'French Fries', '405', '109121', '2015-04-23', '18:16:00.000000', 'Alit', 'DineIn', 1, 331),
(121, 'Roti Bakar', '405', '109121', '2015-04-23', '18:16:00.000000', 'Alit', 'DineIn', 1, 332),
(122, 'Frozen Tiramisu', '608', '109122', '2015-04-23', '18:21:00.000000', 'Alit', 'DineIn', 1, 333),
(122, 'Lemon Lime', '608', '109122', '2015-04-23', '18:21:00.000000', 'Alit', 'DineIn', 1, 334),
(122, 'Almond Chocolate', '608', '109122', '2015-04-23', '18:21:00.000000', 'Alit', 'DineIn', 1, 335),
(122, 'Roti Bakar', '608', '109122', '2015-04-23', '18:21:00.000000', 'Alit', 'DineIn', 1, 336),
(122, 'Frozen Caramel', '608', '109122', '2015-04-23', '18:21:00.000000', 'Alit', 'DineIn', 1, 337),
(123, 'Frozen Tiramisu', '113', '109123', '2015-04-23', '18:32:00.000000', 'Alit', 'DineIn', 1, 338),
(123, 'Lemon Lime', '113', '109123', '2015-04-23', '18:32:00.000000', 'Alit', 'DineIn', 1, 339),
(123, 'Almond Chocolate', '113', '109123', '2015-04-23', '18:32:00.000000', 'Alit', 'DineIn', 1, 340),
(123, 'Roti Bakar', '113', '109123', '2015-04-23', '18:32:00.000000', 'Alit', 'DineIn', 2, 341),
(123, 'Frozen Caramel', '113', '109123', '2015-04-23', '18:32:00.000000', 'Alit', 'DineIn', 1, 342),
(124, 'Frozen Caramel', '201', '109124', '2015-04-23', '18:40:00.000000', 'Alit', 'DineIn', 1, 343),
(124, 'Lemon Lime', '201', '109124', '2015-04-23', '18:40:00.000000', 'Alit', 'DineIn', 1, 344),
(124, 'French Fries', '201', '109124', '2015-04-23', '18:40:00.000000', 'Alit', 'DineIn', 2, 345),
(124, 'Almond Chocolate', '201', '109124', '2015-04-23', '18:40:00.000000', 'Alit', 'DineIn', 3, 346),
(124, 'Roti Bakar', '201', '109124', '2015-04-23', '18:40:00.000000', 'Alit', 'DineIn', 1, 347);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tree`
--

CREATE TABLE IF NOT EXISTS `tree` (
`id` int(11) NOT NULL,
  `id_trans` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) NOT NULL,
  `parent` int(11) NOT NULL,
  `node` int(11) DEFAULT NULL,
  `urutan` int(11) DEFAULT NULL,
  `id_upload` int(11) NOT NULL,
  `no_bill` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ekstrak_transaksi`
--
ALTER TABLE `ekstrak_transaksi`
 ADD PRIMARY KEY (`id_trans`);

--
-- Indexes for table `hasil_rekomendasi`
--
ALTER TABLE `hasil_rekomendasi`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `header`
--
ALTER TABLE `header`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `insert_item`
--
ALTER TABLE `insert_item`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `itemset`
--
ALTER TABLE `itemset`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `itemset_detail`
--
ALTER TABLE `itemset_detail`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
 ADD PRIMARY KEY (`id_menu`), ADD UNIQUE KEY `nama_menu` (`nama_menu`);

--
-- Indexes for table `new_support`
--
ALTER TABLE `new_support`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rescan_item`
--
ALTER TABLE `rescan_item`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tree`
--
ALTER TABLE `tree`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ekstrak_transaksi`
--
ALTER TABLE `ekstrak_transaksi`
MODIFY `id_trans` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `hasil_rekomendasi`
--
ALTER TABLE `hasil_rekomendasi`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `header`
--
ALTER TABLE `header`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `insert_item`
--
ALTER TABLE `insert_item`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `itemset`
--
ALTER TABLE `itemset`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `itemset_detail`
--
ALTER TABLE `itemset_detail`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `new_support`
--
ALTER TABLE `new_support`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rescan_item`
--
ALTER TABLE `rescan_item`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=348;
--
-- AUTO_INCREMENT for table `tree`
--
ALTER TABLE `tree`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
