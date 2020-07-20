-- �ǽ����� --
-- �������� ���α׷��� ����� ���� ���̺�� ����� --
-- �̶�, �������ǿ� �̸��� �ο��� �� 
--      �� �÷��� �ּ��ޱ�

-- ���ǻ�鿡 ���� �����͸� ������� ���ǻ� ���̺�(TB_PUBLISHER) 
-- �÷� : PUB_NO(���ǻ��ȣ) -- �⺻Ű(PUBLISHER_PK)
--        PUB_NAME(���ǻ��) -- NOT NULL(PUBLISHER_NN)
--        PHONE(���ǻ���ȭ��ȣ) -- �������� ����

-- 3�� ������ ���� ������ �߰��ϱ�


DROP TABLE TB_PUBLISHER;
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER,
    PUB_NAME VARCHAR2(20) CONSTRAINT PUBLISHER_NN NOT NULL, --�÷��������
    PHONE VARCHAR2(20),
    CONSTRAINT PUBLISHER_PK PRIMARY KEY(PUB_NO) --���̺��� ���
);

--�÷��� �ּ��ޱ�
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '��ȭ��ȣ';
SELECT* FROM TB_PUBLISHER;

INSERT INTO TB_PUBLISHER VALUES(1, 'KH����������', '02-1111-2222');
INSERT INTO TB_PUBLISHER VALUES(2, '���е���', '02-3333-4444');
INSERT INTO TB_PUBLISHER VALUES(3, '�ٶ�����', '02-1111-6666');

SELECT PUB_NO ��ȭ��ȣ
FROM TB_PUBLISHER;

-- �����鿡 ���� �����͸� ������� ���� ���̺�(TB_BOOK)
-- �÷� : BK_NO (������ȣ) -- �⺻Ű(BOOK_PK)
--        BK_TITLE (������) -- NOT NULL(BOOK_NN_TITLE)
--        BK_AUTHOR(���ڸ�) -- NOT NULL(BOOK_NN_AUTHOR)
--        BK_PRICE(����)
--        BK_PUB_NO(���ǻ��ȣ) -- �ܷ�Ű(BOOK_FK) (TB_PUB ���̺��� �����ϵ���)
--                                  �̶� �����ϰ� �ִ� �θ����� ���� �� �ڽ� �����͵� ���� �ǵ��� �ɼ� ����

CREATE TABLE TB_BOOK(
    BK_NO NUMBER CONSTRAINT BOOK_PK PRIMARY KEY,
    BK_TITLE VARCHAR2(100) CONSTRAINT BOOK_NN_TITLE NOT NULL,
    BK_AUTHOR VARCHAR(50) CONSTRAINT BOKK_NN_AUTHOR NOT NULL,
    BK_PRICE NUMBER,
    BK_PUB_NO NUMBER 
);

COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '����';
COMMENT ON COLUMN TB_BOOK.BK_STOCK IS '���';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ��ȣ';


-- 5�� ������ ���� ������ �߰��ϱ�

INSERT INTO TB_BOOK VALUES (1, 'Ī���� ���� ���߰��Ѵ�.', '��', 10000, 1);
INSERT INTO TB_BOOK VALUES (2, '�ڹ��� ����', 'ȫ�浿', 20000, 2);
INSERT INTO TB_BOOK VALUES (3, 'ORACLE �������ϱ�', '����Ŭ', 30000, 2);
INSERT INTO TB_BOOK VALUES (4, '�ڹ� ���� �����ϱ�', '���ӽ� ����', 15000, 1);
INSERT INTO TB_BOOK VALUES (5, 'SQL�� ������', '������', 15000, 3);

SELECT * FROM TB_BOOK;  --> BK_PUB_NO
SELECT * FROM TB_PUBLISHER; 

SELECT * 
FROM TB_BOOK
JOIN TB_PUBLISHER ON(BK_PUB_NO = PUB_NO);

-- ȸ���� ���� �����͸� ������� ȸ�� ���̺� (TB_MEMBER)
-- �÷��� : MEMBER_NO(ȸ����ȣ) -- �⺻Ű(MEMBER_PK)
--         MEMBER_ID(���̵�)   -- �ߺ�����(MEMBER_UQ)
--         MEMBER_PWD(��й�ȣ) -- NOT NULL(MEMBER_NN_PWD)
--         MEMBER_NAME(ȸ����) -- NOT NULL(MEMBER_NN_NAME)
--         GENDER(����)        -- 'M' �Ǵ� 'F'�� �Էµǵ��� ����(MEMBER_CK_GEN)
--         ADDRESS(�ּ�)       
--         PHONE(����ó)       
--         STATUS(Ż�𿩺�)     -- �⺻������ 'N'  �׸��� 'Y' Ȥ�� 'N'���θ� �Էµǵ��� ��������(MEMBER_CK_STA)
--         ENROLL_DATE(������)  -- �⺻������ SYSDATE, NOT NULL ��������(MEMBER_NN_EN)

DROP TABLE TB_MEMBER;
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,
    MEMBER_ID VARCHAR2(20) CONSTRAINT MEMBER_UQ UNIQUE,
    MEMBER_PWD VARCHAR2(30) CONSTRAINT MEMBER_NN_PWD NOT NULL,
    MEMBER_NAME VARCHAR2(20) CONSTRAINT MEMBER_NN_NAME NOT NULL,
    GENDER VARCHAR2(1)CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN ('M', 'F')),
    ADDRESS VARCHAR2(100),
    PHONE VARCHAR2(20),
    STATUS VARCHAR2(1) DEFAULT 'N' CONSTRAINT MEMBER_CK_STA CHECK(STATUS IN ('Y', 'N')),
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_ENNOT NOT NULL
);
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '���̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '��й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '����ó';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';


-- 5�� ������ ���� ������ �߰��ϱ�






-- � ȸ���� � ������ �뿩�ߴ����� ����  �뿩��� ���̺�(TB_RENT)
-- �÷� : RENT_NO(�뿩��ȣ) -- �⺻Ű(RENT_PK)
--        RENT_MEM_NO(�뿩ȸ����ȣ) -- �ܷ�Ű(RENT_FK_MEM)  TB_MEMBER�� �����ϵ���
--                                     �̶� �θ� ������ ������ �ڽ� ������ ���� NULL�� �ǵ��� �ɼ� ����
--        RENT_BOOK_NO(�뿩������ȣ) -- �ܷ�Ű(RENT_FK_BOOK)  TB_BOOK�� �����ϵ���
--                                      �̶� �θ� ������ ������ �ڽ� ������ ���� NULL���� �ǵ��� �ɼ� ����
--        RENT_DATE(�뿩��) -- �⺻�� SYSDATE

-- ���õ����� 3�� ����  �߰��ϱ�










