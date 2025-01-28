--CYKLUS V PROCEDURE 

--VYPIS CISLA OD 1 DO 20

CREATE OR REPLACE PROCEDURE proc_for_loop AS
BEGIN
    FOR pocet IN 1..20 LOOP
        dbms_output.put_line('AKTUALNE CISLO JE: ' || pocet);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('V CYKLE JE CHYBA');
END;

EXECUTE proc_for_loop();

CREATE OR REPLACE PROCEDURE proc_while_loop AS
    pocet PLS_INTEGER := 0;
BEGIN
    WHILE pocet < 20 LOOP
        dbms_output.put_line('TERAZ JE CISLO: ' || pocet);
        pocet := pocet + 1;
    END LOOP;
END;

EXECUTE proc_while_loop();