-- In this assignment, you'll be building the domain model, database 
-- structure, and data for "KMDB" (the Kellogg Movie Database).
-- The end product will be a report that prints the movies and the 
-- top-billed cast for each movie in the database.

-- Requirements/assumptions
--
-- - There will only be three movies in the database – the three films
--   that make up Christopher Nolan's Batman trilogy
-- - Movie data includes the movie title, year released, MPAA rating,
--   and director
-- - A movie has a single director
-- - A person can be the director of and/or play a role in a movie
-- - Everything you need to do in this assignment is marked with TODO!

-- Rubric
-- 
-- There are three deliverables for this assignment, all delivered via
-- this file and submitted via GitHub and Canvas:
-- - A domain model, implemented via CREATE TABLE statements for each
--   model/table. Also, include DROP TABLE IF EXISTS statements for each
--   table, so that each run of this script starts with a blank database.
--   (10 points)
-- - Insertion of "Batman" sample data into tables (5 points)
-- - Selection of data, so that something similar to the following sample
--   "report" can be achieved (5 points)

-- Submission
-- 
-- - "Use this template" to create a brand-new "hw1" repository in your
--   personal GitHub account, e.g. https://github.com/<USERNAME>/hw1
-- - Do the assignment, committing and syncing often
-- - When done, commit and sync a final time, before submitting the GitHub
--   URL for the finished "hw1" repository as the "Website URL" for the 
--   Homework 1 assignment in Canvas

-- Successful sample output is as shown:

-- Movies
-- ======

-- Batman Begins          2005           PG-13  Christopher Nolan
-- The Dark Knight        2008           PG-13  Christopher Nolan
-- The Dark Knight Rises  2012           PG-13  Christopher Nolan

-- Top Cast
-- ========

-- Batman Begins          Christian Bale        Bruce Wayne
-- Batman Begins          Michael Caine         Alfred
-- Batman Begins          Liam Neeson           Ra's Al Ghul
-- Batman Begins          Katie Holmes          Rachel Dawes
-- Batman Begins          Gary Oldman           Commissioner Gordon
-- The Dark Knight        Christian Bale        Bruce Wayne
-- The Dark Knight        Heath Ledger          Joker
-- The Dark Knight        Aaron Eckhart         Harvey Dent
-- The Dark Knight        Michael Caine         Alfred
-- The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
-- The Dark Knight Rises  Christian Bale        Bruce Wayne
-- The Dark Knight Rises  Gary Oldman           Commissioner Gordon
-- The Dark Knight Rises  Tom Hardy             Bane
-- The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
-- The Dark Knight Rises  Anne Hathaway         Selina Kyle

-- Turns column mode on but headers off
.mode column
.headers off

-- Drop existing tables, so you'll start fresh each time this script is run.
-- TODO!
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS directors;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS castings;

-- Create new tables, according to your domain model
-- TODO!
CREATE TABLE movies (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    year INTEGER,
    rating TEXT,
    director_id INTEGER
);

CREATE TABLE directors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE roles (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT
);

CREATE TABLE castings (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    role_id INTEGER,
    movie_id INTEGER,
    actor TEXT
);

-- Insert data into your database that reflects the sample data shown above
-- Use hard-coded foreign key IDs when necessary
-- TODO!
INSERT INTO movies (title, year, rating, director_id)
VALUES ("Batman Begins", "2005", "PG-13", "1");
INSERT INTO movies (title, year, rating, director_id)
VALUES ("The Dark Knight", "2008", "PG-13", "1");
INSERT INTO movies (title, year, rating, director_id)
VALUES ("The Dark Knight Rises", "2012", "PG-13", "1");

INSERT INTO directors (name)
VALUES ("Christopher Nolan");

INSERT INTO roles (name)
VALUES ("Bruce Wayne");
INSERT INTO roles (name)
VALUES ("Alfred");
INSERT INTO roles (name)
VALUES ("Ra's Al Ghul");
INSERT INTO roles (name)
VALUES ("Rachel Dawes");
INSERT INTO roles (name)
VALUES ("Commissioner Gordon");
INSERT INTO roles (name)
VALUES ("Joker");
INSERT INTO roles (name)
VALUES ("Harvey Dent");
INSERT INTO roles (name)
VALUES ("Bane");
INSERT INTO roles (name)
VALUES ("John Blake");
INSERT INTO roles (name)
VALUES ("Selina Kyle");

INSERT INTO castings (role_id, movie_id, actor)
VALUES ("1", "1", "Christian Bale");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("1", "2", "Christian Bale");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("1", "3", "Christian Bale");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("2", "1", "Michael Caine");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("2", "2", "Michael Caine");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("3", "1", "Liam Neeson");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("4", "1", "Katie Holmes");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("4", "2", "Maggie Gyllenhaal");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("5", "1", "Gary Oldman");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("5", "3", "Gary Oldman");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("6", "2", "Heath Ledger");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("7", "2", "Aaron Eckhart");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("8", "3", "Tom Hardy");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("9", "3", "Joseph Gordon-Levitt");
INSERT INTO castings (role_id, movie_id, actor)
VALUES ("10", "3", "Anne Hathaway");


-- Prints a header for the movies output
.print "Movies"
.print "======"
.print ""

-- The SQL statement for the movies output
-- TODO!
.width 30 5 5 30
SELECT movies.title, movies.year, movies.rating, directors.name
FROM directors INNER JOIN movies ON movies.director_id = directors.id
WHERE directors.name = "Christopher Nolan";

-- Prints a header for the cast output
.print ""
.print "Top Cast"
.print "========"
.print ""


-- The SQL statement for the cast output
-- TODO!
.width 30 30 30
SELECT movies.title, castings.actor, roles.name
FROM ((castings
INNER JOIN movies ON movies.id = castings.movie_id
INNER JOIN roles ON roles.id = castings.role_id))
ORDER BY movies.title;