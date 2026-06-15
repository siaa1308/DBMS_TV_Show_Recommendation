use MovieTVAnalytics;
-- GENRES
INSERT INTO GENRE (Genre_Name)
VALUES ('Action'), ('Comedy'), ('Drama'), ('Sci-Fi'), ('Thriller');

-- USERS
INSERT INTO USER (Name, Email, Age, Country)
VALUES
('Savita Damodaran', 'sav@gmail.com', 20, 'India'),
('Aarav Mehta', 'aarav@gmail.com', 24, 'India'),
('Maya Sharma', 'maya@yahoo.com', 22, 'USA');

-- MOVIES
INSERT INTO MOVIE (Title, Release_Year, Duration, Language, Genre_ID)
VALUES
('Inception', 2010, 148, 'English', 4),
('3 Idiots', 2009, 170, 'Hindi', 2),
('Interstellar', 2014, 169, 'English', 4);

-- TV SHOWS
INSERT INTO TV_SHOW (Title, Seasons, Episodes, Release_Year, Genre_ID)
VALUES
('Breaking Bad', 5, 62, 2008, 3),
('Stranger Things', 4, 34, 2016, 4),
('Friends', 10, 236, 1994, 2);

-- ACTORS
INSERT INTO ACTOR (Name, Age)
VALUES ('Bryan Cranston', 67), ('Millie Bobby Brown', 20), ('Aamir Khan', 59);

-- WATCH HISTORY
INSERT INTO WATCH_HISTORY (User_ID, Content_ID, Watch_Date, Watch_Duration)
VALUES
(1, 1, '2025-10-10', 120),
(2, 3, '2025-10-09', 90),
(3, 2, '2025-10-11', 150);

-- RATINGS
INSERT INTO RATING (User_ID, Content_ID, Rating_Value, Review)
VALUES
(1, 1, 4.8, 'Mind-bending movie!'),
(2, 2, 4.5, 'Very funny and emotional.'),
(3, 3, 5.0, 'Amazing visuals and story.');

-- RECOMMENDATIONS
INSERT INTO RECOMMENDATION (User_ID, Content_ID, Reason)
VALUES
(1, 3, 'Based on your interest in Sci-Fi'),
(2, 1, 'Top-rated movie in Action category'),
(3, 2, 'Trending in your region');
