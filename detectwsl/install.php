<?php
/**
 * The following functions are used by the extension engine to generate a new table
 * for the plugin / destroy it on removal.
 */


/**
 * This function is called on installation and is used to 
 * create database schema for the plugin
 */
function extension_install_detectwsl()
{
    $commonObject = new ExtensionCommon;
	$commonObject -> sqlQuery("DROP TABLE IF EXISTS `detectwsl`;");
    $commonObject -> sqlQuery(
        "CREATE TABLE `detectwsl` (
        `ID` INTEGER NOT NULL AUTO_INCREMENT, 
        `HARDWARE_ID` INTEGER NOT NULL,
        `DATE` VARCHAR(255) DEFAULT NULL,
        `USER` VARCHAR(255) DEFAULT NULL,
        `DISTRIB` VARCHAR(255) DEFAULT NULL,
        PRIMARY KEY (`ID`, `HARDWARE_ID`)
        ) ENGINE=INNODB;"
    );
}

/**
 * This function is called on removal and is used to 
 * destroy database schema for the plugin
 */
function extension_delete_detectwsl()
{
    $commonObject = new ExtensionCommon;
    $commonObject -> sqlQuery("DROP TABLE IF EXISTS `detectwsl`");
}

/**
 * This function is called on plugin upgrade
 */
function extension_upgrade_detectwsl()
{

}

?>