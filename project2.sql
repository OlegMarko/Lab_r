--
-- PostgreSQL database dump
--

-- Dumped from database version 9.4.5
-- Dumped by pg_dump version 9.4.5
-- Started on 2015-12-11 09:14:20

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

DROP DATABASE db_project;
--
-- TOC entry 2073 (class 1262 OID 16407)
-- Name: db_project; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE db_project WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';


ALTER DATABASE db_project OWNER TO postgres;

\connect db_project

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 2074 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 186 (class 3079 OID 11855)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2076 (class 0 OID 0)
-- Dependencies: 186
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 172 (class 1259 OID 16410)
-- Name: db_ faculty; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE "db_ faculty" (
    name_faculty character varying(255),
    id integer NOT NULL
);


ALTER TABLE "db_ faculty" OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 73858)
-- Name: db_ faculty_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE "db_ faculty_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "db_ faculty_id_seq" OWNER TO postgres;

--
-- TOC entry 2077 (class 0 OID 0)
-- Dependencies: 185
-- Name: db_ faculty_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE "db_ faculty_id_seq" OWNED BY "db_ faculty".id;


--
-- TOC entry 182 (class 1259 OID 16440)
-- Name: db_courses_projects; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_courses_projects (
    id integer NOT NULL,
    topic character varying(255),
    symestr smallint,
    id_student integer,
    id_discipline integer
);


ALTER TABLE db_courses_projects OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16438)
-- Name: db_courses_projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_courses_projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_courses_projects_id_seq OWNER TO postgres;

--
-- TOC entry 2078 (class 0 OID 0)
-- Dependencies: 181
-- Name: db_courses_projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_courses_projects_id_seq OWNED BY db_courses_projects.id;


--
-- TOC entry 178 (class 1259 OID 16428)
-- Name: db_department; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_department (
    id integer NOT NULL,
    name_department character varying(255),
    id_faculty integer
);


ALTER TABLE db_department OWNER TO postgres;

--
-- TOC entry 177 (class 1259 OID 16426)
-- Name: db_department_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_department_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_department_id_seq OWNER TO postgres;

--
-- TOC entry 2079 (class 0 OID 0)
-- Dependencies: 177
-- Name: db_department_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_department_id_seq OWNED BY db_department.id;


--
-- TOC entry 180 (class 1259 OID 16434)
-- Name: db_discipline; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_discipline (
    id integer NOT NULL,
    name_discipline character varying(255),
    id_teacher integer,
    id_department integer
);


ALTER TABLE db_discipline OWNER TO postgres;

--
-- TOC entry 179 (class 1259 OID 16432)
-- Name: db_discipline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_discipline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_discipline_id_seq OWNER TO postgres;

--
-- TOC entry 2080 (class 0 OID 0)
-- Dependencies: 179
-- Name: db_discipline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_discipline_id_seq OWNED BY db_discipline.id;


--
-- TOC entry 176 (class 1259 OID 16422)
-- Name: db_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_group (
    id integer NOT NULL,
    name_group character varying(255),
    small_name_group character varying(10),
    id_faculty integer
);


ALTER TABLE db_group OWNER TO postgres;

--
-- TOC entry 175 (class 1259 OID 16420)
-- Name: db_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_group_id_seq OWNER TO postgres;

--
-- TOC entry 2081 (class 0 OID 0)
-- Dependencies: 175
-- Name: db_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_group_id_seq OWNED BY db_group.id;


--
-- TOC entry 184 (class 1259 OID 16446)
-- Name: db_student; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_student (
    id integer NOT NULL,
    name_student character varying(55),
    surname_student character varying(55),
    id_group integer
);


ALTER TABLE db_student OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 16444)
-- Name: db_student_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_student_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_student_id_seq OWNER TO postgres;

--
-- TOC entry 2082 (class 0 OID 0)
-- Dependencies: 183
-- Name: db_student_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_student_id_seq OWNED BY db_student.id;


--
-- TOC entry 174 (class 1259 OID 16416)
-- Name: db_teacher; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE db_teacher (
    id integer NOT NULL,
    surname_teacher character varying(55),
    name_teacher character varying(55),
    id_department integer
);


ALTER TABLE db_teacher OWNER TO postgres;

--
-- TOC entry 173 (class 1259 OID 16414)
-- Name: db_teacher_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE db_teacher_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE db_teacher_id_seq OWNER TO postgres;

--
-- TOC entry 2083 (class 0 OID 0)
-- Dependencies: 173
-- Name: db_teacher_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE db_teacher_id_seq OWNED BY db_teacher.id;


--
-- TOC entry 1917 (class 2604 OID 73860)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "db_ faculty" ALTER COLUMN id SET DEFAULT nextval('"db_ faculty_id_seq"'::regclass);


--
-- TOC entry 1922 (class 2604 OID 16443)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_courses_projects ALTER COLUMN id SET DEFAULT nextval('db_courses_projects_id_seq'::regclass);


--
-- TOC entry 1920 (class 2604 OID 16431)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_department ALTER COLUMN id SET DEFAULT nextval('db_department_id_seq'::regclass);


--
-- TOC entry 1921 (class 2604 OID 16437)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_discipline ALTER COLUMN id SET DEFAULT nextval('db_discipline_id_seq'::regclass);


--
-- TOC entry 1919 (class 2604 OID 16425)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_group ALTER COLUMN id SET DEFAULT nextval('db_group_id_seq'::regclass);


--
-- TOC entry 1923 (class 2604 OID 16449)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_student ALTER COLUMN id SET DEFAULT nextval('db_student_id_seq'::regclass);


--
-- TOC entry 1918 (class 2604 OID 16419)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_teacher ALTER COLUMN id SET DEFAULT nextval('db_teacher_id_seq'::regclass);


--
-- TOC entry 2055 (class 0 OID 16410)
-- Dependencies: 172
-- Data for Name: db_ faculty; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('математики та інформатики', 1);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('інозених мов', 2);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('філософії', 3);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('фізичного виховання та спорту', 4);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('фізико-технічний', 5);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('економічний', 6);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('юридичний', 7);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('мистецтв', 8);
INSERT INTO "db_ faculty" (name_faculty, id) VALUES ('природничих наук', 9);


--
-- TOC entry 2084 (class 0 OID 0)
-- Dependencies: 185
-- Name: db_ faculty_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"db_ faculty_id_seq"', 9, true);


--
-- TOC entry 2065 (class 0 OID 16440)
-- Dependencies: 182
-- Data for Name: db_courses_projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_courses_projects (id, topic, symestr, id_student, id_discipline) VALUES (1, 'Метод прогонки та його модифікації', 1, 1, 1);
INSERT INTO db_courses_projects (id, topic, symestr, id_student, id_discipline) VALUES (2, 'Різницеві формули', 7, 3, 3);
INSERT INTO db_courses_projects (id, topic, symestr, id_student, id_discipline) VALUES (3, 'Метод ****', 8, 7, 5);
INSERT INTO db_courses_projects (id, topic, symestr, id_student, id_discipline) VALUES (4, 'Наближене обчислення елементарних ф-й', 6, 7, 2);


--
-- TOC entry 2085 (class 0 OID 0)
-- Dependencies: 181
-- Name: db_courses_projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_courses_projects_id_seq', 4, true);


--
-- TOC entry 2061 (class 0 OID 16428)
-- Dependencies: 178
-- Data for Name: db_department; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_department (id, name_department, id_faculty) VALUES (1, 'диференціальних рівнянь та прикладної математики', 1);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (3, 'математичного та функціонального аналізу', 1);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (2, 'інформаційних технологій', 1);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (4, 'алгебри та геометрії', 1);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (5, 'Кафедра фізики і хімії твердого тіла', 5);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (6, 'Кафедра комп''ютерної інженерії та електроніки', 5);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (8, 'Кафедра теоретичеої та експерементальної фізики', 5);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (7, 'Кафедра матеріалознавства і новітніх технологій', 5);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (9, 'інформатики', 1);
INSERT INTO db_department (id, name_department, id_faculty) VALUES (10, 'статистики та вищої математики', 1);


--
-- TOC entry 2086 (class 0 OID 0)
-- Dependencies: 177
-- Name: db_department_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_department_id_seq', 10, true);


--
-- TOC entry 2063 (class 0 OID 16434)
-- Dependencies: 180
-- Data for Name: db_discipline; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (1, 'Числові методи', 1, 1);
INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (3, 'МОіДО', 2, 1);
INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (2, 'Бази даних', 4, 4);
INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (4, 'СМПР', 3, 1);
INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (5, 'Зонна теорія твердих тіл', 8, 6);
INSERT INTO db_discipline (id, name_discipline, id_teacher, id_department) VALUES (6, 'Теорія симетрії твердих тіл', 8, 8);


--
-- TOC entry 2087 (class 0 OID 0)
-- Dependencies: 179
-- Name: db_discipline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_discipline_id_seq', 6, true);


--
-- TOC entry 2059 (class 0 OID 16422)
-- Dependencies: 176
-- Data for Name: db_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (1, 'Прикладна математика 4 курс', 'ПМ-4', 1);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (2, ' Математика 4 курс', 'М-4', 1);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (3, 'Статистика 4 курс', 'С-4', 1);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (4, 'Програмна інженерія 1 курс', 'ПІ-4', 1);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (5, 'Інформатика 4 курс 1 група', 'І-41', 1);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (6, 'Фізика 4 курс', 'Ф-4', 5);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (7, 'Комп''ютерна інженерія 4 курс', 'КІ-4', 5);
INSERT INTO db_group (id, name_group, small_name_group, id_faculty) VALUES (8, 'Прикладна фізика 4 курс', 'ПФ-4', 5);


--
-- TOC entry 2088 (class 0 OID 0)
-- Dependencies: 175
-- Name: db_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_group_id_seq', 8, true);


--
-- TOC entry 2067 (class 0 OID 16446)
-- Dependencies: 184
-- Data for Name: db_student; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (1, 'Марта', 'Авраменко', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (2, 'Василь', 'Бедрій', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (3, 'Мар''яна', 'Винник', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (4, 'Вікторія', 'Годованець', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (5, 'Ганна', 'Громадюк', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (6, 'Андрій', 'Данильців', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (7, 'Світлана', 'Доліновська', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (8, 'Роман', 'Заруба', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (9, 'Роксолана', 'Захарук', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (10, 'Оксана', 'Зварич', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (11, 'Христина', 'Лєвічєва', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (12, 'Богдана', 'Малярчук', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (13, 'Олег', 'Марко', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (14, 'Андрій', 'Сергенюк', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (15, 'Соломія', 'Синиця', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (16, 'Руслан', 'Тимків', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (17, 'Ольга', 'Тужеляк', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (18, 'Діана', 'Христан', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (19, 'Валентин', 'Чистяков', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (20, 'Іван', 'Шпачинський', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (21, 'Наталя', 'Цибух', 1);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (22, 'Христина', 'Мамалига', 3);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (24, 'Максим', 'Винник', 2);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (26, 'Назарій', 'Сметанюк', 2);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (23, 'Іван', 'Мельник', 5);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (25, 'Наталія', 'Савчак', 5);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (27, 'Роман', 'Кондрат', 5);
INSERT INTO db_student (id, name_student, surname_student, id_group) VALUES (28, 'Василь', 'Шутак', 3);


--
-- TOC entry 2089 (class 0 OID 0)
-- Dependencies: 183
-- Name: db_student_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_student_id_seq', 28, true);


--
-- TOC entry 2057 (class 0 OID 16416)
-- Dependencies: 174
-- Data for Name: db_teacher; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (1, 'Василишин', 'П. Б.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (2, 'Мазуренко', 'В. В.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (3, 'Костишин', 'Л. П.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (5, 'Соломко', 'А. В.', 3);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (6, 'Дрінь', 'Б. М.', 2);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (7, 'Шевчук', 'Р. В.', 10);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (8, 'Фреїк', 'Д. М.', 5);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (9, 'Пилипів', 'В. М.', 4);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (10, 'Заторський', 'Р. І.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (11, 'Артемович', 'О. Д.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (12, 'Мазуренко', 'Н. І.', 4);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (13, 'Глушак', 'І. Д.', 4);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (14, 'Казмерчук', 'А. І.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (15, 'Махней', 'О. В.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (16, 'Шопа', 'Т. В.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (17, 'Петришин', 'Л. Б.', 1);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (18, 'Ровінський', 'В. А.', 9);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (19, 'Горєлов', 'В. О.', 9);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (20, 'Семаньків', 'М. В.', 10);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (21, 'Філевич', 'П. В.', 3);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (22, 'Малицька', 'Г. П.', 3);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (23, 'Федак', 'І. В.', 3);
INSERT INTO db_teacher (id, surname_teacher, name_teacher, id_department) VALUES (4, 'Козич', 'О. В.', 2);


--
-- TOC entry 2090 (class 0 OID 0)
-- Dependencies: 173
-- Name: db_teacher_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('db_teacher_id_seq', 23, true);


--
-- TOC entry 1925 (class 2606 OID 73865)
-- Name: db_ faculty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY "db_ faculty"
    ADD CONSTRAINT "db_ faculty_pkey" PRIMARY KEY (id);


--
-- TOC entry 1935 (class 2606 OID 16455)
-- Name: db_courses_projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_courses_projects
    ADD CONSTRAINT db_courses_projects_pkey PRIMARY KEY (id);


--
-- TOC entry 1931 (class 2606 OID 16453)
-- Name: db_department_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_department
    ADD CONSTRAINT db_department_pkey PRIMARY KEY (id);


--
-- TOC entry 1933 (class 2606 OID 16457)
-- Name: db_discipline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_discipline
    ADD CONSTRAINT db_discipline_pkey PRIMARY KEY (id);


--
-- TOC entry 1929 (class 2606 OID 16459)
-- Name: db_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_group
    ADD CONSTRAINT db_group_pkey PRIMARY KEY (id);


--
-- TOC entry 1937 (class 2606 OID 16461)
-- Name: db_student_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_student
    ADD CONSTRAINT db_student_pkey PRIMARY KEY (id);


--
-- TOC entry 1927 (class 2606 OID 16463)
-- Name: db_teacher_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY db_teacher
    ADD CONSTRAINT db_teacher_pkey PRIMARY KEY (id);


--
-- TOC entry 1944 (class 2606 OID 74018)
-- Name: db_courses_projects_id_discipline_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_courses_projects
    ADD CONSTRAINT db_courses_projects_id_discipline_fkey FOREIGN KEY (id_discipline) REFERENCES db_discipline(id);


--
-- TOC entry 1943 (class 2606 OID 73986)
-- Name: db_courses_projects_id_student_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_courses_projects
    ADD CONSTRAINT db_courses_projects_id_student_fkey FOREIGN KEY (id_student) REFERENCES db_student(id);


--
-- TOC entry 1940 (class 2606 OID 74003)
-- Name: db_department_id_faculty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_department
    ADD CONSTRAINT db_department_id_faculty_fkey FOREIGN KEY (id_faculty) REFERENCES "db_ faculty"(id);


--
-- TOC entry 1942 (class 2606 OID 74013)
-- Name: db_discipline_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_discipline
    ADD CONSTRAINT db_discipline_id_department_fkey FOREIGN KEY (id_department) REFERENCES db_department(id);


--
-- TOC entry 1941 (class 2606 OID 73955)
-- Name: db_discipline_id_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_discipline
    ADD CONSTRAINT db_discipline_id_teacher_fkey FOREIGN KEY (id_teacher) REFERENCES db_teacher(id);


--
-- TOC entry 1939 (class 2606 OID 74008)
-- Name: db_group_id_faculty_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_group
    ADD CONSTRAINT db_group_id_faculty_fkey FOREIGN KEY (id_faculty) REFERENCES "db_ faculty"(id);


--
-- TOC entry 1945 (class 2606 OID 73960)
-- Name: db_student_id_group_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_student
    ADD CONSTRAINT db_student_id_group_fkey FOREIGN KEY (id_group) REFERENCES db_group(id);


--
-- TOC entry 1938 (class 2606 OID 73970)
-- Name: db_teacher_id_department_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY db_teacher
    ADD CONSTRAINT db_teacher_id_department_fkey FOREIGN KEY (id_department) REFERENCES db_department(id);


--
-- TOC entry 2075 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2015-12-11 09:14:22

--
-- PostgreSQL database dump complete
--

