/*



ROLLBACK

SAVE POINT : 저장점을 정의해두면 ROLLBACK 진행 할 때 전체작업을 롤백하는게 아닌 
SAVEPOINT까지의 일부만 롤백


*/
SELECT * FROM EMP_01;

-- EMP_ID가 901인 사원 지우기 
DELETE FROM EMP_01
WHERE EMP_ID = '901';

SELECT * FROM EMP_01;


