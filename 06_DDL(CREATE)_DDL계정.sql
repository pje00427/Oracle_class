INSERT INTO MEMBER VALUES('user01','pass01','홍길동','2020-07-01');
INSERT INTO MEMBER VALUES('user02','pass02','김영희',sysdate);

/*
    < 제약조건 CONSTRAINTS >
    - 원하는 데이터값만 보관하기 위해서 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다. 
    - 들어올 데이터에 문제가 없는지 자동으로 검사할 목적 
    
    * 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY, FOREIGN KEY
*/

/*
    * NOT NULL 제약조건
      해당 컬럼에 반드시 값이 있어야만 하는 경우 사용 (NULL값이 들어와서는 안되는 경우)
      삽입/수정시  NULL값을 허용하지 않도록 제한 
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

INSERT INTO MEM_NOCONST VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','aaa@naver.com');
SELECT * FROM MEM_NOCONST;
INSERT INTO MEM_NOCONST VALUES(2, NULL, NULL, NULL,NULL,NULL,NULL);
-- 값에 NULL값이 있어도 삽입 성공

SELECT * FROM MEM_NOCONST;

-- NOT NULL 제약조건설정을 한 테이블 만들기
-- 테이블 생성시 컬럼에 제약조건을 거는 방식이 크게 두가지 (컬럼레벨 / 테이블레벨) 있다.
-- (단, NOT NULL 제약조건은 컬럼레벨 방식 밖에 안됨!)

-- * 컬럼레벨 방식 표현식 
-- 컬럼명 자료형 (크기) 제약조건

CREATE TABLE MEM_NOTNULL(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);
INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, NULL,NULL,NULL,NULL,NULL,NULL);
--> NOT NULL 제약조건에 위배되어 있어 오류 발생
--> NOT NULL 제약 조건이 걸려있는 컬럼에는 반드시 값이 있어야 한다.
SELECT * FROM MEM_NOTNULL;

--------------------------------------------------------------------------

-- * UNIQUE 제약조건
--  컬럼값에 중복값을 제한하는 제약조건
--  삽입/수정시 기존에 있는 데이터 값 중에 중복값이 있을 경우 추가 안되게끔!
--  컬럼/테이블레벨 방식 둘다 사용 

INSERT INTO MEM_NOTNULL
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222','hgn@gamil.com');
--> 아이디가 중복됐음에도 불구하고 성공적으로 삽입되어버림
SELECT * FROM MEM_NOTNULL;

CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50)
);

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02','pass02','김말똥',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE 
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222','hgn@gamil.com');
--> UNIQUE 제약조건에 위배되었으므로 INSERT 실패!
--> 오류 구문으로 제약조건명으로 알려준다 (컬럼명으로 알려주지 않음)
--> 제약조건명을 지정해주지 않으면 시스템에서 알아서 임의의 제약조건명을 부여해줌


/*
    * 제약조건 부여하는 표현식
    
    > 컬럼레벨 방식
     CREATE TABLE 테이블명(
        컬럼명 자료형(크기) | [CONSTRANT 제약조건명] 제약조건,
        컬럼명 자료형(크기),
        ...
     );
     
    > 테이블레벨 방식
     CREATE TABLE 테이블명(
       컬럼명 자료형(크기),
       컬럼명 자료형(크기),
       ...
       제약조건(컬럼명)

*/
--<필기다시 확인>
CREATE TABLE MEM_UNIQUE2(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEN_NAME VARCHAR2(20) CONSTRAINT MEM_UNIQUE_MEMNAME_NN NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    CONSTRAINT MEM_UNIQUE_MEMID_UQ UNIQUE 
);

INSERT INTO MEM_UNIQUE2 VALUES(1, 'user01','pass01','홍길동','남','010-1234-5678','aaa@naver.com');
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user02','pass02','김말똥',NULL,NULL,NULL);
INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222','hgn@gamil.com');

--------------------------------------------------------------------------------------

-- * CHECK 제약조건 
-- 컬럼에 기록되는 값에 대한 조건을 설정해둘 수 있다.
-- CHECK (조건식)

INSERT INTO MEM_UNIQUE2
VALUES(3, 'user02', 'pass03', '홍길녀', '여', '010-1111-2222','hgn@gamil.com');
--> 성별에 유효한 값이 아닌게 있어도 잘 INSERT되버림

SELECT * FROM MEM_UNIQUE2;

CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3)CHECK(GENDER IN ('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(50),
    UNIQUE (MEN_ID)
 --   CHECK (GENDER IN ('남','여'))
);

-------------------------------

DROP TABLE MEMBER
