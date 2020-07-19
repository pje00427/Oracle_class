/*
    < DCL : DATA CONTROL LANGUAGE >
    데이터를 제어하는 언어
    
    계정에게 시스템권한 또는 객체접근 권한 부여(GRANT)하거나 회수(REMOVE)하는 언어
    
    > 시스템 권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
    > 객체권한 : 특정 객체를 조작할 수 있는 권한 
    
    > 시스템권한 종류
    - CREATE SESSION : 계정에 접속 할 수 있는 권한
    - CREATE TABLE : 테이블 생성 할 수 있는 권한 
    - CREATE VIEW : 뷰 생성할 수 있는 권한 
    - CREATE SEQUENCE : 시퀀스 생성할 수 있는 권한 
    - CREATE USER : 계정 생성 권한 
    ...
    
    [표기법]
    GRANT 권한1, 권한2, ... TO 사용자계정명;
    
*/

-- 1. SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 2. 계정에 접속하기 위해 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;
-- 3_1. 계정에 테이블 생성할 수 있는 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;
-- 3_2. 테이블 스페이스 할당해줘야됨!
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

----------------------------------------

/*
    > 객체 권한 종류
    특정 객체를 조작할 수 있는 권한
    
    권한종류     특정객체
    SELECT      TABLE,VIEW,SEQUENCE
    INSERT      TABLE,VIEW
    UPDATE      TABLE,VIEW
    DELETE      TABLE,VIEW
    
    [표기법]
    GRANT 권한종류 ON 특정객체 TO 사용자 계정;
*/

-- 4. KH.EMPLOYEE 테이블에 조회 할 수 있는 권한
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
-- 5. DEPARTMENT 테이블에 삽입할수 있는 권한
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;


----------------------------------

/*
    * 롤(ROLE)
    - 특정 권한들을 하나의 집합으로 모아놓은 것 

    CONNECT : CREATE SESSION (데이터베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, CREATE SEQUENCE, ...(특정 객체들을 생성할 수 있는 권한)
    
    일반 사용자 계정 생성 후 CONNECT, RESOURCE 정도의 최소한의 권한만 부여 

*/

SELECT * 
FROM ROLE_SYS_PRIVS
--WHERE ROLE = 'CONNECT';
WHERE ROLE = 'RESOURCE';