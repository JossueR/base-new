CREATE TABLE `permissions` (
                               `permission` varchar(50) NOT NULL,
                               `description` text,
                               `public` enum('Y','N') NOT NULL DEFAULT 'Y',
                               PRIMARY KEY (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `users` (
                         `uid` int(11) NOT NULL AUTO_INCREMENT,
                         `username` varchar(32) NOT NULL,
                         `email` varchar(128) DEFAULT NULL,
                         `password` varchar(32) NOT NULL,
                         `created` datetime DEFAULT NULL,
                         `lastlogin` datetime DEFAULT NULL,
                         `active` tinyint(1) DEFAULT '1' COMMENT 'Activo=1\\\\\\\\nInactivo=0',
                         `LDAP` tinyint(1) NOT NULL DEFAULT '0',
                         `nombre` varchar(45) DEFAULT NULL,
                         `apellidos` varchar(45) DEFAULT NULL,
                         `sexo` enum('M','F') DEFAULT NULL,
                         `f_nacimiento` date DEFAULT NULL,
                         PRIMARY KEY (`uid`),
                         UNIQUE KEY `username` (`username`),
                         UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE `groups` (
                          `id` int(11) NOT NULL AUTO_INCREMENT,
                          `name` varchar(128) DEFAULT NULL,
                          `public` enum('Y','N') NOT NULL DEFAULT 'Y',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;

CREATE TABLE `user_permissions` (
                                    `user_id` int(11) NOT NULL,
                                    `permission` varchar(50) NOT NULL,
                                    PRIMARY KEY (`user_id`,`permission`),
                                    KEY `permission` (`permission`),
                                    KEY `fk_user_permissions_users1_idx` (`user_id`),
                                    CONSTRAINT `fk_user_permissions_permissions1` FOREIGN KEY (`permission`) REFERENCES `permissions` (`permission`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                                    CONSTRAINT `fk_user_permissions_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `group_users` (
                               `user_id` int(11) NOT NULL,
                               `group_id` int(11) NOT NULL,
                               PRIMARY KEY (`user_id`,`group_id`),
                               KEY `user_id` (`user_id`,`group_id`),
                               KEY `group_id` (`group_id`),
                               KEY `fk_group_users_users1_idx` (`user_id`),
                               CONSTRAINT `fk_group_users_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                               CONSTRAINT `fk_group_users_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`uid`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `group_permissions` (
                                     `group_id` int(11) NOT NULL,
                                     `permission` varchar(50) NOT NULL,
                                     PRIMARY KEY (`group_id`,`permission`),
                                     KEY `permission` (`permission`),
                                     KEY `fk_group_permissions_groups1_idx` (`group_id`),
                                     CONSTRAINT `fk_group_permissions_groups1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
                                     CONSTRAINT `fk_group_permissions_permissions1` FOREIGN KEY (`permission`) REFERENCES `permissions` (`permission`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `i18n` (
                        `key` varchar(150) NOT NULL,
                        `en` varchar(300) DEFAULT NULL,
                        `es` varchar(300) DEFAULT NULL,
                        `updated` timestamp NULL DEFAULT NULL,
                        PRIMARY KEY (`key`),
                        UNIQUE KEY `key_UNIQUE` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `config_vars` (
                               `var` varchar(100) NOT NULL,
                               `val` text,
                               PRIMARY KEY (`var`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `sec_access` (
                              `invoker` varchar(255) NOT NULL,
                              `method` varchar(255) NOT NULL,
                              `permission` varchar(50) DEFAULT NULL,
                              `description` text,
                              `create_date` datetime DEFAULT NULL,
                              `create_user` varchar(50) DEFAULT NULL,
                              `update_date` datetime DEFAULT NULL,
                              `update_user` varchar(50) DEFAULT NULL,
                              `active` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
                              PRIMARY KEY (`invoker`),
                              KEY `fk_sec_access_permissions1_idx` (`permission`),
                              KEY `idx_method` (`method`),
                              CONSTRAINT `fk_sec_access_permissions1` FOREIGN KEY (`permission`) REFERENCES `permissions` (`permission`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `connection_from` (
                                   `id` varchar(25) NOT NULL,
                                   `url` varchar(500) DEFAULT NULL,
                                   `ip` varchar(40) DEFAULT NULL,
                                   `user` varchar(50) NOT NULL,
                                   `token` varchar(128) NOT NULL,
                                   `lifetime` time DEFAULT NULL,
                                   `last` datetime DEFAULT NULL,
                                   `PHPSESSID` varchar(32) NOT NULL,
                                   `create_date` datetime DEFAULT NULL,
                                   `create_user` varchar(50) DEFAULT NULL,
                                   `update_date` datetime DEFAULT NULL,
                                   `update_user` varchar(50) DEFAULT NULL,
                                   `active` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8