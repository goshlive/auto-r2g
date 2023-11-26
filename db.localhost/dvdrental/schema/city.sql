-- Table: public.city

-- DROP TABLE IF EXISTS public.city;

CREATE TABLE IF NOT EXISTS public.city
(
    city_id integer NOT NULL DEFAULT nextval('city_city_id_seq'::regclass),
    city character varying(50) COLLATE pg_catalog."default" NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT city_pkey PRIMARY KEY (city_id),
    CONSTRAINT fk_city FOREIGN KEY (country_id)
        REFERENCES public.country (country_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.city
    OWNER to postgres;
-- Index: idx_fk_country_id

-- DROP INDEX IF EXISTS public.idx_fk_country_id;

CREATE INDEX IF NOT EXISTS idx_fk_country_id
    ON public.city USING btree
    (country_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.city;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.city
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();