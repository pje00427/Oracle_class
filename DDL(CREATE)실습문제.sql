-- 실습문제 --
-- 도서관리 프로그램을 만들기 위한 테이블들 만들기 
-- 이때, 제약조건에 이름을 부여할 것
-- 각 컬럼에 주석달기


CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER PRIMARY KEY,
    PUB_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR(40) 
);

INSERT INTO TB_PUBLISHER
VALUES(1,'그냥',02-1111-2222);

SELECT * FROM TB_PUBLISHER;