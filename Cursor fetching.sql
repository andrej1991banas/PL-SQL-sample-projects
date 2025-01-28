--VYPIS CEZ PROCEDURU VSETKYCH ZAMESTNANCOV Z TABULKY EMPLOYEES

CREATE OR REPLACE PROCEDURE proc_loop_emp AS
    CURSOR cur_emp IS
    SELECT
        *
    FROM
        employees; --CURSOR DEFINITION
    rec_emp employees%rowtype; --GETTING ROW FROM THE TABLE WITH DATA TYPES EQUAL AS IN TABLE

BEGIN
    OPEN cur_emp;--OPENNING CURSOR

    LOOP
        FETCH cur_emp INTO rec_emp; --CATCHING ROWS AND SAVING THEIR INSTANCES INTO rec_emp
        dbms_output.put_line('ZAMESTNANEC: '
                             || rec_emp.first_name
                             || ' '
                             || rec_emp.last_name);

        EXIT WHEN cur_emp%notfound; --ESCAPING THE LOOP AT THE END OF cur_emp
    END LOOP;

    dbms_output.put_line('THE '
                         || cur_emp%rowcount
                         || ' NUMBER OF ROWS WERE PRINTED');
    CLOSE cur_emp; --CLOSING CURSOR

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('NASTALA CHYBA' || sqlerrm);
END;

EXECUTE proc_loop_emp();