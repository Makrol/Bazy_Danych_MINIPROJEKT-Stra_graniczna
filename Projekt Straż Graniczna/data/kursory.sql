--Procedura z kursorem zwiększająca pensje o 10% jeżeli ilość kontroli jest powyzej sredniej
create or replace procedure podwyzka as
cursor pk_ko is select id_pracownika, count(*)ile from kontrole group by id_pracownika;
CURSOR pra is select * from pracownicy;
sr numeric(7,2) :=0;
ilosc numeric:=0;
begin
    for tmp in pk_ko loop
    sr:=sr+tmp.ile;
    ilosc:=ilosc+1;
    end loop;
    sr:=sr/ilosc;

    for tmp in pk_ko loop
        if(sr<tmp.ile)then
            update pracownicy set pensja=pensja*1.1 where id_pracownika=tmp.id_pracownika;
        end if;
    end loop;
end;

--Procedura z kursorem służąca do awansowania kaprala na sierżanta jeżeli jego ilość zatrzymanych 
--jest powyżej średniej

create or replace procedure awans_kapral as
cursor pr is select * from pracownicy for update;
cursor kon_ile is select id_pracownika,count(*)ile from kontrole group by id_pracownika order by id_pracownika;
srednia numeric(8,3);
begin
    select avg(count(*)) into srednia from kontrole group by id_pracownika; 
    for tmp1 in pr loop
        for tmp2 in kon_ile loop
            if(tmp1.id_pracownika=tmp2.id_pracownika and tmp2.ile>srednia and tmp1.stopien='kapral')then
                update pracownicy set stopien='sierżant' where current of pr;
            end if;
        end loop;
    end loop;
end;

--Funkcja z kursorem wyliczająca jaki procent osób spośród zatrzymanych do kontroli to osoby poszukiwane

create or replace function procent_zatrz
return varchar
is
cursor zatrz is select * from zatrzymani_do_kontroli;
cursor posz is select * from poszukiwani;
wszyscy number(8,3):=0;
wybrani number(8,3):=0;
wynik number(8,3);
begin
    for tmp1 in zatrz loop
        for tmp2 in posz loop
           if(tmp1.id_osoby=tmp2.id_osoby)then
                wybrani:=wybrani+1;
           end if;
        end loop;
        wszyscy:=wszyscy+1;
    end loop;
    wynik:=(wybrani/wszyscy)*100;
    return wynik||'%';
end;
--Procedura z kursorem do zwiększania pensji pracownikom z jednostki organizacyjnej która
-- zatrzymuje najwięcej osób;

create or replace procedure podwyzka_jednostki as
CURSOR jednostka_zatrzymania is select pr.id_jednostki,count(*)ile from kontrole kontr
join pracownicy pr
on pr.id_pracownika=kontr.id_pracownika
GROUP BY pr.id_jednostki;
cursor prac is select * from pracownicy for update;
maxWartosc Numeric:=0;
id_jedn Numeric:=-1;
begin 
    for tmp in jednostka_zatrzymania loop
        if(id_jedn=-1)then
            id_jedn:= tmp.id_jednostki;
            maxWartosc:=tmp.ile;
        else
            if(tmp.ile>maxWartosc)then
                id_jedn:= tmp.id_jednostki;
                maxWartosc:=tmp.ile;
            end if;
        end if;
    end loop;
    
    for tmp in prac loop
        if(tmp.id_jednostki=id_jedn)then
            update pracownicy set pensja=pensja+100 where current of prac;
        end if;
    end loop;
end;