CREATE TABLE ACTION_LOG (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    User_ID INT,
    Action VARCHAR(255),
    Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
DELIMITER $$

CREATE PROCEDURE AddNewRating(
    IN userId INT,
    IN contentId INT,
    IN ratingVal DECIMAL(2,1),
    IN reviewTxt TEXT
)
BEGIN
    INSERT INTO RATING(User_ID, Content_ID, Rating_Value, Review)
    VALUES (userId, contentId, ratingVal, reviewTxt);
    
    INSERT INTO ACTION_LOG(User_ID, Action)
    VALUES (userId, CONCAT('Rated content ID ', contentId, ' with ', ratingVal));
END$$

DELIMITER $$

CREATE PROCEDURE UpdateSubscription(
    IN userId INT,
    IN newPlan VARCHAR(50)
)
BEGIN
    UPDATE USER
    SET Subscription_Type = newPlan
    WHERE User_ID = userId;
    
    INSERT INTO ACTION_LOG(User_ID, Action)
    VALUES (userId, CONCAT('Changed subscription to ', newPlan));
END$$

DELIMITER ;
CALL UpdateSubscription(2, 'Premium');


DELIMITER ;

CALL AddNewRating(1, 5, 4.5, 'Loved it!');

DELIMITER $$

CREATE PROCEDURE GenerateRecommendations(IN userId INT)
BEGIN
    DECLARE favGenreId INT;
    
    -- Find favorite genre
    SELECT m.Genre_ID INTO favGenreId
    FROM WATCH_HISTORY w
    JOIN MOVIE m ON w.Content_ID = m.Movie_ID
    WHERE w.User_ID = userId
    GROUP BY m.Genre_ID
    ORDER BY COUNT(*) DESC
    LIMIT 1;

    -- Insert a new recommendation
    INSERT INTO RECOMMENDATION(User_ID, Content_ID, Reason)
    SELECT userId, m.Movie_ID, CONCAT('Based on your interest in ', g.Genre_Name)
    FROM MOVIE m
    JOIN GENRE g ON m.Genre_ID = g.Genre_ID
    WHERE m.Genre_ID = favGenreId
      AND m.Movie_ID NOT IN (SELECT Content_ID FROM WATCH_HISTORY WHERE User_ID = userId)
    LIMIT 1;
END$$

DELIMITER ;
CALL GenerateRecommendations(1);
