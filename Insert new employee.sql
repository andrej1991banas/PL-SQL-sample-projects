
CREATE OR REPLACE PROCEDURE insert_new_emp AS
    rec_new_emp      employees%rowtype;
    n_vlozene_riadky NUMBER;
    e_duplicita EXCEPTION;
BEGIN
    rec_new_emp.employee_id := 1000;
    rec_new_emp.first_name := 'EVA';
    rec_new_emp.last_name := 'KRALOVA';
    rec_new_emp.email := 'NOVAKOVA@GMAIL.COM';
    rec_new_emp.phone := 025128535;
    rec_new_emp.hire_date := TO_DATE ( '28.01.2025', 'DD.MM.YYYY' );
    rec_new_emp.manager_id := 1;
    rec_new_emp.job_title := 'UCITELKA';
    rec_new_emp.salary := 1650;
    IF ( rec_new_emp.last_name = 'KRALOVA' ) THEN
        BEGIN
            RAISE e_duplicita;
        END;
    ELSE
        INSERT INTO employees VALUES (
            rec_new_emp.employee_id,
            rec_new_emp.first_name,
            rec_new_emp.last_name,
            rec_new_emp.email,
            rec_new_emp.phone,
            rec_new_emp.hire_date,
            rec_new_emp.manager_id,
            rec_new_emp.job_title,
            rec_new_emp.salary
        );

    END IF;

    dbms_output.put_line('VLOZILI SME NOVEHO ZAMESTNANCA');
    n_vlozene_riadky := SQL%rowcount;
    dbms_output.put_line('VLOZILI SME  ZAMESTNANCA V POCTE RIADKOV: ' || n_vlozene_riadky);
    IF ( n_vlozene_riadky = 1 ) THEN
        BEGIN
            dbms_output.put_line('VLOZILI SME IBA 1 ZAMESTNANCA');
            COMMIT;
        END;
    ELSE
        dbms_output.put_line('NEVLOZILI SME NIC');
    END IF;

EXCEPTION
    WHEN e_duplicita THEN
        dbms_output.put_line('VKLADAS DUPLICITNY ZAZNAM: ');
    WHEN OTHERS THEN
        BEGIN
            dbms_output.put_line('NASTSALA CHYBA: ' || sqlerrm);
            ROLLBACK;
        END;
END insert_new_emp;



EXECUTE insert_new_emp();