INSERT INTO MEMBER VALUES('user01','pass01','ȫ�浿','2020-07-01');
INSERT INTO MEMBER VALUES('user02','pass02','�迵��',sysdate);

/*
    < �������� CONSTRAINTS >
    - ���ϴ� �����Ͱ��� �����ϱ� ���ؼ� Ư�� �÷��� �����ϴ� ����
    - ������ ���Ἲ ������ �������� �Ѵ�. 
    - ���� �����Ϳ� ������ ������ �ڵ����� �˻��� ���� 
    
    * ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL ��������
      �ش� �÷��� �ݵ�� ���� �־�߸� �ϴ� ��� ��� (NULL���� ���ͼ��� �ȵǴ� ���)
      ����/������  NULL���� ������� �ʵ��� ���� 
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

INSERT INTO MEM_NOCONST VALUES(1, 'user01','pass01','ȫ�浿','��','010-1234-5678','aaa@naver.com');
SELECT * FROM MEM_NOCONST;
INSERT INTO MEM_NOCONST VALUES(2, NULL, NULL, NULL,NULL,NULL,NULL);
-- ���� NULL���� �־ ���� ����

SELECT * FROM MEM_NOCONST;

-- NOT NULL �������Ǽ����� �� ���̺� �����
-- ���̺� ������ �÷��� ���������� �Ŵ� ����� ũ�� �ΰ��� (�÷����� / ���̺���) �ִ�.
-- (��, NOT NULL ���������� �÷����� ��� �ۿ� �ȵ�!)

-- * �÷����� ��� ǥ���� 
-- �÷��� �ڷ��� (ũ��) ��������

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','ȫ�浿','��','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, NULL,NULL,NULL,NULL,NULL,NULL);
--> NOT NULL �������ǿ� ����Ǿ� �־� ���� �߻�
--> NOT NULL ���� ������ �ɷ��ִ� �÷����� �ݵ�� ���� �־�� �Ѵ�.
SELECT * FROM MEM_NOTNULL;

--------------------------------------------------------------------------

-- * UNIQUE ��������
--  �÷����� �ߺ����� �����ϴ� ��������
--  ����/������ ������ �ִ� ������ �� �߿� �ߺ����� ���� ��� �߰� �ȵǰԲ�!
--  �÷�/���̺��� ��� �Ѵ� ��� 

INSERT INTO MEM_NOTNULL
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222','hgn@gamil.com');
--> ���̵� �ߺ��������� �ұ��ϰ� ���������� ���ԵǾ����
SELECT * FROM MEM_NOTNULL;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','ȫ�浿','��','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02','pass02','�踻��',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE 
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222','hgn@gamil.com');
--> UNIQUE �������ǿ� ����Ǿ����Ƿ� INSERT ����!
--> ���� �������� �������Ǹ����� �˷��ش� (�÷������� �˷����� ����)
--> �������Ǹ��� ���������� ������ �ý��ۿ��� �˾Ƽ� ������ �������Ǹ��� �ο�����


/*
    * �������� �ο��ϴ� ǥ����
    
    > �÷����� ���
     CREATE TABLE ���̺��(
        �÷��� �ڷ���(ũ��) | [CONSTRANT �������Ǹ�] ��������,
        �÷��� �ڷ���(ũ��),
        ...
     );
     
    > ���̺��� ���
     CREATE TABLE ���̺��(
       �÷��� �ڷ���(ũ��),
       �÷��� �ڷ���(ũ��),
       ...
       ��������(�÷���)

*/
--<�ʱ�ٽ� Ȯ��>
CREATE TABLE MEM_UNIQUE2(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) CONSTRAINT MEM_UNIQUE_MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_UNIQUE_MEMID_UQ UNIQUE 
);

INSERT INTO MEM_UNIQUE2 VALUES(1, 'user01','pass01','ȫ�浿','��','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user02','pass02','�踻��',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222','hgn@gamil.com');

--------------------------------------------------------------------------------------

-- * CHECK �������� 
-- �÷��� ��ϵǴ� ���� ���� ������ �����ص� �� �ִ�.
-- CHECK (���ǽ�)

INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', 'ȫ���', '��', '010-1111-2222','hgn@gamil.com');
--> ������ ��ȿ�� ���� �ƴѰ� �־ �� INSERT�ǹ���

SELECT * FROM MEM_UNIQUE2;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)CHECK(GENDER IN ('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    UNIQUE (MEN_ID)
 --   CHECK (GENDER IN ('��','��'))
);

-------------------------------

DROP TABLE MEMBER
