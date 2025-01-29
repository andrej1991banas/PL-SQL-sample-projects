CREATE OR REPLACE PROCEDURE get_emp_name (
    i_emp_pos IN employees.job_title%TYPE,
    o_data    OUT VARCHAR2
) IS 
-- FOR "DATA OUT" VARIABLES I NEED TO CALL TABLE OF "TYPE" OR CREATE CUSTOM TYPE 
--AND DEFINE CUSTOM TYPES IN IT

    v_name employees.job_title%TYPE;
BEGIN
    v_name := i_emp_pos;
    SELECT
        first_name
    INTO o_data
    FROM
        employees
    WHERE
        job_title = v_name;

    dbms_output.put_line('MENO EMP JE:' || o_data);
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('CHYBA:' || sqlerrm);
END;

--CALL THE PROCEDURE 

DECLARE
    o_data VARCHAR2(100);
BEGIN
    get_emp_name('Programmer', o_data);
    dbms_output.put_line('MENO EMP JE:' || o_data);
END;


SELECT * FROM 