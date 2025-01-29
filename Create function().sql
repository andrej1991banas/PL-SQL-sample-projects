---CREATE FUNCTION


CREATE OR REPLACE FUNCTION func_hypo_pay (
    i_issued_date IN DATE,
    i_day_num     IN NUMBER
) RETURN DATE AS
    v_end      DATE;
    v_interval INTERVAL DAY TO SECOND;
BEGIN
    v_interval := numtodsinterval(i_day_num, 'DAY'); --DEFINITION OF 14 DAY INTERVAL 
    v_end := i_issued_date + v_interval;
    RETURN v_end;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('CHYBA: ' || sqlerrm);
END;

DECLARE
    i_issued_date DATE;
    i_day_num     NUMBER;
    v_return      DATE;
BEGIN
    i_issued_date := NULL;
    i_day_num := NULL;
    v_return := func_hypo_pay(i_issued_date => i_issued_date, i_day_num => i_day_num);
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
*/
    :v_return := v_return;
--rollback; 
END;