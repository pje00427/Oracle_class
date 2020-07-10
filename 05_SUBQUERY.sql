/*
    * SUBQUERY (서브쿼리)
    - 하나의 SQL문 안에 포함된 또다른 SQL문
*/
-- 간단 서브쿼리 예시1.
-- 노옹철 사원과 같은 부서원들 조회하고 싶다!


-- 1) 노옹철 사원의 부서코드 조회 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철'; --> D9인걸 알아냈다!!

-- 2) 부서코드가 D9인 직원들 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE ='D9';

--> 위의 2단계를 하나의 쿼리로! --> 1) 서브쿼리로!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '노옹철');
                   
-- 간단 서브쿼리 예시2
-- 전 직원의 평균 급여보다 더 많은 급여를 받고 있는 직원들의
-- 사번, 이름, 직급코드, 급여 조회

-- 1) 전 직원의 평균급여 조회하기
SELECT AVG(SALARY)
FROM EMPLOYEE;           --> 대략 3047663원 인것을 알아냄

-- 2) 급여가 3047663원 이상인 직원들의 정보조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--> 위의 2단계를 하나의 쿼리문으로!!

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
-----------------------------------------------------------------

/*
    서브쿼리 구분 
    서브쿼리를 수행한 결과값이 몇행 몇열이냐에 따라서 분류됨 
    - 단일행 서브쿼리 : 서브쿼리의 조회 결과 값의 개수가 오로지 한개 일 때 
    
    - 다중행 서브쿼리 : 서브쿼리의 조회 결과 값의 행수가 여러행 일 때
    
    - 다중열 서브쿼리 : 서브쿼리의 조회 결과값이 한 행이지만 컬럼이 여러개 일 때
    
    - 다중행 다중열 서브쿼리 : 서브쿼리의 조회 결과 값이 여러행 여러열 일 때
    
    >> 서브쿼리 유형에 따라 서브커리 앞에 붙는 연산자가 달라진다
*/
/*
    1. 단일행 서브쿼리 (SINGLE ROW SUBQUERTY)
       서브쿼리의 조회 결과값의 개수가 1개 일 때(단일행 단일열)
       일반연산자 사용
       = != ^= < > , ....
*/
 -- 1) 전 직원의 평균 급여보다 급여를 적게 받는 직원들의
 --     이름, 직급코드, 급여 조회
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY < (SELECT AVG(SALARY) --> 결과 값 1행1열
                 FROM EMPLOYEE  );
                 
-- 2) 최저 급여를 받는 직원의 사번, 이름, 직급코드, 급여, 입사일 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) --> 결과값 1행1열
                FROM EMPLOYEE);
-- 3) 노옹철 사원의 급여보다 많이 받는 사원의 사번, 이름, 부서코드, 직급코드, 급여 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT (SALARY)
                 FROM EMPLOYEE 
                 WHERE EMP_NAME = '노옹철');
-- * 서브쿼리는 WHERE 절 뿐만아니라, SELECT/FROM/HAVING 다양한 곳에서 사용가능

-- 4) 부서별 급여 합이 가장 큰 부서의 부서코드, 급여합 조회
-- 각 부서별 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 급여합 중 가장 큰 값 
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))--> 결과값 1행 1열
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE);
-- 전지연 사원이 속해있는 부서원들 조회 (단, 전지연은 제외)
-- 사번, 사원명, 전화번호, 고용일, 부서코드, 부서명
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '전지연')  -- 이해안감...
AND EMP_NAME != '전지연';                   

------------------------------------------------------------

/*
    2. 다중행 서브쿼리 (MULTI ROW SUBQUERY)
        서브쿼리의 조회 결과 값의 개수가 여러행일 때
    
    - IN / NOT IN  서브쿼리 : 여러 개의 결과 값 중에서 한 개라도 일치하는 값이 있다면 혹은 없다면 이라는 의미
    - > ANY / < ANY 서브쿼리 : 여러개의 결과값 중에서 한개라도 큰         / 작은 경우  
                            여러개의 결과값 중에서 가장 작은값 보다 크냐? / 가장 큰값 보다 작냐?     

    - > ALL / < ALL 서브쿼리 : 여러개의 결과값의 모든 값보다 큰 / 작은 경우
                             가장 큰 값 보다 크냐? / 가장 작은 값보다 작냐?
    
*/
-- 1) 각 부서별 최고급여를 받는 직원의 이름, 직급코드, 부서코드, 급여 조회

--> 각 부서별 최고 급여 조회
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- > 2890000,3660000,8000000 등등

--> 위의 급여를 받는 사원을 조회 
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000,2550000);

--> 합쳐서 하나의 쿼리문으로 !

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)  --> 결과값 여러행 1열
                FROM EMPLOYEE
                GROUP BY DEPT_CODE);
                
-- 2) 사수에 해당하는 직원에 대해 조회

--    사번, 이름, 부서코드, 구분(사수/사원)
--> 사수에 해당하는 사번을 조회
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; --> 201,204,100,200,211,207,214

--> 사번이 위와 같은 직원들의 사번, 이름, 부서코드 조회

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'사수'"구분"
FROM EMPLOYEE
WHERE EMP_ID IN (201, 204, 100, 200, 211, 207, 214);

-- >> 하나의 쿼리문으로 !

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'사수'구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );
                 
-->> 일반 사원에 해당 하는 정보 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사원'구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );

-- >> 한번에 보고싶으면 UNION 사용

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'사수'구분
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    )
 UNION                   
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '사원'구분
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );
                  
-->> SELECT절에 서브쿼리 사용하는 방법
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
       CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '사수'
            ELSE '사원' 
        END 구분
FROM EMPLOYEE;        
      
-- 대리 < 과장
-- 3) 대리 직급임에도 불구하고 과장 직급들의 최소 급여보다 많이 받는 직원 조회
-- 사번, 이름, 직급, 급여

-- >> 과장 직급들의 급여 조회 
SELECT SALARY 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'; -- 2200000, 2500000, 3760000 

-->> 직급이 대리인 직원들 중에서 위의 목록들 값 중에 하나라도 큰 경우 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
    AND SALARY > ANY (2200000,2500000,3760000);
    
-->> 한개의 쿼리문으로 합쳐보자
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '대리'
    AND SALARY > ANY (SELECT SALARY 
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                      WHERE JOB_NAME = '과장');
                      
-- 과장 < 차장
-- 4) 과장 직급이지만 차장 직급의 최대 급여보다 더 많이 받는 직원
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
    AND SALARY > ALL (SELECT SALARY
                  FROM EMPLOYEE 
                  JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '차장');
                    
                    
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '과장'
    AND SALARY > (SELECT  MAX(SALARY)
                  FROM EMPLOYEE 
                  JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '차장');               
 
/*
    3. 다중열 서브쿼리 (단일행)
       조회 결과 값이 한 행이지만 나열된 컬럼 수가 여러개 일 때
*/

-- 1) 하이유 사원과 같은 부서코드, 같은 직급코드에 해당하는 사원 조회
-- 이름, 부서코드, 직급코드 입사일

--> 하이유 사원의 부서코드와 직급코드 먼저 조회
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='하이유';   --> DEPT_CODE:D5, JOB_CODE:J5

--> 부서코드가 D5이면서 직급코드가 J5인 사원들 조회
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
    AND JOB_CODE = 'J5';
    
--> 각각 단일행 서브쿼리로써 먼저 작성
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE -- 단일행
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '하이유')
                   
  AND JOB_CODE = (SELECT JOB_CODE -- 단일행
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '하이유') ;                
 
 -->> 다중열 서브쿼리 
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE --> 결과값 1행 여러열
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '하이유');
-- 2) 박나라 사원과 직급코드가 일치 하면서 같은 사수를 가지고 있는 사원 조회
--   사번, 이름, 직급코드, 사수사번
SELECT EMP_ID,EMP_NAME,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID --> 결과값1행 여러열
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '박나라'); -- J6, 207
--------------------------------------------------------------------------

/*
    4. 다중행 다중열 서브쿼리 
        서브쿼리의 조회 결과 값이 여러행 여러열일 경우 
*/
-- 1) 각 직급별 최소 급여를 받는 사원
--   사번, 이름, 직급코드, 급여

-- 각 직급별 최소 급여 조회 
SELECT JOB_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE JOB_CODE ='J2' AND SALARY = 3700000
   OR JOB_CODE ='J7' AND SALARY = 1380000
   OR JOB_CODE ='J3' AND SALARY = 3400000;
   
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY  
FROM EMPLOYEE
WHERE(JOB_CODE,SALARY) IN (SELECT JOB_CODE, MIN(SALARY)
                            FROM EMPLOYEE
                            GROUP BY JOB_CODE);

-- 2) 각 부서별 최저 급여를 받는 사원을 조회
-- 사번, 사원명, 부서코드 급여
SELECT DEPT_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND SALARY = 2320000
   OR DEPT_CODE = 'D1' AND SALARY = 1380000;
   
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (DEPT_CODE, SALARY) IN(SELECT DEPT_CODE, MIN(SALARY)
                             FROM EMPLOYEE
                             GROUP BY DEPT_CODE);
 -- 부서코드 NULL 인 경우 조회 안됨(하동운)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'없음'), SALARY) IN(SELECT NVL(DEPT_CODE,'없음'), MIN(SALARY)
                                        FROM EMPLOYEE
                                        GROUP BY NVL(DEPT_CODE,'없음'));
 
 ----------------------------------------------------------------------------
 
 /*
    5. 인라인 뷰 (INLINE VIEW)
     FROM 절에 서브쿼리를 제시하는 것
     서브쿼리를 수행한 결과를 테이블 대신에 사용함
 */
-- 사번, 이름, 연봉, 부서코드 
-- 연봉이 3000만원 초과인 사원들만 
SELECT EMP_ID, EMP_NAME, SALARY * 12 연봉, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY * 12 > 30000000;
 
SELECT EMP_NAME,연봉
FROM (SELECT EMP_ID, EMP_NAME, SALARY * 12 연봉, DEPT_CODE
       FROM EMPLOYEE) --> 테이블이라고 생각
WHERE 연봉 > 30000000;  

-- 1) 인라인뷰를 활용한 TOP-N 분석

-- 전 직원 중 급여가 가장 높은 상위 5명 순위, 이름, 급여 조회

-- * ROWNUM : 오라클에서 제공해주는 컬럼, 조회된 순서대로 1부터 순번을 부여해주는 컬럼
SELECT ROWNUM,EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
--> FROM --> SELECT --> ORDER BY : 순서가 뒤죽박죽
-- 이미 순번은 부여된 후 정렬이 된 것 
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-->해결방법. ORDER BY한 결과값을 가지고 ROWNUM 부여해야됨 (인라인 뷰)

SELECT ROWNUM 순위, DEPT_TITLE,E.*
FROM (SELECT *
      FROM  EMPLOYEE
      ORDER BY SALARY DESC)E
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)      
WHERE ROWNUM <= 5;

-- 2) 부서별 평균급여가 높은 3개의 부서의 부서코드, 평균 급여 조회
SELECT ROWNUM, DEPT_CODE, ROUND(평균급여)
FROM (SELECT DEPT_CODE, AVG(SALARY) 평균급여
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC)
WHERE ROWNUM <= 3;
-----------------------------------------------

/*
    6. 순위 매기는 함수
       RANK() OVER(정렬기준)        /   DENSE_RANK() OVER(정렬기준)
       
        - RANK() OVER(정렬기준) : 동일한 순위 이후에 등수를 동일한 인원 수 만큼 건너뛰고 순위 계산
                                EX) 공동1위가 2명이면 그 다음 순위를 3위
                                
        - DENSE_RANK() OVER(정렬기준) : 동일한 순위 이후의 등수를 무조건 1씩 증가시키는
                                      EX) 공동1위가 2명이더라도 그 다음 순위는 2위
*/

-- 사원별 급여가 높은 순대로 순위를 매겨서
-- 사원명, 급여, 순위
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE;
--> 공동 19위 2명 뒤의 순위 21위

-- > 상위 5명만 조회
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) 순위
FROM EMPLOYEE
--WHERE 순위 <= 5; 
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; --WHERE 절에 절대 안됨

SELECT EMP_NAME
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC)순위
       FROM EMPLOYEE )
WHERE 순위 <= 5;       
