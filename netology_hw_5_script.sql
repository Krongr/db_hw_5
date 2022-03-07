SELECT genre_name, COUNT(genre_id)
FROM singer_genre_pair sgp 
JOIN genre_list gl ON sgp.genre_id = gl.id
	GROUP BY genre_name;

SELECT COUNT(tl.id)
FROM track_list tl
JOIN record_album_list ral ON tl.album_id = ral.id
	WHERE ral.release_year BETWEEN 2019 AND 2020;

SELECT ral.album_name, ROUND(AVG(tl.track_length), 2)
FROM track_list tl
JOIN record_album_list ral ON tl.album_id = ral.id
	GROUP BY ral.album_name;

SELECT singer_name
FROM singer_list
	WHERE id NOT IN (
		SELECT singer_id
		FROM singer_album_pair sap
		JOIN record_album_list ral ON sap.album_id = ral.id
 			WHERE ral.release_year = 2018
 	);
 
SELECT mcl.collection_name 
FROM music_collection_list mcl 
JOIN track_collection_pair tcp ON mcl.id = tcp.collection_id
JOIN track_list tl ON tcp.track_id = tl.id
JOIN record_album_list ral ON tl.album_id = ral.id
JOIN singer_album_pair sap ON ral.id = sap.album_id
JOIN singer_list sl ON sap.singer_id = sl.id
	WHERE sl.singer_name = 'amazarashi'
	GROUP BY mcl.collection_name;

SELECT ral.album_name
FROM record_album_list ral
JOIN singer_album_pair sap ON ral.id =sap.album_id
JOIN singer_list sl ON sap.singer_id = sl.id
	WHERE sl.id IN (
		SELECT singer_id 
		FROM singer_genre_pair
			GROUP BY singer_id
			HAVING COUNT(genre_id) != 1
	);

SELECT track_name
FROM track_list
	WHERE id NOT IN (
		SELECT track_id
		FROM track_collection_pair
	);

SELECT sl.singer_name
FROM singer_list sl 
JOIN singer_album_pair sap ON sl.id = sap.singer_id
	WHERE sap.album_id IN (
		SELECT album_id 
		FROM track_list
			WHERE track_length = (
				SELECT MIN(track_length)
				FROM track_list
			)
	);

SELECT album_name 
FROM record_album_list
	WHERE id IN (
		SELECT album_id
		FROM track_list
			GROUP BY album_id
			HAVING COUNT(album_id) = (
				SELECT MIN(count)
				FROM (
					SELECT COUNT(album_id)
					FROM track_list
						GROUP BY album_id
				) AS track_count
			)
	);