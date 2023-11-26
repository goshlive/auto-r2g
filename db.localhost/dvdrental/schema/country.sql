-- Table: public.country

-- DROP TABLE IF EXISTS public.country;

CREATE TABLE IF NOT EXISTS public.country
(
    country_id integer NOT NULL DEFAULT nextval('country_country_id_seq'::regclass),
    country character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT country_pkey PRIMARY KEY (country_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.country
    OWNER to postgres;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.country;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.country
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();