DELIMITER $$

CREATE FUNCTION GetAverageRating(contentId INT)
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE avgRating DECIMAL(3,2);
    
    SELECT AVG(Rating_Value)
    INTO avgRating
    FROM RATING
    WHERE Content_ID = contentId;
    
    RETURN IFNULL(avgRating, 0);
END$$

DELIMITER ;

SELECT Title, GetAverageRating(Movie_ID) AS Avg_Rating FROM MOVIE;

DELIMITER $$

CREATE FUNCTION GetUserWatchCount(userId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalWatched INT;
    
    SELECT COUNT(*) INTO totalWatched
    FROM WATCH_HISTORY
    WHERE User_ID = userId;
    
    RETURN totalWatched;
END$$

DELIMITER ;
SELECT Name, GetUserWatchCount(User_ID) AS Total_Watched FROM USER;

DELIMITER $$

CREATE FUNCTION GetFavoriteGenre(userId INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE favGenre VARCHAR(100);
    
    SELECT g.Genre_Name INTO favGenre
    FROM WATCH_HISTORY w
    JOIN MOVIE m ON w.Content_ID = m.Movie_ID
    JOIN GENRE g ON m.Genre_ID = g.Genre_ID
    WHERE w.User_ID = userId
    GROUP BY g.Genre_Name
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    
    RETURN IFNULL(favGenre, 'No data');
END$$

DELIMITER ;
SELECT Name, GetFavoriteGenre(User_ID) AS Favorite_Genre FROM USER;
