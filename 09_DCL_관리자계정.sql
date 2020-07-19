/*
    < DCL : DATA CONTROL LANGUAGE >
    �����͸� �����ϴ� ���
    
    �������� �ý��۱��� �Ǵ� ��ü���� ���� �ο�(GRANT)�ϰų� ȸ��(REMOVE)�ϴ� ���
    
    > �ý��� ���� : DB�� �����ϴ� ����, ��ü�� ������ �� �ִ� ����
    > ��ü���� : Ư�� ��ü�� ������ �� �ִ� ���� 
    
    > �ý��۱��� ����
    - CREATE SESSION : ������ ���� �� �� �ִ� ����
    - CREATE TABLE : ���̺� ���� �� �� �ִ� ���� 
    - CREATE VIEW : �� ������ �� �ִ� ���� 
    - CREATE SEQUENCE : ������ ������ �� �ִ� ���� 
    - CREATE USER : ���� ���� ���� 
    ...
    
    [ǥ���]
    GRANT ����1, ����2, ... TO ����ڰ�����;
    
*/

-- 1. SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 2. ������ �����ϱ� ���� CREATE SESSION ���� �ο�
GRANT CREATE SESSION TO SAMPLE;
-- 3_1. ������ ���̺� ������ �� �ִ� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. ���̺� �����̽� �Ҵ�����ߵ�!
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

----------------------------------------

/*
    > ��ü ���� ����
    Ư�� ��ü�� ������ �� �ִ� ����
    
    ��������     Ư����ü
    SELECT      TABLE,VIEW,SEQUENCE
    INSERT      TABLE,VIEW
    UPDATE      TABLE,VIEW
    DELETE      TABLE,VIEW
    
    [ǥ���]
    GRANT �������� ON Ư����ü TO ����� ����;
*/

-- 4. KH.EMPLOYEE ���̺� ��ȸ �� �� �ִ� ����
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
-- 5. DEPARTMENT ���̺� �����Ҽ� �ִ� ����
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;


----------------------------------

/*
    * ��(ROLE)
    - Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� �� 

    CONNECT : CREATE SESSION (�����ͺ��̽��� ������ �� �ִ� ����)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ...(Ư�� ��ü���� ������ �� �ִ� ����)
    
    �Ϲ� ����� ���� ���� �� CONNECT, RESOURCE ������ �ּ����� ���Ѹ� �ο� 

*/

SELECT * 
FROM ROLE_SYS_PRIVS
--WHERE ROLE = 'CONNECT';
WHERE ROLE = 'RESOURCE';