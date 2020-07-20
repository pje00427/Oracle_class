--�� ���б� ��ũ�� ����
--SQL04_DDL

-- 1��
-- �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CATEGORY(
        NAME VARCHAR2(10),
        USE_YN CHAR(1) DEFAULT 'Y'
);

-- 2��
-- ���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE(
        NO VARCHAR2(5) PRIMARY KEY,
        NAME VARCHAR2(10)
);

-- 3��
-- TB_CATEGORY ���̺��� NAME �÷��� PRIMARY KEY�� �����Ͻÿ�.
-- (KEY �̸��� �������� �ʾƵ� ������. ���� KEY�� �����ϰ��� �Ѵٸ� �̸��� ������ �˾Ƽ� ������ �̸��� ����Ѵ�.)
ALTER TABLE TB_CATEGORY
ADD CONSTRAINT NAME_PK PRIMARY KEY(NAME);

-- 4��
-- TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME CONSTRAINT NAME_NN NOT NULL; 

-- 5��
-- �� ���̺��� �÷� ���� NO�� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10����, �÷����� NAME�� ���� ���������� ���� Ÿ���� �����ϸ鼭
-- ũ�� 20���� �����Ͻÿ�.
ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

-- 6��
-- �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� ���̺� �̸��� �տ� ���� ���·� �����Ѵ�.
-- EX. CATEGORY_NAME
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7��
-- TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY_KEY �̸��� ������ ���� �����Ͻÿ�
-- PRIMARY KEY�� �̸��� "PK_ + �÷��̸�"���� �����Ͻÿ�
ALTER TABLE TB_CATEGORY
RENAME COLUMN CATEGORY_NAME TO PK_CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN CLASS_TYPE_NO TO PK_CLASS_TYPE_NO;

-- 8��
-- ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO TB_CATEGORY VALUES('����','Y');
INSERT INTO TB_CATEGORY VALUES('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES('����','Y');
INSERT INTO TB_CATEGORY VALUES('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES('�ι���ȸ','Y');
COMMIT;


-- 9��
-- TB_DEPARTMENT�� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ����� �����ϵ��� FOREIGN KEY�� �����Ͻÿ�.
-- �� �� KEY �̸��� FK_���̺��̸�_�÷��̸����� �����Ѵ�
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY FOREIGN KEY(CATEGORY) REFERENCES TB_CATEGORY(PK_CATEGORY_NAME);


-- 10��
-- �� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW�� ������� �Ѵ�.
-- �Ʒ� ������ �����Ͽ� ������ SQL���� �ۼ��Ͻÿ�.
CREATE VIEW VW_�л��Ϲ�����(�й�, �л��̸�, �ּ�)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
   FROM TB_STUDENT;
   
-- 11��
-- �� ������б��� 1�⿡ �� ���� �а����� ���������� ���� ����� �����Ѵ�.
-- �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸����� �����Ǿ� �ִ� VIEW�� ����ÿ�.
-- �̶� ���� ���簡 ���� �л��� ���� �� ������ ����Ͻÿ�.
-- (��, �� VIEW�� �ܼ� SELECT���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE VIEW VW_�������(�л��̸�, �а��̸�, ���������̸�)
AS SELECT STUDENT_NAME, DEPARTMENT_NAME, NVL(PROFESSOR_NAME,'�������� ����')
   FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR P
   WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
   AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
   ORDER BY 2;

-- 12��
-- ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW�� �ۼ��غ���.
CREATE VIEW VW_�а����л���(DEPARTMENT_NAME, STUDENT_COUNT)
AS SELECT DEPARTMENT_NAME, COUNT(*)
   FROM TB_DEPARTMENT D, TB_STUDENT S
   WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
   GROUP BY DEPARTMENT_NAME;
   
-- 13��
-- ������ ������ �л��Ϲ����� VIEW�� ���ؼ� �й��� A213046�� �л��� �̸��� ���� �̸����� ����
UPDATE VW_�л��Ϲ�����
SET �л��̸� = '�����̸�'
WHERE �й� = 'A213046';

-- 14��
-- 13�������� ���� VIEW�� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW�� ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�
-- WITH READ ONLY ���� �� SELECT�� ����
CREATE OR REPLACE VIEW VW_�л��Ϲ�����(�й�, �л��̸�, �ּ�)
AS SELECT STUDENT_NO, STUDENT_NAME, STUDENT_ADDRESS
   FROM TB_STUDENT
   WITH READ ONLY;