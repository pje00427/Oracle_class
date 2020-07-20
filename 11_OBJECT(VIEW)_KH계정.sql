/*
    
    < VIEW 뷰 > 
    
    SELECT문을 저장할 수 있는 객체
    논리적인 가상테이블 --> 실질적으로 데이터를 저장하고 있지 않음
                        (단순하게 쿼리문이 저장되어있다고 생각)
    
*/

-- '한국'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무국가명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무국가명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING(NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';


----------------------------------------------------------------------------------

/*
    1. VIEW 생성 방법
    
    [기본 표현식]
    CREATE [OR REPLACE] VIEW 뷰명
    AS 서브쿼리;
    
    [OR REPLACE] : 뷰 생성시 기존에 중복된 뷰가 있다면 해당 뷰를 변경하고
                           기존에 중복된 뷰가 없다면 새로이 뷰를 생성하는 키워드
                           
*/

-- 매번 자주 사용하는 쿼리문을 정의를 해두고 싶을 때 뷰를 생성함!
-- VIEW로 한번만 만들어 두면 마치 테이블처럼 쓸 수 있음!!

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_CODE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID)
   JOIN LOCATION ON (LOCATION_ID=LOCAL_CODE)
   JOIN NATIONAL USING(NATIONAL_CODE);

--> 처음 생성시 CREATE VIEW 권한이 없기 때문에 생성안됨!! (CREATE VIEW 권한받아야됨)


SELECT * 
FROM VW_EMPLOYEE;

-- 한국에 근무하는 사원들의 사번, 이름, 부서명, 급여 조회
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- 러시아에 근무하는 사원들
SELECT EMP_NAME, SALARY--, JOB_CODE
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- 총무부에 근무하는 사원의 사원명, 급여
SELECT EMP_NAME, SALARY
FROM VW_EMPLOYEE            --> 가상테이블인것 뿐 (실제데이터가 담겨있는거 아님)
WHERE DEPT_TITLE = '총무부';

-- [참고]
SELECT * FROM USER_TABLES; -- 해당 계정이 가지고 있는 TABLE들에 대한 내용 조회
SELECT * FROM USER_VIEWS; -- 해당 계정이 가지고 있는 VIEW들에 대한 내용 조회시 사용하는 시스템 테이블


-- 베이스테이블(실제 데이터가 담겨잇는 테이블)의 정보가 변경되면 VIEW에 대한 결과도 같이 변경

SELECT * FROM VW_EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 사번205인 사원명을 정중앙 으로 변경
UPDATE EMPLOYEE
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;

------------------------------------------------------------------------

-- * 생성된 뷰 컬럼에 별칭 부여

-- 서브쿼리의 SELECT절에 함수나 산술연산이 기술되어있는 경우 반드시 별칭 지정!!

-- 사원의 사번, 이름, 직급명, 성별, 근무년수 조회할 수 잇는 뷰로 생성하시오
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') 성별, 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

 SELECT *
 FROM VW_EMP_JOB;  
CREATE OR REPLACE VIEW VW_EMP_JOB(사번, 사원명, 직급명, 성별, 근무년수) --> 모든컬럼에 대한 별칭 부여해야됨
AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
          DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여'), 
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE);

SELECT 사번, 사원명, 성별, 근무년수
FROM VW_EMP_JOB;

-- 뷰삭제하고자 한다면
DROP VIEW VW_EMP_JOB;

--------------------------------------------------------------------------------

-- 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE) 사용가능
-- 뷰를 통해 변경하게 되면 실제데이터가 담겨있는 베이스테이블에도 적용됨!!!

CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
   FROM JOB;
   
SELECT * FROM JOB;
SELECT * FROM VW_JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB VALUES('J8', '인턴');

SELECT * FROM VW_JOB;
SELECT * FROM JOB;      --> 베이스테이블에 값 INSERT

-- 뷰에 UPDATE (J8의 직급명을 알바로 변경)
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;
SELECT * FROM JOB;      --> 베이스테이블에 값 UPDATE

-- 뷰에 DELETE 사용
DELETE FROM VW_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM JOB;          --> 베이스테이블에 값 DELETE
SELECT * FROM VW_JOB;

----------------------------------------------------------------------

/*
    * DML 명령어로 조작이 불가능한 경우
    
    1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
    2) 뷰에 정의되어있지 않은 컬럼 중에,
       베이스테이블상에 NOT NULL 제약조건이 지정된 경우 --> INSERT 시 문제생김
    3) 산술연산식으로 정의 된 경우
    4) 그룹함수나 GROUP BY 절을 포함한 경우
    5) DISTINCT를 포함한 경우
    6) JOIN을 이용해서 여러 테이블을 연결한 경우
    
*/

-- 1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB2
AS SELECT JOB_CODE
   FROM JOB;

SELECT * FROM VW_JOB2;

-- 뷰에 정의 되어있지 않은 컬럼 (JOB_NAME)을 조작
-- INSERT
INSERT INTO VW_JOB2 VALUES('J8', '인턴');

-- UPDATE
UPDATE VW_JOB2
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';

SELECT * FROM JOB;
-- DELETE 
DELETE FROM VW_JOB2
WHERE JOB_NAME = '사원';

-- 2) 뷰에 정의되어있지 않은 컬럼 중에,
--    베이스테이블상에 NOT NULL 제약조건이 지정된 경우 --> INSERT 시 문제생김

CREATE OR REPLACE VIEW VW_JOB3
AS SELECT JOB_NAME
   FROM JOB;

SELECT * FROM VW_JOB3;

-- INSERT
INSERT INTO VW_JOB3 VALUES('인턴');
--> 베이스테이블인 JOB에 JOB_CODE는 NOT NULL 제약조건이 있기 때문에 

-- UPDATE (기존에 사원을 알바로 변경)
UPDATE VW_JOB3
SET JOB_NAME='알바'
WHERE JOB_NAME='사원';

SELECT * FROM JOB;

-- DELETE (알바인 데이터 지우기)
INSERT INTO JOB VALUES('J8', '인턴');

SELECT * FROM VW_JOB3;

DELETE FROM VW_JOB3
WHERE JOB_NAME='인턴';

SELECT * FROM JOB;

-- 3) 산술연산식으로 정의된 경우
--> 회원의 연봉 정보를 조회하는 뷰
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉
   FROM EMPLOYEE;

SELECT * FROM VW_EMP_SAL;

-- INSERT 
INSERT INTO VW_EMP_SAL VALUES(800, '정진훈', 3000000, 36000000);

-- UPDATE (200번 사원의 연봉을 80000000으로 변경)
UPDATE VW_EMP_SAL
SET 연봉 = 80000000
WHERE EMP_ID = 200;

-- UPDATE (205번 사원의 이름을 정중하로 변경) --> 산술연산과 무관한 내용 변경 가능
UPDATE VW_EMP_SAL
SET EMP_NAME = '정중하'
WHERE EMP_ID = 205;

SELECT * FROM EMPLOYEE;

COMMIT;
SELECT * FROM VW_EMP_SAL;
-- DELETE (연봉이 9600만원인 사원 지우기)
DELETE FROM VW_EMP_SAL
WHERE 연봉 = 96000000;

SELECT * FROM EMPLOYEE;

ROLLBACK;


-- 4) 그룹함수 또는 GROUP BY절을 포함한 경우
--> 부서별 총급여합, 급여평균
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE, SUM(SALARY) 합계, FLOOR(AVG(SALARY)) 평균
   FROM EMPLOYEE
   GROUP BY DEPT_CODE;
   
SELECT * FROM VW_GROUPDEPT;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D0', 8000000, 4000000);

INSERT INTO VW_GROUPDEPT(DEPT_CODE) VALUES('D0');

SELECT * FROM VW_GROUPDEPT;
-- UPDATE (D1부서코드를 D0부서코드로 변경)
UPDATE VW_GROUPDEPT
SET DEPT_CODE = 'D0'
WHERE DEPT_CODE = 'D1';

-- DELETE (부서코드가 D1인거 지우기)
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';


-- 5) DISTINCT 포함한 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE;
   
SELECT * FROM VW_DT_JOB;

-- INSERT
INSERT INTO VW_DT_JOB VALUES('J8');

-- UPDATE (J7 --> J8)
UPDATE VW_DT_JOB
SET JOB_CODE = 'J8'
WHERE JOB_CODE='J7';

-- DELETE 
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J2';


-- 6) JOIN을 이용해 여러 테이블을 연결한 경우
CREATE OR REPLACE VIEW VW_JOINEMP
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
   FROM EMPLOYEE
   JOIN DEPARTMENT ON (DEPT_CODE=DEPT_ID);

SELECT * FROM VW_JOINEMP;

-- INSERT
INSERT INTO VW_JOINEMP VALUES(888, '조세오', '총무부');

-- UPDATE (200번 사원의 이름을 서동일)
UPDATE VW_JOINEMP
SET EMP_NAME = '서동일'
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

-- 200번 사원의 부서명을 총무1팀
UPDATE VW_JOINEMP
SET DEPT_TITLE = '총무1팀'
WHERE EMP_ID = 200;

-- DELETE (200번 사원 지우기)
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;

SELECT * FROM VW_JOINEMP;

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '총무부';  --> 서브쿼리의 FROM절의 구문의 테이블에만 영향을 끼침

ROLLBACK;


-------------------------------------------------------------------------

/*
    * VIEW 옵션
    
    [상세 표현식]
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW 뷰명
    AS SUBQUERY
    [WITH CHECK OPTION]
    [WITH READ ONLY];
    
    1) OR REPLACE 옵션 : 기존에 동일한 뷰가 있을경우 덮어쓰고, 존재하지 않으면 새로이 생성시켜주는
    2) FORCE/NOFORCE 옵션
       FORCE : 서브쿼리에 기술된 테이블이 존재하지 않는 테이블이여도 뷰가 생성
       NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성 (생략시 기본값)
    3) WITH CHECK OPTION 옵션 : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정하는 경우 오류 발생
    4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능 (DML 수행 불가)
    
*/

-- 2) FORCE / NOFORCE 옵션
-- NOFORCE : 서브쿼리에 기술된 테이블이 존재하는 테이블이여야만 뷰 생성 (생략시 기본값)
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;

-- FORCE : 서브쿼리에 기술된 테이블이 존재하지 않아도 뷰 생성 가능 (미리 뷰 생성해두고자 할때)
CREATE OR REPLACE FORCE VIEW VW_EMP
AS SELECT TCODE, TNAME, TCONTENT
   FROM TT;
   --> 경고 : 컴파일 오류와 함께 뷰가 생성되었습니다.
   
SELECT * FROM VW_EMP;

CREATE TABLE TT( --> TT 테이블을 생성하면 그때부터 VIEW 조회 가능
    TCODE NUMBER,
    TNAME VARCHAR2(10),
    TCONTENT VARCHAR2(20)
);

-- 3) WITH CHECK OPTION 옵션 : 서브쿼리에 기술한 조건에 부합되지 않는 값으로 수정하는 경우 오류 발생

CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000;
   
SELECT * FROM VW_EMP2;          --> 8명 조회

-- 200번 사원의 급여를 200만원으로 변경 --> 서브쿼리의 조건에 부합하지 않아도 잘 변경 됨!
UPDATE VW_EMP2
SET SALARY = 2000000   
WHERE EMP_ID = 200;

SELECT * FROM EMPLOYEE;

ROLLBACK;


CREATE OR REPLACE VIEW VW_EMP2
AS SELECT *
   FROM EMPLOYEE
   WHERE SALARY >= 3000000
WITH CHECK OPTION;

SELECT * FROM VW_EMP2;

UPDATE VW_EMP2
SET SALARY = 2000000
WHERE EMP_ID = 200; --> 서브쿼리에 기술한 조건에 부합하지 않기때문에 변경 불가

UPDATE VW_EMP2
SET SALARY = 4000000 
WHERE EMP_ID = 200; --> 서브쿼리에 기술한 조건에 부합하기 때문에 변경 가능

ROLLBACK;

-- 4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능 (DML 수행불가)
CREATE OR REPLACE VIEW VW_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM VW_DEPT;

INSERT INTO VW_DEPT VALUES('D0', '해외영업4부', 'L3');

































