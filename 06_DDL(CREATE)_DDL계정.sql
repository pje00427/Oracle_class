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