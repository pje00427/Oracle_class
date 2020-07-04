-- 한 줄 주석 이다 
/*
    여러 줄 주석이다.
*/

-- 사용자 계정 생성하는 구문 (관리자 계정만이 할 수 있는 역할)
-- [표현법] CREATE USER 계정명 IDENTIFIED BY 계정비밀번호;
CREATE USER KH IDENTIFIED BY KH;

-- 위에서 만들어진 사용자 계정에게 최소한의 권한(데이터관리, 접속) 부여
-- [표현법] GRANT 권한1,권한2, ... TO 계정명; 

GRANT RESOURCE, CONNECT TO KH;

