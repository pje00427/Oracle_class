/*
   < JOIN > 
   
   두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
   수행 결과는 하나의 결과물(Result Set) 로 나옴
   
   관계형 데이터베이스는 최소한의 데이터로 각각의 테이블에 담고 있음 (중복을 최소화하기 위해)
    => 즉, 관계형 데이터베이스에서 SQL문을 이용한 "관계"를 맺는 방법 
    
    무작정 데이터를 가져오는게 아닌 테이블간 연결고리로 관계가 맺어진 데이터를 매칭시켜서 조회해야 한다.
    
    [JOIN 용어 정리]
    JOIN은 크게 "오라클 구문"과 "ANSI 구문" 
    ANSI(미국국립표준협회 == 산업표준을 제정하는 단체)
    
                오라클 DBMS에서만                     오라클 + 다른 DBMS에서도
                    오라클 구문             |               ANSI 구문
    ------------------------------------------------------------------------------------------
                    등가 조인               |        내부 조인 (INNER JOIN) --> JOIN USING/ON  
                                                    자연 조인 (NATURAL JOIN) --> JOIN USING
    ------------------------------------------------------------------------------------------                                               
                    포괄 조인                         왼쪽 외부 조인 (LEFT OUTER JOIN),
                  (LEFT OUTER)                       오른쪽 외부 조인 (RIGHT OUTER JOIN),                      
                  (RIGHT OUTER)                      전체 외부 조인 (FULL OUTER JOIN, 오라클 구문으로는 사용불가)
   ------------------------------------------------------------------------------------------
            자체 조인, 비등가 조인                       JOIN ON
   ------------------------------------------------------------------------------------------
                    카타시안 곱                              교차 조인 (CROSS JOIN)
                    
*/

-- 전사원의 사번, 사원명, 부서코드, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

/*
    1. 등가조인 (EQUAL JOIN) / 내부조인 (INNER JOIN)
        연결시키는 컬럼의 값이 일치하는 행들만 조인되서 도회 (== 일치하는 값이 없는 행은 조회 안됨)
*/
-- >> 오라클 전용 구문 
--  FROM 절에 조회하고자 하는 테이블들 나열(, 구분자로)
--  WHERE 절에 매칭시킬 컬럼명 (연결고리)

-- 1) 연결할 두 컬럼명이 다른경우 (EMPLOYEE:DEPT_CODE   / DEPARTMENT:DEPT_ID)
-- 사번, 사원명, 부서코드, 부서명을 같이 조회 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> 일치하는 값이 없는 행은 조회에서 제외된 것 확인 가능

-- 2) 연결할 두 컬럼명이 같은 경우 (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)
--    사번, 사원명, 직급코드, 직급명

-- 방법 1) 테이블명을 이용하는 방법
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--> AMBIGUAUSLY : 애매하다. 모호하다

-- 방법 2) 별칭 사용 (각 테이블마다 별칭 부여해둘 수 있음)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI 표준 구문
--    FROM절에 기준이 되는 테이블을 하나 기술 한 후 
--    JOIN절에서 같이 조회 하고자 하는 테이블 기술 후 매칭 시킬 컬럼에 대한 조건 기술 
--    USING구문과 ON구문 

-- 1) 연결할 두 컬럼명이 다른 경우 (EMPLOYEE:DEPT_CODE  /   DEPARTMENT:DEPT_ID)
--      ON구문으로만!
-- 사번, 사원명, 부서코드, 부서명 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 2) 연결할 두 컬럼명이 같은 경우 (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)
--  USING 구문 사용! (ON을 통해서 직접매칭도 가능하긴 함)
-- 사번, 사원명, 직급코드, 직급명
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); -- AMBIGUOUSLY 발생 X => USING은 같은 컬럼이라고 인식하기 때문

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE); --AMBIGUOUSLY 발생 O

-- 참고 --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;


