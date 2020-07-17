/*
    < DML : DATA MANIPULATION LANGUAGE >
    ������ ���� ���
    
    ���̺� ���� ����(INSERT)�ϰų�, ����(UPDATE)�ϰų�, ����(DELETE)�ϴ� ����
    
*/

-- 1. INSERT
--    ���̺� ���ο� ���� �߰��ϴ� ����

/*
    [ǥ����]
    1) INSERT INTO ���̺�� VALUES(��, ��, ��, ��, ....);
       ���̺� ��� �÷��� ���� ���� INSERT�ϰ��� �� �� ���
       �÷� ������ ���Ѽ� VALUES�� ���� �����ؾߵ�!!
*/

INSERT INTO EMPLOYEE
VALUES(900, '��ä��', '980914-2156477', 'jang_ch@kh.or.kr', '01011112222', 
       'D1', 'J7', 4000000, 0.2, 200, sysdate, null, default);

SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��, ��, ��);
       ���̺� ���� ������ �÷��� ���� ���� INSERT�� �� ���
       ���þȵ� �÷��� �⺻������ NULL���� ��� (��, �⺻��(DEFAULT)�� �����Ǿ������� �⺻���� ���)
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '������', '850918-2514655', 'D1', 'J7', sysdate);

SELECT * FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 3) INSERT INTO ���̺�� (��������); 
--    VALUES�� �� �����ϴ°� ��ſ� ���������� ��ȸ�� ������� ��ä�� INSERT �ٷ� ����!

-- ���ο� ���̺� ����
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ����� ��ȸ
INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID));

SELECT * FROM EMP_01;

---------------------------------------------------------------------------

/*
    2. INSERT ALL
       �ΰ� �̻��� ���̺� ���� INSERT�� 
       �� �� ����ϴ� ���������� ������ ���
       INSERT ALL�� �̿��Ͽ� �ѹ��� ���� ����
*/

-->> �켱 ���̺� ����� 
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;


-- �μ��ڵ尡 D1�� ������� ���, �̸�, �μ��ڵ�, �Ի���, ������ ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';



/*
    [ǥ����]
    INSERT ALL 
    INTO ���̺��1 VALUES(�÷���, �÷���, ..)
    INTO ���̺��2 VALUES(�÷���, �÷���, �÷���, ...)
        ��������;
*/

-- EMP_DEPT ���̺��� �μ��ڵ尡 D1�� ����� ���, �̸�, �μ��ڵ�, �Ի����� �����ϰ�
-- EMP_MANAGER ���̺��� �μ��ڵ尡 D1�� ����� ���, �̸�, �������� �����Ұ�!
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * ������ ����ؼ��� �� ���̺� �� INSERT�����ϴ�

CREATE TABLE EMP_OLD   --> 2000�⵵ ������ �Ի��� �Ի��ڵ鿡 ���� ���� ���� ���̺�
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  -- ������ �����ϴ� ��� 

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
/*
 [ǥ����]
 INSERT ALL
 WHEN ����1 THEN
    INTO ���̺��1 VALUES(�÷���,�÷���,...)
 WHEN ����2 WHEN   
    INTO ���̺��2 VALUES(�÷���,�÷���,...)
 ��������;
*/

INSERT ALL
WHEN HIRE_DATE < '2001/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)  
SELECT EMP_ID,EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-------------------------------------------

/*

    3. UPDATE
       ���̺� ��ϵ� �����͸� �����ϴ� ����
       
       [ǥ����]
       UPDATE ���̺��
       SET �÷��� = �ٲܰ� 
           �÷��� = �ٲܰ�, .... --> �������� �÷��� ���ú��� ���� (,�� �����ؾ��Ѵ� AND�ƴ�!)
       [ WHERE ���� ]; �����ϸ� ��ü ������� �����Ͱ� ����Ǿ������. 
           
*/

-- ���纻 ���̺� ���� �� �۾����� !

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;


SELECT * FROM DEPT_COPY;

-- DEPT_ID�� 'D9'�� �μ����� '������ȹ��'���� ����
UPDATE DEPT_COPY
SET DEPT_TITLE = '������ȹ��'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_COPY;

ROLLBACK;

-- �켱 ���纻 ���� ����

CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE,SALARY,BONUS
    FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;    
-- ���ö ����� �޿��� 1000000������ ����
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '���ö';

-- ������ ����� �޿��� 7000000������, ���ʽ��� 0.2�� �����Ͻÿ�
UPDATE EMP_SALARY
SET SALARY=7000000, BONUS=0.2
WHERE EMP_NAME = '������';

SELECT * FROM EMP_SALARY;

-- *UPDATE�ÿ� ���������� ��� ����
--  ��, ���������� ������ ��������� �����ϰڴ�.
/*
    UPDATE ���̺��
    SET �÷��� = (��������)
    WHERE ����;
*/

-- ���� ����� �޿��� ���ʽ����� �����Ҳ���
-- ����� ����� �޿��� ���ʽ������� ���� 

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
               FROM EMPM_SALARY
               WHERE EMP_NAME = '�����'),
    BONUS =  (SELECT BONUS
                FROM EMP_SALARY
                WHERE EMP_NAME ='�����')
WHERE EMP_NAME = '����';    

UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME='�����')
WHERE EMP_NAME ='����';                        
SELECT * FROM EMP_SALARY;                        
-- ���ö, ������, ������, �ϵ��� ������� �޿��� ���ʽ���
-- ����� ����� �޿��� ���ʽ� ������ �����ϴ� UPDATE

UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME='�����')
WHERE EMP_NAME IN ('���ö','������','������','�ϵ���');

-- �ƽþ� ������ �ٹ��ϴ� �������� ���ʽ��� 0.3���� ����

-- �ƽþ� ������ �ٹ��ϴ� �������� ��� ��ȸ
SELECT EMP_ID
FROM EMP_SALARY
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
WHERE LOCAL_NAME LIKE 'ASIA%';

-- �ƽþ� �������� �ٹ��ϴ� �������� ���ʽ����� 0.3���� ����
UPDATE EMP_SALARY
SET BONUS = 0.3
WHERE EMP_ID IN   (SELECT EMP_ID
                    FROM EMP_SALARY
                    JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
                    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
                    WHERE LOCAL_NAME LIKE 'ASIA%');
SELECT * FROM EMP_SALARY;

--------------------------------------------------

-- UPDATE�� ���� �� ���� �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ� 

-- ���ö ����� �μ��ڵ带 D0���� ���� 
DELETE EMPLOYEE
SET DEPT_CODE = 'D0' --> FOREIGN KEY �������� ����Ǿ� ����
WHERE EMP_NAME = '���ö';

-- ����� 200���� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
SET EMP_NAME = NULL         --> NOT NULL �������� ����� 
WHERE EMP_ID = 200;

----------------------------------------------------

/*
    4. DELETE
      ���̺� ��ϵ� �����͸� �����ϴ� ���� (�� ���� �� �����ɲ���)
      
      [ǥ����]
      DELETE FROM ���̺�� 
      [WHERE ����]; --> WHERE�� ���� ���ϸ� ��ü �� �� ���� ��!
      
*/

COMMIT;

-- ��ä�� ����� �����͸� ����� 
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '��ä��';

SELECT * FROM EMPLOYEE;

ROLLBACK;

DELETE FROM EMPLOYEE
WHERE EMP_NAME = '������';

COMMIT;

-- DEPT_ID�� D3�� �μ��� ����!
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';  --> ���� �� �� D3�μ��� ��� ���� (D3�� ���� ������ ���� �ڽĵ����Ͱ� ���⋚���� ���� �ߵ�)

-- DEPT_ID�� D1�� �μ��� ���� 
DELETE FROM DEPARTMENT
WHERE DEPT_ID ='D1';  --> D1�ǰ��� ������ ���� �ڽĵ����Ͱ� �ֱ⶧���� �����Ұ�

ROLLBACK;

-- * TRUNCATE : ���̺��� ��ü ���� ������ �� ���Ǵ� ���� 
--              DELETE ���� ����ӵ��� ������.
--              ������ ���� ���� �Ұ�, ROLLBACK�� �Ұ���
-- [ǥ����] TRUNCATE TABLE ���̺��;

SELECT * FROM EMP_SALARY;

TRUNCATE TABLE EMP_SALARY; -- ���̺��� ������°� �ƴ϶�, �ȿ��ִ� �����Ͱ� ���� ��
