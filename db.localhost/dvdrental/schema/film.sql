-- Table: public.film

-- DROP TABLE IF EXISTS public.film;

CREATE TABLE IF NOT EXISTS public.film
(
    film_id integer NOT NULL DEFAULT nextval('film_film_id_seq'::regclass),
    title character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    release_year year,
    language_id smallint NOT NULL,
    rental_duration smallint NOT NULL DEFAULT 3,
    rental_rate numeric(4,2) NOT NULL DEFAULT 4.99,
    length smallint,
    replacement_cost numeric(5,2) NOT NULL DEFAULT 19.99,
    rating mpaa_rating DEFAULT 'G'::mpaa_rating,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    special_features text[] COLLATE pg_catalog."default",
    fulltext tsvector NOT NULL,
    CONSTRAINT film_pkey PRIMARY KEY (film_id),
    CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id)
        REFERENCES public.language (language_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film
    OWNER to postgres;
-- Index: film_fulltext_idx

-- DROP INDEX IF EXISTS public.film_fulltext_idx;

CREATE INDEX IF NOT EXISTS film_fulltext_idx
    ON public.film USING gist
    (fulltext)
    TABLESPACE pg_default;
-- Index: idx_fk_language_id

-- DROP INDEX IF EXISTS public.idx_fk_language_id;

CREATE INDEX IF NOT EXISTS idx_fk_language_id
    ON public.film USING btree
    (language_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_title

-- DROP INDEX IF EXISTS public.idx_title;

CREATE INDEX IF NOT EXISTS idx_title
    ON public.film USING btree
    (title COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: film_fulltext_trigger

-- DROP TRIGGER IF EXISTS film_fulltext_trigger ON public.film;

CREATE TRIGGER film_fulltext_trigger
    BEFORE INSERT OR UPDATE 
    ON public.film
    FOR EACH ROW
    EXECUTE FUNCTION tsvector_update_trigger('fulltext', 'pg_catalog.english', 'title', 'description');

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.film;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.film
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();