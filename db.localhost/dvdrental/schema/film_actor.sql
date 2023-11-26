-- Table: public.film_actor

-- DROP TABLE IF EXISTS public.film_actor;

CREATE TABLE IF NOT EXISTS public.film_actor
(
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id),
    CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id)
        REFERENCES public.actor (actor_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (film_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_actor
    OWNER to postgres;
-- Index: idx_fk_film_id

-- DROP INDEX IF EXISTS public.idx_fk_film_id;

CREATE INDEX IF NOT EXISTS idx_fk_film_id
    ON public.film_actor USING btree
    (film_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.film_actor;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.film_actor
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();