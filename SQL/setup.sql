/*

Enter custom T-SQL here that would run after SQL Server has started up. 

*/
CREATE DATABASE TestDB;
SELECT Name from sys.databases;
GO

USE TestDB;
CREATE TABLE Inventory (viewcount INT);
INSERT INTO Inventory VALUES (1);
GO

