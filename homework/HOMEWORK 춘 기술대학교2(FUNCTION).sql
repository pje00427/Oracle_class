-- ������а�(002)�л����� �й��� �̸� ���г⵵

SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, 
        TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD')���г⵵
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ���г⵵;

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3 ���� �������� �̸��� ���̸� ��� ���̰� ���� ������� ���� ��� ������
