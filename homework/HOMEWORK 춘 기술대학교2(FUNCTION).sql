-- 영어영문학과(002)학생들의 학번과 이름 입학년도

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, 
        TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD')입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY 입학년도;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';