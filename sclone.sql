PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;

CREATE TABLE meta(
	id			INTEGER PRIMARY KEY	AUTOINCREMENT	NOT NULL,
	pathname	TEXT				NOT NULL,
	date		TEXT 				NOT NULL, 
	checksum	INTEGER				NOT NULL,
	bytecount	INTEGER				NOT NULL,
	tarball		TEXT				NOT NULL,
	deleted		TEXT				DEFAULT NULL
);
-- deleted=NULL : not yet deleted

/*
CREATE INDEX index_pathname_date 
on meta (pathname, date);
*/

COMMIT;
