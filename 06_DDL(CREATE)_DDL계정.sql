/*
    * DDL (DATA DEFINITION LANGUAGE) : ������ ���� ���
    
    ����Ŭ���� �����ϴ� ��ü(OBJECT)�� 
    ������ �����(CREATE), ������ ����(ALTER)�ϰ�, ���� ��ü�� ����(DROP)�ϴ� ��
    ��, ���� ������ ���� �ƴ� ���� ��ü�� �����ϴ� ���� 
    �ַ� DB������, �����ڰ� �����
    
    ����Ŭ������ ��ü(����) : ���̺�(TABLE), ��(VIEW), ������(SEQUENCE), 
                          �ε���(INDEX), ��Ű��(PACKAGE), Ʈ����(TRIGGER),
                          ���ν���(PROCEDURE), �Լ�(FUNCTION), 
                          ���Ǿ�(SYNONYM), �����(USER)
*/

/*
    < CREATE >
    ���̺�, �ε���, �� ��� �پ��� ��ü�� �����ϴ� ����
    
    1. ���̺� ����
    - ���̺��̶�? : ��(ROW)�� ��(COLUMN)�� �����Ǵ� ���� �⺻���� �����ͺ��̽� ��ü
                  ��� �����ʹ� ���̺��� ���ؼ� �����!!
                  
    * ǥ����
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���, 
        ....
    );
    
    * �ڷ���
    - ���� (CHAR / VARCHAR2) (ũ�������� �ݵ�� �ؾ߸� ��)
      > CHAR : �ִ� 2000BYTE ���� ���� ���� / ���� ���� (�ƹ��� ���� ���� ���͵� ó�� �Ҵ��� ũ�� �״��)
      > VARCHAR2 : �ִ� 4000BYTE ���� ���� ���� / ���� ���� (��� ���� ���� ������ ũ�� ������)
    
    - ���� (NUMBER)
    
    - ��¥ (DATE)
    
*/
-->> ȸ���� ���� �����͸� ������� ���̺� MEMBER �����ϱ�
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

/*
    2. �÷��� �ּ� �ޱ� (�÷��� ���� ��������)
    
    * ǥ����
    COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ��������';

-- ������ ��ųʸ� : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�
SELECT * FROM USER_TABLES;
-- USER_TABLES : ����ڰ� ������ �ִ� ���̺���� �������� ������ Ȯ���� �� �ִ� �����̺�
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���̺�� ���ǵǾ��ִ� �÷��� ���õ� ������ ��ȸ�� �� �ִ� �����̺�

SELECT * FROM MEMBER;

-- ������ �߰� �� �� �ִ� ����
-- INSERT INTO ���̺�� VALUES(�÷���, �÷���, �÷���, �÷���);
INSERT INTO MEMBER VALUES('user01', 'pass01', 'ȫ�浿', '2020-07-01');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES('user02', 'pass02', '�迵��', SYSDATE);

SELECT * FROM MEMBER;

--INSERT INTO MEMBER VALUES('ASDFASDFADSFASDFASDFASDFASDFA', 'pass03', '��ö��', sysdate);



/*
    < �������� CONSTRAINTS > 
    - ���ϴ� �����Ͱ��� �����ϱ� ���ؼ�(�����ϱ� ���ؼ�) Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�.
    - ���� �����Ϳ� ������ ������ �ڵ����� �˻��� ����
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY  
    
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �־�߸� �ϴ� ��� ��� (NULL���� ���ͼ��� �ȵ� ���)
      ����/������ NULL���� ������� �ʵ��� ����
*/

-- �������� �ȵǾ��ִ� ���ο� �Ϲ� ���̺�
CREATE TABLE MEM_NOCONST(
    MEM_NO NUMBER,          -- ȸ����ȣ
    MEM_ID VARCHAR2(20),    -- ȸ�����̵�
    MEM_PWD VARCHAR2(20),   -- ȸ����й�ȣ
    MEM_NAME VARCHAR2(20),  -- ȸ����
    GENDER CHAR(3),         -- ����
    PHONE VARCHAR2(15),     -- ��ȭ��ȣ
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOCONST VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'aaa@naver.com');
SELECT * FROM MEM_NOCONST;
INSERT INTO MEM_NOCONST VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
-- ���� NULL�� �־ ���� ����

SELECT * FROM MEM_NOCONST;

-- NOT NULL �������Ǽ����� �� ���̺� �����
-- ���̺� ������ �÷��� ���������� �Ŵ� ����� ũ�� �ΰ��� (�÷����� / ���̺���) �ִ�.
-- (��, NOT NULL ���������� �÷����� ��� �ۿ� �ȵ�!!)

-- * �÷����� ��� ǥ����
-- �÷��� �ڷ���(ũ��) ��������
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL ���� ���ǿ� ����Ǿ� �־� ���� �߻�
--> NOT NULL ���� ������ �ɷ��ִ� �÷����� �ݵ�� ���� �־�߸� �Ѵ�.
SELECT * FROM MEM_NOTNULL;
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);

-------------------------------------------------------------------------------------

-- * UNIQUE ��������
--   �÷����� �ߺ����� �����ϴ� ��������
--   ����/������ ������ �ִ� ������ �� �߿� �ߺ����� ���� ��� �߰� �ȵǰԲ�!
--   �÷�/���̺��� ��� �Ѵ� ���

INSERT INTO MEM_NOTNULL 
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222', 'hgn@gmail.com');
--> ���̵� �ߺ��������� �ұ��ϰ� ���������� ���Եǹ���
SELECT * FROM MEM_NOTNULL;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222', 'hgn@gmail.com');
--> UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����!
--> ���� �������� �������Ǹ����� �˷���!! (�÷������� �˷����� ����..) --> ���� �ľ��ϱ� ����� 
--> �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ��� �ο�����..

SELECT * FROM MEM_UNIQUE;

/*
    
    * �������� �ο��ϴ� ǥ����
    
    > �÷����� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�] ��������,
        �÷��� �ڷ���(ũ��),
        ...
    );
    
    > ���̺��� ���
    CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��),
        �÷��� �ڷ���(ũ��),
        ....,
        [CONSTRAINT �������Ǹ�] �������� (�÷���)
    );

*/
CREATE TABLE MEM_UNIQUE2(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_UNIQUE_MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_UNIQUE_MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEM_UNIQUE2 VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222', 'hgn@gmail.com');

---------------------------------------------------------------------------------

-- * CHECK ��������
--   �÷��� ��ϵǴ� ���� ���� ������ �����ص� �� �ִ�. 
--   CHECK (���ǽ�)

INSERT INTO MEM_UNIQUE2
VALUES(3, 'user03', 'pass03', 'ȫ���', '��', '010-1111-2222', 'hgn@gmail.com');
--> ������ ��ȿ�� ���� �ƴѰ� �־ �� INSERT �ǹ���!!

SELECT * FROM MEM_UNIQUE2;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')), 
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_ID)
    --CHECK (GENDER IN('��', '��'))
);

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'aaa@naver.com');

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', 'ȫ���', NULL, '010-1111-2222', 'aaa@naver.com');
--> NULL���� INSERT ������!!
--> ���� NULL���� �������� �ϰ��� �Ѵٸ� NOT NULL�� ���� �ο��ؾߵ�!!

--------------------------------------------------------------------------------------

-- ** �⺻��(��������x) ���� ���� ** 

-- INSERT INTO ���̺�� VALUES(��, ��, ��, ��);
-- INSERT INTO ���̺��(�÷���, �÷���, �÷���) VALUES(��, ��, ��);
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME) VALUES('user100', 'pass100', '�̼���');
-->> �������� �÷��� �⺻������ NULL���� ��!!

SELECT * FROM MEMBER;

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME) VALUES('user100', 'pass100', '�̼���');
--> �����ȵ� �÷��� �⺻���� �ο��Ǿ��־��ٸ� NULL���� �ƴ� �⺻���� ���Ե�!

SELECT * FROM MEMBER;

COMMIT;

-------------------------------------------------------------------------------------

-- * PRIMARY KEY (�⺻Ű) �������� 
--   ���̺��� �� ���� ������ �ĺ��ϱ� ���� ����� �÷��� �ο��ϴ� ��������
--   --> ������� ������ �� �ִ� �ĺ����� ���� (EX. ȸ����ȣ, ���, �μ��ڵ�, �����ڵ�, �ֹ���ȣ, �����ȣ, ...)
--   --> PRIMARY KEY�� ���������� �ϰ� �Ǹ� �ش� �� �÷��� NOT NULL + UNIQUE ���������� �ǹ�
--   �������� : �� ���̺� �� �� ���� ���� ����!!
delete FROM MEM_PRIMARYKEY;
DROP TABLE MEM_PRIMARYKEY;
CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- �÷����� ���
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
    --CONSTRAINT MEM_PK PRIMARY KEY(MEM_NO) -- ���̺��� ���
);

INSERT INTO MEM_PRIMARYKEY 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong@naver.com');

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '�̼���', '��', null, null);
--> �⺻Ű �ߺ����� ���� ����

INSERT INTO MEM_PRIMARYKEY
VALUES(null, 'user02', 'pass02', '�̼���', '��', null, null);
--> �⺻Ű null������ ���� ����

INSERT INTO MEM_PRIMARYKEY
VALUES(2, 'user02', 'pass02', '�̼���', '��', null, null);

SELECT * FROM MEM_PRIMARYKEY;

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID)  --> �÷� ��� �⺻Ű ���� --> ����Ű
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-2222', 'hong@naver.com');

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '�踻��', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '������', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(3, NULL, 'pass03', '������', NULL, NULL, NULL);
--> �⺻Ű�� ������ �÷��鿡�� NULL���� ������ �ȵ�!!

SELECT * FROM MEM_PRIMARYKEY2;

-----------------------------------------------------------------------------

-- ȸ����޿� ���� ������ �����ϴ� ���̺�
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES(20, '���ȸ��');
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

SELECT * FROM MEM_GRADE;

-- * FOREIGN KEY (�ܷ�Ű) ��������
--   �ٸ� ���̺� �����ϴ� ���� ���;� �Ǵ� �÷��� �ο��ϴ� ��������
--   --> �ٸ� ���̺��� �����Ѵٰ� ǥ��
--   --> ��, ������ �ٸ� ���̺��� �����ϴ� ���� ����� �� �ִ�. 
--   --> FOREIGN KEY �������ǿ� ���� ���̺� ���� ���谡 ������!!

-- �÷������� ���
-- �÷��� �ڷ���(ũ��) [CONSTRAINT �������Ǹ�] REFERENCES ���������̺��[(�÷���)]

-- ���̺����� ���
-- [CONSTRAINT �������Ǹ�] FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)]

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, --REFERENCES MEM_GRADE--(GRADE_CODE) --> �÷����� ���
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE--(GRADE_CODE) --> ���̺��� ���
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '���߱�', NULL, NULL, NULL, NULL);
--> NULL �� �� ����!!

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', '�Ż��Ӵ�', null, null, null, 40);
--> parent key�� ã�� �� ���ٴ� ���� �߻�
--  40�̶�� ���� MEM_GRADE ���̺� GRADE_CODE �÷����� �����ϴ� ���� �ƴϹǷ� 

-- �θ����̺� (MEM_GRADE) ---����---  �ڽ����̺� (MEM)
-- �ݵ�� �θ����̺� ���� ���� �־�߸���!!

SELECT * FROM MEM;          --> GRADE_ID
SELECT * FROM MEM_GRADE;    --> GRADE_CODE

-- ȸ����ȣ, ȸ�����̵�, ��й�ȣ, �̸�, ��޸�
-->> ����Ŭ����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

-->> ANSI ����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
FULL JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);


-- �θ����̺�(MEM_GRADE)�� �����Ͱ��� �������� ��� ������ �߻��� �� ����!!
SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

-- MEM_GRADE ���̺� GRADE_CODE�� 10�� ������ �����!!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> �ڽ����̺�(MEM) �߿� 10�� ����ϰ� �ֱ� ������ ������ �� ����!!

------------------------------------------------------------------

-- ���� ���ʿ� �ڽ����̺��� ������ �� 
-- �θ����̺��� �����Ͱ� �������� �� ��� ó���� ���� �ɼ����� ���س��� ������!!

-- * FOREIGN KEY ���� �ɼ�

-- �����ɼ��� ������ �������� ������ ON DELETE RESTRICTED (���� ����)���� �⺻ ������ �Ǿ�����!!

SELECT * FROM MEM;

-- ���ǰ� �ִ� ���� ���ٸ� ���� �����ϱ� ��
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(30, 'Ư��ȸ��');

-- MEM ���̺� �ٽ� �����!! (�����ɼ� �����ؼ�!!)
DROP TABLE MEM;
-- 1) ON DELETE SET NULL : �θ����� ������ �ش� �����͸� ����ϰ� �ִ� �ڽ� �����͸� NULL������ �����Ű�� 
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '���߱�', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;

-- GRADE_CODE�� 10�� ������ ��������!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10; --> �������� �� ������!! (��, 10������ ���� �ִ� �ڽĵ����Ͱ����� �� NULL�� ����Ǿ��� ��!)

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

ROLLBACK; -- ���� ��Ű�ڴ�!

DROP TABLE MEM;
-- 2) ON DELETE CASCADE : �θ� ������ ���� �� �ش� �����͸� ���� �ִ� �ڽĵ����͵� ���� �����ع�����
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE CASCADE
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '�踻��', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '�̼���', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '���߱�', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;

-- GRADE_CODE�� 10�� ��������!!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10; --> �������� �� ������ (��, �ش� �����Ͱ� ����ϰ� �ִ� �ڽĵ����͵� ���� DELETE�ǹ���!!)

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

-- �ǽ����� �� Ǫ�źе��� erdcloud ����Ʈ ȸ�������� �� --> ERD ���� --> Ŭ�� Ŭ���ذ��鼭 ���̺� ���� ��


--------------------------------------------------------------------------------

-- KH ��������!!!

-- * SUBQUERY�� �̿��� ���̺� ���� (���̺� ���簰�� ����)

/*
    [ǥ����]
    CREATE TABLE ���̺��
    AS ��������;
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
   FROM EMPLOYEE;
--> �÷�, �÷��� ������ Ÿ��, ����ִ� ������ ��, �������� ���� ��� NOT NULL�� �����

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT * 
   FROM EMPLOYEE
   WHERE 1=0; --> ������ ����ǰ� ��� �࿡ ���� �Ź� FALSE�� ������ �����Ͱ��� ����ȵ�

SELECT * FROM EMPLOYEE_COPY2;


CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 ���� --> SELECT���� ������� �Ǵ� �Լ����� ����� ��� ��Ī�ݵ��!!
    FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY3;

------------------------------------------------------------------------

-- * ���̺� �� ������ �� �ڴʰ� �������� �߰�

-- PRIMARY KEY : ALTER TABLE ���̺�� ADD PRIMARY KEY(�÷���);
-- FOREIGN KEY : ALTER TABLE ���̺�� ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��[(�÷���)];
-- UNIQUE      : ALTER TABLE ���̺�� ADD UNIQUE(�÷���);
-- CHECK       : ALTER TABLE ���̺�� ADD CHECK(�÷������� ����);
-- NOT NULL    : ALTER TABLE ���̺�� MODIFY �÷��� NOT NULL;

-- EMPLOYEE_COPY ���̺� ���� PRIMARY KEY �������� �߰� (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE���̺��� DEPT_CODE�� �ܷ�Ű �������� �߰�
-- �����ϴ� ���̺� DEPARTMENT(DEPT_ID) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE ���̺� JOB_CODE�� �ܷ�Ű �������� �߰�
-- �����ϴ� ���̺� JOB(JOB_CODE)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);

-- DEPARTMENT���̺� LOCATION_ID�� �ܷ�Ű �������� �߰�
-- �����ϴ� ���̺� LOCATION(LOCAL_CODE)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);














