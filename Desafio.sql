-----crear base de datos----    
CREATE DATABASE MatiasGonzalez056;

----primera tabla----
CREATE TABLE films(
id SERIAL PRIMARY KEY,
name VARCHAR (255),
year INT); 

----segunda tabla----
CREATE TABLE tags(
id SERIAL PRIMARY KEY,
tag VARCHAR (32));
 
----tabla intermedia por relacion muchos a muchos---
CREATE TABLE films_tag(
id SERIAL PRIMARY KEY,
films_id INT,
tag_id INT,
FOREIGN KEY ("films_id")
REFERENCES films(id),
FOREIGN KEY ("tag_id")
REFERENCES tags(id));

-----5 peliculas-----
INSERT INTO films(name, year)
VALUES('el cadaver de la novia', 2005), ('el extraño mundo de jack', 1993), 
('hancock', 2008), ('sueños de fuga', 2015), ('titanic', 1997);

----5 tags-----
INSERT INTO tags(tag)
VALUES('animada'),('familiar'), ('acción'), ('terror'), ('romance');

-----tags asociados a las peliculas-----
INSERT INTO films_tag(films_id, tag_id)
VALUES(1,1), (1,2),(1,5),(2,1), (2,2);

 SELECT films.name, COUNT(films_tag.tag_id)AS tags_films FROM films LEFT JOIN films_tag ON films.id = films_tag.films_id
 GROUP BY films.name;

----primera tabla-----
CREATE TABLE questions(
    id SERIAL PRIMARY KEY,
    question VARCHAR (255),
    correct_answer VARCHAR);

----segunda tabla-----
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    age INT CHECK (age >= 18));

-----tabla intermedia----
CREATE TABLE answers(
    id SERIAL PRIMARY KEY,
    answer VARCHAR (255),
    user_id INT,
    question_id INT,
    FOREIGN KEY ("user_id") REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY ("question_id") REFERENCES questions(id)
    );

---insertar 5 usuarios-----
  INSERT INTO users(name, age)
    VALUES('mery', 19),
    ('matias', 19),
    ('martin', 18),
    ('benjamin', 18),
    ('jeremias', 22);

----insertar 5 preguntas----
INSERT INTO questions(question, correct_answer)
    VALUES('¿cuántos minutos tiene una hora?', '60'),
    ('¿cuántas patas tiene un gato?' , '4'),
    ('¿cuantos centimetros hay en un metro?','100'),
    ('¿quién pintó la noche estrellada?', 'Vincent van Gogh'),
    ('¿cuál es el estado del agua?', 'liquido');

----insertar respuestas-----
INSERT INTO answers(answer, user_id, question_id)
VALUES('60',1,1),
('60',2,1),
('100', 4,3),
('juan carlos bodoque', 5,4),
('solido', 3,5);

SELECT users.name, COUNT(answers.answer) as correct_answer FROM questions 
INNER JOIN answers ON questions.id = answers.question_id 
INNER JOIN users ON answers.user_id = users.id WHERE questions.correct_answer = answers.answer
 GROUP BY  users.name;

SELECT questions.question, COUNT (users.id) AS users FROM users 
INNER JOIN answers ON users.id = answers.user_id INNER JOIN questions ON answers.question_id = questions.id 
WHERE questions.correct_answer = answers.answer GROUP BY questions.question;

-----borrar el primer usuario----
   DELETE FROM users WHERE id= 1;    

----restricción----
     ALTER TABLE users ADD CHECK (age >= 18);

---agregar campo email---
ALTER TABLE users ADD COLUMN email VARCHAR(30) UNIQUE;