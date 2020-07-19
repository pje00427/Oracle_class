/*
    *DDL (DATA DEFINITION LANGUAGE)
     ������ ���� ��� 
     
     ��ü���� ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
     
     < ALTER >
     ��ü�� �����ϴ� ����
     
     >> ���̺� ���� <<
     
     [ǥ����]
     ALTER TABLE ���̺�� ������ ����;
     
     - ������ ����
     1) �÷� �߰�/����/����
     2) �������� �߰�/����   --> ������ �Ұ� (�����ϰ��� �Ѵٸ� ���� �� �� ������ �߰��ؾߵ�)
     3) ���̺��/�÷���/�������Ǹ� ����
     
*/

-- 1) �÷� �߰�/����/����
-- 1-1) �÷� �߰� (ADD) : ADD �÷��� ������Ÿ�� [DEFAULT �⺻��]

SELECT * FROM DEPT_COPY;

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));
--> ���ο� �÷��� ��������� �⺻���� NULL���� ä������.

-- LNAME �÷� �߰� �⺻�� ������ ä�� 
ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(40) DEFAULT '�ѱ�');
--> ���ο� �÷��� ��������� ���� ������ �⺻������ ä����


-- 1_2) �÷� ����(MODIFY)
--       ������ Ÿ�� ����� : MODIFY �÷��� �ٲٰ����ϴ� ������Ÿ��
--       �⺻�� �����     : MODIFY �÷��� DEFAULT �ٲٰ����ϴ±⺻��
-- DEPT_ID �÷��� ������ Ÿ���� CHAR(3)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); --> �����Ϸ��� ũ�⸦ �ʱ�ȭ �ϴ� ���� ���� ��

-- DEPT_TITLE�÷��� ������Ÿ���� VARCHAR2(40)��,
-- LOCATION_ID �÷��� ������Ÿ���� VARCHAR2(2)��,
-- LNAME �÷��� �⺻���� '�̱�'����

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';


-- 1_3) �÷� ���� (DROP COLUMN): DROP COLUMN �����ϰ����ϴ� �÷���
--      ������ ���� ��ϵǾ� �־ ���� ������! (������ �÷� ���� �Ұ���)
--      ���̺��� �ּ� �Ѱ��� �÷��� �����ؾ��Ѵ�. 


CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID �÷������
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK ;--> DDL������ ���� �Ұ���
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID; --> �ּ� �Ѱ��� �־�ߵ�


ALTER TABLE DEPARTMENT DROP COLUMN DEPT_ID; --> �����ǰ� �ִ� �÷� �ִٸ� ���� �Ұ���

------------------------------------------------------------------------------

-- 2) �������� �߰�/����

-- 2_1) �������� �߰�


-- DEPT_COPY ���̺� 
-- DEPT_ID PRIMARY KEY �������� �߰�   ADD
-- DEPT_TITLE�� UNIQUE �������� �߰�    ADD
-- LNAME�� NOT�� NULL �������� �߰�     MODIFY

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

--> �������Ǹ� �ο��ϰ��� �Ѵٸ� : [CONSTRAINT �������Ǹ�] ��������

-- 2_2) �������� ���� : DROP CONSTRAINT �������Ǹ�

-- DCOPY_PK �������� �����
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_UQ �������� �����
-- LNAME NOT NULL �������� ����� (MODIFY �÷��� NULL)
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

--> �������� ������ �Ұ� (���� �� �ٽ� �߰����ָ� ��)

-- 3) �÷���/�������Ǹ�/���̺�� ���� (RENAME)

-- 3_1) �÷��� ���� RENAME COLUMN �����÷��� TO �ٲ��÷���
SELECT * FROM DEPT_COPY;

-- DEPT_TITLE --> DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- SYS_C007239 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007249 TO DCOPY_LID_NN;


-- 3_3) ���̺�� ���� : RENAME �������̺�� TO �ٲ����̺��
-- DEPT_COPY --> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_TEST;

----------------------------------------------------------------

-- ���̺� ����
DROP TABLE DEPT_TEST;
-- DEPARTMENT ���� �θ����̺��� �ڽ����̺��ֱ� ������ �Ժη� ���� �Ұ�
-- ���࿡ �����ϰ��� �Ѵٸ�
-- 1. �ڽ����̺� ������ �� �θ����̺� �����ϴ� ���
-- 2. �������ǵ� �Բ� �����ϴ� ��� DROP TABLE DEPARTMENT CACADE 

DROP TABLE DEPT_TEST CASCADE CONSTRAINT;

