--Название и продолжительность самого длительного трека
SELECT track_name, track_duration AS max_duration  
  FROM track
 WHERE track_duration IN 
      (SELECT MAX(track_duration) 
          FROM track);

SELECT track_name, track_duration AS max_duraction  
  FROM track
 ORDER BY track_duration DESC
 LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут
SELECT track_name, track_duration 
  FROM track
 WHERE track_duration > '00:03:29'
 ORDER BY track_duration;

--Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT collection_name 
  FROM collection
 WHERE collection_year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова
SELECT artist_name 
  FROM artist
 WHERE artist_name NOT LIKE '% %'; 

--Название треков, которые содержат слово «my»
SELECT track_name 
  FROM track
 WHERE track_name LIKE '_% my _%'
    OR track_name LIKE 'my _%'
	OR track_name LIKE '_% my'
	OR track_name LIKE 'my'
	OR track_name LIKE '_% My _%'
    OR track_name LIKE 'My _%'
	OR track_name LIKE '_% My'
	OR track_name LIKE 'My';
	
--второй вариан
SELECT track_name 
  FROM track
 WHERE track_name ~* 'my';

--третий вариан
SELECT track_name 
  FROM track
 WHERE string_to_array(lower(track_name), ' ') && ARRAY ['my'];

--Количество исполнителей в каждом жанре
SELECT genre_name, COUNT (artist_name) AS count_artists
  FROM genre AS g 
  LEFT JOIN genre_artist AS ga 
    ON g.genre_id = ga.genre_id
  LEFT JOIN artist AS a  
    ON a.artist_id = ga.artist_id
 GROUP BY genre_name
 ORDER BY count_artists DESC;

--Количество треков, вошедших в альбомы 1990–1993 годов
SELECT COUNT (track_name) AS count_track
  FROM album AS a
  JOIN track AS t
    ON a.album_id = t.album_id
 WHERE release_year BETWEEN 1990 AND 1993;

--Средняя продолжительность треков по каждому альбому
SELECT album_name, AVG (track_duration) AS average_duration_of_song
  FROM album AS a
  JOIN track AS t
    ON a.album_id = t.album_id	
 GROUP BY album_name
 ORDER BY average_duration_of_song;

--Все исполнители, которые не выпустили альбомы в 2020 году
SELECT artist_name
  FROM artist
 WHERE artist_name NOT IN (
     SELECT artist_name
	   FROM artist AS a1
	   JOIN artist_album AS aa
         ON a1.artist_id = aa.artist_id
       JOIN album AS a2
         ON a2.album_id = aa.album_id
      WHERE release_year = 2020
); 

--Названия сборников, в которых присутствует конкретный исполнитель (Bob Marley)
SELECT collection_name, artist_name
  FROM collection 
  JOIN track_collection USING (collection_id)
  JOIN track USING (track_id)
  JOIN album USING (album_id)
  JOIN artist_album USING (album_id)
  JOIN artist USING (artist_id)
 WHERE artist_name = 'Bob Marley'
 GROUP BY collection_name, artist_name;
 
