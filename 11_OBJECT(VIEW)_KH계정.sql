/*
    
    < VIEW �� > 
    
    SELECT���� ������ �� �ִ� ��ü
    ������ �������̺� --> ���������� �����͸� �����ϰ� ���� ����
                        (�ܼ��ϰ� �������� ����Ǿ��ִٰ� ����)
    
*/

-- '�ѱ�'���� �ٹ��ϴ� ����� ���, �̸�, �μ���, �޿�, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ����� ���, �̸�, �μ���, �޿�, �ٹ��������� ��ȸ�Ͻÿ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '���þ�';


----------------------------------------------------------------------------------

/*
    1. VIEW ���� ���
    
    [�⺻ ǥ����]
    CREATE [OR REPLACE] VIEW ���
    AS ��������;
    
    [OR REPLACE] : �� ������ ������ �ߺ��� �䰡 �ִٸ� �ش� �並 �����ϰ�
                           ������ �ߺ��� �䰡 ���ٸ� ������ �並 �����ϴ� Ű����
                           
*/

-- �Ź� ���� ����ϴ� �������� ���Ǹ� �صΰ� ���� �� �並 ������!
-- VIEW�� �ѹ��� ����� �θ� ��ġ ���̺�ó�� �� �� ����!!

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_CODE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
   JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
   JOIN NATIONAL USING(NATIONAL_CODE);

--> ó�� ������ CREATE VIEW ������ ���� ������ �����ȵ�!! (CREATE VIEW ���ѹ޾ƾߵ�)


SELECT * 
FROM VW_EMPLOYEE;

-- �ѱ��� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿� ��ȸ
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

-- ���þƿ� �ٹ��ϴ� �����
SELECT EMP_NAME, SALARY--, JOB_CODE
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- �ѹ��ο� �ٹ��ϴ� ����� �����, �޿�
SELECT EMP_NAME, SALARY
FROM VW_EMPLOYEE            --> �������̺��ΰ� �� (���������Ͱ� ����ִ°� �ƴ�)
WHERE DEPT_TITLE = '�ѹ���';

-- [����]
SELECT * FROM USER_TABLES; -- �ش� ������ ������ �ִ� TABLE�鿡 ���� ���� ��ȸ
SELECT * FROM USER_VIEWS; -- �ش� ������ ������ �ִ� VIEW�鿡 ���� ���� ��ȸ�� ����ϴ� �ý��� ���̺�


-- ���̽����̺�(���� �����Ͱ� ����մ� ���̺�)�� ������ ����Ǹ� VIEW�� ���� ����� ���� ����

SELECT * FROM VW_EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ���205�� ������� ���߾� ���� ����
UPDATE EMPLOYEE
SET EMP_NAME = '���߾�'
WHERE EMP_ID = 205;

------------------------------------------------------------------------

-- * ������ �� �÷��� ��Ī �ο�

-- ���������� SELECT���� �Լ��� ��������� ����Ǿ��ִ� ��� �ݵ�� ��Ī ����!!

-- ����� ���, �̸�, ���޸�, ����, �ٹ���� ��ȸ�� �� �մ� ��� �����Ͻÿ�
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��') ����, 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) �ٹ����
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

 SELECT *
 FROM VW_EMP_JOB;  
CREATE OR REPLACE VIEW VW_EMP_JOB(���, �����, ���޸�, ����, �ٹ����) --> ����÷��� ���� ��Ī �ο��ؾߵ�
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '��', '2', '��'), 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

SELECT ���, �����, ����, �ٹ����
FROM VW_EMP_JOB;

-- ������ϰ��� �Ѵٸ�
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------

-- ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE) ��밡��
-- �並 ���� �����ϰ� �Ǹ� ���������Ͱ� ����ִ� ���̽����̺��� �����!!!

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
   FROM JOB;
   
SELECT * FROM JOB;
SELECT * FROM VW_JOB;

-- �信 INSERT
INSERT INTO VW_JOB VALUES('J8', '����');

SELECT * FROM VW_JOB;
SELECT * FROM JOB;      --> ���̽����̺� �� INSERT

-- �信 UPDATE (J8�� ���޸��� �˹ٷ� ����)
UPDATE VW_JOB
SET JOB_NAME = '�˹�'
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;      --> ���̽����̺� �� UPDATE

-- �信 DELETE ���
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM JOB;          --> ���̽����̺� �� DELETE
SELECT * FROM VW_JOB;

----------------------------------------------------------------------

/*
    * DML ��ɾ�� ������ �Ұ����� ���
    
    1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
    2) �信 ���ǵǾ����� ���� �÷� �߿�,
       ���̽����̺�� NOT NULL ���������� ������ ��� --> INSERT �� ��������
    3) ������������ ���� �� ���
    4) �׷��Լ��� GROUP BY ���� ������ ���
    5) DISTINCT�� ������ ���
    6) JOIN�� �̿��ؼ� ���� ���̺��� ������ ���
    
*/

-- 1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW VW_JOB2
AS SELECT JOB_CODE
   FROM JOB;

SELECT * FROM VW_JOB2;

-- �信 ���� �Ǿ����� ���� �÷� (JOB_NAME)�� ����
-- INSERT
INSERT INTO VW_JOB2 VALUES('J8', '����');

-- UPDATE
UPDATE VW_JOB2
SET JOB_NAME = '����'
WHERE JOB_CODE = 'J7';

SELECT * FROM JOB;
-- DELETE 
DELETE FROM VW_JOB2
WHERE JOB_NAME = '���';

-- 2) �信 ���ǵǾ����� ���� �÷� �߿�,
--    ���̽����̺�� NOT NULL ���������� ������ ��� --> INSERT �� ��������

CREATE OR REPLACE VIEW VW_JOB3
AS SELECT JOB_NAME
   FROM JOB;

SELECT * FROM VW_JOB3;

-- INSERT
INSERT INTO VW_JOB3 VALUES('����');
--> ���̽����̺��� JOB�� JOB_CODE�� NOT NULL ���������� �ֱ� ������ 

-- UPDATE (������ ����� �˹ٷ� ����)
UPDATE VW_JOB3
SET JOB_NAME='�˹�'
WHERE JOB_NAME='���';

SELECT * FROM JOB;

-- DELETE (�˹��� ������ �����)
INSERT INTO JOB VALUES('J8', '����');

SELECT * FROM VW_JOB3;

DELETE FROM VW_JOB3
WHERE JOB_NAME='����';

SELECT * FROM JOB;

-- 3) ������������ ���ǵ� ���
--> ȸ���� ���� ������ ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 ����
   FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;

-- INSERT 
INSERT INTO VW_EMP_SAL VALUES(800, '������', 3000000, 36000000);

-- UPDATE (200�� ����� ������ 80000000���� ����)
UPDATE VW_EMP_SAL
SET ���� = 80000000
WHERE EMP_ID = 200;

-- UPDATE (205�� ����� �̸��� �����Ϸ� ����) --> �������� ������ ���� ���� ����
UPDATE VW_EMP_SAL
SET EMP_NAME = '������'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE;

COMMIT;
SELECT * FROM VW_EMP_SAL;
-- DELETE (������ 9600������ ��� �����)
DELETE FROM VW_EMP_SAL
WHERE ���� = 96000000;

SELECT * FROM EMPLOYEE;

ROLLBACK;


-- 4) �׷��Լ� �Ǵ� GROUP BY���� ������ ���
--> �μ��� �ѱ޿���, �޿����
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) �հ�, FLOOR(AVG(SALARY)) ���
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;
   
SELECT * FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D0', 8000000, 4000000);

INSERT INTO VW_GROUPDEPT(DEPT_CODE) VALUES('D0');

SELECT * FROM VW_GROUPDEPT;
-- UPDATE (D1�μ��ڵ带 D0�μ��ڵ�� ����)
UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D1';

-- DELETE (�μ��ڵ尡 D1�ΰ� �����)
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';


-- 5) DISTINCT ������ ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;
   
SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE (J7 --> J8)
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE='J7';

-- DELETE 
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J2';


-- 6) JOIN�� �̿��� ���� ���̺��� ������ ���
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

SELECT * FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP VALUES(888, '������', '�ѹ���');

-- UPDATE (200�� ����� �̸��� ������)
UPDATE VW_JOINEMP
SET EMP_NAME = '������'
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- 200�� ����� �μ����� �ѹ�1��
UPDATE VW_JOINEMP
SET DEPT_TITLE = '�ѹ�1��'
WHERE EMP_ID = 200;

-- DELETE (200�� ��� �����)
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT * FROM VW_JOINEMP;

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '�ѹ���';  --> ���������� FROM���� ������ ���̺��� ������ ��ħ

ROLLBACK;


-------------------------------------------------------------------------

/*
    * VIEW �ɼ�
    
    [�� ǥ����]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW ���
    AS SUBQUERY
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE �ɼ� : ������ ������ �䰡 ������� �����, �������� ������ ������ ���������ִ�
    2) FORCE/NOFORCE �ɼ�
       FORCE : ���������� ����� ���̺��� �������� �ʴ� ���̺��̿��� �䰡 ����
       NOFORCE : ���������� ����� ���̺��� �����ؾ߸� �䰡 ���� (������ �⺻��)
    3) WITH CHECK OPTION �ɼ� : ���������� ����� ���ǿ� �������� ���� ������ �����ϴ� ��� ���� �߻�
    4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ���� (DML ���� �Ұ�)
    
*/

-- 2) FORCE / NOFORCE �ɼ�
-- NOFORCE : ���������� ����� ���̺��� �����ϴ� ���̺��̿��߸� �� ���� (������ �⺻��)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;

-- FORCE : ���������� ����� ���̺��� �������� �ʾƵ� �� ���� ���� (�̸� �� �����صΰ��� �Ҷ�)
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
   --> ��� : ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.
   
SELECT * FROM VW_EMP;

CREATE TABLE TT( --> TT ���̺��� �����ϸ� �׶����� VIEW ��ȸ ����
    TCODE NUMBER,
    TNAME VARCHAR2(10),
    TCONTENT VARCHAR2(20)
);

-- 3) WITH CHECK OPTION �ɼ� : ���������� ����� ���ǿ� ���յ��� �ʴ� ������ �����ϴ� ��� ���� �߻�

CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;
   
SELECT * FROM VW_EMP2;          --> 8�� ��ȸ

-- 200�� ����� �޿��� 200�������� ���� --> ���������� ���ǿ� �������� �ʾƵ� �� ���� ��!
UPDATE VW_EMP2
SET SALARY = 2000000   
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

ROLLBACK;


CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP2;

UPDATE VW_EMP2
SET SALARY = 2000000
WHERE EMP_ID = 200; --> ���������� ����� ���ǿ� �������� �ʱ⶧���� ���� �Ұ�

UPDATE VW_EMP2
SET SALARY = 4000000 
WHERE EMP_ID = 200; --> ���������� ����� ���ǿ� �����ϱ� ������ ���� ����

ROLLBACK;

-- 4) WITH READ ONLY �ɼ� : �信 ���� ��ȸ�� ���� (DML ����Ұ�)
CREATE OR REPLACE VIEW VW_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM VW_DEPT;

INSERT INTO VW_DEPT VALUES('D0', '�ؿܿ���4��', 'L3');

































