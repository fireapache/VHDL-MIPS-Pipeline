-- MySQL dump 10.13  Distrib 5.5.54, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: tutorial
-- ------------------------------------------------------
-- Server version	5.5.54-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tutorialmodelsim`
--

DROP TABLE IF EXISTS `tutorialmodelsim`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorialmodelsim` (
  `passo` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` text,
  PRIMARY KEY (`passo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutorialmodelsim`
--

LOCK TABLES `tutorialmodelsim` WRITE;
/*!40000 ALTER TABLE `tutorialmodelsim` DISABLE KEYS */;
INSERT INTO `tutorialmodelsim` VALUES (1,'configuracoes no view , para que possa ser utilizado com eficiencia o modelsim são necessárias as janelas:Transcript,Project,Library,Objects'),(2,'Crie dentro da pasta simulation um arquivo chamada nomedoarquivo.do'),(3,'Cole todos os arquivos .vhd,vht e tambem o cabeçalho , exemplo: \n		transcript on\nif {[file exists rtl_work]} {\n	vdel -lib rtl_work -all\n}\nvlib rtl_work\nvmap work rtl_work \n\n\nvcom -93 -work work {../../dec5p1.vhd}\nvcom -93 -work work {../../array32.vhd}\nvcom -93 -work work {../../reg.vhd}\nvcom -93 -work work {../../addSub.vhd}\nvcom -93 -work work {../../mux2to1.vhd}\nvcom -93 -work work {../../PC.vhd}\nvcom -93 -work work {../../signalExtensor.vhd}\nvcom -93 -work work {../../controller.vhd}\nvcom -93 -work work {../../flipflop.vhd}\nvcom -93 -work work {../../ULA.vhd}\nvcom -93 -work work {../../opULA.vhd}\nvcom -93 -work work {../../MIPS.vhd}\nvcom -93 -work work {../../memInst2.vhd}\nvcom -93 -work work {../../memData.vhd}\nvcom -93 -work work {../../mux32to1.vhd}\nvcom -93 -work work {../../regBank.vhd}\nvcom -93 -work work {../../mux4to1.vhd}\nvcom -93 -work work {../../comparador.vhd}\nvcom -93 -work work {../../geradordesinais.vhd}\n\nvcom -93 -work work {MIPS.vht}\n'),(4,'ir no transcript e digitar \'do nomedoarquivo.do\' '),(5,'logo apos no menu acima digite simulation->start simulation , selecione a entidade .vht que está dentro da pasta work'),(6,'no menu objects , selecione todos os sinais e aperte com o botão direito do mouse , logo apos add to -> wave ->Signals in design, salvar essa onda , com um nome qualquer e não esquecendo de anotar o nome'),(7,'logo apos ir no nomedoarquivo.do e colar : vsim -do MIPS_run_msim_rtl_vhdl.do -i -l msim_transcript work.mips_vhd_tst \n\n--mem load -format hex -infile memInst.hex /mips_vhd_tst/i1/memI/memory\n\ndo ondacriada.do\n\nrun 500ns\n'),(8,'ir no transcript e digitar do nomedoarquivo.do'),(9,'coletar resultados');
/*!40000 ALTER TABLE `tutorialmodelsim` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-01-19 17:41:04
