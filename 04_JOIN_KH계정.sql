/*
   < JOIN > 
   
   �� �� �̻��� ���̺��� �����͸� ��ȸ�ϰ��� �� �� ���Ǵ� ����
   ���� ����� �ϳ��� �����(Result Set) �� ����
   
   ������ �����ͺ��̽��� �ּ����� �����ͷ� ������ ���̺� ��� ���� (�ߺ��� �ּ�ȭ�ϱ� ����)
    => ��, ������ �����ͺ��̽����� SQL���� �̿��� "����"�� �δ� ��� 
    
    ������ �����͸� �������°� �ƴ� ���̺� ������� ���谡 �ξ��� �����͸� ��Ī���Ѽ� ��ȸ�ؾ� �Ѵ�.
    
    [JOIN ��� ����]
    JOIN�� ũ�� "����Ŭ ����"�� "ANSI ����" 
    ANSI(�̱�����ǥ����ȸ == ���ǥ���� �����ϴ� ��ü)
    
                ����Ŭ DBMS������                     ����Ŭ + �ٸ� DBMS������
                    ����Ŭ ����             |               ANSI ����
    ------------------------------------------------------------------------------------------
                    � ����               |        ���� ���� (INNER JOIN) --> JOIN USING/ON  
                                                    �ڿ� ���� (NATURAL JOIN) --> JOIN USING
    ------------------------------------------------------------------------------------------                                               
                    ���� ����                         ���� �ܺ� ���� (LEFT OUTER JOIN),
                  (LEFT OUTER)                       ������ �ܺ� ���� (RIGHT OUTER JOIN),                      
                  (RIGHT OUTER)                      ��ü �ܺ� ���� (FULL OUTER JOIN, ����Ŭ �������δ� ���Ұ�)
   ------------------------------------------------------------------------------------------
            ��ü ����, �� ����                       JOIN ON
   ------------------------------------------------------------------------------------------
                    īŸ�þ� ��                              ���� ���� (CROSS JOIN)
                    
*/

-- ������� ���, �����, �μ��ڵ�, �μ��� ��ȸ

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

/*
    1. ����� (EQUAL JOIN) / �������� (INNER JOIN)
        �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 ���εǼ� ��ȸ (== ��ġ�ϴ� ���� ���� ���� ��ȸ �ȵ�)
*/
-- >> ����Ŭ ���� ���� 
--  FROM ���� ��ȸ�ϰ��� �ϴ� ���̺�� ����(, �����ڷ�)
--  WHERE ���� ��Ī��ų �÷��� (�����)

-- 1) ������ �� �÷����� �ٸ���� (EMPLOYEE:DEPT_CODE   / DEPARTMENT:DEPT_ID)
-- ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;
--> ��ġ�ϴ� ���� ���� ���� ��ȸ���� ���ܵ� �� Ȯ�� ����

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)
--    ���, �����, �����ڵ�, ���޸�

-- ��� 1) ���̺���� �̿��ϴ� ���
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
--> AMBIGUAUSLY : �ָ��ϴ�. ��ȣ�ϴ�

-- ��� 2) ��Ī ��� (�� ���̺��� ��Ī �ο��ص� �� ����)
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- >> ANSI ǥ�� ����
--    FROM���� ������ �Ǵ� ���̺��� �ϳ� ��� �� �� 
--    JOIN������ ���� ��ȸ �ϰ��� �ϴ� ���̺� ��� �� ��Ī ��ų �÷��� ���� ���� ��� 
--    USING������ ON���� 

-- 1) ������ �� �÷����� �ٸ� ��� (EMPLOYEE:DEPT_CODE  /   DEPARTMENT:DEPT_ID)
--      ON�������θ�!
-- ���, �����, �μ��ڵ�, �μ��� 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);

-- 2) ������ �� �÷����� ���� ��� (EMPLOYEE:JOB_CODE   /   JOB:JOB_CODE)
--  USING ���� ���! (ON�� ���ؼ� ������Ī�� �����ϱ� ��)
-- ���, �����, �����ڵ�, ���޸�
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE); -- AMBIGUOUSLY �߻� X => USING�� ���� �÷��̶�� �ν��ϱ� ����

SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE=J.JOB_CODE); --AMBIGUOUSLY �߻� O

-- ���� --
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB;


