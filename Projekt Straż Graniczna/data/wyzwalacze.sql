create or replace trigger pracownik_poszukiwany before insert on pracownicy
for each row
declare
przestepca exception;
cursor posz is select * from poszukiwani;
id_posz numeric;
begin 

    for tmp in posz loop
        if(:new.id_osoby=tmp.id_osoby)then
            raise przestepca;
        end if;
    end loop;
end;



create or replace trigger jeden_pies before insert on psy_tropiace
for each row
DECLARE
cursor psy is select * from psy_tropiace;
drugi_pies exception;
begin
    for tmp in psy loop
        if(:new.id_pracownika=tmp.id_pracownika)then
            raise drugi_pies;
        end if;
    end loop;
end;


create or replace trigger prac_zatrz after insert on przedmioty_zatrzymane
for each row
declare
cursor prac is select * from pracownicy for update;
cursor kontr is select * from kontrole;
cursor zat_kontr is select * from zatrzymani_do_kontroli;
begin
   for tmp1 in kontr loop
        if(:new.id_kontroli=tmp1.id_kontroli)then
            for tmp2 in zat_kontr loop
                if(tmp1.id_zatrzymanego=tmp2.id_zatrzymanego)then
                    for tmp3 in prac loop
                        if(tmp3.id_osoby=tmp2.id_osoby)then
                            if(tmp3.pensja<2501)then
                                update pracownicy set pensja=2001 where current of prac;
                            else
                                update pracownicy set pensja=pensja-500 where current of prac;
                            end if;
                            return;
                        end if;
                    end loop;
                return;
                end if;
            end loop;
            return;
        end if;
   end loop;
end;