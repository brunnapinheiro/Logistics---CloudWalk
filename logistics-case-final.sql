USE CloudWalkDB;	

CREATE TABLE CloudWalkTable (
    id INT NOT NULL,
    CreatedAt varchar(255) NOT NULL,
    In_Transit_To_Local_Distribution_At varchar(255) NOT NULL,
    Local_Distribution_At varchar(255) NOT NULL,
    In_transit_to_deliver_At varchar(255) NOT NULL,
    Delivered_At varchar(255) NOT NULL,
    Delivery_Estimate_Date varchar(255) NOT NULL,
    City VARCHAR (255) NOT NULL,
    State VARCHAR (255) NOT NULL
);

LOAD DATA INFILE "logistics-case-v3.csv" 
INTO TABLE CloudWalkTable
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

UPDATE CloudWalkTable SET CreatedAt=STR_TO_DATE(CreatedAt,"%Y-%c-%dT%H:%i:%s.%f");
UPDATE CloudWalkTable SET CreatedAt=CONVERT(CreatedAt,datetime);

UPDATE CloudWalkTable SET In_Transit_To_Local_Distribution_At=STR_TO_DATE(In_Transit_To_Local_Distribution_At,"%Y-%c-%dT%H:%i:%s");

UPDATE CloudWalkTable SET Local_Distribution_At=STR_TO_DATE(Local_Distribution_At,"%Y-%c-%dT%H:%i:%s") 
	WHERE STR_TO_DATE(Local_Distribution_At,"%Y-%c-%dT%H:%i:%s") <> "0000-00-00 00:00:00";
    
UPDATE CloudWalkTable SET In_transit_to_deliver_At=STR_TO_DATE(In_transit_to_deliver_At,"%Y-%c-%dT%H:%i:%s") 
	WHERE STR_TO_DATE(In_transit_to_deliver_At,"%Y-%c-%dT%H:%i:%s") <> "0000-00-00 00:00:00";

UPDATE CloudWalkTable SET Delivered_At=STR_TO_DATE(Delivered_At,"%Y-%c-%dT%H:%i:%s.%f");
UPDATE CloudWalkTable SET Delivered_At=CONVERT(Delivered_At,datetime);

SELECT * FROM CloudWalkDB.CloudWalkTable;