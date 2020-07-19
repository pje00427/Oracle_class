/*
    *DDL (DATA DEFINITION LANGUAGE)
     데이터 정의 언어 
     
     객체들을 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
     
     < ALTER >
     객체를 수정하는 구문
     
     >> 테이블 수정 <<
     
     [표현식]
     ALTER TABLE 테이블명 수정할 내용;
     
     - 수정할 내용
     1) 컬럼 추가/수정/삭제
     2) 제약조건 추가/삭제   --> 수정은 불가 (수정하고자 한다면 삭제 한 후 새로이 추가해야됨)
     3) 테이블명/컬럼명/제약조건명 변경
     
*/

-- 1) 컬럼 추가/수정/삭제
-- 1-1) 컬럼 추가 (ADD) : ADD 컬럼명 데이터타입 [DEFAULT 기본값]

SELECT * FROM DEPT_COPY;

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD (CNAME VARCHAR2(20));
--> 새로운 컬럼이 만들어지고 기본으로 NULL값이 채워진다.

-- LNAME 컬럼 추가 기본값 지정한 채로 
ALTER TABLE DEPT_COPY ADD (LNAME VARCHAR2(40) DEFAULT '한국');
--> 새로운 컬럼이 만들어지고 내가 지정한 기본값으로 채워짐


-- 1_2) 컬럼 수정(MODIFY)
--       데이터 타입 변경시 : MODIFY 컬럼명 바꾸고자하는 데이터타입
--       기본값 변경시     : MODIFY 컬럼명 DEFAULT 바꾸고자하는기본값
-- DEPT_ID 컬럼의 데이터 타입을 CHAR(3)으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER
--ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(10); --> 변경하려는 크기를 초기화 하는 값이 없을 때

-- DEPT_TITLE컬럼의 데이터타입을 VARCHAR2(40)로,
-- LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2)로,
-- LNAME 컬럼의 기본값을 '미국'으로

ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';


-- 1_3) 컬럼 삭제 (DROP COLUMN): DROP COLUMN 삭제하고자하는 컬럼명
--      데이터 값이 기록되어 있어도 같이 삭제됨! (삭제된 컬럼 복구 불가능)
--      테이블에는 최소 한개의 컬럼은 존재해야한다. 


CREATE TABLE DEPT_COPY2
AS SELECT * FROM DEPT_COPY;

SELECT * FROM DEPT_COPY2;

-- DEPT_ID 컬럼지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
ROLLBACK ;--> DDL구문은 복구 불가능
SELECT * FROM DEPT_COPY2;

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;

ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID; --> 최소 한개는 있어야됨


ALTER TABLE DEPARTMENT DROP COLUMN DEPT_ID; --> 참조되고 있는 컬럼 있다면 삭제 불가능

------------------------------------------------------------------------------

-- 2) 제약조건 추가/삭제

-- 2_1) 제약조건 추가


-- DEPT_COPY 테이블에 
-- DEPT_ID PRIMARY KEY 제약조건 추가   ADD
-- DEPT_TITLE에 UNIQUE 제약조건 추가    ADD
-- LNAME에 NOT에 NULL 제약조건 추가     MODIFY

ALTER TABLE DEPT_COPY
ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID)
ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE)
MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

--> 제약조건명 부여하고자 한다면 : [CONSTRAINT 제약조건명] 제약조건

-- 2_2) 제약조건 삭제 : DROP CONSTRAINT 제약조건명

-- DCOPY_PK 제약조건 지우기
ALTER TABLE DEPT_COPY DROP CONSTRAINT DCOPY_PK;

-- DCOPY_UQ 제약조건 지우기
-- LNAME NOT NULL 제약조건 지우기 (MODIFY 컬럼명 NULL)
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DCOPY_UQ
MODIFY LNAME NULL;

--> 제약조건 수정은 불가 (삭제 후 다시 추가해주면 됨)

-- 3) 컬럼명/제약조건명/테이블명 변경 (RENAME)

-- 3_1) 컬럼명 변경 RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
SELECT * FROM DEPT_COPY;

-- DEPT_TITLE --> DEPT_NAME
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

-- 3_2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
-- SYS_C007239 --> DCOPY_LID_NN
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007249 TO DCOPY_LID_NN;


-- 3_3) 테이블명 변경 : RENAME 기존테이블명 TO 바꿀테이블명
-- DEPT_COPY --> DEPT_TEST
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;

SELECT * FROM DEPT_TEST;

----------------------------------------------------------------

-- 테이블 삭제
DROP TABLE DEPT_TEST;
-- DEPARTMENT 같은 부모테이블은 자식테이블있기 때문에 함부로 삭제 불가
-- 만약에 삭제하고자 한다면
-- 1. 자식테이블 삭제한 후 부모테이블 삭제하는 방법
-- 2. 제약조건도 함께 삭제하는 방법 DROP TABLE DEPARTMENT CACADE 

DROP TABLE DEPT_TEST CASCADE CONSTRAINT;

