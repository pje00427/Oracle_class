/*
    * SUBQUERY (��������)
    - �ϳ��� SQL�� �ȿ� ���Ե� �Ǵٸ� SQL��
*/
-- ���� �������� ����1.
-- ���ö ����� ���� �μ����� ��ȸ�ϰ� �ʹ�!


-- 1) ���ö ����� �μ��ڵ� ��ȸ 
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '���ö'; --> D9�ΰ� �˾Ƴ´�!!

-- 2) �μ��ڵ尡 D9�� ������ ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE ='D9';

--> ���� 2�ܰ踦 �ϳ��� ������! --> 1) ����������!
SELECT EMP_NAME
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '���ö');
                   
-- ���� �������� ����2
-- �� ������ ��� �޿����� �� ���� �޿��� �ް� �ִ� ��������
-- ���, �̸�, �����ڵ�, �޿� ��ȸ

-- 1) �� ������ ��ձ޿� ��ȸ�ϱ�
SELECT AVG(SALARY)
FROM EMPLOYEE;           --> �뷫 3047663�� �ΰ��� �˾Ƴ�

-- 2) �޿��� 3047663�� �̻��� �������� ������ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 3047663;

--> ���� 2�ܰ踦 �ϳ��� ����������!!

SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= (SELECT AVG(SALARY)
                 FROM EMPLOYEE);
                 
-----------------------------------------------------------------

/*
    �������� ���� 
    ���������� ������ ������� ���� ��̳Ŀ� ���� �з��� 
    - ������ �������� : ���������� ��ȸ ��� ���� ������ ������ �Ѱ� �� �� 
    
    - ������ �������� : ���������� ��ȸ ��� ���� ����� ������ �� ��
    
    - ���߿� �������� : ���������� ��ȸ ������� �� �������� �÷��� ������ �� ��
    
    - ������ ���߿� �������� : ���������� ��ȸ ��� ���� ������ ������ �� ��
    
    >> �������� ������ ���� ����Ŀ�� �տ� �ٴ� �����ڰ� �޶�����
*/
/*
    1. ������ �������� (SINGLE ROW SUBQUERTY)
       ���������� ��ȸ ������� ������ 1�� �� ��(������ ���Ͽ�)
       �Ϲݿ����� ���
       = != ^= < > , ....
*/
 -- 1) �� ������ ��� �޿����� �޿��� ���� �޴� ��������
 --     �̸�, �����ڵ�, �޿� ��ȸ
 SELECT EMP_NAME, JOB_CODE, SALARY
 FROM EMPLOYEE
 WHERE SALARY < (SELECT AVG(SALARY) --> ��� �� 1��1��
                 FROM EMPLOYEE  );
                 
-- 2) ���� �޿��� �޴� ������ ���, �̸�, �����ڵ�, �޿�, �Ի��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE SALARY = (SELECT MIN(SALARY) --> ����� 1��1��
                FROM EMPLOYEE);
-- 3) ���ö ����� �޿����� ���� �޴� ����� ���, �̸�, �μ��ڵ�, �����ڵ�, �޿� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT (SALARY)
                 FROM EMPLOYEE 
                 WHERE EMP_NAME = '���ö');
-- * ���������� WHERE �� �Ӹ��ƴ϶�, SELECT/FROM/HAVING �پ��� ������ ��밡��

-- 4) �μ��� �޿� ���� ���� ū �μ��� �μ��ڵ�, �޿��� ��ȸ
-- �� �μ��� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �޿��� �� ���� ū �� 
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) = (SELECT MAX(SUM(SALARY))--> ����� 1�� 1��
                       FROM EMPLOYEE
                       GROUP BY DEPT_CODE);
-- ������ ����� �����ִ� �μ����� ��ȸ (��, �������� ����)
-- ���, �����, ��ȭ��ȣ, �����, �μ��ڵ�, �μ���
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE)
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')  -- ���ؾȰ�...
AND EMP_NAME != '������';                   

------------------------------------------------------------

/*
    2. ������ �������� (MULTI ROW SUBQUERY)
        ���������� ��ȸ ��� ���� ������ �������� ��
    
    - IN / NOT IN  �������� : ���� ���� ��� �� �߿��� �� ���� ��ġ�ϴ� ���� �ִٸ� Ȥ�� ���ٸ� �̶�� �ǹ�
    - > ANY / < ANY �������� : �������� ����� �߿��� �Ѱ��� ū         / ���� ���  
                            �������� ����� �߿��� ���� ������ ���� ũ��? / ���� ū�� ���� �۳�?     

    - > ALL / < ALL �������� : �������� ������� ��� ������ ū / ���� ���
                             ���� ū �� ���� ũ��? / ���� ���� ������ �۳�?
    
*/
-- 1) �� �μ��� �ְ�޿��� �޴� ������ �̸�, �����ڵ�, �μ��ڵ�, �޿� ��ȸ

--> �� �μ��� �ְ� �޿� ��ȸ
SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE; -- > 2890000,3660000,8000000 ���

--> ���� �޿��� �޴� ����� ��ȸ 
SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(2890000, 3660000, 8000000, 3760000, 3900000, 2490000,2550000);

--> ���ļ� �ϳ��� ���������� !

SELECT EMP_NAME, JOB_CODE, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY IN(SELECT MAX(SALARY)  --> ����� ������ 1��
                FROM EMPLOYEE
                GROUP BY DEPT_CODE);
                
-- 2) ����� �ش��ϴ� ������ ���� ��ȸ

--    ���, �̸�, �μ��ڵ�, ����(���/���)
--> ����� �ش��ϴ� ����� ��ȸ
SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL; --> 201,204,100,200,211,207,214

--> ����� ���� ���� �������� ���, �̸�, �μ��ڵ� ��ȸ

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'���'"����"
FROM EMPLOYEE
WHERE EMP_ID IN (201, 204, 100, 200, 211, 207, 214);

-- >> �ϳ��� ���������� !

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'���'����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );
                 
-->> �Ϲ� ����� �ش� �ϴ� ���� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '���'����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );

-- >> �ѹ��� ��������� UNION ���

SELECT EMP_ID,EMP_NAME, DEPT_CODE,'���'����
FROM EMPLOYEE
WHERE EMP_ID IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    )
 UNION                   
SELECT EMP_ID, EMP_NAME, DEPT_CODE, '���'����
FROM EMPLOYEE
WHERE EMP_ID NOT IN (SELECT DISTINCT MANAGER_ID
                 FROM EMPLOYEE
                 WHERE MANAGER_ID IS NOT NULL
                    );
                  
-->> SELECT���� �������� ����ϴ� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE,
       CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '���'
            ELSE '���' 
        END ����
FROM EMPLOYEE;        
      
-- �븮 < ����
-- 3) �븮 �����ӿ��� �ұ��ϰ� ���� ���޵��� �ּ� �޿����� ���� �޴� ���� ��ȸ
-- ���, �̸�, ����, �޿�

-- >> ���� ���޵��� �޿� ��ȸ 
SELECT SALARY 
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'; -- 2200000, 2500000, 3760000 

-->> ������ �븮�� ������ �߿��� ���� ��ϵ� �� �߿� �ϳ��� ū ��� 
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > ANY (2200000,2500000,3760000);
    
-->> �Ѱ��� ���������� ���ĺ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '�븮'
    AND SALARY > ANY (SELECT SALARY 
                      FROM EMPLOYEE
                      JOIN JOB USING(JOB_CODE)
                      WHERE JOB_NAME = '����');
                      
-- ���� < ����
-- 4) ���� ���������� ���� ������ �ִ� �޿����� �� ���� �޴� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
    AND SALARY > ALL (SELECT SALARY
                  FROM EMPLOYEE 
                  JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '����');
                    
                    
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE JOB_NAME = '����'
    AND SALARY > (SELECT  MAX(SALARY)
                  FROM EMPLOYEE 
                  JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '����');               
 
/*
    3. ���߿� �������� (������)
       ��ȸ ��� ���� �� �������� ������ �÷� ���� ������ �� ��
*/

-- 1) ������ ����� ���� �μ��ڵ�, ���� �����ڵ忡 �ش��ϴ� ��� ��ȸ
-- �̸�, �μ��ڵ�, �����ڵ� �Ի���

--> ������ ����� �μ��ڵ�� �����ڵ� ���� ��ȸ
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='������';   --> DEPT_CODE:D5, JOB_CODE:J5

--> �μ��ڵ尡 D5�̸鼭 �����ڵ尡 J5�� ����� ��ȸ
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
    AND JOB_CODE = 'J5';
    
--> ���� ������ ���������ν� ���� �ۼ�
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE DEPT_CODE = (SELECT DEPT_CODE -- ������
                   FROM EMPLOYEE
                   WHERE EMP_NAME = '������')
                   
  AND JOB_CODE = (SELECT JOB_CODE -- ������
                  FROM EMPLOYEE
                  WHERE EMP_NAME = '������') ;                
 
 -->> ���߿� �������� 
SELECT EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE 
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE --> ����� 1�� ������
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '������');
-- 2) �ڳ��� ����� �����ڵ尡 ��ġ �ϸ鼭 ���� ����� ������ �ִ� ��� ��ȸ
--   ���, �̸�, �����ڵ�, ������
SELECT EMP_ID,EMP_NAME,JOB_CODE,MANAGER_ID
FROM EMPLOYEE
WHERE (JOB_CODE, MANAGER_ID) = (SELECT JOB_CODE, MANAGER_ID --> �����1�� ������
                                FROM EMPLOYEE
                                WHERE EMP_NAME = '�ڳ���'); -- J6, 207
--------------------------------------------------------------------------

/*
    4. ������ ���߿� �������� 
        ���������� ��ȸ ��� ���� ������ �������� ��� 
*/
-- 1) �� ���޺� �ּ� �޿��� �޴� ���
--   ���, �̸�, �����ڵ�, �޿�

-- �� ���޺� �ּ� �޿� ��ȸ 
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

-- 2) �� �μ��� ���� �޿��� �޴� ����� ��ȸ
-- ���, �����, �μ��ڵ� �޿�
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
 -- �μ��ڵ� NULL �� ��� ��ȸ �ȵ�(�ϵ���)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE (NVL(DEPT_CODE,'����'), SALARY) IN(SELECT NVL(DEPT_CODE,'����'), MIN(SALARY)
                                        FROM EMPLOYEE
                                        GROUP BY NVL(DEPT_CODE,'����'));
 
 ----------------------------------------------------------------------------
 
 /*
    5. �ζ��� �� (INLINE VIEW)
     FROM ���� ���������� �����ϴ� ��
     ���������� ������ ����� ���̺� ��ſ� �����
 */
-- ���, �̸�, ����, �μ��ڵ� 
-- ������ 3000���� �ʰ��� ����鸸 
SELECT EMP_ID, EMP_NAME, SALARY * 12 ����, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY * 12 > 30000000;
 
SELECT EMP_NAME,����
FROM (SELECT EMP_ID, EMP_NAME, SALARY * 12 ����, DEPT_CODE
       FROM EMPLOYEE) --> ���̺��̶�� ����
WHERE ���� > 30000000;  

-- 1) �ζ��κ並 Ȱ���� TOP-N �м�

-- �� ���� �� �޿��� ���� ���� ���� 5�� ����, �̸�, �޿� ��ȸ

-- * ROWNUM : ����Ŭ���� �������ִ� �÷�, ��ȸ�� ������� 1���� ������ �ο����ִ� �÷�
SELECT ROWNUM,EMP_NAME, SALARY
FROM EMPLOYEE;

SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY DESC;
--> FROM --> SELECT --> ORDER BY : ������ ���׹���
-- �̹� ������ �ο��� �� ������ �� �� 
SELECT ROWNUM, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE ROWNUM <= 5
ORDER BY SALARY DESC;
-->�ذ���. ORDER BY�� ������� ������ ROWNUM �ο��ؾߵ� (�ζ��� ��)

SELECT ROWNUM ����, DEPT_TITLE,E.*
FROM (SELECT *
      FROM  EMPLOYEE
      ORDER BY SALARY DESC)E
JOIN DEPARTMENT ON(DEPT_CODE=DEPT_ID)      
WHERE ROWNUM <= 5;

-- 2) �μ��� ��ձ޿��� ���� 3���� �μ��� �μ��ڵ�, ��� �޿� ��ȸ
SELECT ROWNUM, DEPT_CODE, ROUND(��ձ޿�)
FROM (SELECT DEPT_CODE, AVG(SALARY) ��ձ޿�
        FROM EMPLOYEE
        GROUP BY DEPT_CODE
        ORDER BY 2 DESC)
WHERE ROWNUM <= 3;
-----------------------------------------------

/*
    6. ���� �ű�� �Լ�
       RANK() OVER(���ı���)        /   DENSE_RANK() OVER(���ı���)
       
        - RANK() OVER(���ı���) : ������ ���� ���Ŀ� ����� ������ �ο� �� ��ŭ �ǳʶٰ� ���� ���
                                EX) ����1���� 2���̸� �� ���� ������ 3��
                                
        - DENSE_RANK() OVER(���ı���) : ������ ���� ������ ����� ������ 1�� ������Ű��
                                      EX) ����1���� 2���̴��� �� ���� ������ 2��
*/

-- ����� �޿��� ���� ����� ������ �Űܼ�
-- �����, �޿�, ����
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE;
--> ���� 19�� 2�� ���� ���� 21��

-- > ���� 5�� ��ȸ
SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC) ����
FROM EMPLOYEE
--WHERE ���� <= 5; 
WHERE RANK() OVER(ORDER BY SALARY DESC) <= 5; --WHERE ���� ���� �ȵ�

SELECT EMP_NAME
FROM (SELECT EMP_NAME, SALARY, RANK() OVER(ORDER BY SALARY DESC)����
       FROM EMPLOYEE )
WHERE ���� <= 5;       
