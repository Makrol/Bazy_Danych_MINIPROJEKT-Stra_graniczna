CREATE TABLE RODZAJ_UZBROJENIA(
    id_rodzaju NUMERIC(5,0) PRIMARY KEY,
    nazwa VARCHAR2(30) NOT NULL,
    opis VARCHAR2(100) NOT NULL
);
CREATE TABLE ADRESY(
    id_adresu NUMERIC(5,0) PRIMARY KEY,
    miasto  VARCHAR2(20) NOT NULL,
    ulica VARCHAR2(20) NOT NULL,
    nr_budynku NUMERIC(5,0) NOT NULL,
    nr_mieszkania NUMERIC(5,0),
    poczta VARCHAR2(20) NOT NULL,
    kod_pocztowy VARCHAR2(6) NOT NULL
);
CREATE TABLE OSOBY(
    id_osoby NUMERIC(5,0) PRIMARY KEY,
    imie VARCHAR2(20) NOT NULL,
    nazwisko VARCHAR2(20) NOT NULL,
    pesel VARCHAR2(20) NOT NULL UNIQUE,
    data_urodzenia DATE NOT NULL,
    id_adresu NUMERIC(5,0),
    CONSTRAINT os_adres_fk FOREIGN KEY (id_adresu) REFERENCES ADRESY(id_adresu)
);
CREATE TABLE JEDNOSTKI_ORGANIZACYJNE(
    id_jednostki NUMERIC(5,0) PRIMARY KEY,
    nazwa  VARCHAR2(30) NOT NULL,
    id_adresu NUMERIC(5,0),
    CONSTRAINT jedn_adres_fk FOREIGN KEY (id_adresu) REFERENCES ADRESY(id_adresu)
);
CREATE TABLE PRACOWNICY(
    id_pracownika NUMERIC(5,0) PRIMARY KEY,
    pensja NUMERIC(7,2) CHECK (pensja>2000),
    stanowisko VARCHAR2(20) NOT NULL,
    stopien VARCHAR2(20) NOT NULL,
    id_osoby NUMERIC(5,0),
    id_jednostki NUMERIC(5,0),
    CONSTRAINT prac_osoba_fk FOREIGN KEY (id_osoby) REFERENCES OSOBY(id_osoby),
    CONSTRAINT prac_jednostka_fk FOREIGN KEY (id_jednostki) REFERENCES JEDNOSTKI_ORGANIZACYJNE(id_jednostki) 
);
CREATE TABLE POSZUKIWANI(
    id_poszukiwanego NUMERIC(5,0) PRIMARY KEY,
    poszukiwany_za VARCHAR2(50) NOT NULL,
    id_osoby NUMERIC(5,0),
    CONSTRAINT posz_osoba_fk FOREIGN KEY (id_osoby) REFERENCES OSOBY(id_osoby)
);
CREATE TABLE ZATRZYMANI_DO_KONTROLI(
    id_zatrzymanego NUMERIC(5,0) PRIMARY KEY,
    kolor_oczu VARCHAR2(20) NOT NULL,
    kolor_wlosow VARCHAR2(20) NOT NULL,
    cechy_dodatkowe VARCHAR2(100) NOT NULL,
    id_osoby NUMERIC(5,0),
    CONSTRAINT zatrz_osoba_fk FOREIGN KEY (id_osoby) REFERENCES  OSOBY(id_osoby)
);
CREATE TABLE POJAZDY(
    id_pojazdu NUMERIC(5,0) PRIMARY KEY,
    model VARCHAR2(20) NOT NULL,
    marka VARCHAR2(20) NOT NULL,
    zasieg NUMERIC(7,3),
    id_jednostki NUMERIC(5,0),
    CONSTRAINT poj_jednostki_fk FOREIGN KEY (id_jednostki) REFERENCES JEDNOSTKI_ORGANIZACYJNE(id_jednostki)
);
CREATE TABLE UZBROJENIE(
    id_uzbrojenia NUMERIC(5,0) PRIMARY KEY,
    kraj_pochodzenia  VARCHAR2(20) NOT NULL,
    model VARCHAR2(20) NOT NULL,
    waga NUMERIC(6,3) NOT NULL,
    numer_seryjny VARCHAR2(20) NOT NULL,
    id_rodzaju NUMERIC(5,0), 
    id_pracownika NUMERIC(5,0),
    CONSTRAINT uzb_rodzaj_uzbrojenia_fk FOREIGN KEY (id_rodzaju) REFERENCES  RODZAJ_UZBROJENIA(id_rodzaju),
    CONSTRAINT uzb_pracownik_fk FOREIGN KEY (id_pracownika) REFERENCES  PRACOWNICY(id_pracownika)
);
CREATE TABLE PSY_TROPIACE(
    id_psa NUMERIC(5,0) PRIMARY KEY,
    imie VARCHAR2(20) NOT NULL,
    rasa VARCHAR2(20) NOT NULL,
    data_urodzenia DATE NOT NULL,
    id_pracownika NUMERIC(5,0) NOT NULL,
    CONSTRAINT psy_pracownik_fk FOREIGN KEY (id_pracownika) REFERENCES PRACOWNICY(id_pracownika)
);
CREATE TABLE KONTROLE(
    id_kontroli NUMERIC(5,0) PRIMARY KEY,
    powod_kontroli VARCHAR2(50) NOT NULL,
    przewozony_ladunek VARCHAR2(100),
    id_pracownika NUMERIC(5,0),
    id_zatrzymanego NUMERIC(5,0),
    CONSTRAINT kont_pracownik_fk FOREIGN KEY (id_pracownika) REFERENCES PRACOWNICY(id_pracownika),
    CONSTRAINT kont_zatrzymany_fk FOREIGN KEY (id_zatrzymanego) REFERENCES ZATRZYMANI_DO_KONTROLI(id_zatrzymanego)
);
CREATE TABLE PRZEDMIOTY_ZATRZYMANE(
    id_przedmiotu NUMERIC(5,0) PRIMARY KEY,
    nazwa VARCHAR2(30) NOT NULL,
    waga NUMERIC(7,3) NOT NULL,
    ilosc NUMERIC(6,0) NOT NULL,
    cechy_szczegolne VARCHAR2(100) NOT NULL,
    id_kontroli NUMERIC(5,0), 
    CONSTRAINT przed_kontrola_fk FOREIGN KEY (id_kontroli) REFERENCES KONTROLE(id_kontroli)
);