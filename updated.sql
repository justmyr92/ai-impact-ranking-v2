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
2	\n                                    ==============================\n                                    RECORD APPROVAL NOTIFICATION\n                                    ==============================\n                    \n                                    Hello,\n                    \n                                    An existing record has been marked as "Approved" by CSD Office.\n                    \n                                    Record Details:\n                                    ---------------\n                                    - Record ID: REC8804431\n                    \n                                    This record is now considered finalized.\n                    \n                                    Thank you,\n                                    SDO\n                                	2024-11-20 06:24:16.218969	001
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
F166799	=IF(A1/(A1+B1+C1+D1)>=5%,4,0)	S361791
F254256	=IF(B1/(A1+B1+C1+D1)>=60%,10,0)	S361791
F893900	=IF(D1/(A1+B1+C1+D1)>=5%,2,0)	S361791
F910824	=IF(AND(A1>=2,A2>=1),25,IF(AND(A1>0,A2>0),10,IF(AND(A1=1,A2=1),10,IF(AND(A1=1,A2=0),10,IF(AND(A1=0,A2=1),10,IF(AND(A1=0,A2=0),0,IF(AND(A1=0,A2>1),25,IF(AND(A1>1,A2>=0),20))))))))	S426319
F595685	=IF(A5>=2,2,A5)	S165164
F577865	=IF(A2>=5,5,A2)	S751490
F173091	=IF(((A1*1)+(B1*2)+(C1*3)+(D1*4))>=10,10,((A1*1)+(B1*2)+(C1*3)+(D1*4)))	S358930
F568878	=IF(OR(A2=1,B2=1,C2=1,A3=1),5,0)	S407502
F835550	=IF(A5=0,0,IF(A6>=1,3,0))	S181274
F978535	=A3/4*5	S125925
F633329	=IF(A1>=5,5,A1)	S977658
F320714	=IF(A3>=5,5,A3)	S604258
F185566		S243469
F913999	=IF((B1/A1)/0.2*5>=5,5,B1/A1/0.2*5)	S984386
F616977	=IF((B4/A4)/0.2*5>=5,5,(B4/A4)/0.2*5)	S751730
F207248	=IF((B2/A2)/80%*5>=5,5,B2/A2/80%*5/80%*5)	S110934
F215628	=IF(C1/(A1+B1+C1+D1)>=5%,4,0)	S361791
\.


--
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (instrument_id, section_no, sdg_subtitle, sdg_id, status) FROM stdin;
I652006		Research on poverty	SDG01	active
I716377		Community anti-poverty programmes	SDG01	active
I498244		Policy addressing poverty	SDG01	active
I900777		University anti-poverty programmes	SDG01	active
I326216		Financial aid to low-income students	SDG01	active
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
Q598830	Published Research on Poverty	Number		S426319	A1
Q557941	Co-Authored with Low or Lower-Middle income country	Number		S426319	B1
Q927912	Private-Funded	Number		S361791	A1
Q465276	Books	Number		S407502	A2
Q241410	Computers	Number		S407502	B2
Q333074	School Supplies	Number		S407502	C2
Q319123	Government-Funded	Number		S361791	B1
Q681176	Other low income support for students	Number		S243469	A3
Q108933	Both Private and Government Funded	Number		S361791	C1
Q689360	Other	Number		S361791	D1
Q437322	Total Admitted Students	Number		S984386	A1
Q690434	Percentage of low-income admitted students	Number		S984386	B1
Q853347	No. of Foreign Student from Low-Income Country	Number		S165164	A5
Q873743	No. of Foreign Student from Low-Income country received financial support from the campus.	Number		S181274	A6
Q660814	Student Assistant	Number		S751730	A4
Q764752	Student Assistant (Low-Income)	Number		S751730	B4
Q463914	Graduate Students	Number		S110934	A2
Q476426	Percentage of Low-Income Graduates	Number		S110934	B2
Q761053	No. of PPAs	Number		S125925	A3
Q307064	No. of PPAs	Number		S977658	A1
Q476347	No. of PPAs	Number		S751490	A2
Q660722	No. of PPAs	Number		S604258	A3
Q495920	Local	Number		S358930	A1
Q404495	Regional	Number		S358930	B1
Q445552	Global	Number		S358930	D1
Q634876	National	Number		S358930	C1
\.


--
-- Data for Name: records; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.records (record_id, user_id, status, date_submitted, sdg_id, year) FROM stdin;
REC8804431	SD52421917	3	2024-11-20 06:20:59.035023	SDG01	2024
\.


--
-- Data for Name: records_values; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.records_values (record_value_id, value, question_id, record_id, campus_id) FROM stdin;
b8fa4138-3619-42ca-b33c-64e97098beb4	0	Q598830	REC8804431	2
ec33cf8d-e85d-437e-b3e0-4afc22736ad0	2	Q598830	REC8804431	7
2bd82ed4-b7e2-4670-9eb2-5327c934d31c	0	Q598830	REC8804431	11
45ccdbc3-f72a-4232-984a-c8c99b8433dd	0	Q598830	REC8804431	8
8c61ef83-4233-4eb8-8c44-a03bfb0db84d	0	Q557941	REC8804431	2
63515163-c220-48e2-a664-ba4a37964019	0	Q557941	REC8804431	7
feef0150-027f-4653-8850-b5d99cf8c910	3	Q557941	REC8804431	11
bc103e58-7a0e-4986-a57e-8b342137a38a	0	Q557941	REC8804431	8
a11829dd-b326-4ad8-9e0b-d0f2523d682c	0	Q307064	REC8804431	2
c3967567-b57f-478e-8893-4d1a9e3219b6	0	Q307064	REC8804431	7
7558c723-2fe2-4bbb-8cb2-7dad8cf50cb0	1	Q307064	REC8804431	11
5b1b729c-d969-42ff-98b0-4c49d8faf7d4	0	Q307064	REC8804431	8
65f7975d-35bc-4eac-8c27-9e44f629360f	0	Q476347	REC8804431	2
724e88ff-e322-4c26-bcc8-04ec1d3f7b39	3	Q476347	REC8804431	7
ebf9ac23-03c9-427e-9ae7-45dcf9ed7a7e	0	Q476347	REC8804431	11
7303a5fa-f90c-4c27-91c0-ca40d6504c16	0	Q476347	REC8804431	8
50fa7d7a-ea83-443d-b056-c7d7aee19f94	0	Q660722	REC8804431	2
03c0f16d-eb07-44b9-9ca7-2fc02565d713	0	Q660722	REC8804431	7
23a9aafb-72a6-4ece-9867-3d350d831887	1	Q660722	REC8804431	11
c82fe755-f2f5-447b-b4e1-547924b5aa53	0	Q660722	REC8804431	8
1d407666-30f0-4c9d-876a-b5e722e31b1a	0	Q495920	REC8804431	2
f11632d2-a4df-4009-8874-b712d5575694	3	Q495920	REC8804431	7
9a368378-fc16-42a9-8e2f-7857b4fa19d6	13	Q495920	REC8804431	11
913a49d7-2e42-41d9-9ff8-515dd918f151	3	Q495920	REC8804431	8
75026c86-567a-4b0d-b7c1-b8b0931cce5b	2	Q404495	REC8804431	2
0d17e75c-2cd5-40cd-aa84-176a7e75887f	0	Q404495	REC8804431	7
aeafccd3-7124-4a08-93b8-944845f5d88f	0	Q404495	REC8804431	11
01f16256-8ebb-4d60-84aa-a6e0e6c26716	0	Q404495	REC8804431	8
10b1b04d-22f7-4aca-8a05-d41eb2802a0b	0	Q445552	REC8804431	2
fc068cf3-e5d1-4de6-ac92-43e7fc96e2db	9	Q445552	REC8804431	7
2043021d-5de3-4712-8130-d1faffb69157	76	Q445552	REC8804431	11
ebc62861-1e79-455c-83f0-3b5f60e977bb	67	Q445552	REC8804431	8
7ccf721c-2f55-4ab4-b8cf-7412d888c3b1	76	Q634876	REC8804431	2
570f33a5-34ef-46b0-88f6-45ef00b5e1b7	7	Q634876	REC8804431	7
405714ad-5d9e-484b-9d8b-25941541b557	7	Q634876	REC8804431	11
7effb41c-c714-4527-9299-f3c6ff6fe765	7	Q634876	REC8804431	8
cb03cfb3-4c65-4c55-920b-e288a0ff2a31	7	Q437322	REC8804431	2
801f356f-cda8-432e-a948-af1b0d44e513	7	Q437322	REC8804431	7
5cd10575-2311-4e6b-83de-d1bfa6588e9c	77	Q437322	REC8804431	11
364e2d07-ffd8-4b15-bfad-46788b8747ca	7	Q437322	REC8804431	8
6bb448fe-83e8-4db7-9fb7-fd4784dfd2cf	7	Q690434	REC8804431	2
5a36fbbd-8d72-40b9-9e14-dc21d8a8c634	76	Q690434	REC8804431	7
d433db10-fc82-4686-b7db-c402c65bcb53	767	Q690434	REC8804431	11
b5d920cc-cb03-42fc-8a4e-00d8f2a318a0	67	Q690434	REC8804431	8
74e15cb1-16fe-4f40-bf71-a1a5029985a1	7	Q853347	REC8804431	2
04f231f0-f9dc-46e6-97f8-1414e2c00b4f	6	Q853347	REC8804431	7
864eda12-5a43-4efe-a12f-bcb0f68c4892	55	Q853347	REC8804431	11
323decff-abf9-4701-ac80-29be5d0cecfe	456	Q853347	REC8804431	8
ae91b453-15a9-4284-acda-0de27fc7be48	65	Q873743	REC8804431	2
887d713a-b07f-4a7b-a1c5-5deb5ae5d1e7	46	Q873743	REC8804431	7
529575fd-bf0f-4710-8fd8-5608f134ef89	46	Q873743	REC8804431	11
b3c1bfa9-0172-48fb-9277-528244948779	46	Q873743	REC8804431	8
9f72497a-3041-49eb-b26d-9482f514cbe4	54	Q660814	REC8804431	2
8f526bba-bc08-4b21-811e-8ee8ca8efb65	46	Q660814	REC8804431	7
cca45ecc-abd5-43c5-95ee-9e418fe3dd79	464	Q660814	REC8804431	11
7c4b9d74-97ab-4121-8bd9-16d3ad723531	56	Q660814	REC8804431	8
7cf2b986-024d-4f75-9e79-f93564a312c8	0	Q764752	REC8804431	2
54319e4f-7b2c-4cd4-b0c0-e206397f0c05	0	Q764752	REC8804431	7
b531fdaa-6cf3-4807-84d8-ee1912e6a09c	5646	Q764752	REC8804431	11
89257cf3-b5c3-4162-b936-5f48cb6654e9	46	Q764752	REC8804431	8
85c384ed-38d0-4947-97bb-739d6c559a5a	0	Q463914	REC8804431	2
48a1281f-6ae6-4cba-a382-0d943c6c1811	2	Q463914	REC8804431	7
8242230a-655f-4659-9530-29518a00d7e9	3	Q463914	REC8804431	11
8b76a873-fa8a-423a-9a15-44517df9dc0a	3	Q463914	REC8804431	8
8468827d-8f37-4e5a-84d5-cd0688356f79	3	Q476426	REC8804431	2
935e8d71-78db-4f31-957f-902b6488b2b4	0	Q476426	REC8804431	7
3e11c09f-7679-4c04-8422-bac7355181ed	0	Q476426	REC8804431	11
8166c1af-bf3f-4a74-a333-2b11541df866	0	Q476426	REC8804431	8
88cced37-1243-4e7d-a9c4-1e4a9ad77eb6	2	Q761053	REC8804431	2
18a2025a-3143-4357-9f54-a015b46347d4	2	Q761053	REC8804431	7
9aeeae28-f8f6-4c22-b737-5cf782b6aadd	0	Q761053	REC8804431	11
f3b9306e-7812-47ff-89ec-5be97844951c	0	Q761053	REC8804431	8
897dc642-01cc-4594-9758-58ab2200fc45	0	Q927912	REC8804431	2
8434b3ec-5b63-4477-97fc-aa9b88cf6be8	0	Q927912	REC8804431	7
ca34eff2-7159-43e2-9c0d-6ca6606d239c	0	Q927912	REC8804431	11
a5facdde-e753-4865-a3ba-ed3563a52140	0	Q927912	REC8804431	8
9be79fac-b701-4588-84c8-f39cded61a8b	0	Q319123	REC8804431	2
4df9f6e1-c7dd-4426-a945-7895a54fb62f	0	Q319123	REC8804431	7
c966d04a-60c3-476d-9378-c63689cea98c	0	Q319123	REC8804431	11
cf4803e3-cbaa-46e2-a409-0ed5c6d4676a	0	Q319123	REC8804431	8
a03ff810-7412-444c-a86d-ccd21881d052	3	Q108933	REC8804431	2
d2f459c5-4330-4ebd-b1ba-760830161944	2	Q108933	REC8804431	7
d017e3a9-e3e4-49a9-930b-f5245dff22e1	0	Q108933	REC8804431	11
d0f23f76-87b3-4393-9bde-2d634a4b5c75	0	Q108933	REC8804431	8
95b501af-2a45-4a96-84bb-89c6e3141ebe	0	Q689360	REC8804431	2
4c2ee099-36c9-4653-bf41-6a56d5d711a9	2	Q689360	REC8804431	7
42e770ee-7b14-4a4f-862a-1527d08be363	0	Q689360	REC8804431	11
bf9303e6-8d38-4eaf-a537-03d3c0de8d17	0	Q689360	REC8804431	8
e93bb52a-ad2c-4349-b97f-6728cff527a3	3	Q465276	REC8804431	2
8f5f13b3-c072-4175-af50-3c9f755e0f90	0	Q465276	REC8804431	7
0fed7199-0d3e-4fda-ae0d-da303af75e8b	0	Q465276	REC8804431	11
5b8e54c0-4ea0-4894-8ea5-d22631c7ca7d	0	Q465276	REC8804431	8
b8dfe482-1ab3-48c5-a5fd-f8c58e7f0515	0	Q241410	REC8804431	2
ead3cb22-30af-4bbc-85e0-0ad70e5edfaa	3	Q241410	REC8804431	7
a0be81f6-e591-45cb-a726-7dfcb899222c	0	Q241410	REC8804431	11
48baa41a-2abb-4701-b6fb-beeb32d1feac	0	Q241410	REC8804431	8
8fb0c05a-b59e-4e00-979c-f32a7c85f31d	0	Q333074	REC8804431	2
0849c5d3-5b85-49c7-96ce-19776a229ea1	2	Q333074	REC8804431	7
ad3099a2-681e-4f88-92ba-59b2aca7f185	0	Q333074	REC8804431	11
acd24b51-31c3-42dd-8a32-4bae1627f70f	0	Q333074	REC8804431	8
676a018b-0ff3-4059-b03d-8a8344a47ea0	3	Q681176	REC8804431	2
a2fd33d5-3f89-4764-b0ad-469412b760ff	2	Q681176	REC8804431	7
656cd173-0341-4707-8c01-f081cb921680	0	Q681176	REC8804431	11
1a0e4d2f-dbea-4de3-bef1-c1e54b01d362	0	Q681176	REC8804431	8
\.


--
-- Data for Name: sd_notification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sd_notification (notif_id, notification_message, date_received, user_id) FROM stdin;
4	\n                New record submission:\n                - Record ID: REC8804431\n                - Submitted by: Justmyr Dimasacat Gutierrez\n            	2024-11-20 06:21:05.182098	SD52421917
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
S426319		Research on poverty	I652006
S361791		Tuition assistance	I326216
S407502		Vouchers for study related expenses	I326216
S243469		Other low income support for students	I326216
S984386		Admission target of low-income students	I900777
S165164		Student support from low-income countries	I900777
S181274		Student support from low-income countries	I900777
S751730		Student Employment	I900777
S110934		Graduation/completion targets of low-income students	I900777
S125925		Low-income student support	I900777
S977658		Local Start-Up Assistance 	I716377
S751490		Local Start-up Financial Assistance	I716377
S604258		Programmes for services access (extension services)	I716377
S358930		Participation in policy addressing poverty	I498244
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

SELECT pg_catalog.setval('public.csd_notification_notif_id_seq', 2, true);


--
-- Name: sd_notification_notif_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sd_notification_notif_id_seq', 4, true);


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

