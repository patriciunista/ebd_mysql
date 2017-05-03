create table DEPT
(
    DEPT_NO tinyint(2),
    DNOM varchar(14),
    LOC varchar(14),
    PRIMARY KEY(DEPT_NO)
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
    PRIMARY KEY(EMP_NO),
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
    PRIMARY KEY(CLIENT_COD),
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
    PRIMARY KEY(COM_NUM),
    foreign key (CLIENT_COD) references CLIENT(CLIENT_COD)
);

create table PRODUCTE
(
    PROD_NUM int(6),
    DESCRIPCIO varchar(30),
    PRIMARY KEY(PROD_NUM)
);

create table DETALL
(
    COM_NUM smallint(4),
    DETALL_NUM smallint(4),
    PROD_NUM int(6),
    PREU_VENDA decimal(8,2),
    QUANTITAT int(8),
    IMPORT decimal(8,2),
    PRIMARY KEY(COM_NUM, DETALL_NUM),
    foreign key (COM_NUM) references COMANDA(COM_NUM),
    foreign key (PROD_NUM) references PRODUCTE(PROD_NUM)
);