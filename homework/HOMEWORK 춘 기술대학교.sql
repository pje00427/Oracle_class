SELECT DEPARTMENT_NAME,CATEGORY
FROM tb_department;

SELECT DEPARTMENT_NAME �а���, CAtegory �迭
FROM tb_department;

SELECT DEPARTMENT_NAME AS "�а� ��", CATEGORY AS �迭
FROM TB_DEPARTMENT;

-- 2��
-- �а��� �а� ������ ������ ������ ���·� ȭ�鿡 ����Ѵ�.

SELECT DEPARTMENT_NAME || '�� ������ ' || CAPACITY || '�� �Դϴ�.' AS "�а��� ����"
FROM TB_DEPARTMENT;


-- 3�� �����а��� �ٴϴ� ���л� �� ������ �л� 
SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '������а�';

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE SUBSTR(STUDENT_SSN, 8, 1) = '2' AND
      ABSENCE_YN = 'Y' AND DEPARTMENT_NO = 001;

SELECT DEPARTMENT_NO, STUDENT_NAME
FROM TB_DEPARTMENT
JOIN TB_STUDENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�'
  AND SUBSTR(STUDENT_SSN, 8, 1) = '2' 
  AND ABSENCE_YN = 'Y' AND DEPARTMENT_NO = 001;

-- 4�� 
-- ���������� ���� ���� ��� ��ü�ڵ��� ã�� �̸��� �Խ��ϰ��� �Ѵ�.
-- �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL������ �ۼ��Ͻÿ�.
-- A513079, A513090, A513091, A513110, A513119
-- (��ũ�� ����� �ݴ�� �̸� �����ټ�)



-- 10��
SELECT STUDENT_NO,STUDENT_NAME,STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'N' AND TO_CHAR(STUDENT_NO) LIKE '_2_____' 
                       AND STUDENT_ADDRESS LIKE '����%';

