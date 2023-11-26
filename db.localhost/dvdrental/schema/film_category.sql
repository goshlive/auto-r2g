-- Table: public.film_category

-- DROP TABLE IF EXISTS public.film_category;

CREATE TABLE IF NOT EXISTS public.film_category
(
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id),
    CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id)
        REFERENCES public.film (film_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.film_category
    OWNER to postgres;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.film_category;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.film_category
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();