/*
    < PL/SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    ����Ŭ ��ü�� ����Ǿ� �ִ� ������ ���
    SQL���� ������ ������ ����, ����ó��(IF), �ݺ�ó��(LOOP,FOR,WHILE)���� �����Ͽ�
    �ټ��� SQL���� �ѹ��� ���� ����
    
    * PL / SQL ����
    - ����� (DECLARE SECTION)      : DECLARE�� ����, ������ ����� ���� �� �ʱ�ȭ�ϴ� �κ�
    - ����� (EXECUTABLE SECTION)   : BEGIN���� ����, ���(���ǹ�,�ݺ���) ���� ������ ��� �ϴ� �κ�
    - ����ó���� (EXCEPTION SECTION) : EXCEPTION���� ����, ���ܹ߻��� �ذ��ϱ� ���� ������ ����ϴ� �κ�
    
    * PL/SQL ����
    BLOCK������ �ټ��� SQL���� �ѹ��� ORACLE�� ���� ó���ϹǷ� ����ӵ��� ����
    
    
*/

--* �����ϰ� ȭ�鿡 HELLO ORACLE ���
-- PUT_LINE�� �̿��ؼ� ȭ�鿡 ���� ����ϱ� ���ؼ� ȯ�溯���� ON���� �����������
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

------------------------------------------------------------------

-- 1.DECLARE �����
-- ���� �� ��� ���� �� ���� ���� (�ʱ�ȭ�� ����)
-- �Ϲ�Ÿ�Ժ���, ���۷���Ÿ�Ժ���, ROWŸ�Ժ���

-- 1-1) �Ϲ� Ÿ�� ���� ���� �� �ʱ�ȭ
--      [ǥ����] ������ [CONSTANT] �ڷ���(ũ��) [:= ��];
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 888;
    ENAME := '���峲';

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- 1_2) ���۷��� Ÿ�� ���� ���� �� �ʱ�ȭ (����̺��� ��÷��� ������Ÿ���� �����ؼ� �� Ÿ������ ����)
--      [ǥ����] ������ ���̺��.�÷���%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- ����� 200���� ����� ����� ������� ���� EID,ENAME�̶�� ������ ����
    -- ������ �� (SELECT INTO�� �̿��ؼ� ��ȸ����� �� ������ ���Խ�Ű���� �Ѵٸ� �ݵ�� �Ѱ��� ������ ��ȸ�ؾߵ�)
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID,ENAME,SAL  -- ���� ������ ������ �ΰ����, ������ �ΰ��ؾ��� SALARY�߰��� �� ����
    FROM EMPLOYEE
    WHERE EMP_NAME = '&NAME';
    --> '&' ��ȣ�� ��ü����(���� �Է�)�� �Է��ϱ� ���� â�� �߰� ���ִ� ����
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

-----------------------------------------------------------------------------------

/*
    ���۷���Ÿ�Ժ����� EID,ENAME,JCODE, DTITLE, SAL�� �����ϰ�
    �� �ڷ����� EMPLOYEE���̺� �� EMP_ID, EMP_NAME, JOB_CODE, SALARY
            DEPARTMENT ���̺��� DEPT_TITLE �÷� Ÿ�� ����
    
    ����ڰ� �Է��� ������ ��ġ�ϴ� ����� ��ȸ(���, �����, �����ڵ�, �μ���, �޿�)�� �� ��ȸ����� �� ������ ������ ���

*/
    
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;   
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, JOB_CODE, DEPT_TITLE
    INTO EID,ENAME,SAL,JCODE,DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID=DEPT_CODE)
   -- WHERE EMP_NAME = '&�̸�';
    WHERE EMP_ID = 212;
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('���� : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DTITLE);
END;
/

------------------------------------------------------------------------

-- 1_3) �� �࿡ ���� Ÿ�� ���� ����
--      [ǥ����] ������ ���̺��%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_NAME = '������';
    DBMS_OUTPUT.PUT_LINE('��� : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�ֹι�ȣ : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || E.SALARY);
END;
/

-----------------------------------------------------------------------------

-- 2. BEGIN

-- ** ���ǹ� **

-- 1) IF ���ǽ� THEN ���೻�� END IF; (���� IF��)

-- ����Է¹��� �� �ش����� ���, �̸�, �޿�, ���ʽ��� ����ϱ� 
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ��� ��� �� '���ʽ��� ���޹��� �ʴ� ����Դϴ�.'

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY || '��');
    DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    END IF;   
END;
/

-- 2) IF ���ǽ� THEN ���೻�� ELSE ���೻�� END IF; (IF-ELSE��)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || SALARY || '��');
   

    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ��� : ' || BONUS * 100 || '%');
    END IF;   
END;
/

-- ����� �Է¹޾� �ش� ����� ���, �̸�, �μ���, �����ڵ�(NATIONAL_CODE)�� ��ȸ�� �� ���
-- ���� : EID, ENAME, DTITLE, NCODE 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);  -- ���� �ϳ� �� ���� 
BEGIN
    SELECT EMP_ID, EMP_NAME,DEPT_TITLE,NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND E.EMP_ID = &���;
   IF (NCODE = 'KO')
        THEN TEAM := '������';
   ELSE
        TEAM := '�ؿ���';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
   DBMS_OUTPUT.PUT_LINE('�̸� :' || ENAME);
   DBMS_OUTPUT.PUT_LINE('�Ҽ� :' || TEAM);
END;
/

--3) IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2 ELSE ���೻�� END IF; (IF-ELSE-IF��)

-- ������ �Է¹޾� SCORE ������ ������ �� 
-- 90�� �̻��� 'A', '80'�� �̻��� 'B', 70�� �̻��� 'C', 60 �� �̻��� 'D', 60�� �̸��� 'F'�� ó���� ��
-- GRADE ������ ����
-- '����� ������ xx���̰�, ������ X�����Դϴ�.

DECLARE 
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &����;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('����� ������ ' || SCORE || '���̰�, ������ '|| GRADE || '�����Դϴ�.');
    
END;    
/

-- ����ڿ��� �Է¹��� ����� ��ġ�ϴ� ����� �޿� ��ȸ�� �� (SAL������ ����)
-- 500�� �̻��̸� '���'
-- 300�� �̻��̸� '�߱�'
-- 300�� �̸��̸� '�ʱ�'
-- '�ش� ����� �޿������ XX�Դϴ�.'
DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    IF SAL >= 5000000 THEN GRADE := '���';
    ELSIF SAL >= 3000000 THEN GRADE := '�߱�';
    ELSE GRADE := '�ʱ�';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�ش� ����� �޿������ ' || GRADE || '�Դϴ�.');
END;
/



-----------------------------------------------------------------------------

-- 4) CASE ���Ҵ���� WHEN ������Ұ�1 THEN �����1 WHEN �񱳰�2 THEN �����2 ELSE ����� END; (SWITCH��)

-- ����Է¹��� �� �ش� ����� ��� �÷� ������ EMP�� ����

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN 
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &���;

    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
             END;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || DNAME);
END;
/


        
-- ** �ݺ��� **

/*
    1) BASIC LOOP 
    
    [ǥ����]
    LOOP
        �ݺ������� �����ų ����
        
        �ݺ����� �������� ���� 
        
    END LOOP;    
    
    --> �ݺ����� �������� ���ǹ� (�ΰ��� ǥ��)
        IF ���ǽ� THEN EXIT END IF;
        EXIT WHEN ���ǽ�;
    
*/

-- 1~5���� ���������� 1�� �����ϴ� ���� ��� 
DECLARE
    N NUMBER := 1; 
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);  -- ����ϰ�
        N := N + 1;  -- 1������Ű��
        
        --IF N > 5 THEN EXIT; END IF; -- ���ǰ˻縦 �ѹ� �� ���ִ� 
        EXIT WHEN N > 5;
    END LOOP;    
END;
/

------------------------------------------------------
/*
    2) FOR LOOP
    
    [ǥ����]
    FOR ���� IN [REVERSE] �ʱⰪ..������
    LOOP
        �ݺ������� ������ ����;
    END LOOP;
    
*/

BEGIN 
    FOR N IN 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/
-- ������ ���
BEGIN 
    FOR N IN REVERSE 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- �ݺ����� �̿��� ������ ����
CREATE TABLE TEST2(
    NUM NUMBER,
    TODAY DATE
);

SELECT * FROM TEST2;

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST2 VALUES(I, SYSDATE);
    END LOOP;
END;
/

-- ��ø �ݺ���
-- ������(2~9��) ����ϱ�
DECLARE
    RESULT NUMBER;
BEGIN

    -- �ٱ��� FOR���� �ܼ� (2~9)
    -- ���� FOR���� �������� �� (1~9)
    
    FOR DAN IN 2..9
    LOOP
        -- ¦���ܸ� ����ϰ��� �Ҷ�
        
        IF MOD(DAN, 2) = 0
        THEN
            DBMS_OUTPUT.PUT_LINE('== ' || DAN || '�� ==');
            FOR SU IN 1..9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || SU || ' = ' || RESULT);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        
    END LOOP;
END;
/

---------------------------------------------------------------------------------

/*
    3) WHILE LOOP
    
    [ǥ����]
    WHILE �ݺ����̼�������� 
    LOOP
        �ݺ������� �����ұ���
    END LOOP;
    
*/
-- 1-5���� ���������� 1�� �����ϴ� �� ��� 
DECLARE
    N NUMBER := 1;
BEGIN 
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N +1;
    END LOOP;
END;
/

--WHILE ������ ������(2~9 ��) ��� 
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN 

    WHILE DAN <= 9 
    LOOP
        DBMS_OUTPUT.PUT_LINE('== ' || DAN || '�� ==');
        SU := 1;
        WHILE SU <= 9
        LOOP
            RESULT := DAN * SU;
            DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || ' = ' || RESULT);
            SU := SU+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DAN := DAN+1;
END LOOP;
END;
/
------------------------------------------
/*
    3. ����ó����(EXCEPTION)
    ����(EXCEPTION) : ������ �߻��ϴ� ����
    
    [ǥ����]
    EXCEPTION
        WHEN ���ܸ�1 THEN ����ó������1;
        WHEN ���ܸ�2 THEN ����ó������1;
        ...
        WHEN OTHERS THEN ����ó������;
        
     * �ý��� ���� (����Ŭ���� �̸����� �Ǿ��ִ� ����)
     - NO_DATA_FOUND : SELECT�� ���� ����� �� �൵ ���� ��� 
     - TOO_MANY_ROWS : �� �ุ �����ؾߵǴ� SELECT���� �������� ��ȯ �� ��
     - ZERO_DIVIDE : 0���� ���� ��
     - DUP_VAL_ON_INDEX : UNIQUE ���� ������ ���� �÷��� �ߺ��� �����Ͱ� INSERT�� ��
    
*/
-- ����ڰ� �Է��� ���� ������ ������ ��� ��� 
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &����;
    DBMS_OUTPUT.PUT_LINE('���: ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� �����!');
    --WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� �����!');
END;
/

-- UNIQUE  �������� �����
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME ='���ö';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�̹� �����ϴ� ����Դϴ�!');
END;
/

SELECT * FROM EMPLOYEE;