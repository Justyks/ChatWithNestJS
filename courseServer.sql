--
-- PostgreSQL database cluster dump
--

-- Started on 2023-03-27 18:25:36

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE auth;
DROP DATABASE chat;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:Whdi8NiTysFeKYdeG5+pBg==$CTSEuyLJjTL/dSEZY6vxbBxGcrcaNCabxwhEZbd+aX8=:Zi8QWOdwyRBGpEKeI0VGDYnNpHt6Y06NvZ88xUl7Fgo=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-27 18:25:36

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- TOC entry 3315 (class 1262 OID 1)
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3316 (class 0 OID 0)
-- Dependencies: 3315
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- TOC entry 3318 (class 0 OID 0)
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 3315
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


-- Completed on 2023-03-27 18:25:36

--
-- PostgreSQL database dump complete
--

--
-- Database "auth" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-27 18:25:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3354 (class 1262 OID 16398)
-- Name: auth; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE auth WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE auth OWNER TO postgres;

\connect auth

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    value character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16411)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 3355 (class 0 OID 0)
-- Dependencies: 216
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 219 (class 1259 OID 16423)
-- Name: user-roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user-roles" (
    id integer NOT NULL,
    "roleId" integer,
    "userId" integer
);


ALTER TABLE public."user-roles" OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16422)
-- Name: user-roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."user-roles_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."user-roles_id_seq" OWNER TO postgres;

--
-- TOC entry 3356 (class 0 OID 0)
-- Dependencies: 218
-- Name: user-roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."user-roles_id_seq" OWNED BY public."user-roles".id;


--
-- TOC entry 215 (class 1259 OID 16400)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    banned boolean DEFAULT false,
    "banReason" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16399)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3357 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3185 (class 2604 OID 16415)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 3186 (class 2604 OID 16426)
-- Name: user-roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user-roles" ALTER COLUMN id SET DEFAULT nextval('public."user-roles_id_seq"'::regclass);


--
-- TOC entry 3183 (class 2604 OID 16403)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3346 (class 0 OID 16412)
-- Dependencies: 217
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles (id, value, description, "createdAt", "updatedAt") VALUES (1, 'Admin', 'Admin', '2023-03-07 23:33:29.335+03', '2023-03-07 23:33:29.335+03');
INSERT INTO public.roles (id, value, description, "createdAt", "updatedAt") VALUES (2, 'User', 'User', '2023-03-07 23:38:00.443+03', '2023-03-07 23:38:00.443+03');


--
-- TOC entry 3348 (class 0 OID 16423)
-- Dependencies: 219
-- Data for Name: user-roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user-roles" (id, "roleId", "userId") VALUES (1, 2, 4);
INSERT INTO public."user-roles" (id, "roleId", "userId") VALUES (2, 2, 6);
INSERT INTO public."user-roles" (id, "roleId", "userId") VALUES (3, 2, 7);
INSERT INTO public."user-roles" (id, "roleId", "userId") VALUES (4, 1, 8);
INSERT INTO public."user-roles" (id, "roleId", "userId") VALUES (5, 1, 9);


--
-- TOC entry 3344 (class 0 OID 16400)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (1, 'ilya@gmail.com', '1234', false, NULL, '2023-03-07 22:43:43.93+03', '2023-03-07 22:43:43.93+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (3, 'ilyaetet@gmail.com', '1234', false, NULL, '2023-03-07 22:47:23.484+03', '2023-03-07 22:47:23.484+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (4, 'simple.user@gmail.com', '1234', false, NULL, '2023-03-07 23:38:34.779+03', '2023-03-07 23:38:34.779+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (6, '235325w', '$2a$05$l83/gL9x1OpgI8RB70EHDO6nVvfZ.5.IWBdD0bdd9Ct1DZvwYdnE6', false, NULL, '2023-03-08 14:33:26.294+03', '2023-03-08 14:33:26.294+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (7, '2353reerr25w', '$2a$05$aKPBhPsWavvCGkZDVw6WJun6.LcJD8oEWMYs5guChviVJtoAsl0Qm', false, NULL, '2023-03-08 14:35:09.873+03', '2023-03-08 14:35:09.873+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (8, 'fedya@gmail.com', '1234', false, NULL, '2023-03-08 18:40:47.906+03', '2023-03-08 18:40:47.906+03');
INSERT INTO public.users (id, email, password, banned, "banReason", "createdAt", "updatedAt") VALUES (9, 'Admin', '$2a$05$30l2NnKrPi17JZiNEsdJ5.8i.kahzueeOJc2V0fxeaucR8BNVKc6O', false, NULL, '2023-03-08 18:42:02.468+03', '2023-03-08 18:42:02.468+03');


--
-- TOC entry 3358 (class 0 OID 0)
-- Dependencies: 216
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- TOC entry 3359 (class 0 OID 0)
-- Dependencies: 218
-- Name: user-roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."user-roles_id_seq"', 5, true);


--
-- TOC entry 3360 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- TOC entry 3192 (class 2606 OID 16419)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3194 (class 2606 OID 16421)
-- Name: roles roles_value_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_value_key UNIQUE (value);


--
-- TOC entry 3196 (class 2606 OID 16428)
-- Name: user-roles user-roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user-roles"
    ADD CONSTRAINT "user-roles_pkey" PRIMARY KEY (id);


--
-- TOC entry 3198 (class 2606 OID 16430)
-- Name: user-roles user-roles_roleId_userId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user-roles"
    ADD CONSTRAINT "user-roles_roleId_userId_key" UNIQUE ("roleId", "userId");


--
-- TOC entry 3188 (class 2606 OID 16410)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 3190 (class 2606 OID 16408)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3199 (class 2606 OID 16431)
-- Name: user-roles user-roles_roleId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user-roles"
    ADD CONSTRAINT "user-roles_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES public.roles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 3200 (class 2606 OID 16436)
-- Name: user-roles user-roles_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user-roles"
    ADD CONSTRAINT "user-roles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


-- Completed on 2023-03-27 18:25:37

--
-- PostgreSQL database dump complete
--

--
-- Database "chat" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-27 18:25:37

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3337 (class 1262 OID 16441)
-- Name: chat; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE chat WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE chat OWNER TO postgres;

\connect chat

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24652)
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id integer NOT NULL,
    login character varying(255) NOT NULL,
    text character varying(255) NOT NULL,
    recipient character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24651)
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.messages_id_seq OWNER TO postgres;

--
-- TOC entry 3338 (class 0 OID 0)
-- Dependencies: 216
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.messages_id_seq OWNED BY public.messages.id;


--
-- TOC entry 215 (class 1259 OID 16454)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16453)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 3339 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 3179 (class 2604 OID 24655)
-- Name: messages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages ALTER COLUMN id SET DEFAULT nextval('public.messages_id_seq'::regclass);


--
-- TOC entry 3178 (class 2604 OID 16457)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 3331 (class 0 OID 24652)
-- Dependencies: 217
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.messages (id, login, text, recipient, "createdAt", "updatedAt") VALUES (1, 'ilya', 'hi)', 'fedor', '2023-03-09 22:21:14.662+03', '2023-03-09 22:21:14.662+03');
INSERT INTO public.messages (id, login, text, recipient, "createdAt", "updatedAt") VALUES (2, 'fedor', 'hehe', 'ilya', '2023-03-09 22:21:14.662+03', '2023-03-09 22:21:14.662+03');
INSERT INTO public.messages (id, login, text, recipient, "createdAt", "updatedAt") VALUES (3, 'ilya', 'veterok)))))', 'vlad', '2023-03-09 22:21:14.662+03', '2023-03-09 22:21:14.662+03');


--
-- TOC entry 3329 (class 0 OID 16454)
-- Dependencies: 215
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, login, password, "createdAt", "updatedAt") VALUES (6, 'ilya', '$2a$05$U10oRR5KWXFLzwZkwH8wgecJwTICz/C.EVH5TFAB.PMVTyo2W/GU2', '2023-03-09 22:21:14.662+03', '2023-03-09 22:21:14.662+03');


--
-- TOC entry 3340 (class 0 OID 0)
-- Dependencies: 216
-- Name: messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.messages_id_seq', 3, true);


--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 214
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 6, true);


--
-- TOC entry 3185 (class 2606 OID 24659)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- TOC entry 3181 (class 2606 OID 16463)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 3183 (class 2606 OID 16461)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


-- Completed on 2023-03-27 18:25:38

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-03-27 18:25:38

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE postgres;
--
-- TOC entry 3316 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 3317 (class 0 OID 0)
-- Dependencies: 3316
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3318 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


-- Completed on 2023-03-27 18:25:38

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-03-27 18:25:38

--
-- PostgreSQL database cluster dump complete
--

