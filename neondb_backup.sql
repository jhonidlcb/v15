--
-- PostgreSQL database dump
--

\restrict YKjKbvqUagv5K2G1opIc4MzfiF82dt2kQxxdaoCQEyJbX93IgeeRNwprpLUJTOL

-- Dumped from database version 17.5 (84bec44)
-- Dumped by pg_dump version 18.0 (Ubuntu 18.0-1.pgdg24.04+3)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: drizzle; Type: SCHEMA; Schema: -; Owner: neondb_owner
--

CREATE SCHEMA drizzle;


ALTER SCHEMA drizzle OWNER TO neondb_owner;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: __drizzle_migrations; Type: TABLE; Schema: drizzle; Owner: neondb_owner
--

CREATE TABLE drizzle.__drizzle_migrations (
    id integer NOT NULL,
    hash text NOT NULL,
    created_at bigint
);


ALTER TABLE drizzle.__drizzle_migrations OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE; Schema: drizzle; Owner: neondb_owner
--

CREATE SEQUENCE drizzle.__drizzle_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNER TO neondb_owner;

--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: drizzle; Owner: neondb_owner
--

ALTER SEQUENCE drizzle.__drizzle_migrations_id_seq OWNED BY drizzle.__drizzle_migrations.id;


--
-- Name: budget_negotiations; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.budget_negotiations (
    id integer NOT NULL,
    project_id integer NOT NULL,
    proposed_by integer NOT NULL,
    original_price numeric(12,2) NOT NULL,
    proposed_price numeric(12,2) NOT NULL,
    message text,
    status character varying(50) DEFAULT 'pending'::text NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    responded_at timestamp without time zone
);


ALTER TABLE public.budget_negotiations OWNER TO neondb_owner;

--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.budget_negotiations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.budget_negotiations_id_seq OWNER TO neondb_owner;

--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.budget_negotiations_id_seq OWNED BY public.budget_negotiations.id;


--
-- Name: invoices; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.invoices (
    id integer NOT NULL,
    invoice_number character varying(50) NOT NULL,
    project_id integer NOT NULL,
    client_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    due_date timestamp without time zone NOT NULL,
    paid_date timestamp without time zone,
    description text,
    tax_amount numeric(12,2) DEFAULT 0.00,
    discount_amount numeric(12,2) DEFAULT 0.00,
    total_amount numeric(12,2) NOT NULL,
    payment_method_id integer,
    notes text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    currency character varying(3) DEFAULT 'PYG'::character varying NOT NULL
);


ALTER TABLE public.invoices OWNER TO neondb_owner;

--
-- Name: invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.invoices_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.invoices_id_seq OWNER TO neondb_owner;

--
-- Name: invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.invoices_id_seq OWNED BY public.invoices.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.notifications (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying(255) NOT NULL,
    message text NOT NULL,
    type character varying(50) DEFAULT 'info'::character varying NOT NULL,
    is_read boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.notifications OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_id_seq OWNER TO neondb_owner;

--
-- Name: notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.notifications_id_seq OWNED BY public.notifications.id;


--
-- Name: partners; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.partners (
    id integer NOT NULL,
    user_id integer NOT NULL,
    referral_code character varying(50) NOT NULL,
    commission_rate numeric(5,2) DEFAULT 25.00 NOT NULL,
    total_earnings numeric(12,2) DEFAULT 0.00 NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.partners OWNER TO neondb_owner;

--
-- Name: partners_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.partners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.partners_id_seq OWNER TO neondb_owner;

--
-- Name: partners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.partners_id_seq OWNED BY public.partners.id;


--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_methods (
    id integer NOT NULL,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    provider character varying(100),
    last4 character varying(4),
    expiry_date character varying(7),
    holder_name character varying(255),
    bank_name character varying(255),
    account_number character varying(255),
    is_default boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    metadata jsonb,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payment_methods OWNER TO neondb_owner;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_methods_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_methods_id_seq OWNER TO neondb_owner;

--
-- Name: payment_methods_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_methods_id_seq OWNED BY public.payment_methods.id;


--
-- Name: payment_stages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payment_stages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    stage_name text NOT NULL,
    stage_percentage integer NOT NULL,
    amount numeric(10,2) NOT NULL,
    required_progress integer DEFAULT 0 NOT NULL,
    status text DEFAULT 'pending'::character varying NOT NULL,
    payment_link text,
    paid_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    payment_method character varying(50),
    payment_data jsonb,
    proof_file_url text,
    whatsapp_notification_sent boolean DEFAULT false
);


ALTER TABLE public.payment_stages OWNER TO neondb_owner;

--
-- Name: payment_stages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payment_stages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payment_stages_id_seq OWNER TO neondb_owner;

--
-- Name: payment_stages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payment_stages_id_seq OWNED BY public.payment_stages.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    project_id integer NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    payment_data jsonb,
    created_at timestamp without time zone DEFAULT now(),
    stage character varying(50) DEFAULT 'full'::character varying,
    stage_percentage numeric(5,2) DEFAULT 100.00,
    payment_method character varying(100),
    transaction_id character varying(255),
    currency character varying(3) DEFAULT 'PYG'::character varying NOT NULL
);


ALTER TABLE public.payments OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO neondb_owner;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: portfolio; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.portfolio (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    category character varying(100) NOT NULL,
    technologies text NOT NULL,
    image_url text NOT NULL,
    demo_url text,
    completed_at timestamp without time zone NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.portfolio OWNER TO neondb_owner;

--
-- Name: portfolio_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.portfolio_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.portfolio_id_seq OWNER TO neondb_owner;

--
-- Name: portfolio_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.portfolio_id_seq OWNED BY public.portfolio.id;


--
-- Name: project_files; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_files (
    id integer NOT NULL,
    project_id integer NOT NULL,
    file_name character varying(255) NOT NULL,
    file_url text NOT NULL,
    file_type character varying(100) NOT NULL,
    uploaded_by integer NOT NULL,
    uploaded_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_files OWNER TO neondb_owner;

--
-- Name: project_files_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_files_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_files_id_seq OWNER TO neondb_owner;

--
-- Name: project_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_files_id_seq OWNED BY public.project_files.id;


--
-- Name: project_messages; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_messages (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_messages OWNER TO neondb_owner;

--
-- Name: project_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_messages_id_seq OWNER TO neondb_owner;

--
-- Name: project_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_messages_id_seq OWNED BY public.project_messages.id;


--
-- Name: project_timeline; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.project_timeline (
    id integer NOT NULL,
    project_id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text,
    status character varying(50) DEFAULT 'pending'::character varying,
    estimated_date timestamp without time zone,
    completed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.project_timeline OWNER TO neondb_owner;

--
-- Name: project_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.project_timeline_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.project_timeline_id_seq OWNER TO neondb_owner;

--
-- Name: project_timeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.project_timeline_id_seq OWNED BY public.project_timeline.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    progress integer DEFAULT 0 NOT NULL,
    client_id integer NOT NULL,
    partner_id integer,
    delivery_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    start_date timestamp without time zone,
    currency character varying(3) DEFAULT 'PYG'::character varying NOT NULL
);


ALTER TABLE public.projects OWNER TO neondb_owner;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO neondb_owner;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: referrals; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.referrals (
    id integer NOT NULL,
    partner_id integer NOT NULL,
    client_id integer NOT NULL,
    project_id integer,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    commission_amount numeric(12,2) DEFAULT 0.00,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.referrals OWNER TO neondb_owner;

--
-- Name: referrals_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.referrals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.referrals_id_seq OWNER TO neondb_owner;

--
-- Name: referrals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.referrals_id_seq OWNED BY public.referrals.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.sessions (
    sid character varying NOT NULL,
    sess jsonb NOT NULL,
    expire timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO neondb_owner;

--
-- Name: ticket_responses; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.ticket_responses (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    user_id integer NOT NULL,
    message text NOT NULL,
    is_from_support boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.ticket_responses OWNER TO neondb_owner;

--
-- Name: ticket_responses_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.ticket_responses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ticket_responses_id_seq OWNER TO neondb_owner;

--
-- Name: ticket_responses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.ticket_responses_id_seq OWNED BY public.ticket_responses.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    status character varying(50) DEFAULT 'open'::character varying NOT NULL,
    priority character varying(50) DEFAULT 'medium'::character varying NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.tickets OWNER TO neondb_owner;

--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.tickets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tickets_id_seq OWNER TO neondb_owner;

--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.transactions (
    id integer NOT NULL,
    invoice_id integer,
    payment_method_id integer,
    user_id integer NOT NULL,
    type character varying(50) NOT NULL,
    amount numeric(12,2) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    description text NOT NULL,
    transaction_id character varying(255),
    provider_data jsonb,
    processed_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO neondb_owner;

--
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.transactions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO neondb_owner;

--
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- Name: twilio_config; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.twilio_config (
    id integer NOT NULL,
    account_sid character varying(255),
    auth_token character varying(255),
    from_phone_number character varying(20),
    whatsapp_from_number character varying(20),
    is_enabled boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.twilio_config OWNER TO neondb_owner;

--
-- Name: twilio_config_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.twilio_config_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.twilio_config_id_seq OWNER TO neondb_owner;

--
-- Name: twilio_config_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.twilio_config_id_seq OWNED BY public.twilio_config.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    full_name character varying(255) NOT NULL,
    role character varying(50) DEFAULT 'client'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    whatsapp_number character varying(20)
);


ALTER TABLE public.users OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO neondb_owner;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: work_modalities; Type: TABLE; Schema: public; Owner: neondb_owner
--

CREATE TABLE public.work_modalities (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    subtitle character varying(255),
    badge_text character varying(100),
    badge_variant character varying(50) DEFAULT 'secondary'::character varying,
    description text NOT NULL,
    price_text character varying(255) NOT NULL,
    price_subtitle character varying(255),
    features jsonb NOT NULL,
    button_text character varying(255) DEFAULT 'Solicitar Cotización'::character varying NOT NULL,
    button_variant character varying(50) DEFAULT 'default'::character varying,
    is_popular boolean DEFAULT false,
    is_active boolean DEFAULT true,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    title_es character varying(255),
    title_en character varying(255),
    title_pt character varying(255),
    description_es text,
    description_en text,
    description_pt text
);


ALTER TABLE public.work_modalities OWNER TO neondb_owner;

--
-- Name: work_modalities_id_seq; Type: SEQUENCE; Schema: public; Owner: neondb_owner
--

CREATE SEQUENCE public.work_modalities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.work_modalities_id_seq OWNER TO neondb_owner;

--
-- Name: work_modalities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: neondb_owner
--

ALTER SEQUENCE public.work_modalities_id_seq OWNED BY public.work_modalities.id;


--
-- Name: __drizzle_migrations id; Type: DEFAULT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations ALTER COLUMN id SET DEFAULT nextval('drizzle.__drizzle_migrations_id_seq'::regclass);


--
-- Name: budget_negotiations id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations ALTER COLUMN id SET DEFAULT nextval('public.budget_negotiations_id_seq'::regclass);


--
-- Name: invoices id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices ALTER COLUMN id SET DEFAULT nextval('public.invoices_id_seq'::regclass);


--
-- Name: notifications id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications ALTER COLUMN id SET DEFAULT nextval('public.notifications_id_seq'::regclass);


--
-- Name: partners id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners ALTER COLUMN id SET DEFAULT nextval('public.partners_id_seq'::regclass);


--
-- Name: payment_methods id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods ALTER COLUMN id SET DEFAULT nextval('public.payment_methods_id_seq'::regclass);


--
-- Name: payment_stages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages ALTER COLUMN id SET DEFAULT nextval('public.payment_stages_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: portfolio id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio ALTER COLUMN id SET DEFAULT nextval('public.portfolio_id_seq'::regclass);


--
-- Name: project_files id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files ALTER COLUMN id SET DEFAULT nextval('public.project_files_id_seq'::regclass);


--
-- Name: project_messages id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages ALTER COLUMN id SET DEFAULT nextval('public.project_messages_id_seq'::regclass);


--
-- Name: project_timeline id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline ALTER COLUMN id SET DEFAULT nextval('public.project_timeline_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: referrals id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals ALTER COLUMN id SET DEFAULT nextval('public.referrals_id_seq'::regclass);


--
-- Name: ticket_responses id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses ALTER COLUMN id SET DEFAULT nextval('public.ticket_responses_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- Name: twilio_config id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.twilio_config ALTER COLUMN id SET DEFAULT nextval('public.twilio_config_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: work_modalities id; Type: DEFAULT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities ALTER COLUMN id SET DEFAULT nextval('public.work_modalities_id_seq'::regclass);


--
-- Data for Name: __drizzle_migrations; Type: TABLE DATA; Schema: drizzle; Owner: neondb_owner
--

COPY drizzle.__drizzle_migrations (id, hash, created_at) FROM stdin;
\.


--
-- Data for Name: budget_negotiations; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.budget_negotiations (id, project_id, proposed_by, original_price, proposed_price, message, status, created_at, responded_at) FROM stdin;
1	3	1	500.00	750.00	el presupuesto es de tanto 	accepted	2025-09-25 01:07:46.72925	2025-09-25 01:12:06.651
\.


--
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.invoices (id, invoice_number, project_id, client_id, amount, status, due_date, paid_date, description, tax_amount, discount_amount, total_amount, payment_method_id, notes, created_at, updated_at, currency) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.notifications (id, user_id, title, message, type, is_read, created_at) FROM stdin;
1	1	≡ƒÜÇ Nuevo Proyecto Creado	Cliente Test ha creado el proyecto "app para mi pizzeria"	info	f	2025-08-29 02:29:53.553076
5	1	≡ƒÆ¼ Nuevo Mensaje	Cliente Test te ha enviado un mensaje en "app para mi pizzeria"	info	f	2025-08-29 02:58:22.0558
12	1	≡ƒÜÇ Nuevo Proyecto Creado	Jhoni De La Cruz ha creado el proyecto "exporto ropa de chile y necesito un sistema"	info	f	2025-08-29 20:48:33.123939
21	1	≡ƒÜÇ Nuevo Proyecto Creado	Jhoni De La Cruz ha creado el proyecto "test"	info	f	2025-08-29 23:44:45.077605
29	1	💰 Pago Confirmado	El cliente Jhoni De La Cruz confirmó el pago de la etapa "Avance 50% - Desarrollo" mediante Mango. Verificar comprobante.	info	f	2025-09-22 18:29:18.800294
33	1	💰 Pago Confirmado	El cliente Jhoni De La Cruz confirmó el pago de la etapa "Pre-entrega - 90% Completado" mediante undefined. Sin comprobante adjunto.	info	f	2025-09-22 18:45:19.865024
35	1	💰 Pago Confirmado	El cliente Jhoni De La Cruz confirmó el pago de la etapa "Entrega Final" mediante undefined. Sin comprobante adjunto.	info	f	2025-09-22 18:48:25.155926
2	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:27.690196
3	2	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:29.293148
4	5	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:30.617447
6	1	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:38.417924
7	2	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:39.70895
8	5	🚀 Nuevo Proyecto Creado	Pablo ha creado el proyecto "FrigoMgrande"	info	f	2025-09-25 01:04:41.018686
9	3	✅ Proyecto Creado Exitosamente	Tu proyecto "FrigoMgrande" ha sido creado y está siendo revisado	success	f	2025-09-25 01:04:42.352102
10	3	💵 Contraoferta Recibida	Proyecto "FrigoMgrande": Precio propuesto $750	warning	f	2025-09-25 01:07:47.092305
11	3	💰 Pago Disponible	Nueva etapa de pago disponible: Anticipo - Inicio del Proyecto - $187.50	success	f	2025-09-25 01:15:35.583401
13	1	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-25 01:20:46.728237
14	2	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-25 01:20:48.610745
15	5	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-25 01:20:50.144666
16	3	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-25 01:22:17.242974
17	1	💰 Pago Confirmado	El cliente Pablo confirmó el pago de la etapa "Avance 50% - Desarrollo" mediante Mango. Comprobante adjunto: icn-logo.png.	info	f	2025-09-28 20:24:19.659902
18	2	💰 Pago Confirmado	El cliente Pablo confirmó el pago de la etapa "Avance 50% - Desarrollo" mediante Mango. Comprobante adjunto: icn-logo.png.	info	f	2025-09-28 20:24:19.843975
19	5	💰 Pago Confirmado	El cliente Pablo confirmó el pago de la etapa "Avance 50% - Desarrollo" mediante Mango. Comprobante adjunto: icn-logo.png.	info	f	2025-09-28 20:24:19.993308
20	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango. Comprobante adjunto: Flag_of_Brazil.svg.png. Requiere verificación.	warning	f	2025-09-28 20:39:41.003488
22	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango. Comprobante adjunto: icon_logo_1.png. Requiere verificación.	warning	f	2025-09-28 20:39:49.261978
23	2	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango. Comprobante adjunto: icon_logo_1.png. Requiere verificación.	warning	f	2025-09-28 20:39:49.410097
24	5	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Pre-entrega - 90% Completado" mediante Mango. Comprobante adjunto: icon_logo_1.png. Requiere verificación.	warning	f	2025-09-28 20:39:49.559008
25	3	✅ Pago Aprobado	Tu pago para la etapa "Pre-entrega - 90% Completado" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-28 20:53:49.686567
26	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: solar.png. Requiere verificación.	warning	f	2025-09-28 20:54:15.973274
27	2	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: solar.png. Requiere verificación.	warning	f	2025-09-28 20:54:16.120369
28	5	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: solar.png. Requiere verificación.	warning	f	2025-09-28 20:54:16.268642
30	3	💰 Pago Disponible	Nueva etapa de pago disponible: Entrega Final - $187.50	success	f	2025-09-28 20:58:12.519391
31	1	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-28 21:01:35.679576
32	2	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-28 21:01:35.829077
34	5	📋 Comprobante de Pago Recibido	El cliente Pablo envió comprobante de pago para "Entrega Final" mediante Ueno Bank. Comprobante adjunto: photo-1621607512214-68297480165e.jpg. Requiere verificación.	warning	f	2025-09-28 21:01:36.137505
36	3	✅ Pago Aprobado	Tu pago para la etapa "Entrega Final" ha sido verificado y aprobado. ¡Continuamos con el desarrollo!	success	f	2025-09-28 21:03:08.244043
37	3	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:15:35.280459
38	1	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:16:04.201112
39	2	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:16:06.638797
40	5	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:16:09.060873
41	3	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:18:07.59055
42	1	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:18:27.666789
43	2	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:18:30.082562
44	5	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:18:32.483655
45	3	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:20:35.50153
46	3	💬 Nuevo Mensaje	Administrador SoftwarePar te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:20:44.404907
47	1	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:20:51.054356
48	2	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:20:53.42261
49	5	💬 Nuevo Mensaje	Pablo te ha enviado un mensaje en "FrigoMgrande"	info	f	2025-09-28 22:20:55.786113
\.


--
-- Data for Name: partners; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.partners (id, user_id, referral_code, commission_rate, total_earnings, created_at) FROM stdin;
1	4	ABC123	25.00	0.00	2025-09-23 11:04:24.098355
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_methods (id, user_id, type, provider, last4, expiry_date, holder_name, bank_name, account_number, is_default, is_active, metadata, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: payment_stages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payment_stages (id, project_id, stage_name, stage_percentage, amount, required_progress, status, payment_link, paid_date, created_at, updated_at, payment_method, payment_data, proof_file_url, whatsapp_notification_sent) FROM stdin;
1	3	Anticipo - Inicio del Proyecto	25	187.50	0	paid	#manual-payment-1	2025-09-25 01:18:26.742	2025-09-25 01:15:21.680949	2025-09-25 01:18:26.742	\N	\N	\N	f
2	3	Avance 50% - Desarrollo	25	187.50	50	paid	\N	2025-09-28 20:24:19.271	2025-09-25 01:15:21.867294	2025-09-28 20:24:19.271	Mango	{"method": "Mango", "fileInfo": {"fileName": "icn-logo.png", "fileSize": 55070, "fileType": "image/png"}, "confirmedAt": "2025-09-28T20:24:19.271Z", "confirmedBy": 3, "originalFileName": "icn-logo.png"}	comprobante_2_1759091059271_icn-logo.png	f
3	3	Pre-entrega - 90% Completado	25	187.50	90	paid	\N	2025-09-28 20:53:49.467	2025-09-25 01:15:22.045125	2025-09-28 20:53:49.467	Mango	{"method": "Mango", "fileInfo": {"fileName": "icon_logo_1.png", "fileSize": 55070, "fileType": "image/png"}, "confirmedAt": "2025-09-28T20:39:48.890Z", "confirmedBy": 3, "originalFileName": "icon_logo_1.png"}	comprobante_3_1759091988890_icon_logo_1.png	f
4	3	Entrega Final	25	187.50	100	paid	#manual-payment-4	2025-09-28 21:03:07.858	2025-09-25 01:15:22.2227	2025-09-28 21:03:07.858	Ueno Bank	{"method": "Ueno Bank", "fileInfo": {"fileName": "photo-1621607512214-68297480165e.jpg", "fileSize": 392343, "fileType": "image/jpeg"}, "confirmedAt": "2025-09-28T21:01:35.298Z", "confirmedBy": 3, "originalFileName": "photo-1621607512214-68297480165e.jpg"}	comprobante_4_1759093295298_photo-1621607512214-68297480165e.jpg	f
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.payments (id, project_id, amount, status, payment_data, created_at, stage, stage_percentage, payment_method, transaction_id, currency) FROM stdin;
\.


--
-- Data for Name: portfolio; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.portfolio (id, title, description, category, technologies, image_url, demo_url, completed_at, featured, is_active, created_at, updated_at) FROM stdin;
2	Dashboard Analytics	Dashboard interactivo para analisis de datos con graficos en tiempo real y reportes personalizables.	Dashboard	["Vue.js", "Express", "MongoDB", "Chart.js"]	https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800	https://demo-dashboard.softwarepar.lat	2024-02-10 14:30:00	t	t	2025-08-27 14:44:09.899342	2025-08-27 14:44:09.899342
4	Sistema CRM	Sistema de gestion de relaciones con clientes con automatizacion de marketing y seguimiento de ventas.	Web App	["Angular", ".NET Core", "SQL Server"]	https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=800	https://demo-crm.softwarepar.lat	2024-01-28 16:45:00	f	t	2025-08-27 14:44:09.899342	2025-08-27 14:44:09.899342
3	App Movil Delivery1	Aplicacion movil para delivery de comida con seguimiento en tiempo real y multiples metodos de pago.	Mobile App	["React Native", "Firebase", "Google Maps"]	https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=800		2024-03-05 00:00:00	f	t	2025-08-27 14:44:09.899342	2025-08-27 15:03:53.588
1	E-commerce Moderno	Plataforma de comercio electronico con carrito de compras, pagos integrados y panel de administracion completo.	E-commerce	["React", "Node.js", "PostgreSQL", "Stripe"]	https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=800	https://demo-ecommerce.softwarepar.lat	2024-01-15 00:00:00	t	t	2025-08-27 14:44:09.899342	2025-08-29 14:43:38.856
7	BaberShop	Aplicación web completa para gestión de barbería con sistema de reservas online, panel administrativo y soporte multiidioma (Español/Portugués). Incluye catálogo de servicios con precios en múltiples monedas (USD, BRL, PYG), galería de trabajos, gestión de personal y configuración de horarios. Sistema responsive con diseño moderno y funcionalidades avanzadas de administración.	Web App	["React","Express","PostgreSQL"]	https://i.ibb.co/8DwC9CCg/web.png	https://barbershop.softwarepar.lat	2025-09-23 00:00:00	f	t	2025-09-24 23:27:36.539547	2025-09-25 00:12:52.482
\.


--
-- Data for Name: project_files; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_files (id, project_id, file_name, file_url, file_type, uploaded_by, uploaded_at) FROM stdin;
\.


--
-- Data for Name: project_messages; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_messages (id, project_id, user_id, message, created_at) FROM stdin;
1	3	3	hola tarola \n	2025-09-25 01:20:37.763664
2	3	3	hola tarola \n	2025-09-25 01:20:46.204409
3	3	1	test\n	2025-09-25 01:22:16.887521
4	3	1	test\n	2025-09-28 22:15:34.996435
5	3	3	hola	2025-09-28 22:16:03.800792
6	3	1	test admin envio mensaje	2025-09-28 22:18:07.322016
7	3	3	test cliente envio mensaje	2025-09-28 22:18:27.264837
8	3	1	exclente	2025-09-28 22:20:35.233756
9	3	1	perfecto	2025-09-28 22:20:44.134878
10	3	3	exclente	2025-09-28 22:20:50.649361
\.


--
-- Data for Name: project_timeline; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.project_timeline (id, project_id, title, description, status, estimated_date, completed_at, created_at) FROM stdin;
1	3	Análisis y Planificación	Análisis de requerimientos y planificación del proyecto	completed	\N	2025-09-25 01:18:49.546	2025-09-25 01:15:22.581988
2	3	Diseño y Arquitectura	Diseño de la interfaz y arquitectura del sistema	completed	\N	2025-09-25 01:18:53.029	2025-09-25 01:15:22.768333
3	3	Desarrollo - Fase 1	Desarrollo de funcionalidades principales (50% del proyecto)	completed	\N	2025-09-25 01:18:56.851	2025-09-25 01:15:22.945803
4	3	Desarrollo - Fase 2	Completar desarrollo y optimizaciones (90% del proyecto)	completed	\N	2025-09-25 01:19:00.261	2025-09-25 01:15:23.123214
5	3	Testing y QA	Pruebas exhaustivas y control de calidad	completed	\N	2025-09-28 20:29:09.875	2025-09-25 01:15:23.300203
6	3	Entrega Final	Entrega del proyecto completado y documentación	completed	\N	2025-09-28 20:29:13.859	2025-09-25 01:15:23.47745
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.projects (id, name, description, price, status, progress, client_id, partner_id, delivery_date, created_at, updated_at, start_date, currency) FROM stdin;
3	FrigoMgrande	necesito una web para un frigorifico industrial	750.00	completed	100	3	\N	2025-09-30 00:00:00	2025-09-25 01:04:37.891344	2025-09-28 20:29:25.927	2025-09-24 00:00:00	PYG
\.


--
-- Data for Name: referrals; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.referrals (id, partner_id, client_id, project_id, status, commission_amount, created_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.sessions (sid, sess, expire) FROM stdin;
\.


--
-- Data for Name: ticket_responses; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.ticket_responses (id, ticket_id, user_id, message, is_from_support, created_at) FROM stdin;
\.


--
-- Data for Name: tickets; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.tickets (id, title, description, status, priority, user_id, project_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.transactions (id, invoice_id, payment_method_id, user_id, type, amount, status, description, transaction_id, provider_data, processed_at, created_at) FROM stdin;
\.


--
-- Data for Name: twilio_config; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.twilio_config (id, account_sid, auth_token, from_phone_number, whatsapp_from_number, is_enabled, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.users (id, email, password, full_name, role, is_active, created_at, updated_at, whatsapp_number) FROM stdin;
1	softwarepar.lat@gmail.com	$2b$10$FuHFhTc0ctLQqAfTWnUk9e5fbbha/vx2AhragKYn6MRT5R4SM4336	Administrador SoftwarePar	admin	t	2025-08-26 22:32:54.933839	2025-09-22 19:51:21.992481	\N
2	admin@softwarepar.lat	$2b$10$BFheyseXMqElJB.OAgEt8uxP33V9IcUfpnrJqWqv9nKGnCfSMMK2e	Administrador SoftwarePar	admin	t	2025-09-23 11:04:23.159893	2025-09-23 11:04:23.159893	\N
4	partner@test.com	$2b$10$Cv8fsf7yCy3CcMb7Z1jQcOY.1VufhldZQHxZ0h.XCwTXpCMQTyq3W	Partner Test	partner	t	2025-09-23 11:04:23.912957	2025-09-23 11:04:23.912957	\N
3	alfagroupstoreok@gmail.com	$2b$10$w1WuAWHN6PsKnER1/D.H4eaioSXVaf8kCIi9XtuuUYxiMjrnyf5hK	Pablo	client	t	2025-09-23 11:04:23.542438	2025-09-23 14:15:03.921	\N
5	admin@softwarepar.com	$2b$10$6zHQK9oiKCCL1h8hKxMp.uYJXj93fD3KmOpQgVhI0OIqbMIRK6FgO	Administrador	admin	t	2025-09-23 12:05:18.462362	2025-09-28 21:28:54.974	\N
\.


--
-- Data for Name: work_modalities; Type: TABLE DATA; Schema: public; Owner: neondb_owner
--

COPY public.work_modalities (id, title, subtitle, badge_text, badge_variant, description, price_text, price_subtitle, features, button_text, button_variant, is_popular, is_active, display_order, created_at, updated_at, title_es, title_en, title_pt, description_es, description_en, description_pt) FROM stdin;
4	Compra Completa	Tradicional	Tradicional	secondary	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	t	1	2025-09-23 12:20:20.459498	2025-09-29 12:34:05.037	Compra Completa	Complete Purchase	Compra Completa	Recibe el código fuente completo y propiedad total del proyecto	Receive complete source code and total project ownership	Receba o código fonte completo e propriedade total do projeto
3	Modelo SaaS	Más Popular	Más Popular	secondary	Accede al software como servicio con pagos mensuales flexibles	$50 - $200	por mes	["Sin inversión inicial alta", "Actualizaciones automáticas", "Soporte técnico incluido", "Escalabilidad garantizada", "Copias de seguridad automáticas", "Acceso 24/7 desde cualquier lugar"]	Comenzar Ahora	default	t	f	2	2025-09-23 12:07:05.836181	2025-09-23 12:15:18.484	Modelo SaaS	SaaS Model	Modelo SaaS	Accede al software como servicio con pagos mensuales flexibles	Access software as a service with flexible monthly payments	Acesse o software como serviço com pagamentos mensais flexíveis
1	Compra Completa	Tradicional	Tradicional	default	Recibe el código fuente completo y propiedad total del proyecto	$2,500 - $15,000	Precio según complejidad	"[\\"Código fuente completo incluido\\",\\"Propiedad intelectual total\\",\\"Documentación técnica completa\\",\\"3 meses de soporte incluido\\",\\"Capacitación del equipo\\",\\"Deployment en tu servidor\\"]"	Solicitar Cotización	default	f	f	1	2025-09-23 12:01:27.883544	2025-09-23 12:19:00.669	Compra Completa	SaaS Model	Modelo SaaS	Recibe el código fuente completo y propiedad total del proyecto	Access software as a service with flexible monthly payments	Acesse o software como serviço com pagamentos mensais flexíveis
2	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 70%	+ comisiones por ventas	"[\\"Precio reducido inicial\\",\\"Código de referido único\\",\\"20-40% comisión por venta\\",\\"Dashboard de ganancias\\",\\"Sistema de licencias\\",\\"Soporte y marketing incluido\\"]"	Convertirse en Partner	default	t	t	2	2025-09-23 12:01:27.883544	2025-09-23 17:07:39.166	Partnership	Partnership	Parceria	Paga menos, conviértete en partner y genera ingresos revendendolo	Pay less, become a partner and generate income by reselling	Pague menos, torne-se parceiro e gere renda revendendo
5	Partnership	Innovador	Más Popular	default	Paga menos, conviértete en partner y genera ingresos revendendolo	40% - 60%	+ comisiones por ventas	["Precio reducido inicial", "Código de referido único", "20-40% comisión por venta", "Dashboard de ganancias", "Sistema de licencias", "Soporte y marketing incluido"]	Convertirse en Partner	default	t	f	2	2025-09-23 12:20:20.459498	2025-09-23 12:21:44.001	Partnership	SaaS Model	Modelo SaaS	Paga menos, conviértete en partner y genera ingresos revendendolo	Access software as a service with flexible monthly payments	Acesse o software como serviço com pagamentos mensais flexíveis
\.


--
-- Name: __drizzle_migrations_id_seq; Type: SEQUENCE SET; Schema: drizzle; Owner: neondb_owner
--

SELECT pg_catalog.setval('drizzle.__drizzle_migrations_id_seq', 1, false);


--
-- Name: budget_negotiations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.budget_negotiations_id_seq', 1, true);


--
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.invoices_id_seq', 1, false);


--
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.notifications_id_seq', 49, true);


--
-- Name: partners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.partners_id_seq', 1, true);


--
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_methods_id_seq', 1, false);


--
-- Name: payment_stages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payment_stages_id_seq', 4, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- Name: portfolio_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.portfolio_id_seq', 7, true);


--
-- Name: project_files_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_files_id_seq', 1, false);


--
-- Name: project_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_messages_id_seq', 10, true);


--
-- Name: project_timeline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.project_timeline_id_seq', 6, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.projects_id_seq', 3, true);


--
-- Name: referrals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.referrals_id_seq', 1, false);


--
-- Name: ticket_responses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.ticket_responses_id_seq', 1, false);


--
-- Name: tickets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.tickets_id_seq', 1, false);


--
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- Name: twilio_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.twilio_config_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: work_modalities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: neondb_owner
--

SELECT pg_catalog.setval('public.work_modalities_id_seq', 5, true);


--
-- Name: __drizzle_migrations __drizzle_migrations_pkey; Type: CONSTRAINT; Schema: drizzle; Owner: neondb_owner
--

ALTER TABLE ONLY drizzle.__drizzle_migrations
    ADD CONSTRAINT __drizzle_migrations_pkey PRIMARY KEY (id);


--
-- Name: budget_negotiations budget_negotiations_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_pkey PRIMARY KEY (id);


--
-- Name: invoices invoices_invoice_number_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_invoice_number_unique UNIQUE (invoice_number);


--
-- Name: invoices invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_pkey PRIMARY KEY (id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (id);


--
-- Name: partners partners_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_pkey PRIMARY KEY (id);


--
-- Name: partners partners_referral_code_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_referral_code_unique UNIQUE (referral_code);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: payment_stages payment_stages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: portfolio portfolio_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.portfolio
    ADD CONSTRAINT portfolio_pkey PRIMARY KEY (id);


--
-- Name: project_files project_files_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_pkey PRIMARY KEY (id);


--
-- Name: project_messages project_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_pkey PRIMARY KEY (id);


--
-- Name: project_timeline project_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: referrals referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (sid);


--
-- Name: ticket_responses ticket_responses_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: twilio_config twilio_config_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.twilio_config
    ADD CONSTRAINT twilio_config_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: work_modalities work_modalities_pkey; Type: CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.work_modalities
    ADD CONSTRAINT work_modalities_pkey PRIMARY KEY (id);


--
-- Name: IDX_session_expire; Type: INDEX; Schema: public; Owner: neondb_owner
--

CREATE INDEX "IDX_session_expire" ON public.sessions USING btree (expire);


--
-- Name: budget_negotiations budget_negotiations_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: budget_negotiations budget_negotiations_proposed_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.budget_negotiations
    ADD CONSTRAINT budget_negotiations_proposed_by_users_id_fk FOREIGN KEY (proposed_by) REFERENCES public.users(id);


--
-- Name: invoices invoices_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: invoices invoices_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- Name: invoices invoices_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.invoices
    ADD CONSTRAINT invoices_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: notifications notifications_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: partners partners_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.partners
    ADD CONSTRAINT partners_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payment_methods payment_methods_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: payment_stages payment_stages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payment_stages
    ADD CONSTRAINT payment_stages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: payments payments_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_files project_files_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_files project_files_uploaded_by_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_files
    ADD CONSTRAINT project_files_uploaded_by_users_id_fk FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: project_messages project_messages_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: project_messages project_messages_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_messages
    ADD CONSTRAINT project_messages_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: project_timeline project_timeline_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.project_timeline
    ADD CONSTRAINT project_timeline_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: projects projects_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: projects projects_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: referrals referrals_client_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_client_id_users_id_fk FOREIGN KEY (client_id) REFERENCES public.users(id);


--
-- Name: referrals referrals_partner_id_partners_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_partner_id_partners_id_fk FOREIGN KEY (partner_id) REFERENCES public.partners(id);


--
-- Name: referrals referrals_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.referrals
    ADD CONSTRAINT referrals_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: ticket_responses ticket_responses_ticket_id_tickets_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_ticket_id_tickets_id_fk FOREIGN KEY (ticket_id) REFERENCES public.tickets(id);


--
-- Name: ticket_responses ticket_responses_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.ticket_responses
    ADD CONSTRAINT ticket_responses_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: tickets tickets_project_id_projects_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_project_id_projects_id_fk FOREIGN KEY (project_id) REFERENCES public.projects(id);


--
-- Name: tickets tickets_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: transactions transactions_invoice_id_invoices_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_invoice_id_invoices_id_fk FOREIGN KEY (invoice_id) REFERENCES public.invoices(id);


--
-- Name: transactions transactions_payment_method_id_payment_methods_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_payment_method_id_payment_methods_id_fk FOREIGN KEY (payment_method_id) REFERENCES public.payment_methods(id);


--
-- Name: transactions transactions_user_id_users_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: neondb_owner
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_user_id_users_id_fk FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO neon_superuser WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: cloud_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE cloud_admin IN SCHEMA public GRANT ALL ON TABLES TO neon_superuser WITH GRANT OPTION;


--
-- PostgreSQL database dump complete
--

\unrestrict YKjKbvqUagv5K2G1opIc4MzfiF82dt2kQxxdaoCQEyJbX93IgeeRNwprpLUJTOL

