--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Name: event_periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('event_periods_id_seq', 4, true);


--
-- Data for Name: event_periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY event_periods (id, seq_no, name, scale, description, created_at, created_by_user_id, updated_by_user_id, updated_at) FROM stdin;
1	1	day	\N	\N	2012-04-08 00:00:00	1	1	2012-04-08 00:00:00
2	2	week	\N	\N	2012-04-08 00:00:00	1	1	2012-04-08 00:00:00
3	3	month	\N	\N	2012-04-08 00:00:00	1	1	2012-04-08 00:00:00
4	4	year	\N	\N	2012-04-08 00:00:00	1	1	2012-04-08 00:00:00
\.


--
-- PostgreSQL database dump complete
--

