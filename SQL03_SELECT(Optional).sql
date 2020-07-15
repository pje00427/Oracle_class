--�� ���б� ��ũ�� ����
--SQL03_SELECT(Option)

-- 1��
-- �л��̸��� �ּ����� ǥ���Ͻÿ�. ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� �Ѵ�.
SELECT STUDENT_NAME AS "�л� �̸�", STUDENT_ADDRESS AS �ּ���
FROM TB_STUDENT
ORDER BY 1;

-- 2��
-- �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�
SELECT STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ABSENCE_YN = 'Y'
ORDER BY STUDENT_SSN DESC;

-- 3��
-- �ּ����� �������� ��⵵�� �л��� �� 1900��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�.
-- ��, ���������� "�л��̸�", "�й�", "������ �ּ�"�� ��µǵ��� �Ѵ�.
SELECT STUDENT_NAME "�л��̸�", STUDENT_NO "�й�", STUDENT_ADDRESS "������ �ּ�"
FROM TB_STUDENT
WHERE STUDENT_NO LIKE '9%'
	AND (STUDENT_ADDRESS LIKE '��⵵%' OR STUDENT_ADDRESS LIKE '������%')
ORDER BY 1;

-- 4��
-- ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
-- (���а��� '�а� �ڵ�'�� �а� ���̺��� ��ȸ�ؼ� ã�� ������ ����)
SELECT * FROM TB_PROFESSOR;  --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT; --> DEPARTMENT_NO

-- ANSI
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���а�'
ORDER BY 2;

-- ORACLE
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR P, TB_DEPARTMENT D
WHERE P.DEPARTMENT_NO = D.DEPARTMENT_NO
    AND DEPARTMENT_NAME = '���а�'
ORDER BY 2;

-- 5��
-- 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� �Ѵ�. 
-- ������ ���� �л����� ǥ���ϰ�,
-- ������ ������ �й��� ���� �л����� ǥ���ϴ� ������ �ۼ��� ���ÿ�.
-- ��ũ�� ����� �����ϰ� �Ҽ��� �Ʒ� 2�ڸ����� 0���� ǥ���ϱ� ���ؼ� TO_CHAR(NUMBER, 'FM9.00') ���� ���
SELECT * FROM TB_GRADE;

SELECT STUDENT_NO, TO_CHAR(POINT,'99.99') "POINT"
FROM TB_GRADE
WHERE TERM_NO = '200402'
  AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO;

-- 6��
-- �л� ��ȣ, �л� �̸�, �а� �̸��� �л� �̸����� �������� �����Ͽ� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2;

-- ORACLE
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT S, TB_DEPARTMENT D
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2;


-- 7��
-- �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL������ �ۼ��Ͻÿ�.
SELECT * FROM TB_CLASS;         --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_DEPARTMENT D
WHERE C.DEPARTMENT_NO = D.DEPARTMENT_NO
ORDER BY 2, 1;

-- 8��
-- ���� ���� �̸��� ã������ �Ѵ�. ���� �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_CLASS_PROFESSOR; --> CLASS_NO, PROFESSOR_NO
SELECT * FROM TB_CLASS;           --> CLASS_NO
SELECT * FROM TB_PROFESSOR;       -->           PROFESSOR_NO

-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR USING(PROFESSOR_NO)
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO
ORDER BY 2, 1;

-- 9��
-- 8���� ��� �� '�ι� ��ȸ' �迭�� ���� ������ ���� �̸��� ã������ �Ѵ�.
-- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_DEPARTMENT;        --> DEPARTMENT_NO
-- ANSI
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS
JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_PROFESSOR P USING(PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO) --> DEPARTMENT�� �����ؾ� CATEGORY �÷��� ����� �� �ִ�.  
WHERE CATEGORY = '�ι���ȸ'
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR CP, TB_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = CP.CLASS_NO
  AND CP.PROFESSOR_NO = P.PROFESSOR_NO
  AND P.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND CATEGORY = '�ι���ȸ'
ORDER BY 2, 1;
                        
-- 10��
-- '�����а�' �л����� ������ ���Ϸ��� �Ѵ�. 
-- �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- (��, ������ �Ҽ��� 1�ڸ������� �ݿø��Ͽ� ǥ���Ѵ�.)
SELECT * FROM TB_GRADE;      --> STUDENT_NO
SELECT * FROM TB_STUDENT;    --> STUDENT_NO  DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT; -->             DEPARTMENT_NO

-- ANSI
SELECT STUDENT_NO "�й�", STUDENT_NAME "�л� �̸�", ROUND(AVG(POINT), 1) "��ü ����"
FROM TB_GRADE
JOIN TB_STUDENT S USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME='�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO �й�, STUDENT_NAME "�л� �̸�", ROUND(AVG(POINT),1) "��ü ����"
FROM TB_GRADE G, TB_STUDENT S, TB_DEPARTMENT D
WHERE G.STUDENT_NO = S.STUDENT_NO
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '�����а�'
GROUP BY S.STUDENT_NO, STUDENT_NAME
ORDER BY 1;


-- 11��
-- �й��� A313047�� �л��� �б��� ������ ���� �ʴ�. ���� �������� ������ �����ϱ� ���� 
-- �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�.
-- �̶� ����� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO   COACH_PROFESSOR_NO
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
SELECT * FROM TB_DEPARTMENT;    -->                 PROFESSOR_NO

-- ANSI
SELECT DEPARTMENT_NAME �а��̸�, STUDENT_NAME �л��̸�, PROFESSOR_NAME ���������̸�
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- ORACLE
SELECT DEPARTMENT_NAME �а��̸�, STUDENT_NAME �л��̸�, PROFESSOR_NAME ���������̸�
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_PROFESSOR
WHERE COACH_PROFESSOR_NO = PROFESSOR_NO
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND STUDENT_NO = 'A313047';


-- 12��
-- 2007�⵵�� '�ΰ������' ������ ������ �л��� ã�� 
-- �л��̸��� �����б⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.

SELECT * FROM TB_STUDENT;   --> STUDENT_NO 
SELECT * FROM TB_GRADE;     --> STUDENT_NO     CLASS_NO
SELECT * FROM TB_CLASS;     -->                CLASS_NO

-- ANSI
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_CLASS USING(CLASS_NO)
WHERE CLASS_NAME = '�ΰ������'
  AND TERM_NO LIKE '2007%';
  
-- ORACLE
SELECT STUDENT_NAME, TERM_NO "TERM_NAME"
FROM TB_STUDENT S, TB_GRADE G, TB_CLASS C
WHERE S.STUDENT_NO = G.STUDENT_NO
  AND G.CLASS_NO = C.CLASS_NO
  AND CLASS_NAME = '�ΰ������'
  AND TERM_NO LIKE '2007%';


-- 13��
-- ��ü�� �迭 ���� �� ���� ��米���� �� ���� �������� ���� ������ ã�� 
-- �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��� ���� ���� �����ϳ� ���� ������ ���� �ٸ� ������ ����
SELECT * FROM TB_CLASS;             --> CLASS_NO    DEPARTMENT_NO
SELECT * FROM TB_CLASS_PROFESSOR;   --> CLASS_NO   
SELECT * FROM TB_DEPARTMENT;        -->             DEPARTMENT_NO

SELECT CLASS_NO, CLASS_NAME, DEPARTMENT_NO, PROFESSOR_NO
FROM TB_CLASS
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO) 
WHERE PROFESSOR_NO IS NULL;

-- ANSI
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C
LEFT JOIN TB_CLASS_PROFESSOR USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE CATEGORY = '��ü��'
  AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;

-- ORACLE
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS C, TB_CLASS_PROFESSOR P, TB_DEPARTMENT D
WHERE C.CLASS_NO = P.CLASS_NO(+)
  AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND CATEGORY = '��ü��'
  AND PROFESSOR_NO IS NULL
ORDER BY 2, 1;


-- 14��
-- �� ������б� ���ݾƾ��а� �л����� ���������� �Խ��ϰ��� �Ѵ�. 
-- �л��̸��� �������� �̸��� ã�� ���� ���� ������ ���� �л��� ���
-- "�������� ������"���� ǥ���ϵ��� �ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- �� �������� "�л��̸�", "��������"�� ǥ���ϸ� ���й� �л��� ���� ǥ�õǵ��� �Ѵ�.
SELECT * FROM TB_STUDENT;       --> DEPARTMENT_NO   COACH_PROFESSOR_NO
SELECT * FROM TB_PROFESSOR;     -->                 PROFESSOR_NO 
SELECT * FROM TB_DEPARTMENT;    --> DEPARTMENT_NO
-- ANSI
SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME, '�������� ������') ��������
FROM TB_STUDENT S
LEFT JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
JOIN TB_DEPARTMENT D ON(S.DEPARTMENT_NO = D.DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO;

-- ORACLE
SELECT STUDENT_NAME �л��̸�, NVL(PROFESSOR_NAME, '�������� ������') ��������
FROM TB_STUDENT S, TB_PROFESSOR P, TB_DEPARTMENT D 
WHERE S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
  AND S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = '���ݾƾ��а�'
ORDER BY STUDENT_NO;

-- 15��
-- ���л��� �ƴ� �л� �� ������ 4.0 �̻��� �л��� ã�� 
-- �� �л��� �й�, �̸�, �а�, �̸�, ������ ����ϴ� SQL���� �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT WHERE ABSENCE_YN = 'N';    --> STUDENT_NO   DEPARTMENT_NO
SELECT * FROM TB_GRADE;                             --> STUDENT_NO
SELECT * FROM TB_DEPARTMENT;                        -->              DEPARTMENT_NO

-- ANSI
SELECT STUDENT_NO �й�, STUDENT_NAME �̸�, DEPARTMENT_NAME "�а� �̸�", AVG(POINT) ����
FROM TB_STUDENT 
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE ABSENCE_YN = 'N'
GROUP BY STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- ORACLE
SELECT S.STUDENT_NO �й�, STUDENT_NAME �̸�, DEPARTMENT_NAME "�а� �̸�", AVG(POINT) ����
FROM TB_STUDENT S, TB_DEPARTMENT D, TB_GRADE G
WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND S.STUDENT_NO = G.STUDENT_NO
  AND ABSENCE_YN = 'N'
GROUP BY S.STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
HAVING AVG(POINT) >= 4
ORDER BY 1;

-- 16��
-- ȯ�������а� ����������� ���� �� ������ �ľ��� �� �ִ� SQL ���� �ۼ��Ͻÿ�.
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='ȯ�������а�'; --> DEPARTMENT_NO
SELECT * FROM TB_CLASS WHERE CLASS_TYPE LIKE '����%';            --> DEPARTMENT_NO   CLASS_NO
SELECT * FROM TB_GRADE;                                         -->                 CLASS_NO

-- ANSI
SELECT CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS 
JOIN TB_GRADE USING(CLASS_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = 'ȯ�������а�'
  AND CLASS_TYPE LIKE '%����%'
GROUP BY CLASS_NO, CLASS_NAME
ORDER BY 1;

-- ORACLE
SELECT C.CLASS_NO, CLASS_NAME, AVG(POINT)
FROM TB_CLASS C, TB_GRADE G, TB_DEPARTMENT D
WHERE C.CLASS_NO = G.CLASS_NO
  AND C.DEPARTMENT_NO = D.DEPARTMENT_NO
  AND DEPARTMENT_NAME = 'ȯ�������а�'
  AND CLASS_TYPE LIKE '%����%'
GROUP BY C.CLASS_NO, CLASS_NAME
ORDER BY 1;


-- 17��
-- �� ������б��� �ٴϰ� �ִ� �ְ��� �л��� ���� �� �л����� �̸��� �ּҸ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE DEPARTMENT_NO = (SELECT DEPARTMENT_NO
                       FROM TB_STUDENT
                       WHERE STUDENT_NAME = '�ְ���');
                       
-- 18��
-- ������а����� �������� ���� ���� �л��� �̸��� �й��� ǥ���ϴ� SQL���� �ۼ��Ͻÿ�
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='������а�'; --> DEPARTMENT_NO
SELECT * FROM TB_STUDENT;                                       --> DEPARTMENT_NO   STUDENT_NO
SELECT * FROM TB_GRADE;                                         -->                 STUDENT_NO

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�' --> �ش� ������ ��� ����� �� ������ ��Ȯ�� ���ڸ� �߰�����ߵ�
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT))
                     FROM TB_STUDENT
                     JOIN TB_GRADE USING(STUDENT_NO)
                     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                     WHERE DEPARTMENT_NAME = '������а�'
                     GROUP BY STUDENT_NO);

SELECT STUDENT_NO, STUDENT_NAME
FROM TB_STUDENT
JOIN TB_GRADE USING(STUDENT_NO)
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
WHERE DEPARTMENT_NAME = '������а�' --> �ش� ������ ��� ����� �� ������ ��Ȯ�� ���ڸ� �߰�����ߵ�
GROUP BY STUDENT_NO, STUDENT_NAME
HAVING AVG(POINT) = (SELECT MAX(AVG(POINT)) 
                     FROM TB_STUDENT
                     JOIN TB_GRADE USING(STUDENT_NO)
                     JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
                     WHERE DEPARTMENT_NAME = '������а�'
                     GROUP BY STUDENT_NO);


-- 19��
-- �� ������б��� "ȯ�������а�"�� ���� ���� �迭 �а����� 
-- �а� �� �������� ������ �ľ��ϱ� ���� ������ SQL���� ã�Ƴ��ÿ�.
-- ��, �������� "�迭 �а���", "��������"���� ǥ�õǵ��� �ϰ�, 
-- ������ �Ҽ��� ���ڸ������� �ݿø��Ͽ� ǥ�õǵ��� �Ѵ�.
SELECT * FROM TB_DEPARTMENT WHERE DEPARTMENT_NAME='ȯ�������а�'; --> DEPARTMENT_NO
SELECT * FROM TB_CLASS;                                         --> DEPARTMENT_NO   CLASS_NO
SELECT * FROM TB_GRADE;                                         -->                 CLASS_NO

-- ANSI
SELECT DEPARTMENT_NAME "�迭 �а���", ROUND(AVG(POINT),1) ��������
FROM TB_DEPARTMENT 
JOIN TB_CLASS USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(CLASS_NO)
WHERE CATEGORY = (SELECT CATEGORY
                  FROM TB_DEPARTMENT
                  WHERE DEPARTMENT_NAME = 'ȯ�������а�')
    AND CLASS_TYPE LIKE '%����%' --> �� �߰������ ����� ����!!
GROUP BY DEPARTMENT_NAME
ORDER BY 1; 

-- ORACLE
SELECT DEPARTMENT_NAME "�迭 �а���", ROUND(AVG(POINT),1) ��������
FROM TB_DEPARTMENT D, TB_CLASS C, TB_GRADE G
WHERE D.DEPARTMENT_NO = C.DEPARTMENT_NO
AND C.CLASS_NO = G.CLASS_NO
AND CATEGORY = (SELECT CATEGORY
                FROM TB_DEPARTMENT
                WHERE DEPARTMENT_NAME = 'ȯ�������а�')
AND CLASS_TYPE LIKE '%����%'
GROUP BY DEPARTMENT_NAME
ORDER BY 1;