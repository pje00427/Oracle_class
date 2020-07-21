/*
    < Ʈ���� TRIGGER >
    
    ���� ������ ���̺� INSERT, UPDATE, DELETE ���� DML������ ���ؼ� ����� ���
    �ڵ����� ����� ������ �����س��� ��ü
    ������ ���Ἲ�� ����(��ȿ�ѵ����͸� ����)
    EX) ����� ���� ������ ��Ͻ� ���. �������� ������Ʈ �ؾߵȴٰų�, 
        ȸ�� Ż�� �����ϰ� �Ǹ� ������ ȸ�� ���̺� ������ DELETE �� 
        Ż�� ȸ���鸸 �����ϴ� ���̺� INSERT ó���ϴ� ���
        
    * Ʈ���� ���� 
    - SQL���� ����ñ⿡ ���� �з� 
    > BEFORE TRIGGER : �ش� SQL�� ���� �� Ʈ���� ����
    > AFTER TRIGGER  : �ش� SQL�� ���� �� Ʈ���� ����
    
    - SQL���� ���� ������ �޴� �� �࿡ ���� �з�
    > STATEMENT TRIGGER(���� ũ����)
    
    > ROW TRIGGER(�� Ʈ����) : �ش� SQL�� ���� �� �� ���� Ʈ���� ���� 
                             Ʈ���� ���� ���� �ۼ� �� FOR EACH ROW �ɼ� ����ؾ߸� �� 
                > :OLD  : BEFORE INSERT (�Է��� �ڷ�), BEFORE UPDATE(������ �ڷ�),BEFORE DELETE(������ �ڷ�)
                > :NEW  : AFTER INSERT(�Էµ� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
    UPDATE EMPLOYEE SET SALARY = 8000000;
    
    * Ʈ���� ���� ����
    [ǥ����]
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE|AFTER    INSERT|UPDATE|DELETE    ON ���̺��
    [FOR EACH ROW]      --> �� Ʈ����
    [DECLARE
        �����]
    BEGIN
        �����     (�ش� ���� ������ �̺�Ʈ �߻��� �ڵ����� ������ ����)
    [EXCEPTION
        ����ó����]
    END;
    /
*/

-- EMPLOYEE ���̺� ���ο� ���� INSERT �� �� �ڵ����� �޼��� ����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/
-- EMPLOYEE ���̺� INSERT�ϱ�
INSERT INTO EMPLOYEE 
VALUES(300, '�漺��', '690919-2102546', 'gil@iei.or.kr','01011112222',
        'D2','J7', 2000000,0.3, NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE 
VALUES(301, '������', '720919-2102546', 'chun@iei.or.kr','01012224444',
        'D3','J6', 2000000,0.3, NULL, SYSDATE, NULL, DEFAULT);

-- ��ǰ �԰� ��� ���� ����

-->> �ʿ��� ���̺� / ������ ���� 

-- 1. ��ǰ�� ���� ������ ������ ���̺� (TB_PRODECT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY, -- ��ǰ�ڵ�
    PNAME VARCHAR2(30),     -- ��ǰ��
    BRAND VARCHAR2(30),      -- �귣���
    PRICE NUMBER,           -- ����
    STOCK NUMBER DEFAULT 0  -- ���
);

-- ��ǰ�ڵ� �ߺ��ȵǰ� ���ο� ��ȣ �߻��ϴ� ������
CREATE SEQUENCE SEQ_PCODE;

-- ���� ������ �߰� 
INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������10','����', 1300000, DEFAULT);

SELECT * FROM TB_PRODUCT;

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '������11PRO', '����', 1000000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '�����', '������', 600000, DEFAULT);


-- 2. ��ǰ ����� �� �̷� ���̺� (TB_PRODETAIL)
--      (� ��ǰ�� ��� ��� �԰� �Ǵ� ��� �Ǿ����� ����ϴ� ���̺�)
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,   -- ���ڵ� (����� �̷��ڵ�)
    PCODE NUMBER,               -- ��ǰ�ڵ� (�ܷ�Ű�� ���� TB_PRODUCT ���̺� ����) 
    PDATE DATE,                 -- ��ǰ�԰���
    AMOUNT NUMBER,              -- ���� (����� ����) 
    STATUS VARCHAR2(10),        -- ���� (�԰�/���)        
    CHECK(STATUS IN ('�԰�','���')),
    FOREIGN KEY(PCODE) REFERENCES TB_PRODUCT
);
CREATE SEQUENCE SEQ_DCODE;


-- 1�� ��ǰ�� ���ó�¥�� 10���� �԰� 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 10, '�԰�');

SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
-- ��� ������ ���� �ؾߵ�
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 1;

-- 2�� ��ǰ ���ó�¥�� 20���� �԰�
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 20, '�԰�');
-- ��� ������ �����ؾߵ�
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 2;

-- 3�� ��ǰ ���ó�¥�� 5���� �԰� 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 5, '�԰�');
-- ��� ������ �����ؾߵ�
UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 3;

-- 2�� ��ǰ�� ���� ��¥�� 5���� ��� 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL,2, SYSDATE,5, '���');
-- �������� �����ؾߵ�
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 2;

SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;

-- TB_PRODETAIL ���̺� ������ ���� (INSERT)��
-- TB_PRODUCT ���̺� �Ź� �ڵ����� ��� ���� ������Ʈ �ǰԲ� Ʈ���� ��������!
--<����Ȯ��>
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW 
BEGIN 
    -- ��ǰ�� �԰�� ��� --> �������
    IF :NEW.STATUS = '�԰�'
        THEN 
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    
    -- ��ǰ�� ���� ��� --> ��� ����
    IF :NEW.STATUS = '���'
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;
-- 1�� ��ǰ�� ���ó�¥�� 5���� ���
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '���');
-- 2�� ��ǰ�� ���ó�¥�� 100���� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 100, '�԰�');
-- 3�� ��ǰ�� ���� ��¥�� 200���� �԰�
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 200, '�԰�');
