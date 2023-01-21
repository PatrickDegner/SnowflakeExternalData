USE ROLE SYSADMIN;

CREATE DATABASE IF NOT EXISTS PATRICKDB;

CREATE SCHEMA IF NOT EXISTS PATRICKDB.ASSASSINS;

CREATE STAGE PATRICKDB.ASSASSINS.AZUREBLOBSTORAGE
URL = 'azure://patricksdata.blob.core.windows.net/assassins/';
 
SHOW STAGES;
 
LIST @AZUREBLOBSTORAGE;

SELECT $1
FROM @AZUREBLOBSTORAGE/Assassins.csv;

CREATE OR REPLACE FILE FORMAT ASSASSIN_CSV
TYPE = 'CSV'
SKIP_HEADER = 1
FIELD_DELIMITER = ';'
TRIM_SPACE = TRUE;

SELECT $1 AS TITLE, $2 AS RELEASE_YEAR, $3 AS PROTAGONIST
FROM @AZUREBLOBSTORAGE/Assassins.csv
(FILE_FORMAT => ASSASSIN_CSV);

CREATE OR REPLACE VIEW V_GAME_LIST AS
SELECT 
$1 AS TITLE, 
$2 AS RELEASE_YEAR,
$3 AS PROTAGONIST
FROM @AZUREBLOBSTORAGE/Assassins.csv
(FILE_FORMAT => ASSASSIN_CSV);

SELECT * FROM V_GAME_LIST;