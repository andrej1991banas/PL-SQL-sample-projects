--ZISKAJ VSETKY DATA O UCTOVNIKOCH
--VYTVOR A ULOZ ICH DO VYSTUPNEJ PREMENNEJ 


--CREATING OBJECT 
CREATE OR REPLACE TYPE emp_obj IS OBJECT (
    num_emp    NUMBER(5),
    meno       VARCHAR2(30),
    priezvisko VARCHAR2(30),
    plat       NUMBER
);
/
-------------------------------------------------


--CREATING TABLE FOR DATA FROM OBJECT emp_obj
CREATE OR REPLACE TYPE emp_table IS
    TABLE OF emp_obj;
/


-------------------------
CREATE OR REPLACE PROCEDURE get_accountant_data (
    p_job_title IN employees.job_title%TYPE
) AS

--CURSOR cur_acount IS SELECT job_title FROM employees WHERE job_title=p_job_title;
    v_job_title employees.job_title%TYPE;
    rec_emp     emp_table;
BEGIN
    rec_emp := emp_table(); --COLLECTION INICIALIZATION
    v_job_title := p_job_title;
    SELECT
        emp_obj(emp.employee_id, emp.first_name, emp.last_name, emp.salary)
    BULK COLLECT
    INTO rec_emp
    FROM
        employees emp
    WHERE
        emp.job_title = v_job_title;

    FOR i IN 1..rec_emp.count LOOP
        dbms_output.put_line(' ZAMESTNANEC: ' || rec_emp(i).meno);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('CHYBA NA:' || sqlerrm);
END;

EXECUTE get_accountant_data('Accounting Manager');