--
-- PostgreSQL database dump
--

-- Dumped from database version 16.0
-- Dumped by pg_dump version 16.0

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
-- Name: annual_reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.annual_reports (
    annual_id integer NOT NULL,
    year character varying(4) NOT NULL,
    file_path text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.annual_reports OWNER TO postgres;

--
-- Name: annual_reports_annual_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.annual_reports_annual_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.annual_reports_annual_id_seq OWNER TO postgres;

--
-- Name: annual_reports_annual_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.annual_reports_annual_id_seq OWNED BY public.annual_reports.annual_id;


--
-- Name: campus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.campus (
    campus_id character varying(50) NOT NULL,
    name character varying(50),
    is_extension boolean
);


ALTER TABLE public.campus OWNER TO postgres;

--
-- Name: csd_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.csd_notification (
    notif_id integer NOT NULL,
    notification_message text NOT NULL,
    date_received timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id character varying(50) NOT NULL
);


ALTER TABLE public.csd_notification OWNER TO postgres;

--
-- Name: csd_notification_notif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.csd_notification_notif_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.csd_notification_notif_id_seq OWNER TO postgres;

--
-- Name: csd_notification_notif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.csd_notification_notif_id_seq OWNED BY public.csd_notification.notif_id;


--
-- Name: csd_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.csd_office (
    user_id character varying(50) NOT NULL,
    role integer DEFAULT 0,
    name character varying(100),
    email character varying(100),
    password character varying(100),
    CONSTRAINT csd_office_role_check CHECK ((role = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.csd_office OWNER TO postgres;

--
-- Name: evidence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evidence (
    evidence_id character varying(50) NOT NULL,
    name text,
    type character varying(70),
    section_id character varying(50),
    record_id character varying(50)
);


ALTER TABLE public.evidence OWNER TO postgres;

--
-- Name: formula_per_instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formula_per_instrument (
    formula_id character varying(50) NOT NULL,
    formula text,
    instrument_id character varying(50)
);


ALTER TABLE public.formula_per_instrument OWNER TO postgres;

--
-- Name: formula_per_section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formula_per_section (
    formula_id character varying(50) NOT NULL,
    formula text,
    section_id character varying(50)
);


ALTER TABLE public.formula_per_section OWNER TO postgres;

--
-- Name: instrument; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.instrument (
    instrument_id character varying(50) NOT NULL,
    section_no character varying(10),
    sdg_subtitle text,
    sdg_id character varying(50),
    status character varying(10),
    CONSTRAINT instrument_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('inactive'::character varying)::text])))
);


ALTER TABLE public.instrument OWNER TO postgres;

--
-- Name: options; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.options (
    option_id character varying(50) NOT NULL,
    option text,
    question_id character varying(50)
);


ALTER TABLE public.options OWNER TO postgres;

--
-- Name: question; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.question (
    question_id character varying(50) NOT NULL,
    question text,
    type character varying(20),
    suffix character varying(20),
    section_id character varying(50),
    sub_id character varying(50)
);


ALTER TABLE public.question OWNER TO postgres;

--
-- Name: records; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.records (
    record_id character varying(50) NOT NULL,
    user_id character varying(50),
    status integer DEFAULT 1,
    date_submitted timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    sdg_id character varying(50),
    year integer,
    CONSTRAINT records_status_check CHECK ((status = ANY (ARRAY[1, 2, 3])))
);


ALTER TABLE public.records OWNER TO postgres;

--
-- Name: records_values; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.records_values (
    record_value_id character varying(50) NOT NULL,
    value character varying(50),
    question_id character varying(50),
    record_id character varying(50),
    campus_id character varying(255)
);


ALTER TABLE public.records_values OWNER TO postgres;

--
-- Name: sd_notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sd_notification (
    notif_id integer NOT NULL,
    notification_message text NOT NULL,
    date_received timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id character varying(50) NOT NULL
);


ALTER TABLE public.sd_notification OWNER TO postgres;

--
-- Name: sd_notification_notif_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sd_notification_notif_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sd_notification_notif_id_seq OWNER TO postgres;

--
-- Name: sd_notification_notif_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sd_notification_notif_id_seq OWNED BY public.sd_notification.notif_id;


--
-- Name: sd_office; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sd_office (
    user_id character varying(50) NOT NULL,
    role integer DEFAULT 1,
    name character varying(100),
    email character varying(100),
    password character varying(100),
    campus_id character varying(50),
    CONSTRAINT sd_office_role_check CHECK ((role = ANY (ARRAY[0, 1, 2])))
);


ALTER TABLE public.sd_office OWNER TO postgres;

--
-- Name: sdg; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sdg (
    sdg_id character varying(50) NOT NULL,
    title character varying(50),
    number integer,
    description text
);


ALTER TABLE public.sdg OWNER TO postgres;

--
-- Name: section; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.section (
    section_id character varying(50) NOT NULL,
    content_no character varying(10),
    section_content text,
    instrument_id character varying(50)
);


ALTER TABLE public.section OWNER TO postgres;

--
-- Name: user_otp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_otp (
    user_id character varying(50) NOT NULL,
    otp character varying(60) NOT NULL,
    expiration timestamp without time zone NOT NULL
);


ALTER TABLE public.user_otp OWNER TO postgres;

--
-- Name: annual_reports annual_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_reports ALTER COLUMN annual_id SET DEFAULT nextval('public.annual_reports_annual_id_seq'::regclass);


--
-- Name: csd_notification notif_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.csd_notification ALTER COLUMN notif_id SET DEFAULT nextval('public.csd_notification_notif_id_seq'::regclass);


--
-- Name: sd_notification notif_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sd_notification ALTER COLUMN notif_id SET DEFAULT nextval('public.sd_notification_notif_id_seq'::regclass);


--
-- Data for Name: annual_reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.annual_reports (annual_id, year, file_path, created_at) FROM stdin;
1	2001	1730990992324-report card.pdf	2024-11-07 22:49:52.509744
2	2001	1730991693570-Jane Ashley - ID.pdf	2024-11-07 23:01:33.721338
3	2021	1730992063809-Enrollement Form.pdf	2024-11-07 23:07:43.961588
\.


--
-- Data for Name: campus; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.campus (campus_id, name, is_extension) FROM stdin;
1	BatStateU - Pablo Borbon Campus	f
2	BatStateU - Alangilan Campus	f
3	BatStateU - Lipa Campus	f
4	BatStateU - Nasugbu Campus	f
10	BatStateU - Malvar Campus	f
5	BatStateU - Lemery Campus	t
6	BatStateU - Rosario Campus	t
7	BatStateU - Balayan Campus	t
8	BatStateU - Mabini Campus	t
9	BatStateU - San Juan Campus	t
11	BatStateU - Lobo Campus	t
\.


--
-- Data for Name: csd_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.csd_notification (notif_id, notification_message, date_received, user_id) FROM stdin;
\.


--
-- Data for Name: csd_office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.csd_office (user_id, role, name, email, password) FROM stdin;
001	0	CSD Office	justmyrgutierrez92@gmail.com	$2b$10$u0jAbw5mIuPbLjidsFTSHeqeLQWxHCTxk498C6DnCVeG67hGTXJyO
\.


--
-- Data for Name: evidence; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evidence (evidence_id, name, type, section_id, record_id) FROM stdin;
\.


--
-- Data for Name: formula_per_instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.formula_per_instrument (formula_id, formula, instrument_id) FROM stdin;
\.


--
-- Data for Name: formula_per_section; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.formula_per_section (formula_id, formula, section_id) FROM stdin;
F249607	=IF((A1*1)+(B1*2)+(C1*3)+(D1*4)>=10,10,(A1*1)+(B1*2)+(C1*3)+(D1*4))	S518615
F793940	=IF(AND(A1>=2,B1>=1),25,IF(AND(A1>0,B1>0),10,IF(AND(A1=1,B1=1),10,IF(AND(A1=1,B1=0),10,IF(AND(A1=0,B1=1),10,IF(AND(A1=0,B1=0),0,IF(AND(A1=0,B1>1),25,IF(AND(A1>1,B1>=0),20))))))))	S438839
\.


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (instrument_id, section_no, sdg_subtitle, sdg_id, status) FROM stdin;
I172539		Research on poverty	SDG01	active
I183282		Policy addressing poverty	SDG01	active
\.


--
-- Data for Name: options; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.options (option_id, option, question_id) FROM stdin;
\.


--
-- Data for Name: question; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.question (question_id, question, type, suffix, section_id, sub_id) FROM stdin;
Q496696	Local	Number		S518615	A1
Q217589	Regional	Number		S518615	B1
Q560144	Global	Number		S518615	D1
Q108117	National	Number		S518615	C1
Q506208	Published Research on Poverty	Number		S438839	A1
Q832712	Co-Authored with Low or Lower-Middle income country	Number		S438839	B1
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.records (record_id, user_id, status, date_submitted, sdg_id, year) FROM stdin;
REC2238797	SD52421917	1	2024-11-14 21:44:54.194917	SDG01	2024
REC8959457	SD52421917	1	2024-11-14 21:46:59.679876	SDG01	2023
REC9996481	SD52421917	1	2024-11-14 21:47:32.44172	SDG01	2022
REC6692929	SD52421917	1	2024-11-14 21:52:04.602584	SDG01	2021
\.


--
-- Data for Name: records_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.records_values (record_value_id, value, question_id, record_id, campus_id) FROM stdin;
08090550-1d1f-4385-a5e6-e245a5d4ed7b	2	Q506208	REC2238797	2
177d2c1d-b25c-42d1-a82b-d5988c44dcb8	1	Q506208	REC2238797	7
02a696e8-1446-4886-a557-d690cb8f30cb	0	Q506208	REC2238797	11
4a0fbcf7-b3a0-4fec-9b05-f97657846fac	0	Q506208	REC2238797	8
21409f1a-01dd-4049-b047-391bcf83ff75	0	Q832712	REC2238797	2
c8e86570-e849-4fc5-8a30-c2c9bb2f8c8f	0	Q832712	REC2238797	7
86361a04-f839-4ff2-a4e0-a20bd1230a61	3	Q832712	REC2238797	11
12461708-6ea7-44b9-ad64-245f558bce63	0	Q832712	REC2238797	8
fa3c64fc-47b4-4b11-be2c-564b33ceb0df	2	Q496696	REC2238797	2
68572694-0d78-4e70-aaf2-6c23615109a8	0	Q496696	REC2238797	7
9752dc48-e15c-4217-b86b-49e96d9734c0	0	Q496696	REC2238797	11
9e7a181d-0979-437c-8535-425f9bafb67b	0	Q496696	REC2238797	8
c73fb81b-a817-43b8-bfd7-7379770176b1	0	Q217589	REC2238797	2
a31e55e0-1ca4-47a2-aa9f-3c24d46d0d02	3	Q217589	REC2238797	7
12307e03-beb7-4105-83a7-08a3acf430d8	0	Q217589	REC2238797	11
dcd64d3b-808c-49f7-8754-33f1224ff778	0	Q217589	REC2238797	8
adcb4960-fffb-495c-9c68-7fac1eb7ab10	2	Q560144	REC2238797	2
a171f795-0d8e-4c7d-b9cf-d5d1cd97048f	0	Q560144	REC2238797	7
6fdc704b-40b1-4863-810d-af48eb3d6d16	0	Q560144	REC2238797	11
0669d129-dbfa-4717-b052-b1c34b36c029	0	Q560144	REC2238797	8
74b3b26c-1dda-47bd-a57b-1baf38399792	0	Q108117	REC2238797	2
ce6727cc-1407-4202-bb24-c4c95ca4d4e5	0	Q108117	REC2238797	7
0d5a8fdc-83fc-40e1-9477-1841e4caa186	3	Q108117	REC2238797	11
1d626675-26b7-4625-861b-4a787a9d4450	0	Q108117	REC2238797	8
eaaa5a66-c32c-4267-9b65-4a657d44d404	4	Q506208	REC8959457	2
c86334a8-b6b2-462e-8d96-fe5f5ab02689	0	Q506208	REC8959457	7
5fdf679f-06a3-40b8-befb-6471fa00a5d0	0	Q506208	REC8959457	11
46ff7d29-f347-4a09-aba8-feb5c4a726ec	0	Q506208	REC8959457	8
9837b4f9-8da5-41e2-94c6-9c227155cba4	2	Q832712	REC8959457	2
072e13a7-b0a0-4170-9fd1-915cc8cf263a	0	Q832712	REC8959457	7
86219f1a-6e5c-4f30-9802-43795e79c4eb	0	Q832712	REC8959457	11
e12bd74a-e130-4308-966a-c649f296e0dc	0	Q832712	REC8959457	8
1a9c6a2e-6d5e-4322-8f45-0dbe3deeca26	3	Q496696	REC8959457	2
902c6401-f0b2-47ee-81ee-784a42273e85	0	Q496696	REC8959457	7
6dd4ddf6-011e-4c0a-ba4a-de7e2534532e	0	Q496696	REC8959457	11
658c0c3b-83aa-4662-827b-090b7ff4ea41	0	Q496696	REC8959457	8
de758b39-a3fe-4e2a-b466-11b842a48b5b	0	Q217589	REC8959457	2
2b0e6747-3ae6-4013-a649-d9497ffb22c7	3	Q217589	REC8959457	7
12830db2-3694-4402-8642-1ed83ea92051	0	Q217589	REC8959457	11
d49e0284-a19b-4d77-8cc6-1958d78d8d1a	0	Q217589	REC8959457	8
a4411bb7-c66f-4fa8-b015-c3ffcee01b90	0	Q560144	REC8959457	2
d6b62b3e-872c-4f2e-823d-2f993d3e3daa	0	Q560144	REC8959457	7
a3f91131-9982-440e-b603-8aeb1bd13472	0	Q560144	REC8959457	11
19aea790-480d-403c-bd5d-25a641b201d1	0	Q560144	REC8959457	8
87dbc4ea-7613-4065-9621-6d68d7441305	3	Q108117	REC8959457	2
09d0564c-6a61-4324-a412-5fd2d45beb65	2	Q108117	REC8959457	7
d386dead-0b20-4c75-81cf-66e0f85c876d	0	Q108117	REC8959457	11
b7a79deb-6ffd-459c-b32d-feb8667bb7df	1	Q108117	REC8959457	8
5b9d255d-f777-4f80-bdcd-e0e73d6e1ca3	2	Q506208	REC9996481	2
1a91e9a8-81f0-406c-8fb5-6c0f1d173313	0	Q506208	REC9996481	7
ca50a374-2194-4214-a84e-ad7f72457aa1	0	Q506208	REC9996481	11
2ce447b1-9b64-4d2b-a0e6-a58cfb073823	0	Q506208	REC9996481	8
d0470bc0-6d15-400a-a7ad-5bed81b80432	1	Q832712	REC9996481	2
c4aa7399-06a7-447e-952d-21197fb395b1	0	Q832712	REC9996481	7
5174871f-5753-4a00-a411-45a725264516	0	Q832712	REC9996481	11
c12dfc4c-2fc0-4914-b012-ecfe74543779	0	Q832712	REC9996481	8
ce07439a-54bb-42ca-8524-8cbadf8c1525	0	Q496696	REC9996481	2
468f103e-5f8e-412a-a3ac-78681f50b724	0	Q496696	REC9996481	7
cae9445c-f0a2-4e32-801c-5226d5589e45	0	Q496696	REC9996481	11
f2457854-eba8-4b57-b6d4-9fb597fa1e24	0	Q496696	REC9996481	8
f3a483f5-3b0f-4fbe-87b0-5e74208ffea5	0	Q217589	REC9996481	2
67b2c5a4-93a0-4a4e-8fb3-dd988dbf253e	0	Q217589	REC9996481	7
3c86aecd-d3cb-4798-b449-04fa87c978ff	0	Q217589	REC9996481	11
e4263c66-d264-4e1a-bb47-9f229b49e9cc	0	Q217589	REC9996481	8
7cfd54ca-381d-4657-8404-dad1cff2fb03	0	Q560144	REC9996481	2
ebc07724-c21d-464d-b517-b894e444a555	0	Q560144	REC9996481	7
2b7099b5-0970-45fb-ab53-05db8b0d4c7d	0	Q560144	REC9996481	11
fee93b91-c4e5-44dd-b807-6ee22a4b392b	0	Q560144	REC9996481	8
c44cfba8-9e13-4068-b4f2-aeb62a27030d	0	Q108117	REC9996481	2
8814a996-34fa-4652-92c6-7325e3caa2fb	0	Q108117	REC9996481	7
0ac44016-242a-45ee-8467-8b3ed8d26d1d	0	Q108117	REC9996481	11
3c9021b0-3848-4738-9d6d-9847f4904ffb	0	Q108117	REC9996481	8
37a3bf9c-53d7-4442-9518-15789110e3d3	4	Q506208	REC6692929	2
a35297a8-0df1-4acc-8690-507c46c99e48	4	Q506208	REC6692929	7
ca81da9d-007a-4762-8d95-4652b49335d2	0	Q506208	REC6692929	11
a6f08685-ceeb-4789-b919-69e1d6ae1a80	0	Q506208	REC6692929	8
faddcc0b-b71d-482c-8ac5-5df9093f6d0a	0	Q832712	REC6692929	2
d2b4e03f-c70d-460f-9c63-205d2525a0c9	0	Q832712	REC6692929	7
53744fe3-574e-4027-963e-3ca997eef7a1	0	Q832712	REC6692929	11
0e3ab885-8957-416e-ab9c-6f9d06308ac9	0	Q832712	REC6692929	8
05bcab5c-2544-4795-a5ab-ec56a1205d1b	0	Q496696	REC6692929	2
4b9a9213-c98f-421c-9719-dd80731c9fda	0	Q496696	REC6692929	7
b2f6207e-dc61-4cdf-8253-565777a1d26a	0	Q496696	REC6692929	11
19ca282a-b5be-4da8-b901-da65bbd6adf7	0	Q496696	REC6692929	8
a32cb651-b737-4457-baf6-65390fd4af3a	0	Q217589	REC6692929	2
1ce8ef44-7ee4-4d37-8c24-2b4ec3e21e3e	0	Q217589	REC6692929	7
5f4afa18-58b1-48f4-8388-e220aab2bb46	0	Q217589	REC6692929	11
ee55b04d-b28d-4562-8f7c-0bb73ef70e5f	0	Q217589	REC6692929	8
4f953697-ced6-4c9f-913c-9baeb39103a0	0	Q560144	REC6692929	2
ff0485f0-a2f8-4be2-b8b0-540ce25156c6	0	Q560144	REC6692929	7
0a700e4e-8911-436e-9058-cc069f3171b8	0	Q560144	REC6692929	11
93f7a9ab-74fd-40ca-b107-fb92f6704827	0	Q560144	REC6692929	8
375429d9-2cfb-4f10-9b09-6a2550800cd2	0	Q108117	REC6692929	2
b205ecd0-56ad-46ab-a8a8-13edf129e277	0	Q108117	REC6692929	7
72760ab5-a926-477d-bb0f-ff9ed2cd76bf	0	Q108117	REC6692929	11
e46e7262-176c-41bb-bd89-ffead14f0090	0	Q108117	REC6692929	8
\.


--
-- Data for Name: sd_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sd_notification (notif_id, notification_message, date_received, user_id) FROM stdin;
1	\n                New record submission:\n                - Record ID: REC9996481\n                - Submitted by: Justmyr Dimasacat Gutierrez\n            	2024-11-14 21:47:33.194852	SD52421917
2	\n                New record submission:\n                - Record ID: REC6692929\n                - Submitted by: Justmyr Dimasacat Gutierrez\n            	2024-11-14 21:52:05.564136	SD52421917
\.


--
-- Data for Name: sd_office; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sd_office (user_id, role, name, email, password, campus_id) FROM stdin;
SD21072691	1	asdasd	justmyrgutierrez1@gmail.com	$2b$10$wozbUtM/btey9Vm1Rawhq.E9u57jEoVQc0sY3po9qZvd8AbVr2cN2	1
SD95615009	1	asdasd	justmyrgutierrez921@gmail.com	$2b$10$Ocm8BGzJdUs3PXdGekDc6.YZrQCdtlXbIaybFgGnxw/STFQTn/IrK	2
SD52421917	1	Justmyr Dimasacat Gutierrez	justmyrd.gutierrez@gmail.com	$2b$10$iEwBeYJfsJcYUbDiOhZpueBOxW2/04WXh24kL5BjZzsfqI3xvxI3O	2
\.


--
-- Data for Name: sdg; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sdg (sdg_id, title, number, description) FROM stdin;
SDG01	No Poverty	1	\N
SDG02	Zero Hunger	2	\N
SDG03	Good Health and Well-being	3	\N
SDG04	Quality Education	4	\N
SDG05	Gender Equality	5	\N
SDG06	Clean Water and Sanitation	6	\N
SDG07	Affordable and Clean Energy	7	\N
SDG08	Decent Work and Economic Growth	8	\N
SDG09	Industry, Innovation, and Infrastructure	9	\N
SDG10	Reduced Inequality	10	\N
SDG11	Sustainable Cities and Communities	11	\N
SDG12	Responsible Consumption and Production	12	\N
SDG13	Climate Action	13	\N
SDG14	Life Below Water	14	\N
SDG15	Life on Land	15	\N
SDG16	Peace, Justice, and Strong Institutions	16	\N
SDG17	Partnerships for the Goals	17	\N
\.


--
-- Data for Name: section; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.section (section_id, content_no, section_content, instrument_id) FROM stdin;
S518615		Participation in policy addressing poverty	I183282
S438839		Research on poverty	I172539
\.


--
-- Data for Name: user_otp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_otp (user_id, otp, expiration) FROM stdin;
\.


--
-- Name: annual_reports_annual_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.annual_reports_annual_id_seq', 3, true);


--
-- Name: csd_notification_notif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.csd_notification_notif_id_seq', 1, false);


--
-- Name: sd_notification_notif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sd_notification_notif_id_seq', 2, true);


--
-- Name: annual_reports annual_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.annual_reports
    ADD CONSTRAINT annual_reports_pkey PRIMARY KEY (annual_id);


--
-- Name: campus campus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.campus
    ADD CONSTRAINT campus_pkey PRIMARY KEY (campus_id);


--
-- Name: csd_notification csd_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.csd_notification
    ADD CONSTRAINT csd_notification_pkey PRIMARY KEY (notif_id);


--
-- Name: csd_office csd_office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.csd_office
    ADD CONSTRAINT csd_office_pkey PRIMARY KEY (user_id);


--
-- Name: evidence evidence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_pkey PRIMARY KEY (evidence_id);


--
-- Name: formula_per_instrument formula_per_instrument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formula_per_instrument
    ADD CONSTRAINT formula_per_instrument_pkey PRIMARY KEY (formula_id);


--
-- Name: formula_per_section formula_per_section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formula_per_section
    ADD CONSTRAINT formula_per_section_pkey PRIMARY KEY (formula_id);


--
-- Name: instrument instrument_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT instrument_pkey PRIMARY KEY (instrument_id);


--
-- Name: options options_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_pkey PRIMARY KEY (option_id);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_pkey PRIMARY KEY (question_id);


--
-- Name: records records_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_pkey PRIMARY KEY (record_id);


--
-- Name: records_values records_values_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records_values
    ADD CONSTRAINT records_values_pkey PRIMARY KEY (record_value_id);


--
-- Name: sd_notification sd_notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sd_notification
    ADD CONSTRAINT sd_notification_pkey PRIMARY KEY (notif_id);


--
-- Name: sd_office sd_office_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sd_office
    ADD CONSTRAINT sd_office_pkey PRIMARY KEY (user_id);


--
-- Name: sdg sdg_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sdg
    ADD CONSTRAINT sdg_pkey PRIMARY KEY (sdg_id);


--
-- Name: section section_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_pkey PRIMARY KEY (section_id);


--
-- Name: user_otp user_otp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_otp
    ADD CONSTRAINT user_otp_pkey PRIMARY KEY (user_id);


--
-- Name: evidence evidence_record_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_record_id_fkey FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- Name: evidence evidence_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evidence
    ADD CONSTRAINT evidence_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(section_id);


--
-- Name: records_values fk_campus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records_values
    ADD CONSTRAINT fk_campus FOREIGN KEY (campus_id) REFERENCES public.campus(campus_id);


--
-- Name: records fk_sdg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT fk_sdg FOREIGN KEY (sdg_id) REFERENCES public.sdg(sdg_id);


--
-- Name: user_otp fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_otp
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.sd_office(user_id) ON DELETE CASCADE;


--
-- Name: sd_notification fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sd_notification
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.sd_office(user_id) ON DELETE CASCADE;


--
-- Name: csd_notification fk_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.csd_notification
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.csd_office(user_id) ON DELETE CASCADE;


--
-- Name: formula_per_instrument formula_per_instrument_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formula_per_instrument
    ADD CONSTRAINT formula_per_instrument_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);


--
-- Name: formula_per_section formula_per_section_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formula_per_section
    ADD CONSTRAINT formula_per_section_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(section_id);


--
-- Name: instrument instrument_sdg_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.instrument
    ADD CONSTRAINT instrument_sdg_id_fkey FOREIGN KEY (sdg_id) REFERENCES public.sdg(sdg_id);


--
-- Name: options options_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.options
    ADD CONSTRAINT options_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: question question_section_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.question
    ADD CONSTRAINT question_section_id_fkey FOREIGN KEY (section_id) REFERENCES public.section(section_id);


--
-- Name: records records_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records
    ADD CONSTRAINT records_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.sd_office(user_id);


--
-- Name: records_values records_values_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records_values
    ADD CONSTRAINT records_values_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.question(question_id);


--
-- Name: records_values records_values_record_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.records_values
    ADD CONSTRAINT records_values_record_id_fkey FOREIGN KEY (record_id) REFERENCES public.records(record_id);


--
-- Name: sd_office sd_office_campus_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sd_office
    ADD CONSTRAINT sd_office_campus_id_fkey FOREIGN KEY (campus_id) REFERENCES public.campus(campus_id);


--
-- Name: section section_instrument_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.section
    ADD CONSTRAINT section_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES public.instrument(instrument_id);


--
-- PostgreSQL database dump complete
--

