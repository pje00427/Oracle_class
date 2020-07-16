-- CREATE TABLE할수 있는 권한이 없기 때문에 문제발생
--3_1 CREATE TABLE 권한 부여받음
-- 3_2. 테이블 스페이스 할당받음
CREATE TABLE TEST(
    TEST_ID NUMBER
);

-- 본인이 소유하고 있는 테이블들은 바로 조작가능
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);
-----------------------------------------
-- 다른 계정의 테이블에 접근할 수 있는 권한이 없기 때문에 발생한 문제 
--4. KH.EMPLOYEE  
SELECT * FROM KH.EMPLOYEE;
--5. KH.DEPARTMENT에 INSERT할 수 있는 권한
INSERT INTO KH.DEPARTMENT
VALUES('D0','인사부','L2');

