
create or replace view najbardziej_efektywna_jednostka as
    select  jo.id_jednostki,jo.nazwa,miasto,ulica,nr_budynku,nr_mieszkania,poczta,kod_pocztowy,sum(pz.waga) suma_wagi_zarekwirowanych_rzeczy
    from przedmioty_zatrzymane pz
    join kontrole kr
    on kr.id_kontroli=pz.id_kontroli
    join pracownicy pr
    on pr.id_pracownika=kr.id_pracownika
    join jednostki_organizacyjne jo
    on pr.id_jednostki=jo.id_jednostki
    join adresy adr
    on adr.id_adresu=jo.id_adresu
    group by jo.id_jednostki,jo.nazwa,miasto,ulica,nr_budynku,nr_mieszkania,poczta,kod_pocztowy
    having sum(pz.waga)=(select  max(sum(pz.waga))
    from przedmioty_zatrzymane pz
    join kontrole kr
    on kr.id_kontroli=pz.id_kontroli
    join pracownicy pr
    on pr.id_pracownika=kr.id_pracownika
    join jednostki_organizacyjne jo
    on pr.id_jednostki=jo.id_jednostki
    group by jo.id_jednostki
    );

 --Lista osób poszukiwanych wraz informacjami o kontroli podczas której zostali złapania   
create or replace view zlapani as
    select ko.powod_kontroli,po.poszukiwany_za,przewozony_ladunek,nazwisko,imie,pesel,data_urodzenia from zatrzymani_do_kontroli zdk
    join poszukiwani po
    on po.id_osoby=zdk.id_osoby
    join kontrole ko
    on ko.id_zatrzymanego=zdk.id_zatrzymanego
    join osoby os
    on os.id_osoby=zdk.id_osoby;


--Lista zsumowanej wagi przedmiotów zatrzymanych w danej jednostce
create or replace view waga_zatrzymannych as    
    select jo.nazwa,sum(pz.waga)suma_wagi  from przedmioty_zatrzymane pz
    join kontrole ko
    on ko.id_kontroli=pz.id_kontroli
    join pracownicy pr
    on pr.id_pracownika=ko.id_pracownika
    join jednostki_organizacyjne jo
    on jo.id_jednostki=pr.id_jednostki
    group by jo.nazwa;

--Osoby po 30 roku życia przewożące ponad 10kg nelegalnego towaru
create or replace view zatrz_po30 as
    select nazwisko,imie,pesel,pz.nazwa,waga,trunc((sysdate-data_urodzenia)/365)wiek
    from przedmioty_zatrzymane pz
    join kontrole ko
    on ko.id_kontroli= pz.id_kontroli
    join zatrzymani_do_kontroli zdk
    on zdk.id_zatrzymanego=ko.id_zatrzymanego
    join osoby os
    on os.id_osoby=zdk.id_osoby
    where waga>10 and trunc((sysdate-data_urodzenia)/365)>30;
--Psy które zostaną wysłane na emeryturę
create or replace view psyNaEmeryture as
    select jo.nazwa,pt.imie,rasa,pt.data_urodzenia,trunc((sysdate-pt.data_urodzenia)/365) wiek,os.imie imie_wlasciciela,os.nazwisko nazwisko_wlasciciela,os.pesel pesel_wlasciciela, pr.stopien stopien_wlasciciela 
    from psy_tropiace pt
    join pracownicy pr
    on pr.id_pracownika=pt.id_pracownika
    join jednostki_organizacyjne jo
    on jo.id_jednostki=pr.id_jednostki
    join osoby os
    on os.id_osoby=pr.id_osoby
    where (sysdate-pt.data_urodzenia)/365>5;


--Uzbrojenie zabierane do domu przez pracownika który mieszka w tym samym mieście w którym pracuje

create or replace view zabierane_wyposazenie as
    select nazwisko,imie,pesel,adr_jo.miasto,jo.nazwa nazwa_jednostki,ruz.nazwa nazwa_wyposazenia,uz.numer_seryjny,uz.model from pracownicy pr
    join osoby os
    on os.id_osoby=pr.id_osoby
    join adresy adr_pr
    on adr_pr.id_adresu=os.id_adresu
    join jednostki_organizacyjne jo
    on jo.id_jednostki=pr.id_jednostki
    join adresy adr_jo
    on adr_jo.id_adresu=jo.id_jednostki
    join uzbrojenie uz
    on uz.id_pracownika=pr.id_pracownika
    join rodzaj_uzbrojenia ruz
    on ruz.id_rodzaju=uz.id_rodzaju
    where adr_jo.miasto=adr_pr.miasto
    order by adr_jo.miasto;