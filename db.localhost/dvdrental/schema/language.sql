-- Table: public.language

-- DROP TABLE IF EXISTS public.language;

CREATE TABLE IF NOT EXISTS public.language
(
    language_id integer NOT NULL DEFAULT nextval('language_language_id_seq'::regclass),
    name character(20) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT language_pkey PRIMARY KEY (language_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.language
    OWNER to postgres;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.language;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.language
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();