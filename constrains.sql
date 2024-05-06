--                                    Constraints
/*

1-   Primary Key
| Unique     | Not Null       | single or multiple columns      | One in table
*/

 CREATE TABLE Persons (
   ID int NOT NULL ,
   LastName varchar(255) NOT NULL,
   Age int,
   CONSTRAINT  PK_Person PRIMARY KEY(ID, LastName)

);

ALTER TABLE Persons
ADD primary key(ID)

ALTER TABLE Persons
ADD  CONSTRAINT  PK_Person PRIMARY KEY(ID, LastName)


Alter table persons
Drop CONSTRAINT PK_Person


/*
2-     Foriegn key
|  Primary key in another table
*/
CREATE TABLE Orders (
   OrderID int NOT NULL PRIMARY KEY,
   OrderNumber int NOT NULL,
   PersonID int  REFERENCES Persons(PersonID)
);

ALTER TABLE Orders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(PersonID);


ALTER TABLE Orders
DROP CONSTRAINT FK_PersonOrder;

/*
3- NOT NULL
4- Default
5- check
6- unique
*/

ALTER TABLE Persons
ALTER COLUMN Age int NOT NULL



Alter table twitter
add CONSTRAINT df_frindes
DEFAULT 50 FOR noOfFrindes

Alter table twitter
add CONSTRAINT chk_frindes
CHECK (noOfFrindes >= 30)

alter table twitter 
drop CONSTRAINT df_frindes