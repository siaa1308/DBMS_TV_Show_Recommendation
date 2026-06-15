DELIMITER $$

CREATE TRIGGER after_rating_insert
AFTER INSERT ON RATING
FOR EACH ROW
BEGIN
    DECLARE genreId INT;
    
    SELECT Genre_ID INTO genreId
    FROM MOVIE
    WHERE Movie_ID = NEW.Content_ID;
    
    IF NEW.Rating_Value >= 4 THEN
        INSERT INTO RECOMMENDATION(User_ID, Content_ID, Reason)
        SELECT NEW.User_ID, m.Movie_ID, CONCAT('You might like this ', g.Genre_Name, ' movie too!')
        FROM MOVIE m
        JOIN GENRE g ON m.Genre_ID = g.Genre_ID
        WHERE m.Genre_ID = genreId
          AND m.Movie_ID <> NEW.Content_ID
          AND m.Movie_ID NOT IN (
              SELECT Content_ID FROM WATCH_HISTORY WHERE User_ID = NEW.User_ID
          )
        LIMIT 1;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER after_watch_insert
AFTER INSERT ON WATCH_HISTORY
FOR EACH ROW
BEGIN
    INSERT INTO ACTION_LOG(User_ID, Action)
    VALUES (NEW.User_ID, CONCAT('Watched content ID ', NEW.Content_ID));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_user_insert
AFTER INSERT ON USER
FOR EACH ROW
BEGIN
    INSERT INTO ACTION_LOG(User_ID, Action)
    VALUES (NEW.User_ID, 'Welcome! Your account has been created.');
END$$

DELIMITER ;
