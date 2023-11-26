-- Table: public.customer

-- DROP TABLE IF EXISTS public.customer;

CREATE TABLE IF NOT EXISTS public.customer
(
    customer_id integer NOT NULL DEFAULT nextval('customer_customer_id_seq'::regclass),
    store_id smallint NOT NULL,
    first_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(45) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default",
    address_id smallint NOT NULL,
    activebool boolean NOT NULL DEFAULT true,
    create_date date NOT NULL DEFAULT ('now'::text)::date,
    last_update timestamp without time zone DEFAULT now(),
    active integer,
    CONSTRAINT customer_pkey PRIMARY KEY (customer_id),
    CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES public.address (address_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.customer
    OWNER to postgres;
-- Index: idx_fk_address_id

-- DROP INDEX IF EXISTS public.idx_fk_address_id;

CREATE INDEX IF NOT EXISTS idx_fk_address_id
    ON public.customer USING btree
    (address_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_fk_store_id

-- DROP INDEX IF EXISTS public.idx_fk_store_id;

CREATE INDEX IF NOT EXISTS idx_fk_store_id
    ON public.customer USING btree
    (store_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_last_name

-- DROP INDEX IF EXISTS public.idx_last_name;

CREATE INDEX IF NOT EXISTS idx_last_name
    ON public.customer USING btree
    (last_name COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.customer;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.customer
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();