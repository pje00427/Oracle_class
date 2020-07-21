/*
    < 트리거 TRIGGER >
    
    내가 지정한 테이블에 INSERT, UPDATE, DELETE 등의 DML구문에 의해서 변경될 경우
    자동으로 실행될 내용을 정의해놓는 객체
    데이터 무결성을 보장(유효한데이터만 보관)
    EX) 입출고에 대한 데이터 기록시 사용. 재고수량을 업데이트 해야된다거나, 
        회원 탈퇴를 진행하게 되면 기존의 회원 테이블에 데이터 DELETE 후 
        탈퇴 회원들만 보관하는 테이블에 INSERT 처리하는 경우
        
    * 트리거 종류 
    - SQL문의 실행시기에 따른 분류 
    > BEFORE TRIGGER : 해당 SQL문 실행 전 트리거 실행
    > AFTER TRIGGER  : 해당 SQL문 실행 후 트리거 실행
    
    - SQL문에 의해 영향을 받는 각 행에 따른 분류
    > STATEMENT TRIGGER(문장 크리거)
    
    > ROW TRIGGER(행 트리거) : 해당 SQL문 실행 할 때 마다 트리거 실행 
                             트리거 생성 구문 작성 시 FOR EACH ROW 옵션 기술해야만 함 
                > :OLD  : BEFORE INSERT (입력전 자료), BEFORE UPDATE(수정전 자료),BEFORE DELETE(삭제전 자료)
                > :NEW  : AFTER INSERT(입력된 자료), AFTER UPDATE(수정 후 자료)
    UPDATE EMPLOYEE SET SALARY = 8000000;
    
    * 트리거 생성 구문
    [표현식]
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE|AFTER    INSERT|UPDATE|DELETE    ON 테이블명
    [FOR EACH ROW]      --> 행 트리거
    [DECLARE
        선언부]
    BEGIN
        실행부     (해당 위에 지정된 이벤트 발생시 자동으로 실행할 구문)
    [EXCEPTION
        예외처리부]
    END;
    /
*/

-- EMPLOYEE 테이블에 새로운 행이 INSERT 될 때 자동으로 메세지 출력하는 트리거 정의
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/
-- EMPLOYEE 테이블에 INSERT하기
INSERT INTO EMPLOYEE 
VALUES(300, '길성춘', '690919-2102546', 'gil@iei.or.kr','01011112222',
        'D2','J7', 2000000,0.3, NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE 
VALUES(301, '길춘향', '720919-2102546', 'chun@iei.or.kr','01012224444',
        'D3','J6', 2000000,0.3, NULL, SYSDATE, NULL, DEFAULT);

-- 상품 입고 출고 관련 예시

-->> 필요한 테이블 / 시퀀스 생성 

-- 1. 상품에 대한 데이터 보관할 테이블 (TB_PRODECT)
CREATE TABLE TB_PRODUCT(
    PCODE NUMBER PRIMARY KEY, -- 상품코드
    PNAME VARCHAR2(30),     -- 상품명
    BRAND VARCHAR2(30),      -- 브랜드명
    PRICE NUMBER,           -- 가격
    STOCK NUMBER DEFAULT 0  -- 재고
);

-- 상품코드 중복안되게 새로운 번호 발생하는 시퀀스
CREATE SEQUENCE SEQ_PCODE;

-- 샘플 데이터 추가 
INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '갤럭시10','샘송', 1300000, DEFAULT);

SELECT * FROM TB_PRODUCT;

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '아이폰11PRO', '애플', 1000000, DEFAULT);

INSERT INTO TB_PRODUCT
VALUES(SEQ_PCODE.NEXTVAL, '대륙폰', '샤오미', 600000, DEFAULT);


-- 2. 상품 입출고 상세 이력 테이블 (TB_PRODETAIL)
--      (어떤 상품이 어떤날 몇개가 입고 또는 출고가 되었는지 기록하는 테이블)
CREATE TABLE TB_PRODETAIL(
    DCODE NUMBER PRIMARY KEY,   -- 상세코드 (입출고 이력코드)
    PCODE NUMBER,               -- 상품코드 (외래키로 지정 TB_PRODUCT 테이블 참조) 
    PDATE DATE,                 -- 상품입고일
    AMOUNT NUMBER,              -- 수량 (입출고 개수) 
    STATUS VARCHAR2(10),        -- 상태 (입고/출고)        
    CHECK(STATUS IN ('입고','출고')),
    FOREIGN KEY(PCODE) REFERENCES TB_PRODUCT
);
CREATE SEQUENCE SEQ_DCODE;


-- 1번 상품이 오늘날짜로 10개가 입고 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 10, '입고');

SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;
-- 재고 수량도 변경 해야됨
UPDATE TB_PRODUCT
SET STOCK = STOCK + 10
WHERE PCODE = 1;

-- 2번 상품 오늘날짜로 20개가 입고
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 20, '입고');
-- 재고 수량도 변경해야됨
UPDATE TB_PRODUCT
SET STOCK = STOCK + 20
WHERE PCODE = 2;

-- 3번 상품 오늘날짜로 5개가 입고 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 5, '입고');
-- 재고 수량도 변경해야됨
UPDATE TB_PRODUCT
SET STOCK = STOCK + 5
WHERE PCODE = 3;

-- 2번 상품이 오늘 날짜로 5개가 출고 
INSERT INTO TB_PRODETAIL
VALUES(SEQ_DCODE.NEXTVAL,2, SYSDATE,5, '출고');
-- 재고수량도 변경해야됨
UPDATE TB_PRODUCT
SET STOCK = STOCK - 5
WHERE PCODE = 2;

SELECT * FROM TB_PRODETAIL;
SELECT * FROM TB_PRODUCT;

-- TB_PRODETAIL 테이블에 데이터 삽입 (INSERT)시
-- TB_PRODUCT 테이블에 매번 자동으로 재고 슈량 업데이트 되게끔 트리거 생성하자!
--<영상확인>
CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PRODETAIL
FOR EACH ROW 
BEGIN 
    -- 상품이 입고된 경우 --> 재고증가
    IF :NEW.STATUS = '입고'
        THEN 
            UPDATE TB_PRODUCT
            SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
    
    -- 상품이 출고된 경우 --> 재고 감소
    IF :NEW.STATUS = '출고'
        THEN
            UPDATE TB_PRODUCT
            SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PCODE = :NEW.PCODE;
    END IF;
END;
/
SELECT * FROM TB_PRODUCT;
SELECT * FROM TB_PRODETAIL;
-- 1번 상품이 오늘날짜로 5개가 출고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '출고');
-- 2번 상품이 오늘날짜로 100개가 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 100, '입고');
-- 3번 상품이 오늘 날짜로 200개가 입고
INSERT INTO TB_PRODETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 200, '입고');
