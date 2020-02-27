CREATE DATABASE CSP_TUTORIALS_2018368;
USE CSP_TUTORIALS_2018368;
CREATE TABLE Artist(
	artID INT,
    artName VARCHAR(255) NOT NULL,
    
    CONSTRAINT pk_Art_artID PRIMARY KEY (artID),
    CONSTRAINT chk_Art_artName UNIQUE (artName)
);
DESCRIBE Artist;

CREATE TABLE CD(
	cID INT NULL NULL,
    cTitle VARCHAR(20),
    cPrice DOUBLE,
    cGenre VARCHAR(20),
    cNumberOfTracks INT,
    
    CONSTRAINT pk_cd_cID PRIMARY KEY (cID)
    
);

DESCRIBE CD;
SHOW TABLES;

ALTER TABLE CD ADD COLUMN artID INT NOT NULL;
ALTER TABLE CD ADD CONSTRAINT fk_Art_CD_artID FOREIGN KEY (artID) REFERENCES Artist (artID);

CREATE TABLE Track(
	trID INT,
    trTitle VARCHAR(20) NOT NULL,
    trTime TIME,
    
    CONSTRAINT tr_tID_pk PRIMARY KEY(trID)
);

DESCRIBE Track;

CREATE TABLE CD_Track(
	cID INT,
    trID INT,
    
    CONSTRAINT fk_CD_Track_cdID  FOREIGN KEY (cID) REFERENCES CD (cID),
    CONSTRAINT fk_CD_Track_trID  FOREIGN KEY (trID) REFERENCES Track (trID),
    
	CONSTRAINT pk_cdtrack_cIDtrID PRIMARY KEY(cID,trID)
);

DESCRIBE CD_Track;
SHOW CREATE TABLE CD;

/*tut 5*/


INSERT INTO Artist(artID,artName) VALUES (1,"Muse");
INSERT INTO Artist VALUES (2,"Mr. Scruff"),(4,"Mark Ronson"),(3,"Deadmau5"),(5,"Animal Collective");


DESCRIBE CD;

INSERT INTO CD VALUES (1,"Black Holes Revelations",9.99,"Rock",9,(SELECT artID FROM Artist WHERE artName="Muse") );
INSERT INTO CD VALUES (2,"The Resistance",11.99,"Rock",5,(SELECT artID FROM Artist WHERE artName="Muse") );

INSERT INTO CD VALUES (3,"NinjaTuna",9.99,"Electronica",7,(SELECT artID FROM Artist WHERE artName="Mr. Scruff")),
(4,"ForBetName",9.99,"ElectHouse",5,(SELECT artID FROM Artist WHERE artName="Deadmau5")),
(5,"RecordCollec",11.99,"AlternatRock",5,(SELECT artID FROM Artist WHERE artName="Mark Ronson")),
(6,"Version",12.99,"Pop",5,(SELECT artID FROM Artist WHERE artName="Mark Ronson")),
(7,"MeriweatherPav",12.99,"Electronica",8,(SELECT artID FROM Artist WHERE artName="Animal Collective"));

UPDATE Artist SET artName="Mrs.Scruff" WHERE artName="Mr. Scruff";
UPDATE CD SET cPrice=cPrice+1.00;
UPDATE Artist SET artName="Amuse" WHERE artName="Muse";
UPDATE CD SET cPrice=cPrice-1.00;
UPDATE CD SET cPrice=cPrice-0.05 WHERE cPrice>10.00;

INSERT INTO Artist VALUES (6,"Mark Ronson & The Business Intl") ;

UPDATE CD SET artID =6 WHERE cTitle="RecordCollec";

DELETE FROM Artist WHERE artName = 'Animal Collective';

SELECT *FROM CD;
SELECT cID,cGenre FROM CD;
SELECT *FROM Artist;

SELECT artID 
FROM Artist
WHERE artName="kisal";