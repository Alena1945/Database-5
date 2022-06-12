SELECT g.genres_name, count(ag.artist_id) FROM genres g 
   JOIN artists_genre ag ON ag.id = ag.genre_id
   GROUP BY g.genres_name;
   
SELECT a.albums_name, a.creation, count(t.id) FROM albums a2 
   JOIN tracks t2  ON t.id = t.album_id
   WHERE t.creation BETWEEN 2019 and 2020
   GROUP BY a.albums_name, t.creation;
  
SELECT a.albums_name, AVG(t.length_track) FROM albums a2  
	JOIN tracks ON a.id = t.album_id
	GROUP BY a.albums_name;

SELECT a.artist_name FROM artists a2 
   JOIN artists_album aa ON a.id = aa.artist_id
   JOIN albums a3 ON a.id = aa.album_id
   WHERE a.creation < 2020; 
  
SELECT c.collections_name FROM collections c  
   JOIN collection_track_album cta ON c.id = cta.collection_id
   JOIN tracks t2 ON t.id = cta.track_id
   JOIN albums a2 ON a.id = t.album_id
   JOIN artists_album aa ON a.id = aa.album_id
   JOIN artists a ON a.id = aa.artist_id 
   WHERE a.artists_name LIKE '%%Eminem%%';
  
SELECT a.album_name FROM album a
	JOIN artists_album aa ON a.id = aa.album_id
	JOIN artists a2 ON a.id = aa.artist_id
	JOIN artists_genre ag ON ag.artist_id = a.id
	JOIN genres g ON g.id = ag.genre_id
	GROUP BY a.artists_name, a.albums_name
    HAVING count(ag.genre_id) > 1;
   
SELECT t.tracks_name FROM tracks t 
	LEFT JOIN collection_track_album cta ON t.id = cta.track_id
	WHERE cta.track_id IS null;
	
SELECT a.artists_name FROM artists a2 
	JOIN artists_album aa ON a.id = aa.artist_id
	JOIN albums a3 ON a.id = aa.album_id
	JOIN tracks t ON t.album_id = a.id
	WHERE length_track = (SELECT MIN(length_track) FROM track);

SELECT a.albums_name , count(t.id) FROM albums a3
    JOIN tracks t ON a.id = t.album_id
    GROUP BY a.albums_name 
    HAVING count(t.id) in (
    	SELECT count(t.id) FROM albums a3
    	JOIN tracks t ON a.id = t.album_id
        GROUP BY a.albums_name
        ORDER BY count(t.id)
        LIMIT 1);