-- Table: public.payment

-- DROP TABLE IF EXISTS public.payment;

CREATE TABLE IF NOT EXISTS public.payment
(
    payment_id integer NOT NULL DEFAULT nextval('payment_payment_id_seq'::regclass),
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp without time zone NOT NULL,
    CONSTRAINT payment_pkey PRIMARY KEY (payment_id),
    CONSTRAINT payment_customer_id_fkey FOREIGN KEY (customer_id)
        REFERENCES public.customer (customer_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT payment_rental_id_fkey FOREIGN KEY (rental_id)
        REFERENCES public.rental (rental_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT payment_staff_id_fkey FOREIGN KEY (staff_id)
        REFERENCES public.staff (staff_id) MATCH SIMPLE
        ON UPDATE CASCADE
        ON DELETE RESTRICT
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.payment
    OWNER to postgres;
-- Index: idx_fk_customer_id

-- DROP INDEX IF EXISTS public.idx_fk_customer_id;

CREATE INDEX IF NOT EXISTS idx_fk_customer_id
    ON public.payment USING btree
    (customer_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_fk_rental_id

-- DROP INDEX IF EXISTS public.idx_fk_rental_id;

CREATE INDEX IF NOT EXISTS idx_fk_rental_id
    ON public.payment USING btree
    (rental_id ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: idx_fk_staff_id

-- DROP INDEX IF EXISTS public.idx_fk_staff_id;

CREATE INDEX IF NOT EXISTS idx_fk_staff_id
    ON public.payment USING btree
    (staff_id ASC NULLS LAST)
    TABLESPACE pg_default;