--PROCEDURE CHOOSING ALL CUSTOMERS WITH CREDIT LIMIT AS VARIABLE v_cred_lim
--CREATE DATA OUT VARIABLE NAME, ADRESS, WEBSITE

CREATE OR REPLACE TYPE o_cust_det IS OBJECT (
    name    VARCHAR2(255),
    address VARCHAR2(255),
    website VARCHAR2(255)
);
/

CREATE OR REPLACE TYPE o_cust_obj_tab IS
    TABLE OF o_cust_det;
/

CREATE OR REPLACE PROCEDURE proc_get_cust_details (
    i_v_cred_lim IN NUMBER,
    o_customers  OUT o_cust_obj_tab
) AS
BEGIN 

--v_tab:=o_cust_obj_tab();
    SELECT
        o_cust_det(cust.name, cust.address, cust.website)
    BULK COLLECT
    INTO o_customers
    FROM
        customers cust
    WHERE
        credit_limit = i_v_cred_lim;

    FOR i IN 1..o_customers.count LOOP
        dbms_output.put_line('CLOVEK: ' || o_customers(i).name);--||o_customers(i).address||o_customers(i).website);

    END LOOP;

END;

DECLARE
    i_v_cred_lim NUMBER;
    o_customers  andrej1991.o_cust_obj_tab;
BEGIN
    i_v_cred_lim := 5000;
    proc_get_cust_details(i_v_cred_lim => i_v_cred_lim, o_customers => o_customers);
    dbms_output.put_line('O_CUSTOMERS = ' || o_customers(1).name);
 
  --:O_CUSTOMERS := O_CUSTOMERS;
--rollback; 
END;