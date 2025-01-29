--VTPIS VSETKYCH EMP, KTORI PATRIA POD MANAZERA_id 4 ALEBO MANAZERA_id 4

CREATE OR REPLACE PROCEDURE proc_manager_emp AS

    CURSOR cur1_sel_emp (
        i_manager_id IN NUMBER
    ) IS
    SELECT
        *
    FROM
        employees
    WHERE
        manager_id = i_manager_id;

    rec_emp employees%rowtype;
BEGIN
    FOR rec_emp IN cur1_sel_emp(4) LOOP
        dbms_output.put_line('TENTO CLOVEK PATRIPOD MANAZERA 4: '
                             || rec_emp.first_name
                             || ' '
                             || rec_emp.last_name);
    END LOOP;

    FOR rec_emp IN cur1_sel_emp(2) LOOP
        dbms_output.put_line('TENTO CLOVEK PATRIPOD MANAZERA 2: '
                             || rec_emp.first_name
                             || ' '
                             || rec_emp.last_name);
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('CHYBA: ' || sqlerrm);
END;

EXECUTE proc_manager_emp();