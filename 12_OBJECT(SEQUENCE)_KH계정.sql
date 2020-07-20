/*
    < 시퀀스 SEQUENCE>
    
    자동번호 발생기 역할을 하는 객체
    정수값을 자동으로 순차적으로 생성해줌

*/

/*
    1.시퀀스 생성 구문
    
    [표현식]
    
    CREATE SEQUENCE 시퀀스명
    [START WITH 숫자]         --> 처음 발생시킬 시작값 지정
    [INCREMENT BY 숫자]       --> 다음 발생될 값에 대한 증가치 
    [MAXVALUE 숫자]           --> 발생시킬 최대값 지정
    [MINVALUE 숫자]           --> 최소값 지정
    [CYCLE | NOCYCLE]        --> 값 순환 여부 지정
    [CACHE 바이트크기 | NOCACHE] --> 캐시메모리 할당 (기본값 20바이트)
    
    * 캐시메모리 : 미리 다음값들을 생성해서 저장해둠
                 매번 호출할 때 마다 새로이 생성을 하는것 보다 캐시메모리 공간에 미리생성된 값들을 가져다 쓰면
                 훨씬 속도가 빠름
*/

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [참고] 이 계정이 가지고 있는 시퀀스에 대한 정보
SELECT * FROM USER_SEQUENCES;

/*
    2. SEQUENCE 사용 구문
    
    시퀀스명.CURRVAL  : 현재 시퀀스의 값
    시퀀스명.NEXTVAL  : 시퀀스값을 증가시키고 증가된 시퀀스 값
                        == 시퀀스명.CURRVAL + INCREMENT


*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL를 한번이라도 수행하지 않으면 CURRVAL를 할 수 없음
--> 왜? CURRVAL은 사실 마지막으로 수행된 NEXTVAL값을 저장해서 보여주는 임시값

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 310 초과하면 에러

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

/*
    3. 시퀀스 변경
    
    [표현식]
    
    ALTER SEQUENCE 시퀀스명
    [INCREMENT BY 숫자]
    [MAXVALUE 숫자]
    [MINVALUE 숫자]
    [CYCLE | NOCYCLE]
    [CACHE 바이트수 | NOCACHE];
    
    * START WITH 변경 불가 --> 재설정하고자 한다면 기존 시퀀스 DROP 후 재생성
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --320

DROP SEQUENCE SEQ_EMPNO;

--------------------------------------

-- 매번 새로운 사번이 발생되는 시퀀스 생성
DROP SEQUENCE SEQ_EID;
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '홍길동','666666-6666666', 'hong@iei.or.kr',
        '01041112222', 'D2','J3', 5000000,0.1,NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL,'겅겅','111111-2222222', 'gong@iei.or.kr',
        '01011112222','D1','J3',6000000, NULL,NULL,SYSDATE, NULL,DEFAULT);
ROLLBACK;   


