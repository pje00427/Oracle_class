/*
    < PL/SQL >
    PROCEDURE LANGUAGE EXTENSION TO SQL
    
    오라클 자체에 내장되어 있는 절차적 언어
    SQL문장 내에서 변수의 정의, 조건처리(IF), 반복처리(LOOP,FOR,WHILE)등을 지원하여
    다수의 SQL문을 한번에 실행 가능
    
    * PL / SQL 구조
    - 선언부 (DECLARE SECTION)      : DECLARE로 시작, 변수나 상수를 선언 및 초기화하는 부분
    - 실행부 (EXECUTABLE SECTION)   : BEGIN으로 시작, 제어문(조건문,반복분) 등의 로직을 기술 하는 부분
    - 예외처리부 (EXCEPTION SECTION) : EXCEPTION으로 시작, 예외발생시 해결하기 위한 구문을 기술하는 부분
    
    * PL/SQL 장점
    BLOCK구조로 다수의 SQL문을 한번에 ORACLE로 보내 처리하므로 수행속도가 빠름
    
    
*/

--* 간단하게 화면에 HELLO ORACLE 출력
-- PUT_LINE을 이용해서 화면에 구문 출력하기 위해서 환경변수를 ON으로 변경해줘야함
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE');
END;
/

------------------------------------------------------------------

-- 1.DECLARE 선언부
-- 변수 및 상수 선언 해 놓는 공간 (초기화도 가능)
-- 일반타입변수, 레퍼런스타입변수, ROW타입변수

-- 1-1) 일반 타입 변수 선언 및 초기화
--      [표현법] 변수명 [CONSTANT] 자료형(크기) [:= 값];
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(30);
    PI CONSTANT NUMBER := 3.14;
BEGIN
    EID := 888;
    ENAME := '배장남';

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- 1_2) 레퍼런스 타입 변수 선언 및 초기화 (어떤테이블의 어떤컬럼의 데이터타입을 참조해서 그 타입으로 지정)
--      [표현법] 변수명 테이블명.컬럼명%TYPE;

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
BEGIN
    -- 사번이 200번인 사원의 사번과 사원명을 각각 EID,ENAME이라는 변수에 대입
    -- 유의할 점 (SELECT INTO를 이용해서 조회결과를 각 변수에 대입시키고자 한다면 반드시 한개의 행으로 조회해야됨)
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID,ENAME,SAL  -- 내가 담고싶은 변수가 두개라면, 셀렉도 두개해야함 SALARY추가할 수 없음
    FROM EMPLOYEE
    WHERE EMP_NAME = '&NAME';
    --> '&' 기호는 대체변수(값을 입력)를 입력하기 위한 창이 뜨게 해주는 구문
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
END;
/

-----------------------------------------------------------------------------------

/*
    레퍼런스타입변수로 EID,ENAME,JCODE, DTITLE, SAL를 선언하고
    각 자료형은 EMPLOYEE테이블 각 EMP_ID, EMP_NAME, JOB_CODE, SALARY
            DEPARTMENT 테이블의 DEPT_TITLE 컬럼 타입 참조
    
    사용자가 입력한 사원명과 일치하는 사원을 조회(사번, 사원명, 직급코드, 부서명, 급여)한 후 조회결과를 각 변수에 대입후 출력

*/
    
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;   
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, JOB_CODE, DEPT_TITLE
    INTO EID,ENAME,SAL,JCODE,DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_ID=DEPT_CODE)
   -- WHERE EMP_NAME = '&이름';
    WHERE EMP_ID = 212;
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SAL);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || JCODE);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DTITLE);
END;
/

------------------------------------------------------------------------

-- 1_3) 한 행에 대한 타입 변수 선언
--      [표현법] 변수명 테이블명%ROWTYPE;
DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT *
    INTO E
    FROM EMPLOYEE
    WHERE EMP_NAME = '선동일';
    DBMS_OUTPUT.PUT_LINE('사번 : ' || E.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('주민번호 : ' || E.EMP_NO);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || E.SALARY);
END;
/

-----------------------------------------------------------------------------

-- 2. BEGIN

-- ** 조건문 **

-- 1) IF 조건식 THEN 실행내용 END IF; (단일 IF문)

-- 사번입력받은 후 해당사원의 사번, 이름, 급여, 보너스율 출력하기 
-- 단, 보너스를 받지 않는 사원은 보너스율 출력 전 '보너스를 지급받지 않는 사원입니다.'

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY || '원');
    DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    
    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    END IF;   
END;
/

-- 2) IF 조건식 THEN 실행내용 ELSE 실행내용 END IF; (IF-ELSE문)

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SALARY EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;
BEGIN 
    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SALARY, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || SALARY || '원');
   

    IF (BONUS = 0)
        THEN DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스율 : ' || BONUS * 100 || '%');
    END IF;   
END;
/

-- 사번을 입력받아 해당 사원의 사번, 이름, 부서명, 국가코드(NATIONAL_CODE)를 조회한 후 출력
-- 변수 : EID, ENAME, DTITLE, NCODE 

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    TEAM VARCHAR2(20);  -- 변수 하나 더 생성 
BEGIN
    SELECT EMP_ID, EMP_NAME,DEPT_TITLE,NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
    WHERE E.DEPT_CODE = D.DEPT_ID
        AND D.LOCATION_ID = L.LOCAL_CODE
        AND E.EMP_ID = &사번;
   IF (NCODE = 'KO')
        THEN TEAM := '국내팀';
   ELSE
        TEAM := '해외팀';
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
   DBMS_OUTPUT.PUT_LINE('이름 :' || ENAME);
   DBMS_OUTPUT.PUT_LINE('소속 :' || TEAM);
END;
/

--3) IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2 ELSE 실행내용 END IF; (IF-ELSE-IF문)

-- 점수를 입력받아 SCORE 변수에 저장한 후 
-- 90점 이상은 'A', '80'점 이상은 'B', 70점 이상은 'C', 60 점 이상은 'D', 60점 미만은 'F'로 처리한 후
-- GRADE 변수에 저장
-- '당신의 점수는 xx점이고, 학점은 X학점입니다.

DECLARE 
    SCORE NUMBER;
    GRADE VARCHAR2(1);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90 THEN GRADE := 'A';
    ELSIF SCORE >= 80 THEN GRADE := 'B';
    ELSIF SCORE >= 70 THEN GRADE := 'C';
    ELSIF SCORE >= 60 THEN GRADE := 'D';
    ELSE GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || SCORE || '점이고, 학점은 '|| GRADE || '학점입니다.');
    
END;    
/

-- 사용자에게 입력받은 사번과 일치하는 사원의 급여 조회한 후 (SAL변수에 대입)
-- 500만 이상이면 '고급'
-- 300만 이상이면 '중급'
-- 300만 미만이면 '초급'
-- '해당 사원의 급여등급은 XX입니다.'
DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    IF SAL >= 5000000 THEN GRADE := '고급';
    ELSIF SAL >= 3000000 THEN GRADE := '중급';
    ELSE GRADE := '초급';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE || '입니다.');
END;
/



-----------------------------------------------------------------------------

-- 4) CASE 비교할대상자 WHEN 동등비교할값1 THEN 결과값1 WHEN 비교값2 THEN 결과값2 ELSE 결과값 END; (SWITCH문)

-- 사번입력받은 후 해당 사원의 모든 컬럼 데이터 EMP에 대입

DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DNAME VARCHAR2(30);
BEGIN 
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;

    DNAME := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
             END;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || DNAME);
END;
/


        
-- ** 반복문 **

/*
    1) BASIC LOOP 
    
    [표현식]
    LOOP
        반복적으로 실행시킬 구문
        
        반복문을 빠져나갈 조건 
        
    END LOOP;    
    
    --> 반복문을 빠져나갈 조건문 (두가지 표현)
        IF 조건식 THEN EXIT END IF;
        EXIT WHEN 조건식;
    
*/

-- 1~5까지 순차적으로 1씩 증가하는 값을 출력 
DECLARE
    N NUMBER := 1; 
BEGIN 
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);  -- 출력하고
        N := N + 1;  -- 1증가시키고
        
        --IF N > 5 THEN EXIT; END IF; -- 조건검사를 한번 더 해주는 
        EXIT WHEN N > 5;
    END LOOP;    
END;
/

------------------------------------------------------
/*
    2) FOR LOOP
    
    [표현식]
    FOR 변수 IN [REVERSE] 초기값..최종값
    LOOP
        반복적으로 실행할 구문;
    END LOOP;
    
*/

BEGIN 
    FOR N IN 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/
-- 역으로 출력
BEGIN 
    FOR N IN REVERSE 1..5
    LOOP 
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/

-- 반복문을 이용한 데이터 삽입
CREATE TABLE TEST2(
    NUM NUMBER,
    TODAY DATE
);

SELECT * FROM TEST2;

BEGIN
    FOR I IN 1..10
    LOOP
        INSERT INTO TEST2 VALUES(I, SYSDATE);
    END LOOP;
END;
/

-- 중첩 반복문
-- 구구단(2~9단) 출력하기
DECLARE
    RESULT NUMBER;
BEGIN

    -- 바깥쪽 FOR문에 단수 (2~9)
    -- 안쪽 FOR문에 곱해지는 수 (1~9)
    
    FOR DAN IN 2..9
    LOOP
        -- 짝수단만 출력하고자 할때
        
        IF MOD(DAN, 2) = 0
        THEN
            DBMS_OUTPUT.PUT_LINE('== ' || DAN || '단 ==');
            FOR SU IN 1..9
            LOOP
                RESULT := DAN * SU;
                DBMS_OUTPUT.PUT_LINE(DAN || ' X ' || SU || ' = ' || RESULT);
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
        
    END LOOP;
END;
/

---------------------------------------------------------------------------------

/*
    3) WHILE LOOP
    
    [표현식]
    WHILE 반복문이수행될조건 
    LOOP
        반복적으로 실행할구문
    END LOOP;
    
*/
-- 1-5까지 순차적으로 1씩 증가하는 값 출력 
DECLARE
    N NUMBER := 1;
BEGIN 
    WHILE N <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        N := N +1;
    END LOOP;
END;
/

--WHILE 문으로 구구단(2~9 단) 출력 
DECLARE
    RESULT NUMBER;
    DAN NUMBER := 2;
    SU NUMBER;
BEGIN 

    WHILE DAN <= 9 
    LOOP
        DBMS_OUTPUT.PUT_LINE('== ' || DAN || '단 ==');
        SU := 1;
        WHILE SU <= 9
        LOOP
            RESULT := DAN * SU;
            DBMS_OUTPUT.PUT_LINE(DAN || 'X' || SU || ' = ' || RESULT);
            SU := SU+1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
    DAN := DAN+1;
END LOOP;
END;
/
------------------------------------------
/*
    3. 예외처리부(EXCEPTION)
    예외(EXCEPTION) : 실행중 발생하는 오류
    
    [표현식]
    EXCEPTION
        WHEN 예외명1 THEN 예외처리구문1;
        WHEN 예외명2 THEN 예외처리구문1;
        ...
        WHEN OTHERS THEN 예외처리구문;
        
     * 시스템 예외 (오라클에서 미리정의 되어있는 예외)
     - NO_DATA_FOUND : SELECT문 수행 결과가 한 행도 없을 경우 
     - TOO_MANY_ROWS : 한 행만 리턴해야되는 SELECT문이 여러행을 반환 할 때
     - ZERO_DIVIDE : 0으로 나눌 때
     - DUP_VAL_ON_INDEX : UNIQUE 제약 조건을 가진 컬럼에 중복된 데이터가 INSERT될 때
    
*/
-- 사용자가 입력한 수로 나눗셈 연산한 결과 출력 
DECLARE
    RESULT NUMBER;
BEGIN
    RESULT := 10 / &숫자;
    DBMS_OUTPUT.PUT_LINE('결과: ' || RESULT);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없어요!');
    --WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없어요!');
END;
/

-- UNIQUE  제약조건 위배시
BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME ='노옹철';
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('이미 존재하는 사번입니다!');
END;
/

SELECT * FROM EMPLOYEE;