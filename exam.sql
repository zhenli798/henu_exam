/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50731
Source Host           : localhost:3306
Source Database       : exam

Target Server Type    : MYSQL
Target Server Version : 50731
File Encoding         : 65001

Date: 2022-05-26 11:19:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for exam
-- ----------------------------
DROP TABLE IF EXISTS `exam`;
CREATE TABLE `exam` (
  `e_id` int(11) NOT NULL AUTO_INCREMENT,
  `t_id` varchar(20) DEFAULT NULL COMMENT '˭?????',
  `e_name` varchar(20) DEFAULT NULL COMMENT '???Կ?Ŀ',
  `e_starttime` varchar(40) DEFAULT NULL COMMENT '??ʼʱ?',
  `e_stoptime` varchar(40) DEFAULT NULL,
  `e_autostart` tinyint(2) DEFAULT NULL,
  `e_status` tinyint(2) DEFAULT NULL COMMENT 'nothing\r\n\r\n',
  `q_path` varchar(255) DEFAULT NULL,
  `q_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`e_id`),
  KEY `FK_t_e_fk` (`t_id`),
  CONSTRAINT `FK_t_e_fk` FOREIGN KEY (`t_id`) REFERENCES `teacher` (`t_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='????ʵ?';

-- ----------------------------
-- Records of exam
-- ----------------------------

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
  `f_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '???',
  `s_id` varchar(40) DEFAULT NULL,
  `f_name` varchar(255) DEFAULT NULL,
  `f_path` varchar(1024) DEFAULT NULL,
  `f_size` int(11) DEFAULT NULL,
  `f_time` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`f_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='?ļ??????еģ????????';

-- ----------------------------
-- Records of file
-- ----------------------------

-- ----------------------------
-- Table structure for global
-- ----------------------------
DROP TABLE IF EXISTS `global`;
CREATE TABLE `global` (
  `g_id` int(11) NOT NULL,
  `task_interval` int(11) DEFAULT NULL,
  `record_number` int(11) DEFAULT NULL,
  `max_advance_time` int(11) DEFAULT NULL,
  `min_file_size` int(11) DEFAULT NULL,
  `max_file_size` int(11) DEFAULT NULL,
  `teacher_can_clean` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`g_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='ϵͳʵ???洢ȫ????????Ϣ';

-- ----------------------------
-- Records of global
-- ----------------------------
INSERT INTO `global` VALUES ('1', '22', '13', '11', '4', '200', '1');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `n_id` int(11) NOT NULL AUTO_INCREMENT,
  `e_id` int(11) DEFAULT NULL,
  `n_text` varchar(1024) DEFAULT NULL,
  `n_time` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`n_id`),
  KEY `FK_e_n_fk` (`e_id`),
  CONSTRAINT `FK_e_n_fk` FOREIGN KEY (`e_id`) REFERENCES `exam` (`e_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='ʵʱ??Ϣʵ?';

-- ----------------------------
-- Records of notice
-- ----------------------------

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `s_i` int(11) NOT NULL AUTO_INCREMENT,
  `e_id` int(11) DEFAULT NULL,
  `s_id` varchar(20) DEFAULT NULL,
  `s_name` varchar(20) DEFAULT NULL,
  `s_class` varchar(20) DEFAULT NULL,
  `s_ipaddress` varchar(40) DEFAULT NULL,
  `s_online` tinyint(2) DEFAULT NULL,
  `s_score` int(5) DEFAULT NULL,
  `s_comment` varchar(1024) DEFAULT NULL,
  `s_fpath` varchar(255) DEFAULT NULL,
  `s_fname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`s_i`),
  KEY `FK_s_f_fk2` (`e_id`),
  CONSTRAINT `FK_s_f_fk2` FOREIGN KEY (`e_id`) REFERENCES `exam` (`e_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------

-- ----------------------------
-- Table structure for teacher
-- ----------------------------
DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `t_id` varchar(20) NOT NULL COMMENT '˭?????',
  `t_pwd` varchar(40) NOT NULL COMMENT '??ʦ???',
  `t_name` varchar(20) NOT NULL COMMENT '??ʦ??ʵ????',
  `t_isadmin` tinyint(2) NOT NULL COMMENT '?Ƿ?Ϊ????Ա',
  PRIMARY KEY (`t_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='?û?????ģ????ʦ??????Աʵ?';

-- ----------------------------
-- Records of teacher
-- ----------------------------
INSERT INTO `teacher` VALUES ('001', '2226d8ac6eca2771790dc3847fd188', '李振', '1');
INSERT INTO `teacher` VALUES ('002', '0adc3949ba59abbe56e057f20f883e', '刘琳', '1');
INSERT INTO `teacher` VALUES ('003', '0adc3949ba59abbe56e057f20f883e', '洪凯威', '1');
