--procedura pre prechadyanie riadkov a pridanie dat do novej tabulky cez 
--FOR LOOP


CREATE OR REPLACE PROCEDURE proc_all_emp AS
    rec_emp        employees%rowtype;
    CURSOR cur_emp IS
    SELECT
        *
    FROM
        employees;

    n_spolu_emp    NUMBER;
    n_pocet_update NUMBER;
BEGIN
    FOR rec_emp IN cur_emp LOOP
        dbms_output.put_line('KRSTNE MENO JE: ' || rec_emp.first_name);
        n_spolu_emp := cur_emp%rowcount;
        IF ( rec_emp.first_name = 'Roman' ) THEN
            BEGIN
                UPDATE employees
                SET
                    salary = 1254
                WHERE
                    first_name LIKE ( 'Am%' );

                n_pocet_update := SQL%rowcount; --KOLKO RIADKOV BOLO ZMENENYCH A SLEDUJE POSLEDNY 
--VYKONANY PRIKAZ
                COMMIT;
            EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line('CHYBA VO VNUTRI: ' || sqlerrm);
            END;
        END IF;

    END LOOP;

    dbms_output.put_line('PRESLI SME: '
                         || n_spolu_emp
                         || ' RIADKOV');
    dbms_output.put_line('PRESLI A ZMENILI SME: '
                         || n_pocet_update
                         || ' RIADKOV');
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('CHYBA: ' || sqlerrm);
END;

EXECUTE proc_all_emp();