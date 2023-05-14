CREATE TABLE IF NOT EXISTS genre (
    PRIMARY KEY (genre_id),
	genre_id   serial   NOT NULL,
	genre_name char(32) NOT NULL
);


CREATE TABLE IF NOT EXISTS artist (
	PRIMARY KEY (artist_id),
	artist_id   serial      NOT NULL ,
	artist_name varchar(32) NOT NULL
);


CREATE TABLE IF NOT EXISTS genre_artist (
	genre_id  int REFERENCES genre(genre_id),
	artist_id int REFERENCES artist(artist_id),
	
	CONSTRAINT genre_artist_pk PRIMARY KEY (genre_id, artist_id) 
);


CREATE TABLE IF NOT EXISTS album (
	PRIMARY KEY (album_id),
	album_id     serial      NOT NULL,
	album_name   varchar(32) NOT NULL,
	release_year int         NOT NULL 
);


CREATE TABLE IF NOT EXISTS artist_album (
	artist_id int REFERENCES artist(artist_id),
	album_id  int REFERENCES album(album_id),
	
	CONSTRAINT artist_album_pk PRIMARY KEY (artist_id, album_id) 
);


CREATE TABLE IF NOT EXISTS track (
	PRIMARY KEY (track_id),
	track_id       serial      NOT NULL,
	track_name     varchar(64) NOT NULL,
	track_duration time        NOT NULL,
	FOREIGN KEY (album_id)     REFERENCES album(album_id)
);


CREATE TABLE IF NOT EXISTS collection (
	PRIMARY KEY (collection_id),
	collection_id   serial      NOT NULL,
	collection_name varchar(32) NOT NULL,
	collection_year int         NOT NULL 
);


CREATE TABLE IF NOT EXISTS track_collection (
	track_id      int REFERENCES track(track_id),
	collection_id int REFERENCES collection(collection_id),
	
	CONSTRAINT track_collection_pk PRIMARY KEY (track_id, collection_id) 
);
