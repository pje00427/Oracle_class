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
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL);
INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222', 'hgn@gmail.com');

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

-- * PRIMARY KEY (기본키) 제약조건 
--   테이블에서 각 행의 정보를 식별하기 위해 사용할 컬럼에 부여하는 제약조건
--   --> 각행들을 구분할 수 있는 식별자의 역할 (EX. 회원번호, 사번, 부서코드, 직급코드, 주문번호, 예약번호, ...)
--   --> PRIMARY KEY로 제약조건을 하게 되면 해당 그 컬럼에 NOT NULL + UNIQUE 제약조건을 의미
--   주의할점 : 한 테이블 당 한 개만 설정 가능!!
delete FROM MEM_PRIMARYKEY;
DROP TABLE MEM_PRIMARYKEY;
CREATE TABLE MEM_PRIMARYKEY(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, -- 컬럼레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
    --CONSTRAINT MEM_PK PRIMARY KEY(MEM_NO) -- 테이블레벨 방식
);

INSERT INTO MEM_PRIMARYKEY 
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong@naver.com');

INSERT INTO MEM_PRIMARYKEY
VALUES(1, 'user02', 'pass02', '이순신', '남', null, null);
--> 기본키 중복으로 인한 오류

INSERT INTO MEM_PRIMARYKEY
VALUES(null, 'user02', 'pass02', '이순신', '남', null, null);
--> 기본키 null값으로 인한 오류

INSERT INTO MEM_PRIMARYKEY
VALUES(2, 'user02', 'pass02', '이순신', '남', null, null);

SELECT * FROM MEM_PRIMARYKEY;

CREATE TABLE MEM_PRIMARYKEY2(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    PRIMARY KEY(MEM_NO, MEM_ID)  --> 컬럼 묶어서 기본키 설정 --> 복합키
);

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-2222', 'hong@naver.com');

INSERT INTO MEM_PRIMARYKEY2
VALUES(1, 'user02', 'pass02', '김말똥', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(2, 'user02', 'pass03', '유관순', NULL, NULL, NULL);

INSERT INTO MEM_PRIMARYKEY2
VALUES(3, NULL, 'pass03', '유관순', NULL, NULL, NULL);
--> 기본키로 설정된 컬럼들에는 NULL값이 들어가서는 안됨!!

SELECT * FROM MEM_PRIMARYKEY2;

-----------------------------------------------------------------------------

-- 회원등급에 대한 데이터 보관하는 테이블
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT INTO MEM_GRADE VALUES(10, '일반회원');
INSERT INTO MEM_GRADE VALUES(20, '우수회원');
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

SELECT * FROM MEM_GRADE;

-- * FOREIGN KEY (외래키) 제약조건
--   다른 테이블에 존재하는 값만 들어와야 되는 컬럼에 부여하는 제약조건
--   --> 다른 테이블을 참조한다고 표현
--   --> 즉, 참조된 다른 테이블이 제공하는 값만 사용할 수 있다. 
--   --> FOREIGN KEY 제약조건에 의해 테이블 간의 관계가 형성됨!!

-- 컬럼레벨일 경우
-- 컬럼명 자료형(크기) [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명[(컬럼명)]

-- 테이블레벨일 경우
-- [CONSTRAINT 제약조건명] FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(컬럼명)]

CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER, --REFERENCES MEM_GRADE--(GRADE_CODE) --> 컬럼레벨 방식
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE--(GRADE_CODE) --> 테이블레벨 방식
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이순신', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);
--> NULL 들어갈 수 있음!!

INSERT INTO MEM
VALUES(5, 'user05', 'pass05', '신사임당', null, null, null, 40);
--> parent key를 찾을 수 없다는 오류 발생
--  40이라는 값은 MEM_GRADE 테이블 GRADE_CODE 컬럼에서 제공하는 값이 아니므로 

-- 부모테이블 (MEM_GRADE) ---관계---  자식테이블 (MEM)
-- 반드시 부모테이블에 먼저 값이 있어야만함!!

SELECT * FROM MEM;          --> GRADE_ID
SELECT * FROM MEM_GRADE;    --> GRADE_CODE

-- 회원번호, 회원아이디, 비밀번호, 이름, 등급명
-->> 오라클전용
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM, MEM_GRADE
WHERE GRADE_ID = GRADE_CODE(+);

-->> ANSI 구문
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM
FULL JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);


-- 부모테이블(MEM_GRADE)의 데이터값을 삭제했을 경우 문제가 발생할 수 있음!!
SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

-- MEM_GRADE 테이블에 GRADE_CODE가 10인 데이터 지우기!!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--> 자식테이블(MEM) 중에 10을 사용하고 있기 때문에 삭제할 수 없음!!

------------------------------------------------------------------

-- 따라서 애초에 자식테이블을 생성할 때 
-- 부모테이블의 데이터가 삭제됐을 때 어떻게 처리할 지를 옵션으로 정해놓을 수있음!!

-- * FOREIGN KEY 삭제 옵션

-- 삭제옵션을 별도로 제시하지 않으면 ON DELETE RESTRICTED (삭제 제한)으로 기본 지정이 되어있음!!

SELECT * FROM MEM;

-- 사용되고 있는 값이 없다면 삭제 가능하긴 함
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 30;

SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES(30, '특별회원');

-- MEM 테이블 다시 만들기!! (삭제옵션 지정해서!!)
DROP TABLE MEM;
-- 1) ON DELETE SET NULL : 부모데이터 삭제시 해당 데이터를 사용하고 있는 자식 데이터를 NULL값으로 변경시키는 
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이순신', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;

-- GRADE_CODE가 10인 데이터 지워보자!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10; --> 문제없이 잘 삭제됨!! (단, 10가져다 쓰고 있는 자식데이터값들이 다 NULL로 변경되었을 것!)

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

ROLLBACK; -- 원복 시키겠다!

DROP TABLE MEM;
-- 2) ON DELETE CASCADE : 부모 데이터 삭제 시 해당 데이터를 쓰고 있는 자식데이터도 같이 삭제해버리는
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE CASCADE
);

INSERT INTO MEM
VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL, 10);

INSERT INTO MEM
VALUES(2, 'user02', 'pass02', '김말똥', NULL, NULL, NULL, 20);

INSERT INTO MEM
VALUES(3, 'user03', 'pass03', '이순신', null, null, null, 10);

INSERT INTO MEM
VALUES(4, 'user04', 'pass04', '안중근', NULL, NULL, NULL, NULL);

SELECT * FROM MEM;

-- GRADE_CODE가 10인 지워보기!!
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10; --> 문제없이 잘 삭제됨 (단, 해당 데이터가 사용하고 있던 자식데이터도 같이 DELETE되버림!!)

SELECT * FROM MEM_GRADE;
SELECT * FROM MEM;

-- 실습문제 다 푸신분들은 erdcloud 사이트 회원가입할 것 --> ERD 생성 --> 클릭 클릭해가면서 테이블 만들어볼 것


--------------------------------------------------------------------------------

-- KH 계정에서!!!

-- * SUBQUERY를 이용한 테이블 생성 (테이블 복사같은 개념)

/*
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
AS SELECT *
   FROM EMPLOYEE;
--> 컬럼, 컬럼에 데이터 타입, 담겨있는 데이터 값, 제약조건 같은 경우 NOT NULL만 복사됨

SELECT * FROM EMPLOYEE_COPY;

CREATE TABLE EMPLOYEE_COPY2
AS SELECT * 
   FROM EMPLOYEE
   WHERE 1=0; --> 구조만 복사되고 모든 행에 대해 매번 FALSE기 때문에 데이터값은 복사안됨

SELECT * FROM EMPLOYEE_COPY2;


CREATE TABLE EMPLOYEE_COPY3
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉 --> SELECT절에 산술연산 또는 함수식이 기술된 경우 별칭반드시!!
    FROM EMPLOYEE;

SELECT * FROM EMPLOYEE_COPY3;

------------------------------------------------------------------------

-- * 테이블 다 생성된 후 뒤늦게 제약조건 추가

-- PRIMARY KEY : ALTER TABLE 테이블명 ADD PRIMARY KEY(컬럼명);
-- FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명[(컬럼명)];
-- UNIQUE      : ALTER TABLE 테이블명 ADD UNIQUE(컬럼명);
-- CHECK       : ALTER TABLE 테이블명 ADD CHECK(컬럼에대한 조건);
-- NOT NULL    : ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;

-- EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건 추가 (EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY(EMP_ID);

-- EMPLOYEE테이블의 DEPT_CODE에 외래키 제약조건 추가
-- 참조하는 테이블 DEPARTMENT(DEPT_ID) 
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE 테이블에 JOB_CODE에 외래키 제약조건 추가
-- 참조하는 테이블 JOB(JOB_CODE)
ALTER TABLE EMPLOYEE ADD FOREIGN KEY(JOB_CODE) REFERENCES JOB(JOB_CODE);

-- DEPARTMENT테이블에 LOCATION_ID에 외래키 제약조건 추가
-- 참조하는 테이블 LOCATION(LOCAL_CODE)
ALTER TABLE DEPARTMENT ADD FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION(LOCAL_CODE);














