-- List each pair of actors that have worked together.

select * 
from sakila.film_actor a1
left join sakila.film_actor a2
on a1.film_id = a2.film_id
and a1.actor_id <> a2.actor_id;

-- For each film, list actor that has acted in more films.

select * from sakila.film;

select * from sakila.film_Actor;

select * from sakila.actor;

with actorfilmcount as (
select fa.actor_id, fa.film_id,
count(fa.film_id) over (partition by fa.actor_id) as film_count
from sakila.film_actor fa
)

select f.title as film_title, a.actor_id, a.first_name, a.capital_surname
from sakila.film f
join (
select afc.film_id, afc.actor_id
from actorfilmcount afc
join (
	select film_id, max(film_count) as max_film_count
    from actorfilmcount
    group by film_id
    ) max_film
    on afc.film_id = max_film.film_id and 
    afc.film_Count = max_film.max_film_count
    ) max_actors
    on f.film_id = max_actors.film_id
    join sakila.actor a on max_actors.actor_id = a.actor_id
    order by f.title, a.capital_surname,
    a.first_name;
    
    select * from sakila.actor;