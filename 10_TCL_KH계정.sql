/*



ROLLBACK

SAVE POINT : �������� �����صθ� ROLLBACK ���� �� �� ��ü�۾��� �ѹ��ϴ°� �ƴ� 
SAVEPOINT������ �Ϻθ� �ѹ�


*/
SELECT * FROM EMP_01;

-- EMP_ID�� 901�� ��� ����� 
DELETE FROM EMP_01
WHERE EMP_ID = '901';

SELECT * FROM EMP_01;


