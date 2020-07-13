/*
    * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어
    
    오라클에서 제공하는 객체(OBJECT)를 
    새로이 만들고(CREATE), 구조를 변경(ALTER)하고, 구조 자체를 삭제(DROP)하는 등
    즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어로 
    주로 DB관리자, 설계자가 사용함
    
    오라클에서의 객체(구조) : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 
                          인덱스(INDEX), 패키지(PACKAGE), 트리거(TRIGGER),
                          프로시져(PROCEDURE), 함수(FUNCTION), 
                          동의어(SYNONYM), 사용자(USER)
*/

/*
    < CREATE >
    테이블, 인덱스, 뷰 등등 다양한 객체를 생성하는 구문
    
    1. 테이블 생성
    - 테이블이란? : 행(ROW)과 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                  모든 데이터는 테이블을 통해서 저장됨!!
                  
    * 표현식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        컬럼명 자료형, 
        ....
    );
    
    * 자료형
    - 문자 (CHAR / VARCHAR2) (크기지정을 반드시 해야만 함)
      > CHAR : 최대 2000BYTE 까지 저장 가능 / 고정 길이 (아무리 적은 값이 들어와도 처음 할당한 크기 그대로)
      > VARCHAR2 : 최대 4000BYTE 까지 저장 가능 / 가변 길이 (담긴 값에 따라서 공간의 크기 맞춰짐)
    
    - 숫자 (NUMBER)
    
    - 날짜 (DATE)
    
*/
-->> 회원에 대한 데이터를 담기위한 테이블 MEMBER 생성하기
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE
);

SELECT * FROM MEMBER;

/*
    2. 컬럼에 주석 달기 (컬럼에 대한 설명같은거)
    
    * 표현식
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/
COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원가입일';

-- 데이터 딕셔너리 : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블
SELECT * FROM USER_TABLES;
-- USER_TABLES : 사용자가 가지고 있는 테이블들의 전반적인 구조를 확인할 수 있는 뷰테이블
SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 테이블상에 정의되어있는 컬럼과 관련된 정보를 조회할 수 있는 뷰테이블

SELECT * FROM MEMBER;

-- 데이터 추가 할 수 있는 구문
-- INSERT INTO 테이블명 VALUES(컬럼값, 컬럼값, 컬럼값, 컬럼값);
INSERT INTO MEMBER VALUES('user01', 'pass01', '홍길동', '2020-07-01');

SELECT * FROM MEMBER;

INSERT INTO MEMBER VALUES('user02', 'pass02', '김영희', SYSDATE);

SELECT * FROM MEMBER;

--INSERT INTO MEMBER VALUES('ASDFASDFADSFASDFASDFASDFASDFA', 'pass03', '김철수', sysdate);



/*
    < 제약조건 CONSTRAINTS > 
    - 원하는 데이터값만 유지하기 위해서(보관하기 위해서) 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다.
    - 들어올 데이터에 문제가 없는지 자동으로 검사할 목적
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY  
    
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 있어야만 하는 경우 사용 (NULL값이 들어와서는 안될 경우)
      삽입/수정시 NULL값을 허용하지 않도록 제한
*/

-- 제약조건 안되어있는 새로운 일반 테이블
CREATE TABLE MEM_NOCONST(
    MEM_NO NUMBER,          -- 회원번호
    MEM_ID VARCHAR2(20),    -- 회원아이디
    MEM_PWD VARCHAR2(20),   -- 회원비밀번호
    MEM_NAME VARCHAR2(20),  -- 회원명
    GENDER CHAR(3),         -- 성별
    PHONE VARCHAR2(15),     -- 전화번호
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_NOCONST VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
SELECT * FROM MEM_NOCONST;
INSERT INTO MEM_NOCONST VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
-- 값에 NULL이 있어도 삽입 성공

SELECT * FROM MEM_NOCONST;

-- NOT NULL 제약조건설정을 한 테이블 만들기
-- 테이블 생성시 컬럼에 제약조건을 거는 방식이 크게 두가지 (컬럼레벨 / 테이블레벨) 있다.
-- (단, NOT NULL 제약조건은 컬럼레벨 방식 밖에 안됨!!)

-- * 컬럼레벨 방식 표현식
-- 컬럼명 자료형(크기) 제약조건
CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, NULL, NULL, NULL, NULL, NULL, NULL);
--> NOT NULL 제약 조건에 위배되어 있어 오류 발생
--> NOT NULL 제약 조건이 걸려있는 컬럼에는 반드시 값이 있어야만 한다.
SELECT * FROM MEM_NOTNULL;
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL);

-------------------------------------------------------------------------------------

-- * UNIQUE 제약조건
--   컬럼값에 중복값을 제한하는 제약조건
--   삽입/수정시 기존에 있는 데이터 값 중에 중복값이 있을 경우 추가 안되게끔!
--   컬럼/테이블레벨 방식 둘다 사용

INSERT INTO MEM_NOTNULL 
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222', 'hgn@gmail.com');
--> 아이디가 중복됐음에도 불구하고 성공적으로 삽입되버림
SELECT * FROM MEM_NOTNULL;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222', 'hgn@gmail.com');
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패!
--> 오류 구문으로 제약조건명으로 알려줌!! (컬럼명으로 알려주지 않음..) --> 쉽게 파악하기 어려움 
--> 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해줌..

SELECT * FROM MEM_UNIQUE;

/*
    
    * 제약조건 부여하는 표현식
    
    > 컬럼레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기) [CONSTRAINT 제약조건명] 제약조건,
        컬럼명 자료형(크기),
        ...
    );
    
    > 테이블레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(크기),
        컬럼명 자료형(크기),
        ....,
        [CONSTRAINT 제약조건명] 제약조건 (컬럼명)
    );

*/
CREATE TABLE MEM_UNIQUE2(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_UNIQUE_MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_UNIQUE_MEMID_UQ UNIQUE (MEM_ID)
);

INSERT INTO MEM_UNIQUE2 VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'aaa@naver.com');
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user02', 'pass02', , NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222', 'hgn@gmail.com');
SELECT * FROM MEM_UNIQUE2;
---------------------------------------------------------------------------------

-- * CHECK 제약조건
--   컬럼에 기록되는 값에 대한 조건을 설정해둘 수 있다. 
--   CHECK (조건식)

INSERT INTO MEM_UNIQUE2
VALUES(3, 'user03', 'pass03', '홍길녀', '강', '010-1111-2222', 'hgn@gmail.com');
--> 성별에 유효한 값이 아닌게 있어도 잘 INSERT 되버림!!

SELECT * FROM MEM_UNIQUE2;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_ID)
    --CHECK (GENDER IN('남', '여'))
);

INSERT INTO MEM_CHECK
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'aaa@naver.com');

INSERT INTO MEM_CHECK
VALUES(2, 'user02', 'pass02', '홍길녀', NULL, '010-1111-2222', 'aaa@naver.com');
--> NULL값도 INSERT 가능함!!
--> 만일 NULL값도 못들어오게 하고자 한다면 NOT NULL도 같이 부여해야됨!!

SELECT * FROM MEM_CHECK;
--------------------------------------------------------------------------------------

-- ** 기본값(제약조건x) 설정 가능 ** 

-- INSERT INTO 테이블명 VALUES(값, 값, 값, 값);
-- INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME) VALUES('user100', 'pass100', '이순신');
-->> 지정안한 컬럼은 기본적으로 NULL값이 들어감!!

SELECT * FROM MEMBER;

DROP TABLE MEMBER;
CREATE TABLE MEMBER(
    MEMBER_ID VARCHAR2(20),
    MEMBER_PWD VARCHAR2(20),
    MEMBER_NAME VARCHAR2(20),
    MEMBER_DATE DATE DEFAULT SYSDATE
);

INSERT INTO MEMBER(MEMBER_ID, MEMBER_PWD, MEMBER_NAME) VALUES('user100', 'pass100', '이순신');
--> 지정안된 컬럼에 기본값이 부여되어있었다면 NULL값이 아닌 기본값이 들어가게됨!

SELECT * FROM MEMBER;

COMMIT;

-------------------------------------------------------------------------------------






