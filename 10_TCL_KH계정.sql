/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션 제어하는 언어
    
    * 트랜잭션
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경 사항(DML)들을 묶어서 하나의 트랜잭션에 담아 처리
      COMMIT 하기 전까지의 변경사항들을 하나의 트랜잭션에 담게 된다. 
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE  (DML)
    
    COMMIT(트랜잭션 종료처리 후 저장), ROLLBACK (트랜잭션 취소), SAVEPOINT (임시저장)
    
    COMMIT 진행 : 메모리 버퍼에 임시 저장된 데이터를 DB에 반영
             --> 모든작업들을 정상적으로 처리하겠다고 확정하는 명령어, 하나의 트랜잭션 과정을 종료하게됨
             
    ROLLBACK 진행 : 메모리 버퍼에 임시 저장된 데이터를 삭제한 후 마지막 COMMIT 시점으로 돌아감
    
    SAVEPOINT : 저장점을 정의해두면 ROLLBACK진행할 때 전체작업을 롤백하는게 아닌 SAVEPOINT까지의 일부만 롤백
                SAVEPOINT 포인트명1; -- 저장점 지정
                ROLLBACK TO 포인트명1; -- 해당 포인트지점까지의 트랜잭션만 롤백함
      
*/

SELECT * FROM EMP_01;

-- EMP_ID가 901인 사원지우기
DELETE FROM EMP_01
WHERE EMP_ID = '901'; 

DELETE FROM EMP_01
WHERE EMP_ID = 900;

-- 두개의 행이 삭제된 시점에 SAVEPOINT지정
SAVEPOINT SP1;

-- 200번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200;

ROLLBACK TO SP1;

ROLLBACK;

DELETE FROM EMP_01
WHERE EMP_ID IN (217,216,214);

INSERT INTO EMP_01 VALUES(800, '홍길동', '총무부');

COMMIT; 

INSERT INTO EMP_01 VALUES(801, '김말똥', '인사부');

SELECT * FROM EMP_01;

COMMIT;

ROLLBACK;

-- 218번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 218;

--> DDL 구문 실행하는 순간 기존에 트랜잭션에 있던 변경사항들
--  무조건 실제 DB에 반영되버림 (COMMIT 시켜버림)
CREATE TABLE TEST(
    TID NUMBER
);

ROLLBACK;

SELECT * FROM EMP_01;

















