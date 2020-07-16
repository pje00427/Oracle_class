/*
    < DML : DATA MANIPULATION LANGUAGE >
    데이터 조작 언어
    
    테이블에 값을 삽입(INSERT)하거나, 수정(UPDATE)하거나, 삭제(DELETE)하는 구문
    
*/

-- 1. INSERT
--    테이블에 새로운 행을 추가하는 구문

/*
    [표현식]
    1) INSERT INTO 테이블명 VALUES(값, 값, 값, 값, ....);
       테이블에 모든 컬럼에 대한 값을 INSERT하고자 할 때 사용
       컬럼 순번을 지켜서 VALUES에 값을 나열해야됨!!
*/

INSERT INTO EMPLOYEE
VALUES(900, '장채현', '980914-2156477', 'jang_ch@kh.or.kr', '01011112222', 
       'D1', 'J7', 4000000, 0.2, 200, sysdate, null, default);

SELECT * FROM EMPLOYEE;

/*
    2) INSERT INTO 테이블명(컬럼명, 컬럼명, 컬럼명) VALUES(값, 값, 값);
       테이블에 내가 선택한 컬럼에 대한 값만 INSERT할 때 사용
       선택안된 컬럼은 기본적으로 NULL값이 담김 (단, 기본값(DEFAULT)이 지정되어있으면 기본값이 담김)
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
VALUES(901, '강람보', '850918-2514655', 'D1', 'J7', sysdate);

SELECT * FROM EMPLOYEE;

--------------------------------------------------------------------------------

-- 3) INSERT INTO 테이블명 (서브쿼리); 
--    VALUES로 값 기입하는거 대신에 서브쿼리로 조회한 결과값을 통채로 INSERT 바로 가능!

-- 새로운 테이블 세팅
CREATE TABLE EMP_01(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명을 조회
INSERT INTO EMP_01
    (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
     FROM EMPLOYEE
     LEFT JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID));

SELECT * FROM EMP_01;

---------------------------------------------------------------------------

/*
    2. INSERT ALL
       두개 이상의 테이블에 각각 INSERT시 
       그 때 사용하는 서브쿼리가 동일한 경우
       INSERT ALL을 이용하여 한번에 삽입 가능
*/

-->> 우선 테이블 만들기 
CREATE TABLE EMP_DEPT
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
   FROM EMPLOYEE
   WHERE 1=0;

CREATE TABLE EMP_MANAGER
AS SELECT EMP_ID, EMP_NAME, MANAGER_ID
   FROM EMPLOYEE
   WHERE 1=0;

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;


-- 부서코드가 D1인 사원들의 사번, 이름, 부서코드, 입사일, 사수사번 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';



/*
    [표현식]
    INSERT ALL 
    INTO 테이블명1 VALUES(컬럼명, 컬럼명, ..)
    INTO 테이블명2 VALUES(컬럼명, 컬럼명, 컬럼명, ...)
        서브쿼리;
*/

-- EMP_DEPT 테이블에는 부서코드가 D1인 사원의 사번, 이름, 부서코드, 입사일을 삽입하고
-- EMP_MANAGER 테이블에는 부서코드가 D1인 사원의 사번, 이름, 사수사번을 삽입할것!
INSERT ALL
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE)
INTO EMP_MANAGER VALUES(EMP_ID, EMP_NAME, MANAGER_ID)
    SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE, MANAGER_ID
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D1';

SELECT * FROM EMP_DEPT;
SELECT * FROM EMP_MANAGER;

-- * 조건을 사용해서도 각 테이블에 값 INSERT가능하다

CREATE TABLE EMP_OLD   --> 2000년도 이전에 입사한 입사자들에 대한 정보 담을 테이블
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;  -- 구조만 복사하는 방식 

CREATE TABLE EMP_NEW
AS SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
    FROM EMPLOYEE
    WHERE 1=0;
    
SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;
/*
 [표현식]
 INSERT ALL
 WHEN 조건1 THEN
    INTO 테이블명1 VALUES(컬럼명,컬럼명,...)
 WHEN 조건2 WHEN   
    INTO 테이블명2 VALUES(컬럼명,컬럼명,...)
 서브쿼리;
*/

INSERT ALL
WHEN HIRE_DATE < '2001/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)
WHEN HIRE_DATE >= '2000/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID,EMP_NAME,HIRE_DATE,SALARY)  
SELECT EMP_ID,EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE;

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-------------------------------------------

/*

    3. UPDATE
       테이블에 기록된 데이터를 수정하는 구문
       
       [표현식]
       UPDATE 테이블명
       SET 컬럼명 = 바꿀값 
           컬럼명 = 바꿀값, .... --> 여러개의 컬럼값 동시변경 가능 (,로 나열해야한다 AND아님!)
       [ WHERE 조건 ]; 생략하면 전체 모든행의 데이터가 변경되어버린다. 
           
*/

-- 복사본 테이블 만든 후 작업하자 !

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;

-- DEPT_ID가 'D9'인 부서명을 '전략기획팀'으로 수정
UPDATE DEPT_COPY
SET DEPT_TITLE = '전략기획팀'
WHERE DEPT_ID = 'D9';

SELECT * FROM DEPT_COPY;

ROLLBACK;

-- 우선 복사본 떠서 진행
CREATE TABLE EMP_SALARY
AS SELECT EMP_ID, EMP_NAME, DEPT_CODE,SALARY,BONUS
    FROM EMPLOYEE;
SELECT * FROM EMP_SALARY;    
-- 노옹철 사원의 급여를 1000000원으로 변경
UPDATE EMP_SALARY
SET SALARY = 1000000
WHERE EMP_NAME = '노옹철';

-- 선동일 사원의 급여를 7000000원으로, 보너스를 0.2로 변경하시오
UPDATE EMP_SALARY
SET SALARY=7000000, BONUS=0.2
WHERE EMP_NAME = '선동일';

SELECT * FROM EMP_SALARY;

-- *UPDATE시에 서브쿼리를 사용 가능
--  즉, 서브쿼리를 수행한 결과값으로 변경하겠다.
/*
    UPDATE 테이블명
    SET 컬럼명 = (서브쿼리)
    WHERE 조건;
*/

-- 방명수 사원의 급여와 보너스값을 변경할꺼임
-- 유재식 사원의 급여와 보너스값으로 변경 

UPDATE EMP_SALARY
SET SALARY = (SELECT SALARY
               FROM EMPM_SALARY
               WHERE EMP_NAME = '유재식'),
    BONUS =  (SELECT BONUS
                FROM EMP_SALARY
                WHERE EMP_NAME ='유재식')
WHERE EMP_NAME = '방명수';    

UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME='유재식')
WHERE EMP_NAME ='방명수';                        
                        
-- 노옹철, 전형돈, 정중하, 하동운 사원들의 급여와 보너스를
-- 유재식 사원의 급여와 보너스 값으로 변경하는 UPDATE

UPDATE EMP_SALARY
SET (SALARY,BONUS) = (SELECT SALARY, BONUS
                        FROM EMP_SALARY
                        WHERE EMP_NAME='유재식')
WHERE EMP_NAME IN ('노옹철','전형돈','정중하','하동운');

-- 아시아 지역에 근무하는 직원들의 보너스를 0.3으로 변경

