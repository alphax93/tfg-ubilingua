-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 20-05-2019 a las 20:41:23
-- Versión del servidor: 5.7.19
-- Versión de PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ubilingua`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetroles`
--

DROP TABLE IF EXISTS `aspnetroles`;
CREATE TABLE IF NOT EXISTS `aspnetroles` (
  `Id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Name` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `RoleNameIndex` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `aspnetroles`
--

INSERT INTO `aspnetroles` (`Id`, `Name`) VALUES
('3', 'admin'),
('2', 'Alumno'),
('1', 'Profesor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserclaims`
--

DROP TABLE IF EXISTS `aspnetuserclaims`;
CREATE TABLE IF NOT EXISTS `aspnetuserclaims` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ClaimType` longtext COLLATE utf8_unicode_ci,
  `ClaimValue` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`),
  KEY `FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserlogins`
--

DROP TABLE IF EXISTS `aspnetuserlogins`;
CREATE TABLE IF NOT EXISTS `aspnetuserlogins` (
  `LoginProvider` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `ProviderKey` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ProviderKey`,`UserId`),
  KEY `FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetuserroles`
--

DROP TABLE IF EXISTS `aspnetuserroles`;
CREATE TABLE IF NOT EXISTS `aspnetuserroles` (
  `UserId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `RoleId` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId` (`RoleId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `aspnetuserroles`
--

INSERT INTO `aspnetuserroles` (`UserId`, `RoleId`) VALUES
('f35045fc-abdc-4e03-8ca4-09da730999d5', '3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aspnetusers`
--

DROP TABLE IF EXISTS `aspnetusers`;
CREATE TABLE IF NOT EXISTS `aspnetusers` (
  `Id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `Email` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `EmailConfirmed` tinyint(4) NOT NULL,
  `PasswordHash` longtext COLLATE utf8_unicode_ci,
  `SecurityStamp` longtext COLLATE utf8_unicode_ci,
  `PhoneNumber` longtext COLLATE utf8_unicode_ci,
  `PhoneNumberConfirmed` tinyint(4) NOT NULL,
  `TwoFactorEnabled` tinyint(4) NOT NULL,
  `LockoutEndDateUtc` datetime(3) DEFAULT NULL,
  `LockoutEnabled` tinyint(4) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `UserName` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `Surname1` longtext COLLATE utf8_unicode_ci,
  `Surname2` longtext COLLATE utf8_unicode_ci,
  `Name` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `aspnetusers`
--

INSERT INTO `aspnetusers` (`Id`, `Email`, `EmailConfirmed`, `PasswordHash`, `SecurityStamp`, `PhoneNumber`, `PhoneNumberConfirmed`, `TwoFactorEnabled`, `LockoutEndDateUtc`, `LockoutEnabled`, `AccessFailedCount`, `UserName`, `Surname1`, `Surname2`, `Name`) VALUES
('f35045fc-abdc-4e03-8ca4-09da730999d5', 'a.garher93@gmail.com', 0, 'AHdXuHBWixWcYd61/d3856MGl5TNC1J+5BFwlOdDDf3+QbMow1JOAhhD7MqSaL2JHA==', '7f743504-d4d7-4dc3-8e22-fc1a5edce849', NULL, 0, 0, NULL, 1, 0, 'a.garher93@gmail.comAitor', 'Garcia', '', 'Aitor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `blocks`
--

DROP TABLE IF EXISTS `blocks`;
CREATE TABLE IF NOT EXISTS `blocks` (
  `BlockID` int(11) NOT NULL AUTO_INCREMENT,
  `BlockName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `SubjectID` int(11) NOT NULL,
  PRIMARY KEY (`BlockID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `blocks`
--

INSERT INTO `blocks` (`BlockID`, `BlockName`, `SubjectID`) VALUES
(1, 'Tema 1', 1),
(2, 'Tema 2', 1),
(3, 'Tema 1', 2),
(4, 'Tema 3', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `joinsubjectusers`
--

DROP TABLE IF EXISTS `joinsubjectusers`;
CREATE TABLE IF NOT EXISTS `joinsubjectusers` (
  `SubjectID` int(11) NOT NULL,
  `UserID` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SubjectID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `joinsubjectusers`
--

INSERT INTO `joinsubjectusers` (`SubjectID`, `UserID`) VALUES
(1, 'f35045fc-abdc-4e03-8ca4-09da730999d5');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `joinusermarks`
--

DROP TABLE IF EXISTS `joinusermarks`;
CREATE TABLE IF NOT EXISTS `joinusermarks` (
  `ResourceID` int(11) NOT NULL,
  `UserID` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `User` longtext COLLATE utf8_unicode_ci,
  `SubjectID` int(11) NOT NULL,
  `TaskName` longtext COLLATE utf8_unicode_ci,
  `Mark` double NOT NULL,
  `FilePath` longtext COLLATE utf8_unicode_ci,
  `Delivered` datetime(3) NOT NULL,
  PRIMARY KEY (`ResourceID`,`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `joinusermarks`
--

INSERT INTO `joinusermarks` (`ResourceID`, `UserID`, `User`, `SubjectID`, `TaskName`, `Mark`, `FilePath`, `Delivered`) VALUES
(2, 'f35045fc-abdc-4e03-8ca4-09da730999d5', 'Aitor Garcia ', 1, NULL, 10, 'test', '2019-04-20 20:08:18.001');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resources`
--

DROP TABLE IF EXISTS `resources`;
CREATE TABLE IF NOT EXISTS `resources` (
  `ResourceID` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ResourcePath` longtext COLLATE utf8_unicode_ci NOT NULL,
  `BlockID` int(11) NOT NULL,
  `IsVisible` tinyint(1) NOT NULL,
  `ResourceType` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ResourceID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `resources`
--

INSERT INTO `resources` (`ResourceID`, `ResourceName`, `ResourcePath`, `BlockID`, `IsVisible`, `ResourceType`) VALUES
(1, 'Recurso1', 'Recurso de texto', 2, 1, 'text'),
(2, 'prueba', 'exe.zip', 1, 0, 'test'),
(3, 'prueba2', 'a.zip', 2, 0, 'test'),
(4, 'prueba3', 'b.zip', 2, 0, 'test'),
(5, 'dfsdf', 'dfsdf', 2, 0, 'task');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `riddleresources`
--

DROP TABLE IF EXISTS `riddleresources`;
CREATE TABLE IF NOT EXISTS `riddleresources` (
  `RiddleID` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceID` int(11) NOT NULL,
  `RiddleName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `AudioPath` longtext COLLATE utf8_unicode_ci NOT NULL,
  `ImagePath` longtext COLLATE utf8_unicode_ci,
  `Text` longtext COLLATE utf8_unicode_ci,
  `TranslatedText` longtext COLLATE utf8_unicode_ci,
  `Answer` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`RiddleID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subjects`
--

DROP TABLE IF EXISTS `subjects`;
CREATE TABLE IF NOT EXISTS `subjects` (
  `SubjectID` int(11) NOT NULL AUTO_INCREMENT,
  `SubjectName` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `IsPrivate` tinyint(1) NOT NULL,
  `SubjectPassword` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ImagePath` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SubjectID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `subjects`
--

INSERT INTO `subjects` (`SubjectID`, `SubjectName`, `IsPrivate`, `SubjectPassword`, `ImagePath`) VALUES
(1, 'Ingles', 1, '123', 'uk.jpg'),
(2, 'Frances', 0, NULL, 'france.jpg'),
(3, 'Aleman', 0, NULL, 'germany.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taskresources`
--

DROP TABLE IF EXISTS `taskresources`;
CREATE TABLE IF NOT EXISTS `taskresources` (
  `TaskID` int(11) NOT NULL AUTO_INCREMENT,
  `ResourceID` int(11) NOT NULL,
  `TaskName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `Deadline` datetime(3) NOT NULL,
  `Text` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`TaskID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `taskresources`
--

INSERT INTO `taskresources` (`TaskID`, `ResourceID`, `TaskName`, `Deadline`, `Text`) VALUES
(1, 5, 'dfsdf', '2019-05-21 23:59:00.000', 'gsdgfg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `teachers`
--

DROP TABLE IF EXISTS `teachers`;
CREATE TABLE IF NOT EXISTS `teachers` (
  `TeacherID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` longtext COLLATE utf8_unicode_ci,
  `TeacherName` longtext COLLATE utf8_unicode_ci NOT NULL,
  `Position` longtext COLLATE utf8_unicode_ci,
  `Contact` longtext COLLATE utf8_unicode_ci,
  `SpanishRole` longtext COLLATE utf8_unicode_ci,
  `OtherRole` longtext COLLATE utf8_unicode_ci,
  `SpanishCV` longtext COLLATE utf8_unicode_ci,
  `OtherCV` longtext COLLATE utf8_unicode_ci,
  `Image` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`TeacherID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `teachers`
--

INSERT INTO `teachers` (`TeacherID`, `UserID`, `TeacherName`, `Position`, `Contact`, `SpanishRole`, `OtherRole`, `SpanishCV`, `OtherCV`, `Image`) VALUES
(1, NULL, 'Agustía Darias Marrero', 'RESPONSABLE DE FRANCÉS / RESPONSABLE POUR LE FRANÇAIS', NULL, 'Además de ser el coordinador de este grupo, su papel fundamental en su seno es la elaboración de material didáctico para el aprendizaje del francés como lengua extranjera y de la interpretación.', 'Dans ce Groupe d’Innovation Éducative (GIE) dont il assure la coordination, sa principale mission est d’élaborer des ressources didactiques pour l’enseignement et l’apprentissage du français langue étrangère et de l’interprétation.', 'Agustín Darias Marrero es Master en Interpretación de Conferencias por la Universidad de La Laguna y Doctor en Traducción e Interpretación por la ULPGC en la que ejerce como profesor de interpretación simultánea y consecutiva en el par de lenguas francés – español. En la actualidad es miembro del grupo de investigación de la ULPGC, Cultura y textos en la traducción oral y escrita, y forma parte del proyecto de investigación del  Ministerio de Ciencia e Innovación, Caracterización objetiva de la dificultad general de los originales. Estos focos de interés han sido objeto de sus publicaciones y comunicaciones en congresos nacionales e internacionales. Su línea de investigación principal se ha enriquecido más recientemente con la perspectiva de la interculturalidad y la incorporación de las TIC aplicadas a los procesos de enseñanza y aprendizaje.', 'Diplômé d’un Master en interprétation de conférences à l’Université de La Laguna et d’un Doctorat en traduction et en interprétation à l’Université de Las Palmas de Gran Canaria, Agustín Darias Marrero est maître de conférences dans cette université où il donne des cours d’interprétation consécutive et simultanée français – espagnol. À l’heure actuelle, il participe au groupe de recherche Culture et textes en traduction orale et écrite, et il est également membre du projet de recherche du Ministère espagnol des Sciences et de l’innovation, Caractérisation objective de la difficulté générale des textes originaux. Dans le cadre de ces travaux il a réalisé plusieurs publications et a participé à des congrès nationaux et internationaux. Il a mené aussi des recherches sur la diversité culturelle et l’utilisation des TICE.', 'teacher0.jpg'),
(2, NULL, 'Ana Ruth Vidal Luengo', 'RESPONSABLE DE ÁRABE', NULL, 'Su función dentro del grupo es la creación de materiales didácticos en lengua árabe y la investigación sobre su aplicación a contextos nómadas, con especial atención a los espacios interculturales y su función en el proceso de aprendizaje.', 'إن وظيفتها في المجموعة هي إنشاء ملفات تدريب باللغة العربية  والبحث العلمي في تطبيق هذه الموارد في سياق التنقل مع إبداء اهتمام خاص للمجالات ما بين الثقافات ووظيفتها في عملية التعلم.', 'Ana Ruth Vidal Luengo es profesora de lengua y literatura árabe de la Universidad de Las Palmas de Gran Canaria. Es Doctora en Filología Semítica por la Universidad de Granada y miembro de los grupos de investigación Paces imperfectas del Instituto de la Paz y los Conflictos de la Universidad de Granada, y Análisis lingüístico y edición de textos (en la línea de investigación La competencia comunicativa, los textos y el proceso de enseñanza/aprendizaje en la era de Internet) de la ULPGC. Ha estudiado árabe clásico en Túnez y Jordania y ha realizado diversas estancias en Egipto, Francia y Marruecos. Su línea de investigación principal sobre las cosmovisiones de paz y la regulación de conflictos en ámbito árabe-islámico le ha llevado a publicar diversos trabajos sobre las mediaciones entre paz y violencia y la interculturalidad, sobre todo en el ámbito literario, y ha derivado en otras líneas de trabajo, como la didáctica de ELE/L2 (Español como Lengua Extranjera o Segunda Lengua) a aprendientes arabófonos y la cultura de paz a través de la enseñanza de lenguas. Ha participado en el proyecto Web@idiomas y en la actualidad desarrolla una investigación en el marco de este Grupo de Innovación Educativa sobre la enseñanza-aprendizaje ubicuo de la lengua árabe a través de las TIC.', 'آنا روت بيدال لوانغوا أستاذة اللغة العربية وأدبها في جامعة لاس بالماس دي كران كناريا (إسبانيا). حصلت على الدكتوراه في اللغات السامية بجامعة غرناطة وهي عضو في مجموعتَي البحث: مجموعة السل غير المكتمل والنزاعات (معهد دراسات السلام والنزاعات لجامعة غرناطة) ومجموعة التحليل اللغوي ونشر النصوص (فرع الكفاء الاتصالي والنصوص وتطور التعليم والتعلم في عهد الأنترنيت لجامعة لاس بالماس دي كران كناريا). درست اللغة العربية في تونس والأردن وأقامت بعض الفترات في مصر وفرنسا والمغرب للبحث العلمي.إن قيامها بالبحث العلمي في ميدان الرؤى على السلام والتفاعل مع النزاعات في النطاق العربي والإسلامي أدى بها إلى نشر بعض الأعمال عن دور الوساطة بين العنف والسلم وحول تعدد الثقافات خصوصا في المجال الأدبي. بدأت في السنوات الماضية البحث في ميادين نشر ثقافة السلام عبر تعليم اللغات وتعليم اللغة الإسبانية لغير الناطقين بها (كـلغة إجنبية أو لغة ثانية) خصوصا للمتعلمين العرب. إنها شاركت في مشروع ويبيديوماس وحاليا تقوم بتطوير أبـحاث في إطار هذه المجموعة عن تعليم واسع الإنتشار(ubiquitous learning)لـللغة العربية عبر خدمات الاتصالات وتكنولوجيا المعلومات.', 'teacher0.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `__migrationhistory`
--

DROP TABLE IF EXISTS `__migrationhistory`;
CREATE TABLE IF NOT EXISTS `__migrationhistory` (
  `MigrationId` varchar(150) CHARACTER SET utf8 NOT NULL,
  `ContextKey` varchar(300) CHARACTER SET utf8 NOT NULL,
  `Model` longblob NOT NULL,
  `ProductVersion` varchar(32) CHARACTER SET utf8 NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `__migrationhistory`
--

INSERT INTO `__migrationhistory` (`MigrationId`, `ContextKey`, `Model`, `ProductVersion`) VALUES
('201904181740349_InitialCreate', 'Ubilingua.Models.Model1', 0x1f8b0800000000000400dd5cc972dc3610bda72affc0e2591e6a49ca8e6a64973cb252aa58964a23eb8e213123da2030214059fab61cf249f985803b48801bb829295d242caf1b8dee46138dd63f7ffdbdfcf0ec21e309fad425f8cc3c5a1c9a06c436715cbc3b3303b67df3cefcf0fee79f969f1cefd97848c79d84e3f84c4ccfcc47c6f6a79645ed47e801baf05cdb27946cd9c2269e051c621d1f1efe661d1d599043981ccb3096770166ae07a33ff89f2b826db8670140d7c4818826edbc671da11a5f8007e91ed8f0ccfcba7111672e008b78ac699c2317703ed6106d4d03604c18609ccbd3af14ae994ff06ebde70d00ddbfec211fb70588c284fbd37c78db851c1e870bb1f28929941d5046bc8e8047278964acf2742df99a99e4b8ec3e7119b39770d591fccecc0d22f6772eb032a9d315f2c361b27017f1940323eb38c89480eb4af87360ac02c4021f9e6118301fa003e336d820d7fe03bedc93ef109fe100219131ce1aef2b34f0a65b9feca1cf5eeee03661f76348fbeac234ace264ab3c3b9b5b9e182fea0ab39363d3f8c2d9001b04330d1004b066c487bf430c7dc0a0730b18833edfc02b074632945850110c7f4d4972bde3d2328d6bf0fc19e21d7be4a675f8f6e4ed2f47ef8e4f4ce3d27d864eda9170f315bbdcec72ee2476eb5958079b6fd066cdab16619656ae23b59af38db898c61402caf7bf930e9527cfa34d8280ace6d1dc77f83aaad77a1b9a95ef0bc18dbb9eb259ad75c7ef0650b74e7a12eeb107fc8e8ea630731e0db9839404be0d47561191ccff4847d48407748823f83f19e61ed0a11d793dc16baeef29b10bc215b9bb9c2f5d04b9463c4ec6f305442e0f19a19331ce95f2de0da576eb43db4d62c4a19c8a9f184c378792cd7a6dce645a0fd136844969ce1bc5a45c0cacce1db968193fd6835cd1076e08913dc7301f094110606d99842853c9a4bd6dba8e83a0a68516e7ce64a711135a569acd9cda46fbaa66ccf9bc967e1e382e99d7ccaf3cb09bf6e0bc87cf6c3a623ec014858a3629d9734c7f0c1af70de3a8920fd06e1e2a9df4cabe5827fd0c6deb9c12920d5ee5d7c3714c99defaee13e7bbef619bace21650fa83f8ce002be9ef837428b5b60bc63f78f48eefc2cc792c24fc5ad3318f74de7fede01ee1ebb423071710387c9b61af2fbfd10fc6618e0c0681fdd8f5b2339d349341c4d4b56c229f3a955934df4c0d1c7d452b9cd7806e0975e3f4ce44ab5e11cc803d5dfcb7de03ecd2c73b828694723dcd1bc6f775528ac92a570fd3ae71427a51643212b57a171c692c3f63fcf48a34f4ac470a2fccfd47e28829f7d67e004b2e33865b4356ca7fe6c4e3acf122edb0eae7cb593009491ed20253c898280185fe06342192939084be2694f2a58e8c551ed180987f7d495079570346295295804afd4d68d9e12e03655d2a9dcdb4337fa460c5af14d2d70c56c57386e535d8efb91909cf1b9216631dbf6d58bd59774ffb7b3186655345f63fe336a3c48f6c6ed8a5def09870e0a5eb53c6233ab001a1c5ae1c4f1a96d862856c532205732b472db9bcd3e1e1ef4944a07e7f50c6c82577c917e3f168235a17cc18a9221e4d5ddb0001bfeace774550e0e1da17088d3871882121c5cdedb184af7811ab26931d6a5f493265f15b92fc4b816279375bedb5e4f77aed7a135a8bfd6f861852ea555869842b02a9f3c633ef5d7ec4f4deb84aa896bb5633bf4acce2f7b528eaba8cfe509b568722638c6dfe5558f9cd810895b7b6478a13d6224adcd21e21cf578b28796b7b2421112d4209cdafc6c8f2c8a4978155c2b430ae9ab9d3185631c7acc2ebaa8cc57cb10ab1ab4a0d150708e95f114968eebeca3803ac5a65dcf37a94bdf479d04fe5ebc1da287e1342a5e0b3146f41e81529e3365b38902109095c99b3ae4624a4624530a1b983dae7f98c82dae7cd1dceace852b8705e452d1d104a29d00256a9af83bc920c67415849dbab31c1ecb3ba97ed55a1b430baeaa953c43b856ca402adab8d0809c6a23bcf9a3bf396e71815fce59de3dade4cda59bcabe9a5a2b5502df4b4617e5d405dd654753ab20e65d86361b8203f4ff315e3eab4750c273e972aa6b77dfdb4b002a58d02564ead966996aa2b0ab622f9578735ccc76e21b5a6e0a9abfee55932112c6f6d8f94a5bf44a0acb183d316d35a05872d76b4c7135256229ad0dc99b73039a4e02c6ceec85719296bec7818290ea2c92d5fbab72f0fc9a867f7f7a57bfa657267de5c9b285da2c743c2c711e4c975a20bf497f59f6811f62fa25f57c8e50bce475cf33ddb42cae27700e6af8bb7a502c7d7536c6851ea2045ce41ae382ceed6a4c57f6e28dcc6770a3a0fc4639f16534104ef5874aef52ddb8bf81da9684f631b66aa9a6b96820c527c4df2047cfb11f872a1d318856e1a829dadd86c2ed1aa51eb0c28cae80f6f3f3248f9599d2e33622d97334c2d972e2b528996c33d1f9ba0446b5053d0d6efa11dbeaa3a4adbe7ab8a9cb4c154c75ddf4aa50d21689032a596abd2ae36d251b6c1ea7d4655b47e3b2a17f868eb9754a7a38d243d75d7f56de263616d0c65718c2e5ab1e66568ad57dfa44e5f43328ac22bca4654f1455803d1b72644cbad55148434f3d8466f2493d081d52cf5d050a661ca2d5eb1df6c13086a954968455fdd3ddf20d50e3a8a3160d9c128ea51fc80d13f78a402026d0d29d701e8f2547adeaffd1d25bfdad785921ee3f7e4297ff3de8ba3fe308517f1ed40ba3d7497dfe05664308ab76bd5efd9e3eb47ee7e3684f31d3339e65b7715bdb15fc457d11cfcd1bc8ad0a86fea9504c77878af2234d6b37c15ad115eee2bc9f47dd72fe7019696f89f0c971790babb1c22fcbf86980b91bbf91c341d7385b72475307c712247e990f2f51264800712e0dc67ee96fb7cdecde545a3c29c0780023ee493b781ce15be09d83e60e794426f830a65784bab9e7e54bc50e47979b30fffa2432c81b3e986b1d00dfe18b8c8c9f8be54042e1510a1934c2203ced59a8511c2ee254392ff2356155022be0bb887388c2beea1b70fbf08e90d5e8327a8c31b0f333ec31db05fd26c4e3548f34614c5bebc70c1ce071e4d30f2f9fc4faec38ef7fcfe5f947323c2d0530000, '6.2.0-61023');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
