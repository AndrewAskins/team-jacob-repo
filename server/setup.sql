SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `rumbly`
--

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `entry_id` int(11) NOT NULL AUTO_INCREMENT,
  `place_id` varchar(100) NOT NULL,
  `review_id` varchar(100) NOT NULL,
  `sequence` int(11) NOT NULL,
  `reviewer` varchar(100) NOT NULL,
  `emoji` varchar(100) NOT NULL,
  `review_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;
