/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    Ʈ����� �����ϴ� ���
    
    * Ʈ�����
    - �����ͺ��̽��� ���� �������
    - �������� ���� ����(DML)���� ��� �ϳ��� Ʈ����ǿ� ��� ó��
      COMMIT �ϱ� �������� ������׵��� �ϳ��� Ʈ����ǿ� ��� �ȴ�. 
    - Ʈ������� ����� �Ǵ� SQL : INSERT, UPDATE, DELETE  (DML)
    
    COMMIT(Ʈ����� ����ó�� �� ����), ROLLBACK (Ʈ����� ���), SAVEPOINT (�ӽ�����)
    
    COMMIT ���� : �޸� ���ۿ� �ӽ� ����� �����͸� DB�� �ݿ�
             --> ����۾����� ���������� ó���ϰڴٰ� Ȯ���ϴ� ��ɾ�, �ϳ��� Ʈ����� ������ �����ϰԵ�
             
    ROLLBACK ���� : �޸� ���ۿ� �ӽ� ����� �����͸� ������ �� ������ COMMIT �������� ���ư�
    
    SAVEPOINT : �������� �����صθ� ROLLBACK������ �� ��ü�۾��� �ѹ��ϴ°� �ƴ� SAVEPOINT������ �Ϻθ� �ѹ�
                SAVEPOINT ����Ʈ��1; -- ������ ����
                ROLLBACK TO ����Ʈ��1; -- �ش� ����Ʈ���������� Ʈ����Ǹ� �ѹ���
      
*/

SELECT * FROM EMP_01;

-- EMP_ID�� 901�� ��������
DELETE FROM EMP_01
WHERE EMP_ID = '901'; 

DELETE FROM EMP_01
WHERE EMP_ID = 900;

-- �ΰ��� ���� ������ ������ SAVEPOINT����
SAVEPOINT SP1;

-- 200�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 200;

ROLLBACK TO SP1;

ROLLBACK;

DELETE FROM EMP_01
WHERE EMP_ID IN (217,216,214);

INSERT INTO EMP_01 VALUES(800, 'ȫ�浿', '�ѹ���');

COMMIT; 

INSERT INTO EMP_01 VALUES(801, '�踻��', '�λ��');

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK;

-- 218�� ��� �����
DELETE FROM EMP_01
WHERE EMP_ID = 218;

--> DDL ���� �����ϴ� ���� ������ Ʈ����ǿ� �ִ� ������׵�
--  ������ ���� DB�� �ݿ��ǹ��� (COMMIT ���ѹ���)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01;

















