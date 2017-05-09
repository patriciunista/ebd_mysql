"1.Crea el següent esquema amb el nom EMPRESA."

create schema EMPRESA;

create table DEPT
(
    DEPT_NO tinyint(2),
    DNOM varchar(14),
    LOC varchar(14),
    primary key (DEPT_NO)
);

create table EMP
(
    EMP_NO smallint(4),
    COGNOM varchar(10),
    OFICI varchar(10),
    CAP smallint(4),
    DATA_ALTA date,
    SALARI int,
    COMISSIO int,
    DEPT_NO tinyint(2),
    primary key (EMP_NO),
    foreign key (DEPT_NO) references DEPT(DEPT_NO),
    foreign key (CAP) references EMP(EMP_NO)
);

create table CLIENT
(
    CLIENT_COD int(6),
    NOM varchar(45),
    ADRECA varchar(30),
    CIUTAT varchar(50),
    ESTAT varchar(2),
    CODI_POSTAL varchar(9),
    AREA smallint(3),
    TELEFON varchar(9),
    REPR_COD smallint(4),
    LIMIT_CREDIT decimal(9,2),
    OBSERVACIONS text,
    primary key (CLIENT_COD),
    foreign key (REPR_COD) references EMP(EMP_NO)
);

create table COMANDA
(
    COM_NUM smallint(4),
    COM_DATA date,
    COM_TIPUS char(1),
    CLIENT_COD int(6),
    DATA_TRAMESA date,
    TOTAL decimal(8,2),
    primary key (COM_NUM),
    foreign key (CLIENT_COD) references CLIENT(CLIENT_COD)
);

create table PRODUCTE
(
    PROD_NUM int(6),
    DESCRIPCIO varchar(30),
    primary key (PROD_NUM)
);

create table DETALL
(
    COM_NUM smallint(4),
    DETALL_NUM smallint(4),
    PROD_NUM int(6),
    PREU_VENDA decimal(8,2),
    QUANTITAT int(8),
    IMPORT decimal(8,2),
    primary key (COM_NUM, DETALL_NUM),
    foreign key (COM_NUM) references COMANDA(COM_NUM),
    foreign key (PROD_NUM) references PRODUCTE(PROD_NUM)
);

"2.Fes les següents consultes simples sobre l’esquema Empresa:"
-- A.Mostreu els productes (codi i descripció) que comercialitza l'empresa.
    select * 
    from PRODUCTE;
-- B.Mostreu els productes (codi i descripció) que contenen la paraula tennis en la descripció.
    select * 
    from PRODUCTE 
    where descripcio like '%tennis%';
-- C.Mostreu el codi, nom, àrea i telèfon dels clients de l'empresa.
    select CLIENT_COD, NOM, AREA, TELEFON 
    from CLIENT;
-- D.Mostreu els clients (codi, nom, ciutat) que no són de l'àrea telefònica 636.
    select CLIENT_COD, NOM, CIUTAT 
    from CLIENT 
    where AREA not like 636;
-- E.Mostreu les ordres de compra de la taula de comandes (codi, dates d'ordre i de tramesa).
    select COM_NUM, COM_DATA, DATA_TRAMESA 
    from COMANDA;
-- F.Mostreu tots els clients (codi, nom i observacions) que tinguin un crèdit superior a 4.000 i inferior a 8.000 i el nom dels quals contingui alguna S.
    select CLIENT_COD, NOM, OBSERVACIONS 
    from CLIENT 
    where (LIMIT_CREDIT > 4000 
        and LIMIT_CREDIT < 8000) 
        and NOM like '%s%';


"3.Crea a MySQL el següent esquema SANITAT"

create schema SANITAT;

create table HOSPITAL
(
    HOSPITAL_COD tinyint(2),
    NOM varchar(10),
    ADRECA varchar(20),
    TELEFON varchar(8),
    QTAT_LLITS smallint(3),
    primary key (HOSPITAL_COD)
);

create table DOCTOR
(
    HOSPITAL_COD tinyint(2),
    DOCTOR_NO smallint(3),
    COGNOM varchar(13),
    ESPECIALITAT varchar(16),
    primary key (HOSPITAL_COD, DOCTOR_NO),
    foreign key (HOSPITAL_COD) references HOSPITAL(HOSPITAL_COD)
);

create table SALA
(
    HOSPITAL_COD tinyint(2),
    SALA_COD tinyint(2),
    NOM varchar(20),
    QTAT_LLITS smallint(3),
    primary key (HOSPITAL_COD, SALA_COD),
    foreign key (HOSPITAL_COD) references HOSPITAL(HOSPITAL_COD)
);

create table PLANTILLA
(
    HOSPITAL_COD tinyint(2),
    SALA_COD tinyint(2),
    EMPLEAT_NO smallint(4),
    COGNOM varchar(15),
    FUNCIO varchar(10),
    TORN varchar(1),
    SALARI int(10),
    primary key (HOSPITAL_COD, SALA_COD, EMPLEAT_NO),
    foreign key (HOSPITAL_COD, SALA_COD) references SALA(HOSPITAL_COD, SALA_COD)
);

create table MALALT
(
    INSCRIPCIO int(5),
    COGNOM varchar(15),
    ADRECA varchar(20),
    DATA_NAIX date,
    SEXE char(1),
    NSS char(9),
    primary key (INSCRIPCIO)
);

create table INGRESSOS
(
    INSCRIPCIO int(5),
    HOSPITAL_COD tinyint(2),
    SALA_COD tinyint(2),
    LLIT smallint(4),
    primary key (INSCRIPCIO),
    foreign key (HOSPITAL_COD, SALA_COD) references SALA(HOSPITAL_COD, SALA_COD),
    foreign key (INSCRIPCIO) references MALALT(INSCRIPCIO)
);


"4. Realitzeu les següents consultes simples sobre la BBDD SANITAT"
-- Mostreu els hospitals existents (número, nom i telèfon).
    select HOSPITAL_COD, NOM, TELEFON 
    from HOSPITAL;
-- Mostreu els hospitals existents (número, nom i telèfon) que tinguin una lletra A en la segona posició del nom.
    select HOSPITAL_COD, NOM, TELEFON 
    from HOSPITAL where NOM like "_a%";
-- Mostreu els treballadors (codi hospital, codi sala, número empleat i cognom) existents.
    select HOSPITAL_COD, SALA_COD, EMPLEAT_NO, COGNOM 
    from PLANTILLA;
-- Mostreu els treballadors (codi hospital, codi sala, número empleat i cognom) que no siguin del torn de nit.
    select HOSPITAL_COD, SALA_COD, EMPLEAT_NO, COGNOM 
    from PLANTILLA 
    where TORN not like 'N';
-- Mostreu els malalts nascuts l'any 1960.
    select * 
    from MALALT 
    where year(DATA_NAIX) = 1960;
-- Mostreu els malalts nascuts a partir de l'any 1960.
    select *
    from MALALT 
    where year(DATA_NAIX) > 1960;
-- Mostreu una relació de tots els doctors de l'hospital 22.
    select d.DOCTOR_NO, d.COGNOM, d.ESPECIALITAT
    from hospital h inner join doctor d on h.HOSPITAL_COD = d.HOSPITAL_COD 
    where h.HOSPITAL_COD = 22;

"5. A la BBDD Empresa feu les consultes següents:"
-- Mostrar els empleats (codi, cognom i nom del departament) de l'empresa que tenen el rang de director i ordenats pel cognom.
    select e.EMP_NO, e.COGNOM, d.DNOM 
    from EMP e inner join DEPT d 
    where (OFICI like 'DIRECTOR') 
    order by e.COGNOM ASC;
-- Mostrar l'import global que cada departament assumeix anualment en concepte de nòmina dels empleats i ordenat descendentment per l'import global.
    select DEPT_NO, sum(SALARI) 
    from EMP 
    group by DEPT_NO 
    order by sum(SALARI) desc;
-- Mostrar els departaments ordenats ascendentment per l'antiguitat dels empleats.
    select sum(DATA_ALTA), DEPT_NO
    from EMP
    group by DEPT_NO
    order by sum(DATA_ALTA) desc;
-- Mostrar els empleats (codi i cognom) acompanyats del nombre de comandes que han gestionat, ordenats pel cognom.
    select e.EMP_NO, e.COGNOM, count(com.COM_NUM) as 'NUMERO COMANDES'
    from EMP e inner join CLIENT c on e.EMP_NO = c.REPR_COD inner join COMANDA com on com.CLIENT_COD = c.CLIENT_COD
    group by e.EMP_NO
    order by e.COGNOM asc;
-- Mostrar el rànquing dels empleats (codi i cognom), segons el nombre de comandes que han gestionat, que n'hagin gestionat més de cinc.
    select e.EMP_NO, e.COGNOM, count(com.COM_NUM) as 'NUMERO COMANDES'
    from EMP e inner join CLIENT c on e.EMP_NO = c.REPR_COD inner join COMANDA com on com.CLIENT_COD = c.CLIENT_COD
    group by e.EMP_NO 
    having count(com.COM_NUM) > 5
    order by 3 desc;

"6. A la BBDD SANITAT feu les següents consultes: (alguna consulta potser necessita subconsulta)"
-- Mostrar, per cada sala, la quantitat de malalts de cada sexe.
    select s.NOM, m.SEXE, count(m.INSCRIPCIO) as 'Num malalts'
    from MALALT m inner join INGRESSOS i on i.INSCRIPCIO = m.INSCRIPCIO inner join SALA s on s.SALA_COD = i.SALA_COD
    group by s.SALA_COD, m.SEXE, s.NOM;
-- Mostrar els malalts del sistema hospitalari no ingressats en l'actualitat.
    select m.INSCRIPCIO, m.ADRECA, m.COGNOM, m.DATA_NAIX, m.NSS
    from MALALT m left join INGRESSOS i on i.INSCRIPCIO = m.INSCRIPCIO
    where i.inscripcio is null;
    
-- Mostrar el rànquing d'hospitals segons la proporció de llits per treballador.
    (h.sales) count(sales.llits) / treb.hosp

    

-- Mostrar els hospitals on no hi ha cap doctor de cardiologia.
    select h.HOSPITAL_COD, h.NOM 
    from HOSPITAL h
    where h.HOSPITAL_COD not in (select HOSPITAL_COD from DOCTOR where ESPECIALITAT like "Cardiologia");




"--- Exercici consultes general ---"

"1. Esquema: EBD_GENERAL"

create table DEPARTAMENTS (
    NUM_DPT INT,
    NOM CHAR(20), 
    PLANTA INT, 
    EDIFICI CHAR(30),
    CIUTAT_DPT CHAR(20),
    primary key (NUM_DPT)
);

create table PROJECTES (
    NUM_PROJ INT, 
    NOM_PROJ CHAR(10),
    PRODUCTE CHAR(20),
    PRESSUPOST INT,
    primary key (NUM_PROJ)
);

create table EMPLEATS (
    NUM_EMPL INT,
    NOM_EMPL CHAR(30),
    SOU INT,
    CIUTAT_EMPL CHAR(20),
    NUM_DPT INT,
    NUM_PROJ INT,
    primary key (NUM_EMPL),
    foreign key (NUM_DPT) references DEPARTAMENTS(NUM_DPT),
    foreign key (NUM_PROJ) references PROJECTES(NUM_PROJ)
);

"2. Inserts"
-- DEPARTAMENTS
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (1, "DIRECCIO", 10, "PAU CLARIS", "BARCELONA");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (2, "DIRECCIO", 8, "RIOS ROSAS", "MADRID");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (3, "MARKETING", 1, "PAU CLARIS", "BARCELONA");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (4, "MARKETING", 3, "RIOS ROSAS", "MADRID");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (5, "VENDES", 1, "MUNTANER", "BARCELONA");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (6, "VENDES", 1, "CASTELLANA", "MADRID");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (7, "VENDES", 3, "BLASCO IBAÑEZ", "VALENCIA");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (8, "VENDES", 1, "DE LA SIERPES", "SEVILLA");
insert into DEPARTAMENTS(NUM_DPT, NOM, PLANTA, EDIFICI, CIUTAT_DPT) values (9, "ADMINISTRACIO", 7, "MUNTANER", "BARCELONA");


-- PROJECTES
insert into PROJECTES(NUM_PROJ, NOM_PROJ, PRODUCTE, PRESSUPOST) values (1, "BDTEL", "TELEVISIO", 60000);
insert into PROJECTES(NUM_PROJ, NOM_PROJ, PRODUCTE, PRESSUPOST) values (2, "BDVID", "VIDEO", 30000);
insert into PROJECTES(NUM_PROJ, NOM_PROJ, PRODUCTE, PRESSUPOST) values (3, "BDTEF", "TELEFON", 12000);
insert into PROJECTES(NUM_PROJ, NOM_PROJ, PRODUCTE, PRESSUPOST) values (4, "BDCOM", "BLUE RAY", 120000);


-- EMPLEATS
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (1, "CARME", 2400, "MATARO", 1, 1);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (2, "EUGENIA", 2100, "TOLEDO", 2, 2);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (3, "JOSEP", 1500, "SITGES", 3, 1);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (4, "RICARDO", 1500, "MADRID", 4, 2);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (5, "EULALIA", 900, "BARCELONA", 5, 1);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (6, "MIQUEL", 750, "BADALONA", 5, 1);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (7, "MARIA", 1000, "MADRID", 6, 2);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (8, "ESTEBAN", 900, "MADRID", 6, 2);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (9, "LAURA", 750, "VALENCIA", 7, 3);
insert into EMPLEATS(NUM_EMPL, NOM_EMPL, SOU, CIUTAT_EMPL, NUM_DPT, NUM_PROJ) values (10, "ANTONIO", 900, "SEVILLA", 8, 3);



"3. Realitzar les seguents consultes"

-- Obtenir el nom i el sou dels empleats amb num_dpt 1, 2 o 3 
    select e.NOM_EMPL, e.SOU
    from EMPLEATS e
    where e.NUM_DPT in (1, 2, 3);
-- Obtenir els noms dels empleats del departament núm 5 i l’edifici on treballen 
    select e.NOM_EMPL, d.EDIFICI
    from EMPLEATS e inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where e.NUM_DPT = 5;
-- Obtenir els números i els noms dels departaments situats a Madrid, que tenen empleats que guanyen més de 1200€ 
    select d.NUM_DPT, d.NOM
    from EMPLEATS e left join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where e.SOU > 1200 && d.CIUTAT_DPT like "MADRID";
-- Obtenir per ordre alfabètic descendent els noms dels empleats que guanyen més de 1200€
    select e.NOM_EMPL
    from EMPLEATS e
    where e.SOU > 1200
    order by e.NOM_EMPL DESC;
-- Obtenir per cada departament quin és el sou més gran. Concretament, cal llistar el número de departament i el sou més gran.
    select d.NUM_DPT, max(e.SOU) as 'SOU MES GRAN'
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by d.NUM_DPT;
-- Obtenir tots els números i els noms dels empleats que no són del departament número 1 i que treballen a Barcelona.
    select e.NUM_EMPL, e.NOM_EMPL
    from EMPLEATS e inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where e.NUM_DPT != 1 && d.CIUTAT_DPT like "BARCELONA";
-- Obtenir quantes persones dels diferents departaments treballen a la ciutat de Madrid
    select d.NUM_DPT, d.NOM, count(e.NUM_EMPL) as 'NUM EMPLEATS'
    from EMPLEATS e inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where d.CIUTAT_DPT like "MADRID"
    group by d.NUM_DPT;
-- Obtenir els noms dels empleats que guanyen més que l’empleat número 3.
    select e.NOM_EMPL
    from EMPLEATS e
    where e.SOU > 
    (
        select emp.SOU
        from EMPLEATS emp
        where emp.NUM_EMPL = 3
    );
-- Obtenir el nom dels empleats que guanyen el sou més alt.
    select e.NOM_EMPL
    from EMPLEATS e
    where e.SOU = 
    (
        select max(emp.SOU)
        from EMPLEATS emp
    );
-- Obtenir els números i els noms dels projectes que no tenen cap empleat assignat.
    select p.NUM_PROJ, p.NOM_PROJ
    from PROJECTES p
    where p.NUM_PROJ not in 
    (
        select distinct e.NUM_PROJ
        from EMPLEATS e
    );
-- Obtenir els noms dels departaments que tenen empleats que treballen al projecte BDTEL.
    select d.NUM_DPT, d.NOM 
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where e.NUM_PROJ = 
    (
        select p.NUM_PROJ
        from PROJECTES p
        where p.NOM_PROJ like "BDTEL"
    );
-- Obtenir els noms dels empleats que no treballen en el projecte número 2
    select e.NOM_EMPL
    from EMPLEATS e inner join PROJECTES p on e.NUM_PROJ = p.NUM_PROJ
    where e.NUM_PROJ != 2;
-- Obtenir els números i els noms dels departaments que tenen 2 o més empleats en el projecte 1.
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where e.NUM_PROJ = 1
    group by d.NUM_DPT
    having count(e.NUM_EMPL) >= 2;
-- Obtenir els números i els noms dels projectes que tenen assignats més de 2 empleats
    select p.NUM_PROJ, p.NOM_PROJ
    from PROJECTES p inner join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ
    group by p.NUM_PROJ
    having count(e.NUM_EMPL) > 2;
-- Obtenir els productes que tenen assignats els empleats del departament número 1.
    select p.PRODUCTE
    from PROJECTES p inner join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ
    where e.NUM_DPT = 1;
-- Obtenir el nom del departament on treballa i el nom del projecte on està assignat l’empleat número 2.
    select d.NOM, p.NOM_PROJ
    from (EMPLEATS e left join PROJECTES p on e.NUM_PROJ = p.NUM_PROJ) inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where e.NUM_EMPL = 2;
-- Obtenir el número i el nom dels empleats que viuen a la mateixa ciutat on està situat el departament on treballen 
    select e.NUM_EMPL, e.NOM_EMPL
    from EMPLEATS e inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    where e.CIUTAT_EMPL like d.CIUTAT_DPT;
-- Obtenir per cada projecte que tingui més d’un empleat treballant en el mateix edifici,  el número i nom del projecte i el nom de l’edifici.
    select p.NUM_PROJ, p.NOM_PROJ, d.EDIFICI
    from (PROJECTES p left join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ) inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
    group by p.NUM_PROJ, d.EDIFICI
    having count(e.NUM_EMPL) > 1;
-- Obtenir els projectes amb un pressupost més petit que el pressupostat del projecte número 1. Concretament, es demana el número i el nom dels projecte i el sou promig dels empleats que hi estan assignats. 
    select p.NUM_PROJ, p.NOM_PROJ, avg(e.SOU)
    from PROJECTES p left join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ
    where p.PRESSUPOST < (
        select p.PRESSUPOST
        from PROJECTES p
        where p.NUM_PROJ = 1;
    )
    group by p.NUM_PROJ;
-- Obtenir el número i el nom dels projecte que tenen un pressupost més petit de 36000€ i que tots els empleats que hi estan assignats tenen un sou superior o igual a 1200€ 
    select p.NUM_PROJ, p.NOM_PROJ
    from PROJECTES p inner join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ
    where p.PRESSUPOST > 36000
    group by e.SOU
    having e.SOU >= 1200;
-- Obtenir els noms de les ciutats on hi viuen empleats però no hi ha cap departament. 
    select distinct e.CIUTAT_EMPL
    from EMPLEATS e
    where e.CIUTAT_EMPL not in (
        select d.CIUTAT_DPT
        from DEPARTAMENTS d
    );
-- Obtenir els departaments que tenen més empleats que el departament número 1. Concretament, es demana el número i el nom d’aquests departaments.
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by d.NUM_DPT, d.NOM
    having count(e.NUM_EMPL) > (
        select count(e.NUM_EMPL)
        from EMPLEATS e inner join DEPARTAMENTS d on e.NUM_DPT = d.NUM_DPT
        where d.NUM_DPT = 1;
    );
-- Obtenir els departaments que no tenen cap empleat assignat i que estan situats a la ciutat de Barcelona. Concretament, es demana el número i el nom d’aquests departaments. 
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d left join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where d.CIUTAT_DPT like "Barcelona"
    group by d.NUM_DPT, d.NOM
    having count(e.NUM_EMPL) < 1;
-- Obtenir els projectes que tenen assignats més de dos empleats de la mateixa ciutat. Concretament, es demana el número, el nom i el pressupost d’aquests projectes. 
    select p.NUM_PROJ, p.NOM_PROJ, p.PRESSUPOST
    from PROJECTES p inner join EMPLEATS e on p.NUM_PROJ = e.NUM_PROJ
    group by e.NUM_PROJ, e.CIUTAT_EMPL
    having count(e.NUM_EMPL) > 2;
-- Obtenir el número, el nom i el sou dels empleats que tenen un sou més alt que el màxim dels sous dels empleats que tenen el número de departament més alt de la relació empleats. 
    /*********************************************/
    select e.NUM_EMPL, e.NOM_EMPL, e.SOU
    from EMPLEATS e
    group by e.NUM_DPT, e.NUM_EMPL
    having e.SOU > ();
    /*********************************************/
-- Obtenir les dades de tots els empleats completada amb les dades del projecte al que estan assignats. 
    select *
    from EMPLEATS e inner join PROJECTES p on e.NUM_PROJ = p.NUM_PROJ;
-- Obtenir els empleats que viuen a MADRID, que tenen un sou superior o igual a 1000€ i que estan assignats a un projecte que no és el projecte BDTEL. Es vol totes les dades dels empleats completada amb les dades del projecte al que estan assignats. 
    select *
    from EMPLEATS e inner join PROJECTES p on e.NUM_PROJ = p.NUM_PROJ
    where (e.CIUTAT_EMPL like "Madrid") 
        and (e.SOU >= 1000)
        and (e.NUM_PROJ != (
                select p.NUM_PROJ
                from PROJECTES p
                where p.NOM_PROJ like "BDTEL"
            )
        );
-- Obtenir el número i nom dels departaments que tenen algun empleat que viu a MADRID 
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where e.CIUTAT_EMPL like "Madrid";
-- Obtenir el número i nom dels departaments que tenen més de 5 empleats que viuen a MADRID 
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by d.NUM_DPT
    having count(e.CIUTAT_EMPL) > 5;
-- Obtenir els departaments que tenen algun empleat que viu a MADRID. Concretament es demana el número i el nom dels departaments i el sou promig dels empleats que hi treballen. 
    select d.NUM_DPT, d.NOM, avg(e.SOU)
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where e.CIUTAT_EMPL like "Madrid"
    group by d.NUM_DPT;
-- Obtenir el número i nom dels departaments que tenen dos o més empleats que viuen a una mateixa ciutat. 
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by d.NUM_DPT, e.CIUTAT_EMPL
    having count(e.CIUTAT_EMPL) >= 2;
-- Obtenir el número i nom dels departaments que tenen dos o més empleats que viuen a ciutat diferents. 
    select distinct d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by d.NUM_DPT, e.CIUTAT_EMPL
    having count(e.CIUTAT_EMPL) < 2;
-- Obtenir el número i nom dels departaments que no tenen cap empleat que visqui a Madrid 
    /*** Per la BBDD que tenim, aquesta consulta funciona, pero em sembla que no funcionaria si hi hagues un empleat de diferent ciutat en un mateix departament ***/
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where e.CIUTAT_EMPL not like "Madrid"
    group by d.NUM_DPT;
    /*** Per aixo, he fet aquesta altra consulta, que aparentment dona el mateix resultat ***/
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    where d.NUM_DPT not in (
        select e.NUM_DPT
        from EMPLEATS e
        where e.CIUTAT_EMPL like "Madrid"
    )
    group by d.NUM_DPT;
-- Obtenir el número i nom dels departaments tals que tots els seus empleats viuen a MADRID. El resultat no ha d’incloure aquells departaments que no tenen cap empleat. 
    select d.NUM_DPT, d.NOM
    from DEPARTAMENTS d inner join EMPLEATS e on d.NUM_DPT = e.NUM_DPT
    group by e.NUM_DPT, e.CIUTAT_EMPL
    having (count(e.NUM_DPT) = count(e.CIUTAT_EMPL))
        and (e.CIUTAT_EMPL like "Madrid");
-- Incrementar en 3000€ el pressupost dels projectes que tenen algun empleat que treballa a Barcelona. 

-- Incrementar en 30000€ el pressupost dels projectes que tenen 5 o més empleats que treballen a Barcelona. 

-- Incrementar en 30000€ el pressupost dels projectes que no tenen cap empleat que treballa a Barcelona 

-- Incrementar en 30000 el pressupost dels projectes tals que tots els seus empleats treballen a Barcelona. No es vol incrementar el pressupost d’aquells projectes que no tenen cap empleat. 

-- Esborrar els empleats que estan assignats als departaments situats a l’edifici Pau Claris de Barcelona. 

-- Esborrar els departaments que no tenen cap empleat.


create table DEPARTAMENTS (
    NUM_DPT INT,
    NOM CHAR(20), 
    PLANTA INT, 
    EDIFICI CHAR(30),
    CIUTAT_DPT CHAR(20),
    primary key (NUM_DPT)
);

create table PROJECTES (
    NUM_PROJ INT, 
    NOM_PROJ CHAR(10),
    PRODUCTE CHAR(20),
    PRESSUPOST INT,
    primary key (NUM_PROJ)
);

create table EMPLEATS (
    NUM_EMPL INT,
    NOM_EMPL CHAR(30),
    SOU INT,
    CIUTAT_EMPL CHAR(20),
    NUM_DPT INT,
    NUM_PROJ INT,
    primary key (NUM_EMPL),
    foreign key (NUM_DPT) references DEPARTAMENTS(NUM_DPT),
    foreign key (NUM_PROJ) references PROJECTES(NUM_PROJ)
);









