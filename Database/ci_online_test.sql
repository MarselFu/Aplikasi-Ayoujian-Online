-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 30, 2023 at 11:41 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ci_online_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `id_dosen` int(11) NOT NULL,
  `nip` char(12) NOT NULL,
  `nama_dosen` varchar(50) NOT NULL,
  `email` varchar(254) NOT NULL,
  `matkul_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dosen`
--

INSERT INTO `dosen` (`id_dosen`, `nip`, `nama_dosen`, `email`, `matkul_id`) VALUES
(1, '123456789', 'Mulyanto', 'Mulyanto123@gmail.com', 1),
(3, '10302038', 'Suyanto ', 'suyanto30@gmail.com', 2);

--
-- Triggers `dosen`
--
DELIMITER $$
CREATE TRIGGER `edit_user_dosen` BEFORE UPDATE ON `dosen` FOR EACH ROW UPDATE `users` SET `email` = NEW.email, `username` = NEW.nip WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `hapus_user_dosen` BEFORE DELETE ON `dosen` FOR EACH ROW DELETE FROM `users` WHERE `users`.`username` = OLD.nip
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` mediumint(8) UNSIGNED NOT NULL,
  `name` varchar(20) NOT NULL,
  `description` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`, `description`) VALUES
(1, 'admin', 'Administrator'),
(2, 'dosen', 'Pembuat Soal dan ujian'),
(3, 'mahasiswa', 'Peserta Ujian');

-- --------------------------------------------------------

--
-- Table structure for table `h_ujian`
--

CREATE TABLE `h_ujian` (
  `id` int(11) NOT NULL,
  `ujian_id` int(11) NOT NULL,
  `mahasiswa_id` int(11) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(11) NOT NULL,
  `nilai` decimal(10,2) NOT NULL,
  `nilai_bobot` decimal(10,2) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `id_jurusan` int(11) NOT NULL,
  `nama_jurusan` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jurusan`
--

INSERT INTO `jurusan` (`id_jurusan`, `nama_jurusan`) VALUES
(1, 'Teknik Informatika'),
(2, 'Sistem Informasi'),
(3, 'Ilmu Komputer'),
(4, 'Manajemen Informatika'),
(5, 'Sistem Multimedia');

-- --------------------------------------------------------

--
-- Table structure for table `jurusan_matkul`
--

CREATE TABLE `jurusan_matkul` (
  `id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `jurusan_matkul`
--

INSERT INTO `jurusan_matkul` (`id`, `matkul_id`, `jurusan_id`) VALUES
(2, 1, 1),
(3, 2, 2),
(4, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `jurusan_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `jurusan_id`) VALUES
(1, '3A', 1),
(2, '3B', 1),
(5, '3A', 2),
(6, '3B', 2),
(15, '3A', 3),
(16, '3B', 3),
(17, '3A', 4),
(18, '3B', 4),
(19, '3A', 5),
(20, '3B', 5);

-- --------------------------------------------------------

--
-- Table structure for table `kelas_dosen`
--

CREATE TABLE `kelas_dosen` (
  `id` int(11) NOT NULL,
  `kelas_id` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `kelas_dosen`
--

INSERT INTO `kelas_dosen` (`id`, `kelas_id`, `dosen_id`) VALUES
(10, 1, 1),
(11, 2, 1),
(33, 5, 3),
(34, 6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

CREATE TABLE `login_attempts` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `login` varchar(100) NOT NULL,
  `time` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `id_mahasiswa` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `nim` char(20) NOT NULL,
  `email` varchar(254) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kelas_id` int(11) NOT NULL COMMENT 'kelas&jurusan'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mahasiswa`
--

INSERT INTO `mahasiswa` (`id_mahasiswa`, `nama`, `nim`, `email`, `jenis_kelamin`, `kelas_id`) VALUES
(1, 'Marcellino Fadhilah Utomo', '011203028', 'marselfu46@gmail.com', 'L', 2),
(2, 'Azis Rizkil Mubarokah', '011203024', 'azisrizkilracing46@gmail.com', 'L', 5),
(3, 'Achmad Akbar', '011203029', 'achmaddd@gmail.com', 'L', 1),
(4, 'Gigih Andira Hidayat', '011203039', 'gigihknalpot20@gmail.com', 'L', 6),
(5, 'M.D.Luffy', '011203020', 'onepiece@gmail.com', 'L', 2),
(9, 'Bachtiar Ramadhan', '112030390', 'abah@gmail.com', 'L', 17),
(10, 'Valen Rionald', '112030391', 'valen@gmail.com', 'L', 18),
(11, 'Gilang Aditya', '12030077', 'gilang@gmail.com', 'L', 20);

-- --------------------------------------------------------

--
-- Table structure for table `matkul`
--

CREATE TABLE `matkul` (
  `id_matkul` int(11) NOT NULL,
  `nama_matkul` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `matkul`
--

INSERT INTO `matkul` (`id_matkul`, `nama_matkul`) VALUES
(1, 'Pemrogramman Web'),
(2, 'Analisis dan Desain Perangkat Lunak'),
(3, 'Kompresi Data Multimedia'),
(4, 'Jaringan Komputer');

-- --------------------------------------------------------

--
-- Table structure for table `m_ujian`
--

CREATE TABLE `m_ujian` (
  `id_ujian` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(11) NOT NULL,
  `waktu` int(11) NOT NULL,
  `jenis` enum('acak','urut') NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `terlambat` datetime NOT NULL,
  `token` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `tb_soal`
--

CREATE TABLE `tb_soal` (
  `id_soal` int(11) NOT NULL,
  `dosen_id` int(11) NOT NULL,
  `matkul_id` int(11) NOT NULL,
  `bobot` int(11) NOT NULL,
  `file` varchar(255) NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `file_a` varchar(255) NOT NULL,
  `file_b` varchar(255) NOT NULL,
  `file_c` varchar(255) NOT NULL,
  `file_d` varchar(255) NOT NULL,
  `file_e` varchar(255) NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `questions_used` int(11) NOT NULL,
  `is_active` int(11) NOT NULL,
  `created_on` int(11) NOT NULL,
  `updated_on` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `tb_soal`
--

INSERT INTO `tb_soal` (`id_soal`, `dosen_id`, `matkul_id`, `bobot`, `file`, `tipe_file`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `file_a`, `file_b`, `file_c`, `file_d`, `file_e`, `jawaban`, `questions_used`, `is_active`, `created_on`, `updated_on`) VALUES
(1, 1, 1, 4, '', '', '<p><span xss=removed>Proses langkah pembuatan aplikasi berbasis web yang dilalui dengan tahap teknologi jaringan, internet dan bahasa pemrograman adalah...</span><br></p>', '<p>Pemrogramman C++</p>', '<p>Algoritma Pemrogramman </p>', '<p>Pemrogramman Web</p>', '<p>Web Desain </p>', '<p>Pemrogramman Mobile</p>', '', '', '', '', '', 'C', 0, 0, 1685434217, 1692189404),
(2, 1, 1, 4, '', '', '<p><span xss=\"removed\">File HTML harus berekstensi...</span><br></p>', '<p>.php</p>', '<p>.html</p>', '<p>.css</p>', '<p>.index</p>', '<p>.png</p>', '', '', '', '', '', 'B', 1, 0, 1685434291, 1692436133),
(4, 1, 1, 4, '', '', '<p><span xss=removed> Berikut ini yang menjadi standarisasi Web adalah...</span><br></p>', '<p><span xss=removed>﻿</span><span xss=removed>ECMAN (eropean Computer Manufacturers Association)</span><br></p>', '<p><span xss=removed>﻿</span>Google</p>', '<p><span xss=removed>W3C (Word Wide Web Consortium)</span><br></p>', '<p>Linux</p>', '<p>Https</p>', '', '', '', '', '', 'C', 1, 1, 1685527571, 1692436325),
(6, 1, 1, 4, '', '', '<p><span xss=removed> Setiap </span><strong xss=removed>variabel </strong><span xss=removed>di PHP diawali dengan simbol....</span><br></p>', '<p>#</p>', '<p>$</p>', '<p>%</p>', '<p>(</p>', '<p>*</p>', '', '', '', '', '', 'B', 1, 0, 1688538412, 1688653965),
(7, 1, 1, 4, '', '', '<p><span xss=\"removed\"><b>Perhatikan sintak berikut : </b></span></p><p><span class=\"kwd\" xss=\"removed\">function</span><span class=\"pln\" xss=\"removed\"> </span><span class=\"typ\" xss=\"removed\">SetNilai</span><span class=\"pun\" xss=\"removed\">(</span><span class=\"pln\" xss=\"removed\"> $nilai</span><span class=\"pun\" xss=\"removed\">=</span><span class=\"pln\" xss=\"removed\"> </span><span class=\"lit\" xss=\"removed\">50</span><span class=\"pun\" xss=\"removed\">)</span><span class=\"pun\" xss=\"removed\">{</span><span class=\"pln\" xss=\"removed\">\r\n</span></p><p><span class=\"pln\" xss=\"removed\">              echo $nilai</span><span class=\"pun\" xss=\"removed\">;</span></p><p><span class=\"pun\" xss=\"removed\">}</span></p><p><span class=\"typ\" xss=\"removed\">SetNilai</span><span class=\"pun\" xss=\"removed\">();</span><span xss=\"removed\"><br></span></p><p><span xss=\"removed\"><b>Program diatas menghasilkan output ?</b><br></span><br></p>', '<p>0</p>', '<p>Null</p>', '<p>Syntax Error</p>', '<p>50</p>', '<p>10</p>', '', '', '', '', '', 'D', 1, 0, 1688538524, 1690787350),
(9, 1, 1, 4, '', '', '<p><span xss=\"removed\">Aplikasi yang dapat digunakan untuk mendesain tampilan aplikasi Android adalah ...</span><br></p>', '<p>Codeigniter</p>', '<p>Unity</p>', '<p>Microsoft Sql Server</p>', '<p>Java Net Beans</p>', '<p>Android Studio</p>', '', '', '', '', '', 'E', 0, 0, 1688539073, 1688653956),
(10, 1, 1, 4, '', '', '<p><span xss=removed>Ketika menggunakan method POST, variabel akan ditampilkan pada URL.....</span><br></p>', '<p>True</p>', '<p>False</p>', '', '', '', '', '', '', '', '', 'B', 0, 0, 1688539267, 1688653839),
(11, 1, 1, 4, '', '', '<p><span xss=removed>Saat membuat list pada HTML dibagi menjadi tiga, diantaranya...</span><br></p>', '<p><span xss=removed>Deskripsi, terarah dan terurut</span><br></p>', '<p><span xss=removed>Panjang, pendek, dan sedang</span><br></p>', '<p><span xss=removed>Ordered list, unordered list dan descripsion list</span><br></p>', '<p>Ordered list dan unordered list<br></p>', '<p>Panjang, pendek, dan sedang<br></p>', '', '', '', '', '', 'C', 1, 0, 1688539701, 1688653832),
(12, 1, 1, 4, '', '', '<p><b>Buah Favoritku : </b></p><p>1. Mangga</p><p>2. Jeruk</p><p>3. Pisang</p><p>4. Alpukat</p><p>5. Nanas</p><p><b>List diatas termasuk kedalam list bagian...</b></p>', '<p>Unordered list</p>', '<p>Description List</p>', '<p>Tag ol</p>', '<p>Ordered list<br></p>', '<p>Tag li</p>', '', '', '', '', '', 'D', 1, 0, 1688539839, 1690787331),
(13, 1, 1, 4, '', '', '<p>Bahasa khusus yang berfungsi untuk mempercantik atau memperindah tampilan web adalah...<br></p>', '<p>Laravel</p>', '<p>Javascript</p>', '<p>PHP</p>', '<p>CSS</p>', 'Query', '', '', '', '', '', 'D', 1, 0, 1688539933, 1688653781),
(14, 1, 1, 4, '', '', '<p>Manakah cara yang tepat untuk menambahkan 1 ke variabel $count.....<br></p>', '<p>$count =+ 1;<br></p>', '<p>++count;<br></p>', '<p> count++;<br></p>', '<p>**count//;</p>', '<p> $count++;<br></p>', '', '', '', '', '', 'E', 0, 0, 1688653533, 1688653774),
(15, 1, 1, 4, '', '', '<p>Yang bertugas untuk membuat halam web menjadi lebih hidup serta dapat menentukan fungsi atau efek yang diterapkan pada website adalah...<br></p>', '<p>Javascript</p>', '<p>PHP</p>', '<p>Laravel</p>', '<p>CSS</p>', '<p>Python</p>', '', '', '', '', '', 'A', 1, 0, 1688654465, 1688654465),
(16, 1, 1, 4, '', '', '<p>SGML singkatan dari...<br></p>', '<p>Standard Google Markup Language<br></p>', '<p>Standard Generalized Markup Language<br></p>', '<p>Standard Gift Markup List<br></p>', '<p>Search Generator Markah Languange<br></p>', '<p>Standard General Markup<br></p>', '', '', '', '', '', 'B', 1, 0, 1688654658, 1688654658),
(17, 1, 1, 4, '', '', '<p><b>Perhatikan codingan berikut ini :</b></p><p><br></p><p>public class MyClass {</p><p>public static void main(String[] args) {</p><p>int time = 22;</p><p>if (time < 10><p>System.out.println(\"Good morning.\");</p><p>}  else if (time < 20><p>System.out.println(\"Good day.\");</p><p>}  else {</p><p>System.out.println(\"Good evening.\");</p><p>}</p><p>}</p><p>}</p><p><br></p><p><b>Program diatas menghasilkan output ?</b></p><p><br></p><p><br></p>', '<p>Good day.</p>', '<p>Good morning.</p>', '<p>Good Night.</p>', '<p>Good evening.</p>', '<p>Good afternoon.</p>', '', '', '', '', '', 'D', 1, 0, 1688655026, 1688655026),
(18, 1, 1, 4, '', '', '<p>Method dibagi menjadi dua, yaitu...<br></p>', '<p>Get dan action<br></p>', '<p>Submit dan action<br></p>', '<p>Get dan post<br></p>', '<p>Post dan method<br></p>', '<p>Method dan get<br></p>', '', '', '', '', '', 'C', 0, 0, 1688655277, 1688655277),
(19, 1, 1, 4, '', '', '<p>Untuk menerima masukan berupa pilihan dalam formulir adalah..<br></p>', '<p>Submit</p>', '<p>Radio<br></p>', '<p>Text</p>', '<p>Button</p>', '<p>Checkbox</p>', '', '', '', '', '', 'B', 1, 0, 1688655540, 1688655540),
(20, 1, 1, 4, '', '', '<p>Untuk menghubungkan halaman web dengan basis data, bahasa pemrograman yang umum digunakan adalah...<br></p>', '<p>Java</p>', '<p>Ruby</p>', '<p>SQL</p>', '<p>C++</p>', '<p>C#</p>', '', '', '', '', '', 'C', 1, 0, 1688656015, 1688656015),
(21, 1, 1, 4, '', '', '<p><b>Daftar penjelasan :</b></p><p>Teh </p><p>Adalah sebuah minuman yang berasal dari daun teh yang menjadi menu minuman favorit. </p><p>Kopi Gula Aren</p><p>Adalah kopi yang dicampuri dengan gula aren, sekarang menjadi minuman favorit dikalangan anak muda.</p><p><b>List diatas termasuk kedalam bagian...</b></p>', '<p>Unordered list<br></p>', '<p>List biasa<br></p>', '<p>Nested List</p>', '<p>Description List</p>', '<p>Ordered List</p>', '', '', '', '', '', 'D', 1, 0, 1690787295, 1690787313),
(22, 1, 1, 4, '', '', '<p>Jika membuat file HTML dengan menggunakan spasi maka biasanya pada tampilan URL akan muncul...<br></p>', '<p>Error</p>', '<p>Spasi</p>', '<p> </p>', '<p>Blank View</p>', '<p>404</p>', '', '', '', '', '', 'C', 1, 0, 1690787540, 1690787540),
(23, 1, 1, 4, '', '', '<p>Dibawah ini merupakan struktur perulangan di PHP, kecuali...<br></p>', '<p>Switch</p>', '<p>For</p>', '<p>Foreach</p>', '<p>while</p>', '<p>Do</p>', '', '', '', '', '', 'A', 1, 0, 1690787746, 1690787746),
(24, 1, 1, 4, '', '', '<p><b>Perhatikan kode berikut:</b></p><p>for ($x = 1; $x < 10><p>  echo $x.\" \";</p><p>}</p><p><b>Kode tersebut menghasilkan output?</b></p>', '<p>12345678910</p>', '<p>123456789</p>', '<p>13579</p>', '<p>Error syntax</p>', '<p>2468</p>', '', '', '', '', '', 'B', 1, 0, 1690787881, 1690787881),
(25, 1, 1, 4, '', '', '<p>Untuk menerima data/informasi yang dikirim dari form menggunakan metode GET adalah?<br></p>', '<p>$_VAR</p>', '<p>$_GET</p>', '<p>$_METHOD</p>', '<p>$_POST</p>', '<p>$_GLOBAL</p>', '', '', '', '', '', 'B', 1, 0, 1690787969, 1690787969),
(26, 1, 1, 4, '', '', '<p>Sintak yang benar untuk membuat fungsi (function) di PHP adalah...<br></p>', '<p>new My_Function()<br></p>', '<p>function My_Function()<br></p>', '<p><span xss=removed>update My_Function()</span><br></p>', '<p><span xss=removed>create My_Function()</span><br></p>', '<p><span xss=removed>select My_Function()</span><br></p>', '', '', '', '', '', 'B', 1, 0, 1690788059, 1690788083),
(27, 1, 1, 4, '', '', '<p>Untuk membuat cookie di PHP menggunakan...<br></p>', '<p> createcookie()<br></p>', '<p> makecookie()<br></p>', '<p><span xss=removed> setcookie()</span><br></p>', '<p><span xss=removed> newcookie()</span><br></p>', '<p><span xss=removed> startcookie()</span><br></p>', '', '', '', '', '', 'C', 0, 0, 1690788165, 1690788165),
(28, 1, 1, 4, '', '', '<div><b>Perhatikan kode berikut:</b></div><div><br></div><div>$nama = array(\"Dina\", \"Aldi\", \"Okta\",\"Bayu\",\"Ahmad\"); </div><div>echo $nama[4];</div><div><br></div><div><b>Kode tersebut menghasilkan output?</b></div>', '<p>Ahmad</p>', '<p>Dina</p>', '<p>Okta</p>', '<p>Aldi</p>', '<p>Bayu</p>', '', '', '', '', '', 'A', 1, 0, 1690788297, 1690788297);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(254) DEFAULT NULL,
  `activation_selector` varchar(255) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `forgotten_password_selector` varchar(255) DEFAULT NULL,
  `forgotten_password_code` varchar(255) DEFAULT NULL,
  `forgotten_password_time` int(11) UNSIGNED DEFAULT NULL,
  `remember_selector` varchar(255) DEFAULT NULL,
  `remember_code` varchar(255) DEFAULT NULL,
  `created_on` int(11) UNSIGNED NOT NULL,
  `last_login` int(11) UNSIGNED DEFAULT NULL,
  `active` tinyint(1) UNSIGNED DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ip_address`, `username`, `password`, `email`, `activation_selector`, `activation_code`, `forgotten_password_selector`, `forgotten_password_code`, `forgotten_password_time`, `remember_selector`, `remember_code`, `created_on`, `last_login`, `active`, `first_name`, `last_name`, `company`, `phone`) VALUES
(1, '127.0.0.1', 'Admin Ayoujian', '$2y$12$tGY.AtcyXrh7WmccdbT1rOuKEcTsKH6sIUmDr0ore1yN4LnKTTtuu', 'admin@admin.com', NULL, '', NULL, NULL, NULL, NULL, NULL, 1268889823, 1692435199, 1, 'Admin', 'Ayoujian', 'ADMIN', '0'),
(10, '::1', '011203028', '$2y$10$g9ay.Ty2Es3eIL8xZjvUs.FUHkkD1mBayovabDs2U.pGSqN8N.QFa', 'marselfu46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1685433794, 1692131191, 1, 'Marcellino', 'Utomo', NULL, NULL),
(12, '::1', '123456789', '$2y$10$pNFvD7iViCHrMjSAc9h.ruU97p2FNd1xN81deHAxbznOO91YNc.IS', 'Mulyanto123@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1685434108, 1692863371, 1, 'Mulyanto', 'Mulyanto', NULL, NULL),
(13, '::1', '10302038', '$2y$10$Uo6oKyrlKKHrB2WN2uBvNeJihSrIIsbA3.5uDlSLCT2A3Tls.I4jO', 'suyanto30@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1690997085, 1691991185, 1, 'Suyanto', '-', NULL, NULL),
(14, '::1', '011203024', '$2y$10$5tmq7Tjj2JYi/MOm70b0ueufiSoPsEnGdkSn8LFWIDwR2BGSmvFZe', 'azisrizkilracing46@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691070641, NULL, 1, 'Azis', 'Mubarokah', NULL, NULL),
(15, '::1', '011203029', '$2y$10$NJ0.uj1d5zS3r1vzZxnUM.QI0OevG9t6qWQaKwDAgYgBEkL7NruCi', 'achmaddd@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691070718, NULL, 1, 'Achmad', 'Akbar', NULL, NULL),
(16, '::1', '011203039', '$2y$10$H3/R3BgT4GeNXtFEjoac5OI.LSO.XbL6K.TIJuo1c8zPxn7.yLveC', 'gigihknalpot20@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691070794, NULL, 1, 'Gigih', 'Hidayat', NULL, NULL),
(18, '::1', '011203020', '$2y$10$kKqgQ2zk5/hfdL0f/LQA6OCP1CULFnfCqne8D8k40hvTdhLFj8Up6', 'onepiece@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691692840, NULL, 1, 'M.D.Luffy', 'M.D.Luffy', NULL, NULL),
(19, '::1', '112030390', '$2y$10$RaP4cO3jdM9THggDFVx1V.5AehOYiX4IVDJn/aA4W9W/xCVWyBw2K', 'abah@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691727257, NULL, 1, 'Bachtiar', 'Ramadhan', NULL, NULL),
(20, '::1', '112030391', '$2y$10$kTXJi9EXAN4aejYDt8HCJeKC3nZUwQ0fJehAk8kAou0p2QS5A7uUG', 'valen@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691727258, NULL, 1, 'Valen', 'Rionald', NULL, NULL),
(21, '::1', '12030077', '$2y$10$KhAVYyEyBhn5/7TG5ohIPuwYt.ayQmxVA3KPDrtSmXyCFjLjKze0e', 'gilang@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1691727259, NULL, 1, 'Gilang', 'Aditya', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users_groups`
--

CREATE TABLE `users_groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) UNSIGNED NOT NULL,
  `group_id` mediumint(8) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(3, 1, 1),
(12, 10, 3),
(14, 12, 2),
(15, 13, 2),
(16, 14, 3),
(17, 15, 3),
(18, 16, 3),
(20, 18, 3),
(21, 19, 3),
(22, 20, 3),
(23, 21, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`id_dosen`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `nip` (`nip`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ujian_id` (`ujian_id`),
  ADD KEY `mahasiswa_id` (`mahasiswa_id`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`id_jurusan`);

--
-- Indexes for table `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jurusan_id` (`jurusan_id`),
  ADD KEY `matkul_id` (`matkul_id`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `jurusan_id` (`jurusan_id`);

--
-- Indexes for table `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kelas_id` (`kelas_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `login_attempts`
--
ALTER TABLE `login_attempts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`id_mahasiswa`),
  ADD UNIQUE KEY `nim` (`nim`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `kelas_id` (`kelas_id`);

--
-- Indexes for table `matkul`
--
ALTER TABLE `matkul`
  ADD PRIMARY KEY (`id_matkul`);

--
-- Indexes for table `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD PRIMARY KEY (`id_ujian`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD PRIMARY KEY (`id_soal`),
  ADD KEY `matkul_id` (`matkul_id`),
  ADD KEY `dosen_id` (`dosen_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_activation_selector` (`activation_selector`),
  ADD UNIQUE KEY `uc_forgotten_password_selector` (`forgotten_password_selector`),
  ADD UNIQUE KEY `uc_remember_selector` (`remember_selector`),
  ADD UNIQUE KEY `uc_email` (`email`) USING BTREE;

--
-- Indexes for table `users_groups`
--
ALTER TABLE `users_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uc_users_groups` (`user_id`,`group_id`),
  ADD KEY `fk_users_groups_users1_idx` (`user_id`),
  ADD KEY `fk_users_groups_groups1_idx` (`group_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dosen`
--
ALTER TABLE `dosen`
  MODIFY `id_dosen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `groups`
--
ALTER TABLE `groups`
  MODIFY `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `h_ujian`
--
ALTER TABLE `h_ujian`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jurusan`
--
ALTER TABLE `jurusan`
  MODIFY `id_jurusan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `login_attempts`
--
ALTER TABLE `login_attempts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  MODIFY `id_mahasiswa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `matkul`
--
ALTER TABLE `matkul`
  MODIFY `id_matkul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `m_ujian`
--
ALTER TABLE `m_ujian`
  MODIFY `id_ujian` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tb_soal`
--
ALTER TABLE `tb_soal`
  MODIFY `id_soal` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users_groups`
--
ALTER TABLE `users_groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `dosen`
--
ALTER TABLE `dosen`
  ADD CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Constraints for table `h_ujian`
--
ALTER TABLE `h_ujian`
  ADD CONSTRAINT `h_ujian_ibfk_1` FOREIGN KEY (`ujian_id`) REFERENCES `m_ujian` (`id_ujian`),
  ADD CONSTRAINT `h_ujian_ibfk_2` FOREIGN KEY (`mahasiswa_id`) REFERENCES `mahasiswa` (`id_mahasiswa`);

--
-- Constraints for table `jurusan_matkul`
--
ALTER TABLE `jurusan_matkul`
  ADD CONSTRAINT `jurusan_matkul_ibfk_1` FOREIGN KEY (`jurusan_id`) REFERENCES `jurusan` (`id_jurusan`),
  ADD CONSTRAINT `jurusan_matkul_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Constraints for table `kelas_dosen`
--
ALTER TABLE `kelas_dosen`
  ADD CONSTRAINT `kelas_dosen_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `kelas_dosen_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Constraints for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD CONSTRAINT `mahasiswa_ibfk_2` FOREIGN KEY (`kelas_id`) REFERENCES `kelas` (`id_kelas`);

--
-- Constraints for table `m_ujian`
--
ALTER TABLE `m_ujian`
  ADD CONSTRAINT `m_ujian_ibfk_1` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`),
  ADD CONSTRAINT `m_ujian_ibfk_2` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`);

--
-- Constraints for table `tb_soal`
--
ALTER TABLE `tb_soal`
  ADD CONSTRAINT `tb_soal_ibfk_1` FOREIGN KEY (`matkul_id`) REFERENCES `matkul` (`id_matkul`),
  ADD CONSTRAINT `tb_soal_ibfk_2` FOREIGN KEY (`dosen_id`) REFERENCES `dosen` (`id_dosen`);

--
-- Constraints for table `users_groups`
--
ALTER TABLE `users_groups`
  ADD CONSTRAINT `fk_users_groups_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_users_groups_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
