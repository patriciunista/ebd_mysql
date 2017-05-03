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

    select p.SALA_COD, sum(s.QTAT_LLITS)
    from PLANTILLA p inner join SALA s on s.SALA_COD = p.SALA_COD
    group by p.SALA_COD, s.QTAT_LLITS;

-- Mostrar els hospitals on no hi ha cap doctor de cardiologia.
    select h.HOSPITAL_COD, h.NOM 
    from HOSPITAL h
    where h.HOSPITAL_COD not in (select HOSPITAL_COD from DOCTOR where ESPECIALITAT like "Cardiologia");
