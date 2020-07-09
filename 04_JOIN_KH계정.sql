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
                   (EQUAL JOIN)                     자연 조인 (NATURAL JOIN) --> JOIN USING
    ------------------------------------------------------------------------------------------                                               
                    포괄 조인                         왼쪽 외부 조인 (LEFT OUTER JOIN),
                  (LEFT OUTER)                      오른쪽 외부 조인 (RIGHT OUTER JOIN),                      
                  (RIGHT OUTER)                      전체 외부 조인 (FULL OUTER JOIN, 오라클 구문으로는 사용불가)
   ------------------------------------------------------------------------------------------
            자체 조인, 비등가 조인                       JOIN ON
   ------------------------------------------------------------------------------------------
                    카타시안 곱                          교차 조인 (CROSS JOIN)
                    
*/

-- 전사원의 사번, 사원명, 부서코드, 부서명 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

/*
    1. 등가조인 (EQUAL JOIN) / 내부조인 (INNER JOIN)
        연결시키는 컬럼의 값이 일치하는 행들만 조인되서 조회 (== 일치하는 값이 없는 행은 조회 안됨)
*/
-- >> 오라클 전용 구문 
--  FROM 절에 조회하고자 하는 테이블들 나열(, 구분자로)
--  WHERE 절에 매칭시킬 컬럼명 (연결고리)

-- 1) 연결할 두 컬럼명이 다른경우 (EMPLOYEE:DEPT_CODE   / DEPARTMENT:DEPT_ID)
-- 사번, 사원명, 부서코드(DEPT_CODE), 부서명을(DEPT_TITLE) 같이 조회 
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

-- 사원번호, 사원명, 부서명
-- >> 오라클 전용 구문 
SELECT EMP_ID,EMP_NAME,DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID); 

-- 사번, 사원명, 직급명 
-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE=J.JOB_CODE;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
--JOIN JOB USING(JOB_CODE);
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE);


-- 직급이 대리인 사원의 사번, 이름, 직급명, 급여를 조회
-- >> 오라클
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE AND JOB_NAME ='대리';

-- >> ANSI
SELECT EMP_ID, EMP_NAME, JOB_NAME,SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME ='대리';

SELECT*FROM DEPARTMENT;     --> LOCATION_ID

SELECT*FROM LOCATION;       --> LOCAL_CODE

-- 테이블 조회해보고, 어떤 데이터 보관하고 있는지 확인 


-- 1. 부서코드, 부서명, 지역코드, 지역명을 조회하시오
-- >> 오라클 구문
SELECT DEPT_ID,DEPT_TITLE, LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT , LOCATION 
WHERE LOCATION_ID = LOCAL_CODE;

-- >> ANSI 구문
SELECT DEPT_ID,DEPT_TITLE, LOCATION_ID,LOCAL_NAME
FROM DEPARTMENT
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE);

-- 2. 보너스를 받는 사원들의 사번, 사원명, 보너스 부서명을 조회하시오
-- >> 오라클 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID AND BONUS IS NOT NULL;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
WHERE BONUS IS NOT NULL;


-- 3. 인사관리부가 아닌 사원들의 사원명, 급여 조회하시오 
-- >> 오라클 구문

SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE=DEPT_ID AND DEPT_TITLE != '인사관리부';

-- >> ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
WHERE DEPT_TITLE != '인사관리부';

-- 사번, 사원명, 부서명, 직급명
-- >> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE,JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE=DEPT_ID AND E.JOB_CODE=J.JOB_CODE;

-- >> ANSI 구문 <필기확인해야함 >
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN JOB USING(JOB_CODE);

-------------------------------------------------------------

/*
    2. 포괄 조인 / 외부 조인 (OUTER JOIN)
    두 테이블 간의 JOIN시 일치하지 않는 행도 포함시켜서 조회가능
    단, 반드시 LEFT / RIGHT를 지정해줘야만 한다. (기준이 되는 테이블 지정) 
*/

-- OUTER JOIN과 비교할 INNER JOIN 구해놓기
-- 사원명, 부서명, 급여, 연봉
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY, SALARY*12
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);
-- 부서가 지정되지 않은 사원 2명에 대한 정보는 조회되지 않음 
-- 부서에 배정된 사원이 없는 부서 같은 경우도 조회되지 않음 

-- 1) LEFT [OUTER] JOIN : 두 테이블 중 왼편에 기술 된 테이블의 컬럼을 기준으로 JOIN
-- >> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
--> 부서코드가 없던 사원(하동운, 이오리)의 정보도 나오게 됨 

-- >> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+); -- 오른쪽 테이블 컬럼에 +표시

-- 2) RIGHT [OUTER] JOIN : 두 테이블 중 오른편에 기술 된 테이블의 컬럼을 기준으로 JOIN
-- >> ANSI 구문

SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
RIGHT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID); -- 

-- >> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID;


-- 3) FULL [OUTER] JOIN : 두 테이블이 가진 모든 행을 조회할 수 있음(단, 오라클 전용 구문으로는 안됨)
-- >> ANSI
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY*12
FROM EMPLOYEE
FULL JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID);

------------------------------------------------------------------

/*
    3. 카테시안곱(CATESIAN PRODUCT)      /  교차조인(CROSS JOIN)
    조인되는 모든 테이블의 각 행들이 서로서로 모두 매핑된 데이터가 검색됨(곱집합)
    
    두테이블의 행들이 모두 곱해진 행들의 조합이 출력 --> 방대한 데이터 출력 --> 과부화의 위험

*/
-- 사원명, 부서명
-- >> 오라클 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT; -- 컬럼매칭 안하면 전체가 다 조회됨 23*9 => 207

-- >> ANSI 구문

SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT;

-----------------------------------------------------------------------
/*
    4. 비등가 조인 (NON EQUAL JOIN)
    '='(등호)를 사용하지 않는 조인문
    지정한 컬럼 값이 일치하는 경우가 아닌, 값의 "범위"에 포함되는 행들을 연결하는 방식
    
    ANSI 구문으로는 JOIN구문으로만 사용가능(USING 사용불가)
    
*/

-- EMPLOYEE에 SAL_LEVEL 컬럼 지워버리자 !
ALTER TABLE EMPLOYEE DROP COLUMN SAL_LEVEL;

-- 사원명, 급여, 급여등급
-- >> 오라클 구문 
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
--WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

-- >> ANSI 구문
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE
JOIN SAL_GRADE ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);

------------------------------------------------
/*
    5. 자체 조인 (SELF JOIN)
    같은 테이블을 조인하는 경우 
    자기 자신과 조인을 맺는 것 
*/

SELECT*FROM EMPLOYEE;

-- 각각의 사원의 사번, 사원명, 사원부서코드, 사수사번, 사수명 조회

-- >> 오라클 구문
SELECT E.EMP_ID 사원사번, E.EMP_NAME 사원명, E.DEPT_CODE 사원부서코드,E.SALARY 사원급여, 
       E.MANAGER_ID 사수사번, M.EMP_NAME 사수명, M.DEPT_CODE 사수부서코드, M.SALARY 사수급여
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID=M.EMP_ID(+);

-- >> ANSI 구문
SELECT E.EMP_ID 사원사번, E.EMP_NAME 사원명,E.JOB_CODE 사원직급코드,
       M.EMP_ID 사수사번, M.EMP_NAME 사수명, M.JOB_CODE 사수직급코드
FROM EMPLOYEE E
--JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID)
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID);

------------------------------------------------------------

SELECT* FROM EMPLOYEE;      -- DEPT_CODE     JOB_CODE
SELECT* FROM DEPARTMENT;    -- DEPT_ID
SELECT* FROM JOB;           --               JOB_CODE

/*
    < 다중 JOIN >
    
    N개의 테이블을 JOIN

*/

-- 사번, 사원명, 부서명, 지역명 조회
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE

-- >> 오라클 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION 
WHERE DEPT_CODE=DEPT_ID AND LOCATION_ID = LOCAL_CODE;

-- >> ANSI 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE) -- 다중조인은 순서가 중요 !
JOIN JOB USING(JOB_CODE);

------------------------ 실습문제 <필기확인> ---------------------------------

-- 1. 사번, 사원명, 부서명, 지역명, 국가명 조회
SELECT * FROM EMPLOYEE;     -- DEPT_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID      LOCATION_ID
SELECT * FROM LOCATION;     --              LOCAL_CODE      NATIONAL_CODE
SELECT * FROM NATIONAL;     --                              NATIONAL_CODE
-- >> 오라클 구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_CODE 국가명
FROM EMPLOYEE E, DEPARTMENT D,LOCATION L, NATIONAL N
WHERE E.DEPT_CODE=D.DEPT_ID
AND D.LOCATION_ID=L.LOCAL_CODE 
AND L.NATIONAL_CODE=N.NATIONAL_CODE;

-- >> ANSI 구문
SELECT EMP_ID 사번, EMP_NAME 사원명, DEPT_TITLE 부서명, LOCAL_NAME 지역명, NATIONAL_CODE 국가명
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)
JOIN LOCATION ON(LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE);

-- 2. 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- >> 오라클 구문
SELECT EMP_ID,EMP_NAME, DEPT_TITLE, JOB_NAME, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N, SAL_GRADE S
WHERE E.DEPT_CODE=D.DEPT_ID 
    AND E.JOB_CODE=J.JOB_CODE
    AND D.LOCATION_ID=L.LOCAL_CODE
    AND L.NATIONAL_CODE=N.NATIONAL_CODE
    AND E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL;
    
    
-- >> ANSI 구문 
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, D.DEPT_TITLE 부서명, 
       J. JOB_NAME 직급명,L.LOCAL_NAME 근무지역명,N.NATIONAL_NAME 근무국가명,S.SAL_LEVEL 급여등급
FROM EMPLOYEE E
JOIN DEPARTMENT D ON (E.DEPT_CODE=D.DEPT_ID)
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE)
JOIN LOCATION L ON(D.LOCATION_ID=L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE=N.NATIONAL_CODE)
JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL);


------------------ 실습 문제 -----------------------------------


-- 1. 직급이 대리이면서 ASIA지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오

SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, J.JOB_NAME 직급명, D.DEPT_TITLE 부서명, 
       L.LOCAL_NAME 근무지역명,E.SALARY 급여
FROM EMPLOYEE E,JOB J,DEPARTMENT D,LOCATION L, NATIONAL N,SAL_GRADE S
WHERE E.DEPT_CODE=D.DEPT_ID 
    AND E.JOB_CODE=J.JOB_CODE
    AND D.LOCATION_ID=L.LOCAL_CODE
    AND N.NATIONAL_CODE=L.NATIONAL_CODE
    AND JOB_NAME ='대리';
    

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--    사원명, 주민번호, 부서명, 직급명을 조회하시오

SELECT E.EMP_NAME 사원명, E.EMP_NO 주민번호,D.DEPT_TITLE 부서명,J.JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D,JOB J
WHERE E.DEPT_CODE=D.DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE
    AND EMP_NO LIKE '7______2%'
    AND EMP_NAME LIKE '전%';


-- 3. 이름에 '형'자가 들어있는 직원들의
--    사번, 사원명, 직급명을 조회하시오

SELECT 



-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오

-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오

-- 7. '한국'과 '일본'에 근무하는 직원들의 
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7인 직원들의
--    사원명, 직급명, 급여를 조회하시오

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이때 구분에 해당하는 값은
--    급여등급이 S1, S2인 경우 '고급'
--    급여등급이 S3, S4인 경우 '중급'
--    급여등급이 S5, S6인 경우 '초급' 으로 조회되게 하시오.

-- 10. 각 부서별 총 급여합을 조회하되
--     이때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오

-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리)로 조회하시오.
--      단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오.



