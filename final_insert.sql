INSERT INTO USER (User_ID, Name, Email, Subscription_Type)
VALUES (10, 'Sarayu', 'sarayu@example.com', 'Basic');

SELECT * FROM ACTION_LOG WHERE User_ID = 10;
INSERT INTO WATCH_HISTORY (User_ID, Content_ID, Watch_Date, Watch_Duration)
VALUES (10, 2, NOW(), 120);

SELECT * FROM ACTION_LOG WHERE User_ID = 10;
INSERT INTO RATING (User_ID, Content_ID, Rating_Value, Review)
VALUES (10, 2, 4.5, 'Great watch!');

SELECT * FROM RECOMMENDATION WHERE User_ID = 10;
