-- Table: public.address

-- DROP TABLE IF EXISTS public.address;

CREATE TABLE IF NOT EXISTS public.address
(
    address_id integer NOT NULL DEFAULT nextval('address_address_id_seq'::regclass),
    address character varying(50) COLLATE pg_catalog."default" NOT NULL,
    address2 character varying(50) COLLATE pg_catalog."default",
    district character varying(20) COLLATE pg_catalog."default" NOT NULL,
    city_id smallint NOT NULL,
    postal_code character varying(10) COLLATE pg_catalog."default",
    phone character varying(20) COLLATE pg_catalog."default" NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT address_pkey PRIMARY KEY (address_id),
    CONSTRAINT fk_address_city FOREIGN KEY (city_id)
        REFERENCES public.city (city_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.address
    OWNER to postgres;
-- Index: idx_fk_city_id

-- DROP INDEX IF EXISTS public.idx_fk_city_id;

CREATE INDEX IF NOT EXISTS idx_fk_city_id
    ON public.address USING btree
    (city_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.address;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.address
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();