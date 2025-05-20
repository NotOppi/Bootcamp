-- DIFICULTAD: Muy fácil
-- 1- Devuelve todas las películas


-- 2- Devuelve todos los géneros existentes


-- 3- Devuelve la lista de todos los estudios de grabación 
--    que estén activos


-- 4- Devuelve una lista de los 20 últimos miembros 
--    en anotarse a la plataforma


-- DIFICULTAD: Fácil
-- 5- Devuelve las 20 duraciones de películas más frecuentes, 
--    ordenados de mayor a menor


-- 6- Devuelve las películas del año 2000 en adelante 
--    que empiecen por la letra A.


-- 7- Devuelve los actores nacidos un mes de Junio


-- 8- Devuelve los actores nacidos cualquier mes que no sea Junio 
--    y que sigan vivos

SELECT actor_name AS Nombre
FROM public.actors
WHERE month(actor_birth_date) <> 6 AND ACTOR_DEAD_DATE IS NULL;

-- 9- Devuelve el nombre y la edad de todos los directores 
--    menores o iguales de 50 años que estén vivos

SELECT director_name AS Nombre, FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 AS Edad
FROM public.directors
WHERE FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 <= 50 AND DIRECTOR_DEAD_DATE IS NULL
ORDER BY Edad;

-- 10- Devuelve el nombre y la edad de todos los actores 
--     menores de 50 años que hayan fallecido

SELECT director_name AS Nombre, FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 AS Edad
FROM public.directors
WHERE FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 <= 50 AND DIRECTOR_DEAD_DATE IS NOT NULL
ORDER BY Edad;

-- 11- Devuelve el nombre de todos los directores 
--     menores o iguales de 40 años que estén vivos

SELECT director_name AS Nombre, FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 AS Edad
FROM public.directors
WHERE FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365 <= 40 AND DIRECTOR_DEAD_DATE IS NULL
ORDER BY Edad;

-- 12- Indica la edad media de los directores vivos

SELECT AVG(FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365) AS "Edad Media Directores Vivos"
FROM public.directors
WHERE DIRECTOR_DEAD_DATE IS NULL;

-- 13- Indica la edad media de los actores que han fallecido

SELECT AVG(FLOOR(DAYS(CURDATE()) - DAYS(DIRECTOR_BIRTH_DATE)) / 365) AS "Edad Media Directores Vivos"
FROM public.directors
WHERE DIRECTOR_DEAD_DATE IS NOT NULL;

-- DIFICULTAD: Media
-- 14- Devuelve el nombre de todas las películas 
--     y el nombre del estudio que las ha realizado

SELECT m.movie_name, s.studio_name
FROM public.MOVIES m
JOIN PUBLIC.STUDIOS s
ON m.STUDIO_ID = s.STUDIO_ID;

-- 15- Devuelve los miembros que accedieron al menos una película 
--     entre el año 2010 y el 2015

SELECT DISTINCT user_name AS "Miembro"
FROM public.users u
JOIN public.user_movie_access um
ON u.user_id = um.user_id
WHERE um.ACCESS_DATE BETWEEN '2010-01-01' AND '2015-12-31';

-- 16- Devuelve cuantas películas hay de cada país

SELECT  n.nationality_name AS "Pais", COUNT(m.nationality_id)
FROM public.nationalities n
JOIN public.MOVIES m
ON n.NATIONALITY_ID = m.NATIONALITY_ID
GROUP BY n.NATIONALITY_NAME;

-- 17- Devuelve todas las películas que hay de género documental

SELECT m.movie_name
FROM public.movies m
JOIN public.genres g
ON m.genre_id = g.genre_id
WHERE g.genre_name = 'Documentary';

-- 18- Devuelve todas las películas creadas por directores 
--     nacidos a partir de 1980 y que todavía están vivos

SELECT m.movie_name
FROM public.movies m
JOIN public.directors d
ON m.director_id = d.DIRECTOR_ID
WHERE YEAR(d.director_birth_date) >= 1980 AND d.director_dead_date IS NULL;

-- 19- Indica si hay alguna coincidencia de nacimiento de ciudad 
--     (y si las hay, indicarlas) entre los miembros de la plataforma 
--     y los directores

SELECT *
FROM public.users u
JOIN public.directors d
ON u.user_town = d.director_birth_place;

-- 20- Devuelve el nombre y el año de todas las películas 
--     que han sido producidas por un estudio que actualmente 
--     no esté activo

SELECT 
FROM public.movies m
JOIN public.studios s
ON m.studio_id = s.STUDIO_ID
WHERE s.STUDIO_ACTIVE = 

-- 21- Devuelve una lista de las últimas 10 películas 
--     a las que se ha accedido

SELECT m.movie_name, YEAR(m.movie_release_date)
FROM public.movies m
JOIN public.studios s
ON m.studio_id = s.STUDIO_ID
WHERE s.STUDIO_ACTIVE = FALSE;

-- 22- Indica cuántas películas ha realizado cada director 
--     antes de cumplir 41 años

SELECT d.DIRECTOR_NAME, count(*) Num_Peliculas
FROM public.movies m
JOIN public.directors d
ON m.DIRECTOR_ID = d.DIRECTOR_ID
WHERE YEAR(d.DIRECTOR_BIRTH_DATE) + 41 > YEAR(m.MOVIE_RELEASE_DATE)
GROUP BY d.DIRECTOR_NAME
ORDER BY Num_Peliculas DESC;

-- 23- Indica cuál es la media de duración de las películas 
--     de cada director

SELECT d.DIRECTOR_NAME, AVG(m.MOVIE_DURATION) AS Duracion
FROM public.movies m
JOIN public.directors d
ON m.DIRECTOR_ID = d.DIRECTOR_ID
GROUP BY d.DIRECTOR_NAME
ORDER BY Duracion;

-- 24- Indica cuál es el nombre y la duración mínima de las películas 
--     a las que se ha accedido en los últimos 2 años por los miembros 
--     del plataforma (La “fecha de ejecución” de esta consulta 
--     es el 25-01-2019)

SELECT m.MOVIE_NAME, MIN(m.MOVIE_DURATION) AS Duracion
FROM public.movies m
JOIN public.user_movie_access um
ON m.MOVIE_ID = um.MOVIE_ID
WHERE um.ACCESS_DATE BETWEEN '2017-01-25' AND '2019-01-25'
GROUP BY m.MOVIE_NAME
ORDER BY Duracion;

-- 25- Indica el número de películas que hayan hecho los directores 
--     durante las décadas de los 60, 70 y 80 que contengan la palabra 
--     “The” en cualquier parte del título

SELECT d.director_name, COUNT(*) AS cantidad_peliculas
FROM public.movies m
JOIN public.directors d 
 ON m.director_id = d.director_id
WHERE 
  (YEAR(m.movie_release_date) = 1970 OR
   YEAR(m.movie_release_date) = 1980 OR
   YEAR(m.movie_release_date) = 1990) AND
  LOWER(m.movie_name) LIKE '%the%'
GROUP BY d.director_name;

-- DIFICULTAD: Difícil
-- 26- Lista nombre, nacionalidad y director de todas las películas

SELECT m.MOVIE_NAME, n.NATIONALITY_NAME , d.DIRECTOR_NAME
FROM public.movies m
JOIN public.directors d
	ON m.director_id = d.director_id
JOIN public.nationalities n
	ON m.NATIONALITY_ID  = n.NATIONALITY_ID;

-- 27- Muestra las películas con los actores que han participado 
--     en cada una de ellas

SELECT m.movie_name AS "Película", a.actor_name AS "Actor"
FROM public.movies m
JOIN public.movies_actors ma 
	ON m.movie_id = ma.movie_id
JOIN public.actors a 
	ON ma.actor_id = a.actor_id
ORDER BY m.movie_name, a.actor_name;

-- alternativa que me gusta más

SELECT m.movie_name AS "Película", LISTAGG(a.actor_name, ', ') WITHIN GROUP (ORDER BY a.actor_name) AS "Actores"
FROM public.movies m
JOIN public.movies_actors ma ON m.movie_id = ma.movie_id
JOIN public.actors a ON ma.actor_id = a.actor_id
GROUP BY m.movie_name
ORDER BY m.movie_name;

-- 28- Indica cual es el nombre del director del que más películas 
--     se ha accedido

SELECT d.DIRECTOR_NAME, COUNT(*) AS cantidad_peliculas
FROM public.movies m
JOIN public.directors d
    ON m.director_id = d.director_id
JOIN public.user_movie_access um
    ON m.movie_id = um.movie_id
GROUP BY d.DIRECTOR_NAME
ORDER BY cantidad_peliculas DESC
LIMIT 1;

-- 29- Indica cuantos premios han ganado cada uno de los estudios 
--     con las películas que han creado

SELECT S.STUDIO_NAME, COUNT(a.AWARD_WIN) AS Premios_Ganados
FROM public.STUDIOS s
JOIN public.MOVIES m
	ON s.STUDIO_ID = m.STUDIO_ID
JOIN public.awards a
	ON A.MOVIE_ID = M.MOVIE_ID
GROUP BY S.STUDIO_NAME
ORDER BY Premios_Ganados DESC;

-- 30- Indica el número de premios a los que estuvo nominado un actor, 
--     pero que no ha conseguido (Si una película está nominada a un premio, 
--     su actor también lo está)

SELECT ac.ACTOR_NAME, COUNT(a.AWARD_ID) AS Nominaciones
FROM public.ACTORS ac
JOIN public.movies_actors ma ON ac.ACTOR_ID = ma.ACTOR_ID
JOIN public.MOVIES m 
	ON m.MOVIE_ID = ma.MOVIE_ID
JOIN public.awards a 
	ON a.AWARD_NOMINATION = m.MOVIE_ID
WHERE a.AWARD_WIN <> m.MOVIE_ID
GROUP BY ac.ACTOR_NAME
ORDER BY Nominaciones DESC;

-- 31- Indica cuantos actores y directores hicieron películas 
--     para los estudios no activos

SELECT 
    COUNT(DISTINCT a.ACTOR_ID) AS Actores, 
    COUNT(DISTINCT d.DIRECTOR_ID) AS Directores
FROM public.ACTORS a
JOIN public.movies_actors ma 
    ON a.ACTOR_ID = ma.ACTOR_ID
JOIN public.MOVIES m 
    ON m.MOVIE_ID = ma.MOVIE_ID
JOIN public.studios s 
    ON s.STUDIO_ID = m.STUDIO_ID
JOIN public.DIRECTORS d 
    ON d.DIRECTOR_ID = m.DIRECTOR_ID
WHERE s.STUDIO_ACTIVE = FALSE;

-- 32- Indica el nombre, ciudad, y teléfono de todos los miembros 
--     de la plataforma que hayan accedido películas que hayan sido 
--     nominadas a más de 150 premios y ganaran menos de 50

SELECT u.USER_NAME, u.USER_TOWN, u.USER_PHONE
FROM public.USERS u
JOIN public.USER_MOVIE_ACCESS uma
    ON uma.USER_ID = u.USER_ID
JOIN public.MOVIES m 
    ON m.MOVIE_ID = uma.MOVIE_ID
JOIN public.AWARDS a 
    ON a.MOVIE_ID = m.MOVIE_ID
JOIN public.DIRECTORS d 
    ON d.DIRECTOR_ID = m.DIRECTOR_ID
WHERE a.AWARD_NOMINATION > 150 AND A.AWARD_WIN <50;

-- 33- Comprueba si hay errores en la BD entre las películas y directores 
--     (un director muerto en el 76 no puede dirigir una película en el 88)

SELECT d.DIRECTOR_DEAD_DATE, m.MOVIE_RELEASE_DATE
FROM public.directors d
JOIN public.movies m
    ON m.DIRECTOR_ID = d.DIRECTOR_ID
WHERE d.DIRECTOR_DEAD_DATE < m.MOVIE_RELEASE_DATE;

-- 34- Utilizando la información de la sentencia anterior, 
--     modifica la fecha de defunción a un año más tarde del estreno 
--     de la película (mediante sentencia SQL)

UPDATE public.directors 
SET DIRECTOR_DEAD_DATE = (
    SELECT DATEADD('year', 1, m.MOVIE_RELEASE_DATE)
    FROM public.movies m
    WHERE m.DIRECTOR_ID = directors.DIRECTOR_ID
    AND directors.DIRECTOR_DEAD_DATE < m.MOVIE_RELEASE_DATE
    LIMIT 1
)
WHERE EXISTS (
    SELECT 1
    FROM public.movies m
    WHERE m.DIRECTOR_ID = directors.DIRECTOR_ID
    AND directors.DIRECTOR_DEAD_DATE < m.MOVIE_RELEASE_DATE
);

-- DIFICULTAD: Berserk mode (enunciados simples, mucha diversión…)
-- 35- Indica cuál es el género favorito de cada uno de los directores 
--     cuando dirigen una película

SELECT d.DIRECTOR_NAME AS "Director", g.GENRE_NAME AS "Género Favorito"
FROM public.DIRECTORS d
JOIN public.MOVIES m 
    ON d.DIRECTOR_ID = m.DIRECTOR_ID
JOIN public.GENRES g 
    ON m.GENRE_ID = g.GENRE_ID
GROUP BY d.DIRECTOR_ID, d.DIRECTOR_NAME, g.GENRE_NAME
HAVING 
    COUNT(*) >= ALL (
        SELECT COUNT(*) 
        FROM public.MOVIES m2
        JOIN public.GENRES g2 ON m2.GENRE_ID = g2.GENRE_ID
        WHERE m2.DIRECTOR_ID = d.DIRECTOR_ID
        GROUP BY g2.GENRE_ID
    );

-- 36- Indica cuál es la nacionalidad favorita de cada uno de los estudios 
--     en la producción de las películas

SELECT s.STUDIO_NAME AS "Estudio", 
       (SELECT n2.NATIONALITY_NAME 
        FROM public.MOVIES m2
        JOIN public.NATIONALITIES n2 ON m2.NATIONALITY_ID = n2.NATIONALITY_ID
        WHERE m2.STUDIO_ID = s.STUDIO_ID
        GROUP BY n2.NATIONALITY_NAME
        ORDER BY COUNT(*) DESC, n2.NATIONALITY_NAME
        FETCH FIRST 1 ROW ONLY) AS "Nacionalidad Favorita"
FROM public.STUDIOS s
WHERE EXISTS (SELECT 1 FROM public.MOVIES m WHERE m.STUDIO_ID = s.STUDIO_ID)
ORDER BY s.STUDIO_NAME;

-- 37- Indica cuál fue la primera película a la que accedieron los miembros 
--     de la plataforma cuyos teléfonos tengan como último dígito el ID 
--     de alguna nacionalidad

SELECT u.USER_NAME AS "Miembro", m.MOVIE_NAME AS "Primera Película", uma.ACCESS_DATE AS "Fecha de Acceso"
FROM public.USERS u
JOIN public.NATIONALITIES n 
    ON RIGHT(u.USER_PHONE, 1) = CAST(n.NATIONALITY_ID AS VARCHAR)
JOIN public.USER_MOVIE_ACCESS uma 
    ON u.USER_ID = uma.USER_ID
JOIN public.MOVIES m 
    ON uma.MOVIE_ID = m.MOVIE_ID
WHERE 
    (uma.ACCESS_DATE) = (
        SELECT MIN(uma2.ACCESS_DATE) 
        FROM public.USER_MOVIE_ACCESS uma2 
        WHERE uma2.USER_ID = u.USER_ID
    )
ORDER BY u.USER_NAME;