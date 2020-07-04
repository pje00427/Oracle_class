

/*

    < SELECT >
    데이터 조회할 때 사용되는 구문
    
    >> RESULT SET : SELECT문을 통해 조회된 결과물 (즉, 조회된 행들의 집합을 의미)
    
    >> 표현법 <<
    SELECT 조회하고자하는 컬럼, 컬럼, 컬럼,...
    FROM 테이블명;
    
    조회하고자 하는 컬럼들은 반드시 FROM절에 기술한 테이블에 존재하는 컬럼
    
*/

-- EMPLOYEE 테이블에 전체 사원의 모든 컬럼 정보 조회 
SELECT *
FROM EMPLOYEE;

-- EMPLOYEE 테이블의 전체 사원들의 사번, 이름, 급여만을 조회
-- SELECT 절에 조회하고자 하는 컬럼명들 나열
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE;

------------------ 실습 문제-------------------------
-- 1. JOB테이블의 모든 컬럼 정보 조회

SELECT *
FROM JOB;


-- 2. JOB 테이블의 직급명 컬럼만 조회
SELECT JOB_NAME
FROM JOB;

-- 3. DEPARTMENT 테이블의 모든 컬럼 정보 조회
SELECT *
FROM DEPARTMENT;

-- 4. EMPLOYEE 테이블의 사원명, 이메일, 전화번호, 입사일(HIRE_DATE) 정보 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;

-- 대소문자 가리지 않음(단, 대문자 위주로 기술)

-- 5. EMPLOYEE 테이블의 입사일, 사원명, 급여 조회
SELECT HIRE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;

-------------------------------------------------

/*
    <컬럼값을 통한 산술연산>
    SELECT 절 컬럼명 입력 부분에 산술연산을 이용해서 결과를 조회할 수 있다. 
*/
-- EMPLOYEE 테이블에서 직원명, 직원의 연봉(연봉 = 급여 * 12)
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원명, 연봉, 보너스포함된 연봉(급여 + 보너스*급여)*12 조회
SELECT EMP_NAME, SALARY * 12,(SALARY + BONUS * SALARY) * 12
FROM EMPLOYEE;

--> 산술 연산 중 NULL값이 존재할 경우 산술연산한 결과값도 NULL!

-- EMPLOYEE 테이블에서 직원명, 입사일, 근무일수(오늘날짜 - 입사일)
-- DATE 형식끼리도 연산가능
-- 오늘날짜 : SYSDATE

SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;

-- 결과 값은 일 수 가 맞음
-- 단, 값이 지저분한 이유는 DATE형은 년/월/일/시/분/초 단위로 시간정보를 관리하기 때문에

----------------------------------------------------------------------------

/*
    <컬럼명에 별칭 지정하기>
    산술연산을 하게 되면 컬럼명이 지저분함.. 이때 컬럼명에별칭을 부여해서 깔끔하게 보여줄 수 있음
    
    >> 표현법 <<
    컬럼명 AS 별칭 / 컬럼명 AS"별칭" / 컬럼명 "별칭" / 컬럼명 별칭
    
    부여하고자 하는 별칭에 띄어쓰기 혹은 특수문자가 표함될 경우 반드시 더블퀘테이션("")을 써야됨
    
-- EMPLOYWW 테이블에서 직원명(별칭:이름), 연봉(별칭:연봉(원)), 보너스포함 연봉(별칭:총소득(원))
*/

SELECT EMP_NAME AS 이름, SALARY*12 AS "연봉(원)", (SALARY+BONUS*SALARY) * 12 "총소득(원)"
FROM EMPLOYEE;

--------------------------------------------------------------------------------

/*

    <리터럴>
    임의로 지정한 문자열을 SELECT절에 사용하면 테이블에 존재하는 데이터처럼 조회가능
    리터럴은 RESULT SET의 모든 행에 반복적으로 출력이 된다. 

*/

-- EMPLOYEE 테이블에서 직원번호, 직원명, 급여, 단위(데이터값:원) 조회 
SELECT EMP_ID, EMP_NAME, SALARY, '원' AS 단위
FROM EMPLOYEE;

---------------------------------------------------------------------------------

/*
    <DISTINST>
    컬럼에 포함된 중복값을 한번씩만 표시하고자 할 때 사용

*/

-- EMPLOYEE 테이블에서 직급코드 조회 

SELECT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직급코드(중복제거)조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 부서코드(중복제거)조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE; 
-- DISTINCT는 SELECT절에 딱 한번만 기술 할 수 있음 

---------------------------------------------------------------

/*
    < WHERE절 >
    
    조회하고자 하는 테이블에서 해당 조건에 만족하는 결과만을 조회하고자 할 때 사용 
    조건식에서는 다양한 연산자들 사용가능
    >> 표현법 <<
    SELECT 조회하고자 하는 컬럼, 컬럼, 컬럼,....
    FROM 테이블명
    WHERE 조건식;
    
    < 비교연산자 >
    >, <, >=, <=        --> 대소비교
    =                   --> 동등비교
    !=, ^=, <>          --> 같지않냐
    
*/


-- EMPLOYEE 테이블에서 부서코드가'D9'와 일치하는 사원들의 모든 컬럼 정보 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

-- EMPLOYEE 테이블에서 부서코드가 'D9'와 일치하는 사원들의 직원명, 부서코드, 급여만 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9';

-- EMPLOYEE 테이블에서 급여가 400 만원 이상인 직원들의 직원명, 부서코드, 급여 조회

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

-- EMPLOYEE 테이블에서 부서코드가 'D9'아닌 사원들의 사번, 사원명, 부서코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
--WHERE DEPT_CODE != 'D9';
WHERE DEPT_CODE ^= 'D9';

-- EMPLOYEE 테이블에서 재직중(ENT_YN컬럼값이 'N')인 직원들의 사번, 이름, 입사일 
SELECT EMP_ID, EMP_NAME, HIRE_DATE '재직중'
FROM EMPLOYEE
WHERE ENT_YN = 'N';

