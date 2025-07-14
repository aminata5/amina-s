-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : dim. 13 juil. 2025 à 19:43
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `e_tontine`
--

-- --------------------------------------------------------

--
-- Structure de la table `cotisations`
--

CREATE TABLE `cotisations` (
  `id` int(11) NOT NULL,
  `tontine_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `date_cotisation` timestamp NOT NULL DEFAULT current_timestamp(),
  `statut` enum('en_attente','payé','en_retard') DEFAULT 'en_attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `dons`
--

CREATE TABLE `dons` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `date_don` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `dons`
--

INSERT INTO `dons` (`id`, `nom`, `montant`, `message`, `date_don`) VALUES
(1, 'Fall', 6650.00, 'kho', '2025-07-10 19:44:23');

-- --------------------------------------------------------

--
-- Structure de la table `membres_tontine`
--

CREATE TABLE `membres_tontine` (
  `tontine_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_ajout` timestamp NOT NULL DEFAULT current_timestamp(),
  `cin_numero` varchar(100) DEFAULT NULL,
  `cin_fichier` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `membres_tontine`
--

INSERT INTO `membres_tontine` (`tontine_id`, `user_id`, `date_ajout`, `cin_numero`, `cin_fichier`) VALUES
(1, 1, '2025-07-10 16:59:34', '6775665', 'cin_686ff176d130d_Capture d\'écran 2025-07-07 002403.png'),
(1, 2, '2025-07-10 16:54:24', '2345', 'cin_686ff040c784f_Capture d\'écran 2025-07-07 002403.png');

-- --------------------------------------------------------

--
-- Structure de la table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `tontine_id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_envoi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `tontines`
--

CREATE TABLE `tontines` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `montant` decimal(10,2) NOT NULL,
  `frequence` enum('quotidien','hebdomadaire','mensuel') DEFAULT 'mensuel',
  `date_debut` date DEFAULT NULL,
  `createur_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `tontines`
--

INSERT INTO `tontines` (`id`, `nom`, `description`, `montant`, `frequence`, `date_debut`, `createur_id`, `created_at`) VALUES
(1, 'Maouloud Fall', 'mlknlk', 45555.00, 'mensuel', NULL, 1, '2025-06-27 18:55:24'),
(2, 'Maouloud Fall', 'bljhbjhb', 97687.00, 'hebdomadaire', NULL, 1, '2025-06-27 18:58:31'),
(3, 'Maouloud Fall', 'Je suis interesé', 200000.00, 'mensuel', NULL, 2, '2025-07-10 13:23:13'),
(4, 'Arbre', 'Tontine Arbre', 10000.00, 'mensuel', '2025-07-11', 1, '2025-07-10 14:20:52'),
(5, 'Natte Tégui', 'Chaque fin du mois Natte Tégui', 10000.00, 'hebdomadaire', '2025-07-20', 4, '2025-07-12 22:29:49'),
(6, 'Kawral', 'Conférence', 2000.00, 'quotidien', '2025-07-13', 6, '2025-07-13 17:06:47');

-- --------------------------------------------------------

--
-- Structure de la table `tours`
--

CREATE TABLE `tours` (
  `id` int(11) NOT NULL,
  `tontine_id` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` varchar(50) DEFAULT 'en attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(20) DEFAULT 'membre'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `email`, `telephone`, `password`, `created_at`, `role`) VALUES
(6, 'amina konté', 'mina@gmail.com', '678899', '$2y$10$ausQsSBK09ZgWPNmXgc1qe4mFW.yuET7LFMet51ktBZQkKWZD3yq.', '2025-07-13 17:04:04', 'membre');

-- --------------------------------------------------------

--
-- Structure de la table `versements`
--

CREATE TABLE `versements` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `nom` varchar(150) DEFAULT NULL,
  `tontine_id` int(11) NOT NULL,
  `montant` decimal(10,2) NOT NULL,
  `type_versement` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `versements`
--

INSERT INTO `versements` (`id`, `user_id`, `nom`, `tontine_id`, `montant`, `type_versement`, `date`) VALUES
(1, 1, 'Maouloud Fall', 4, 5666.00, 'retard', '2025-07-10 17:57:22'),
(2, 1, 'Maouloud Fall', 4, 5666.00, 'retard', '2025-07-10 17:58:23'),
(3, 4, 'Admin1', 1, 12000.00, 'exceptionnel', '2025-07-12 22:36:39');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `dons`
--
ALTER TABLE `dons`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `membres_tontine`
--
ALTER TABLE `membres_tontine`
  ADD PRIMARY KEY (`tontine_id`,`user_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Index pour la table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tontine_id` (`tontine_id`),
  ADD KEY `sender_id` (`sender_id`);

--
-- Index pour la table `tontines`
--
ALTER TABLE `tontines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `createur_id` (`createur_id`);

--
-- Index pour la table `tours`
--
ALTER TABLE `tours`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tontine_id` (`tontine_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `versements`
--
ALTER TABLE `versements`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `dons`
--
ALTER TABLE `dons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `tontines`
--
ALTER TABLE `tontines`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `tours`
--
ALTER TABLE `tours`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `versements`
--
ALTER TABLE `versements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `tours`
--
ALTER TABLE `tours`
  ADD CONSTRAINT `tours_ibfk_1` FOREIGN KEY (`tontine_id`) REFERENCES `tontines` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
