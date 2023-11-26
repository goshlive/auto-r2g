-- Table: public.category

-- DROP TABLE IF EXISTS public.category;

CREATE TABLE IF NOT EXISTS public.category
(
    category_id integer NOT NULL DEFAULT nextval('category_category_id_seq'::regclass),
    name character varying(25) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.category
    OWNER to postgres;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.category;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.category
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();