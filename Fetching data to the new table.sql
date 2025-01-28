--TAKE PROGRAMMERS FROM EMPLOYEES TABLE, CREATE A NEW TABLE AND MOVE PROGRAMMERS 
--INTO THE NEW TABLE, SHOW THEIR NAMES, USE LOOP PROCEDURE

CREATE TABLE programmers (
    first_name       VARCHAR2(255 BYTE),
    lst_name VARCHAR2(255 BYTE)
); --CREATING NEW TABLE FOR STORING DATA


--CREATING PROCEDURE 
CREATE OR REPLACE PROCEDURE proc_cur_prog AS
    CURSOR cur_prog IS
    SELECT
        *
    FROM
        employees
    WHERE
        job_title = 'Programmer'; -- CURSOR

    rec_prog     employees%rowtype;
    n_pocet_ludi NUMBER;
BEGIN
    OPEN cur_prog;
    LOOP
        FETCH cur_prog INTO rec_prog;
        EXIT WHEN cur_prog%notfound;
        INSERT INTO programmers (
            fist_name,
            last_name
        ) VALUES (
            rec_prog.first_name,
            rec_prog.last_name
        );

        COMMIT;
        dbms_output.put_line('Programator: '
                             || rec_prog.first_name
                             || ' '
                             || rec_prog.last_name);

    END LOOP;

    n_pocet_ludi := cur_prog%rowcount;
    dbms_output.put_line('celkovo sme sprocesovali riadkov:' || n_pocet_ludi);
    CLOSE cur_prog;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('MAME V PROCEDURE CHYBU' || sqlerrm);
END;

EXECUTE proc_cur_prog();
