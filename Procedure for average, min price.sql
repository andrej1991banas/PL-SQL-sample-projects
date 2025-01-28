---VYPOCITAJ PRIEMERNU CENU OBJEDNAVKY, MINILANU CENU OBJDNAVKY, A ESTE VYPIS KTO DANU OBJEDNAVKU VYTVORIL 

--POTREBUJEME TABULKY ORDER_ITEMS, CUSTOMERS, ORDERS


CREATE OR REPLACE PROCEDURE proc_avg_order_price AS 

n_cislo_obj NUMBER;
n_average_price NUMBER;
n_min_price NUMBER;
v_customer_name customers.name %TYPE;
s_sql VARCHAR2(4000);
s_sql2 VARCHAR2(4000);
v_vystupna_sprava VARCHAR2 (4000);
s_sql4 VARCHAR2(4000);
v_tabulkova_premenna my_customer_tab; --OWN DATA TYPE DEFINITION

BEGIN

n_cislo_obj =94;

s_sql = '
SELECT ROUND(AVG(quantityunit_price),2) AS avg_price, ROUND (MIN(quantityunit_price),2) AS min_price FROM ORDERS o
INNER JOIN ORDER_ITEMS oi
ON o.ORDER_ID = oi.ORDER_ID
WHERE o.status NOT IN (''Canceled'', ''Pending'') AND o.order_id = 'n_cislo_obj'
GROUP BY o.order_id
';

s_sql2= '
SELECT c.name FROM ORDERS o
INNER JOIN CUSTOMERS c
ON c.customer_id=o.customer_id
WHERE o.order_id = 'n_cislo_obj --SIGNS  ONLY FROM THE LEFT, AS THE SELECT ENDS BEHING THE VARIABLE
;

s_sql4='
SELECT customer_id, COUNT(customer_id) FROM orders
GROUP BY customer_id 
';

EXECUTE IMMEDIATE s_sql INTO n_average_price, n_min_price; ---COOMIT WITH THE EXECUTE 
EXECUTE IMMEDIATE s_sql2 INTO v_customer_name;
--EXECUTE IMMEDIATE s_sql4 INTO v_tabulkova_premenna;

DBMS_OUTPUT.PUT_LINE ('PROCESSES ARE FINE  ');
DBMS_OUTPUT.PUT_LINE ('AVERAGE PRICE IS ' n_average_price);
DBMS_OUTPUT.PUT_LINE ('MINIMUN PRICE IS ' n_min_price);
DBMS_OUTPUT.PUT_LINE ('NAME OF THE CUSTOMER IS ' v_customer_name);
--DBMS_OUTPUT.PUT_LINE ('NAME IS ' v_tabulkova_premenna);

EXCEPTION WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE ('VO VYPOCTE MAME CHYBU ' SQLERRM);
END ; 



EXECUTE proc_avg_order_price();



--side selects as tests

CREATE OR REPLACE TYPE my_customer_obj IS OBJECT(
cislo_cust NUMBER(6,2),
pocet_obj NUMBER
);


CREATE OR REPLACE TYPE my_customer_tab IS TABLE OF moj_customer_obj;