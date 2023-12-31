-- Table: public.staff

-- DROP TABLE IF EXISTS public.staff;

CREATE TABLE IF NOT EXISTS public.staff
(
    staff_id integer NOT NULL DEFAULT nextval('staff_staff_id_seq'::regclass),
    first_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    address_id smallint NOT NULL,
    email character varying(50) COLLATE pg_catalog."default",
    store_id smallint NOT NULL,
    active boolean NOT NULL DEFAULT true,
    username character varying(16) COLLATE pg_catalog."default" NOT NULL,
    password character varying(40) COLLATE pg_catalog."default",
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    picture bytea,
    CONSTRAINT staff_pkey PRIMARY KEY (staff_id),
    CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES public.address (address_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.staff
    OWNER to postgres;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.staff;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.staff
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();