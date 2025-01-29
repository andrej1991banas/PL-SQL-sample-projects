--CREATE FUNCTION SUMS TWO NUMBERS

CREATE OR REPLACE FUNCTION func_result (
    i_num  IN NUMBER,
    i_num2 IN NUMBER
) RETURN NUMBER AS
    o_result NUMBER;
BEGIN
    o_result := i_num + i_num2;
    RETURN o_result;
END;

DECLARE
    i_num    NUMBER;
    i_num2   NUMBER;
    v_return NUMBER;
BEGIN
    i_num := 5;
    i_num2 := 10;
    v_return := func_result(i_num => i_num, i_num2 => i_num2);
    dbms_output.put_line('v_Return = ' || v_return);
    :v_return := v_return;
--rollback; 
END;