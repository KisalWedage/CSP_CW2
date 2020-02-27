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
    cTitle VARCHAR(255),
    cPrice DOUBLE,
    cGenre VARCHAR(255),
    cNumberOfTracks INT,
    
    CONSTRAINT pk_cd_cID PRIMARY KEY (cID)
    
);

DESCRIBE CD;
SHOW TABLES;

ALTER TABLE CD ADD COLUMN artID INT NOT NULL;
ALTER TABLE CD ADD CONSTRAINT fk_Art_CD_artID FOREIGN KEY (artID) REFERENCES Artist (artID);

CREATE TABLE Track(
	trID INT,
    trTitle VARCHAR(255) NOT NULL,
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
SHOW tables;

/*
tute 6
*/

DROP TABLE IF EXISTS cd_track;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS CD;
DROP TABLE IF EXISTS Artist;



SELECT * FROM Artist;
SELECT * FROM cd;

SELECT cTitle AS Title, cGenre AS Genre FROM CD;

SELECT artName FROM Artist;
SELECT cGenre AS genre FROM CD;
SELECT cTitle AS Title , cPrice AS Price FROM CD;

/*DISTINT TO AVOID DUPLICATION*/
SELECT DISTINCT cGenre AS genre FROM CD;
SELECT DISTINCT ArtID,cGenre FROM CD;

SELECT * FROM CD WHERE cPrice > 10.00;
SELECT * FROM CD WHERE cGenre = 'Rock';
SELECT * FROM CD WHERE cGenre <> 'Rock';

SELECT * FROM CD WHERE cGenre='Electronica';
SELECT * FROM CD WHERE cPrice < 10.00;
SELECT * FROM CD WHERE (cPrice < 10.00) AND NOT (cGenre = 'Rock');

SELECT * FROM CD WHERE (cGenre='pop') OR (cPrice>10.00);
SELECT cTitle FROM CD WHERE ((cGenre='Rock') AND ((cPrice>=10.00) AND (cPrice<=12.00)));


/*JOINTSSSSSS*/



SELECT * FROM Artist INNER JOIN CD USING (artID) ;
SELECT cTitle FROM CD NATURAL JOIN Artist WHERE artName='Muse';
 
 /*TUTORIAL 7*/
 
SELECT cTitle,cPrice -- OUTPUT1 
FROM CD
WHERE cTitle LIKE '% %';

											
SELECT cTitle, artName -- OUTPUT2 
FROM Artist, CD
WHERE cTitle LIKE '%The%' OR  cTitle LIKE '%the%'; 

SELECT * -- OUTPUT3
FROM CD
WHERE cGenre LIKE '%Ro__';

DESCRIBE CD;
SELECT * FROM CD;
SELECT * FROM Artist;

SELECT * -- OUTPUT4
FROM CD
WHERE cGenre = (SELECT cGenre
		FROM CD
		WHERE cTitle ="The Resistance") AND cTitle <> 'The Resistance';
					FROM Artist
 WHERE  )


SELECT cTitle  -- OUTPUT5
FROM CD
WHERE cPrice IN (SELECT cPrice
				FROM CD
                WHERE cGenre='Pop' );
                
 SELECT cTitle  -- OUTPUT6 
 FROM CD
 WHERE  cPrice > ANY(
	SELECT cPrice
    FROM CD
 );
 
 SELECT cTitle  -- OUTPUT7
 FROM CD
 WHERE  cPrice >= ALL(
	SELECT cPrice
    FROM CD
 );
 
 SELECT artName  	-- OUTPUT8
 FROM Artist
 WHERE artID IN(
	SELECT artID
    FROM CD 
    WHERE cPrice< 10.00
 );
 
 SELECT cTitle  -- output 9 
 FROM CD
 WHERE artID IN(
	 SELECT artID
	 FROM Artist
	 WHERE artName NOT LIKE '% %');
     
SELECT * -- output 10 1OR
FROM CD
WHERE cPrice< ANY (
		SELECT cPrice
		FROM CD)AND (cGenre ="Rock" OR cGenre="pop");
        
SELECT * -- output 10 2
FROM CD
WHERE (cGenre ="Rock" OR cGenre="pop")
		AND cPrice< ANY
			(SELECT cPrice
			FROM CD) ; 
            
 SELECT artName ,artID-- OUTPUT11
 FROM Artist
 WHERE artID IN (
	SELECT artID
    FROM CD
    WHERE cPrice =12.99
 );
 
 