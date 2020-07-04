

/*

    < SELECT >
    ������ ��ȸ�� �� ���Ǵ� ����
    
    >> RESULT SET : SELECT���� ���� ��ȸ�� ����� (��, ��ȸ�� ����� ������ �ǹ�)
    
    >> ǥ���� <<
    SELECT ��ȸ�ϰ����ϴ� �÷�, �÷�, �÷�,...
    FROM ���̺��;
    
    ��ȸ�ϰ��� �ϴ� �÷����� �ݵ�� FROM���� ����� ���̺� �����ϴ� �÷�
    
*/

-- EMPLOYEE ���̺� ��ü ����� ��� �÷� ���� ��ȸ 
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ��ü ������� ���, �̸�, �޿����� ��ȸ
-- SELECT ���� ��ȸ�ϰ��� �ϴ� �÷���� ����
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

------------------ �ǽ� ����-------------------------
-- 1. JOB���̺��� ��� �÷� ���� ��ȸ

SELECT *
FROM JOB;


-- 2. JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT ���̺��� ��� �÷� ���� ��ȸ
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE ���̺��� �����, �̸���, ��ȭ��ȣ, �Ի���(HIRE_DATE) ���� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- ��ҹ��� ������ ����(��, �빮�� ���ַ� ���)

-- 5. EMPLOYEE ���̺��� �Ի���, �����, �޿� ��ȸ
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-------------------------------------------------

/*
    <�÷����� ���� �������>
    SELECT �� �÷��� �Է� �κп� ��������� �̿��ؼ� ����� ��ȸ�� �� �ִ�. 
*/
-- EMPLOYEE ���̺��� ������, ������ ����(���� = �޿� * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ������, ����, ���ʽ����Ե� ����(�޿� + ���ʽ�*�޿�)*12 ��ȸ
SELECT EMP_NAME, SALARY * 12,(SALARY + BONUS * SALARY) * 12
FROM EMPLOYEE;

--> ��� ���� �� NULL���� ������ ��� ��������� ������� NULL!

-- EMPLOYEE ���̺��� ������, �Ի���, �ٹ��ϼ�(���ó�¥ - �Ի���)
-- DATE ���ĳ����� ���갡��
-- ���ó�¥ : SYSDATE

SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;

-- ��� ���� �� �� �� ����
-- ��, ���� �������� ������ DATE���� ��/��/��/��/��/�� ������ �ð������� �����ϱ� ������

----------------------------------------------------------------------------

/*
    <�÷��� ��Ī �����ϱ�>
    ��������� �ϰ� �Ǹ� �÷����� ��������.. �̶� �÷�����Ī�� �ο��ؼ� ����ϰ� ������ �� ����
    
    >> ǥ���� <<
    �÷��� AS ��Ī / �÷��� AS"��Ī" / �÷��� "��Ī" / �÷��� ��Ī
    
    �ο��ϰ��� �ϴ� ��Ī�� ���� Ȥ�� Ư�����ڰ� ǥ�Ե� ��� �ݵ�� ���������̼�("")�� ��ߵ�
    
-- EMPLOYWW ���̺��� ������(��Ī:�̸�), ����(��Ī:����(��)), ���ʽ����� ����(��Ī:�Ѽҵ�(��))
*/

SELECT EMP_NAME AS �̸�, SALARY*12 AS "����(��)", (SALARY+BONUS*SALARY) * 12 "�Ѽҵ�(��)"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*

    <���ͷ�>
    ���Ƿ� ������ ���ڿ��� SELECT���� ����ϸ� ���̺� �����ϴ� ������ó�� ��ȸ����
    ���ͷ��� RESULT SET�� ��� �࿡ �ݺ������� ����� �ȴ�. 

*/

-- EMPLOYEE ���̺��� ������ȣ, ������, �޿�, ����(�����Ͱ�:��) ��ȸ 
SELECT EMP_ID, EMP_NAME, SALARY, '��' AS ����
FROM EMPLOYEE;

---------------------------------------------------------------------------------

/*
    <DISTINST>
    �÷��� ���Ե� �ߺ����� �ѹ����� ǥ���ϰ��� �� �� ���

*/

-- EMPLOYEE ���̺��� �����ڵ� ��ȸ 

SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �����ڵ�(�ߺ�����)��ȸ
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ� ��ȸ
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �μ��ڵ�(�ߺ�����)��ȸ
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; 
-- DISTINCT�� SELECT���� �� �ѹ��� ��� �� �� ���� 

---------------------------------------------------------------

/*
    < WHERE�� >
    
    ��ȸ�ϰ��� �ϴ� ���̺��� �ش� ���ǿ� �����ϴ� ������� ��ȸ�ϰ��� �� �� ��� 
    ���ǽĿ����� �پ��� �����ڵ� ��밡��
    >> ǥ���� <<
    SELECT ��ȸ�ϰ��� �ϴ� �÷�, �÷�, �÷�,....
    FROM ���̺��
    WHERE ���ǽ�;
    
    < �񱳿����� >
    >, <, >=, <=        --> ��Һ�
    =                   --> �����
    !=, ^=, <>          --> �����ʳ�
    
*/


-- EMPLOYEE ���̺��� �μ��ڵ尡'D9'�� ��ġ�ϴ� ������� ��� �÷� ���� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�� ��ġ�ϴ� ������� ������, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

-- EMPLOYEE ���̺��� �޿��� 400 ���� �̻��� �������� ������, �μ��ڵ�, �޿� ��ȸ

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE ���̺��� �μ��ڵ尡 'D9'�ƴ� ������� ���, �����, �μ��ڵ� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
WHERE DEPT_CODE ^= 'D9';

-- EMPLOYEE ���̺��� ������(ENT_YN�÷����� 'N')�� �������� ���, �̸�, �Ի��� 
SELECT EMP_ID, EMP_NAME, HIRE_DATE '������'
FROM EMPLOYEE
WHERE ENT_YN = 'N';

