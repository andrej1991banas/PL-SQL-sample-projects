--NAPISEM PROCEDURU, PROGRAM, KTORY ZMENI PLAT VSETKYCH ZAM NA ROVNAKU SUMU PRIROVNAKEJ PRAC POZICII

CREATE OR REPLACE PROCEDURE proc_nastav_rovnaky_plat AS

    v_pracovne_zaradenie employees.job_title%TYPE;
    n_originalny_plat    employees.salary%TYPE;
    n_zvoleny_clovek     employees.employee_id%TYPE;
    n_pocet_ludi_po_zmene NUMBER;
BEGIN
--V PRVOM KROKU SI ZVOLIM CLOVEKA Z TABULKY EMPLOYEES PODLA id
    n_zvoleny_clovek := 10;
    SELECT
        job_title,
        salary
    INTO
        v_pracovne_zaradenie,
        n_originalny_plat
    FROM
        employees
    WHERE
        employee_id = n_zvoleny_clovek;

    dbms_output.put_line('PROCEDURA SKONCILA A ZARADENIE JE: '
                         || v_pracovne_zaradenie
                         || ' A JEHO PLAT JE: '
                         || n_originalny_plat);

        BEGIN
            UPDATE employees
            SET
                salary = n_originalny_plat
            WHERE
                job_title = v_pracovne_zaradenie;
                n_pocet_ludi_po_zmene := SQL%ROWCOUNT;
            IF (n_pocet_ludi_po_zmene<6) THEN
            BEGIN
            COMMIT;
            dbms_output.put_line('UPDATE PREBEHOL BEZ PROBLEMOV A JE NASTAVENY PLAT: ' || n_originalny_plat);
            dbms_output.put_line('ZMENILI SME : ' || n_pocet_ludi_po_zmene|| ' LUDI');
            END;
            ELSE BEGIN ROLLBACK; --NOT COMMITING AND UPDATING INSTANCES BEFORE SELECT
            dbms_output.put_line('ZMENA NEPREBEHLA KVOLI VELKEMU POCTU ZMIEN ');
            END;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('PROCEDURA PADLA NA CHYBE VO VNUTRI PROCEDURE: ' || sqlerrm);
        END;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('PROCEDURA PADLA NA CHYBE: ' || sqlerrm);
END;


EXECUTE  proc_nastav_rovnaky_plat();