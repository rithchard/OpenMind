CREATE DATABASE openmind;
use openmind;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `artn` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `dia` varchar(200) CHARACTER SET utf8 NOT NULL,
  `mes` varchar(20) CHARACTER SET utf8 NOT NULL,
  `anio` varchar(20) CHARACTER SET utf8 NOT NULL,
  `ArtFolder` varchar(100) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `nofounds` (
  `id` int(22) NOT NULL AUTO_INCREMENT,
  `artn` varchar(222) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

CREATE TABLE IF NOT EXISTS `tipeados` (
  `id` int(22) NOT NULL AUTO_INCREMENT,
  `artn` varchar(222) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;
