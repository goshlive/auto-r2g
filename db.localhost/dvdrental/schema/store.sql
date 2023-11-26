-- Table: public.store

-- DROP TABLE IF EXISTS public.store;

CREATE TABLE IF NOT EXISTS public.store
(
    store_id integer NOT NULL DEFAULT nextval('store_store_id_seq'::regclass),
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp without time zone NOT NULL DEFAULT now(),
    CONSTRAINT store_pkey PRIMARY KEY (store_id),
    CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id)
        REFERENCES public.address (address_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT store_manager_staff_id_fkey FOREIGN KEY (manager_staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.store
    OWNER to postgres;
-- Index: idx_unq_manager_staff_id

-- DROP INDEX IF EXISTS public.idx_unq_manager_staff_id;

CREATE UNIQUE INDEX IF NOT EXISTS idx_unq_manager_staff_id
    ON public.store USING btree
    (manager_staff_id ASC NULLS LAST)
    TABLESPACE pg_default;

-- Trigger: last_updated

-- DROP TRIGGER IF EXISTS last_updated ON public.store;

CREATE TRIGGER last_updated
    BEFORE UPDATE 
    ON public.store
    FOR EACH ROW
    EXECUTE FUNCTION public.last_updated();