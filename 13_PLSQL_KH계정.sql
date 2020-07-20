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

-- 사용자에게 입력받은 사번과 일치하는 사원의 급여 조회한 후 (SAL 변수에 대입)
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
    END IF ;

    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE || '입니다.');
END;
---<필기확인>
DECLARE
    SAL EMPLOYEE.SALARY%TYPE;
    GRADE VARCHAR2(10);
BEGIN
    SELECT SALARY
    INTO SAL
    FROM EMPLOYEE 
    WHERE EMP_ID = &사번;
    
   SELECT SAL_LEVEL 
   INTO GRADE
   FROM SAL_GRADE
   WHERE SAL BETWEEN MIN_SAL AND MAX_SAL;
   
    DBMS_OUTPUT.PUT_LINE('해당 사원의 급여등급은 ' || GRADE || '입니다.');
END;


-----------------------------------------------------------------------------