/*
    <�Լ� FUNCTION>
    
    �÷����� �о ����� ����� ��ȯ��
    
    - ������ �Լ� : N���� ���� �о N���� ����� ����
    - �׷� �Լ� : N���� ���� �о 1���� ����� ����
    
    * SELECT���� �������Լ��� �׷��Լ��� �Բ� ����� �� ����.
    * �Լ��� ��� �� �� �ִ� ��ġ : SELECT��, WHERE��, ORDER BY��, GROUP BY��, HAVING��
    

*/

--------------------------< ������ �Լ� > -------------------
/*

    < ���� ���� �Լ�>
    * LENGTH / LENGTHB      => ��� �� NUMBER
    
    LENGTH(�÷�|'���ڰ�') : ���� ���� ��ȯ
    LENGTHB(�÷�|'���ڰ�') : ������ ����Ʈ �� ��ȯ
     
    '��' '��'�ѱ� �ѱ��� => 3BYTE
    ������, ����, Ư������ �ѱ��� => 1BYTE

*/
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- �������̺� (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL),LENGTHB(EMAIL), 
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

--------------------------------------------------------------

/*
    * INSTR
    ������ ��ġ���� ������ ���ڹ�°�� ��Ÿ���� ������ ���� ��ġ ��ȯ
    
    INSTR(�÷���|'���ڰ�', '����', [ã����ġ�� ���۰�, ����])
    
    ã����ġ�� ���۰�
    1   : �տ������� ã�ڴ�.
    -1  : �ڿ������� ã�ڴ�.
    

*/
SELECT INSTR('AABAACAABBAA', 'B' ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1 ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1,3 ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1,3 ) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@' )"@��ġ", INSTR(EMAIL,'S',1,2)
FROM EMPLOYEE;

/*
    * SUBSTR
    ���ڿ����� ������ ��ġ���� ������ ���� ��ŭ�� ���ڿ��� �����ؼ� ��ȯ
    (�ڹٿ����� substring(start, end)�� ����)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => ��� ���� CHARACTER
    STRING : ����Ÿ�� �÷� �Ǵ� '���ڰ�'
    POSITION : ���ڿ��� �߶� �� ��ġ
    LENGTH : ������ ���� ���� (������ ������ �ǹ�)

*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;
SELECT SUBSTR('��� �� �� �Ӵ�', 2, 5) FROM DUAL;

-- �ֹι�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱� 
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;

-- ���ڻ���� ��ȸ
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) ='1';

-- ���ڻ���� ��ȸ
SELECT EMP_NAME, '��' ����
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) ='2';

-- �Լ� ��ø ���
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1) ���̵�
FROM EMPLOYEE;

/*
    * LPAD / RPAD
    ���ڿ� ���� ���ϰ��ְ� �����ְ��� �� �� ���
    
    LPAD/RPAD(STRING, ���������� ��ȯ �� ������ ����(����Ʈ), [�����̰����ϴ� ����])
    
    ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ� ���� N���� ��ŭ�� ���ڿ��� ��ȯ
    �����̰��� �ϴ� ���� ������ �������� ó�� 
*/
-- 20��ŭ�� ���� �� EMAIL���� 
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 891201-2******       => �ѱ��ڼ� : 14����
SELECT RPAD('891201-2',14, '*')
FROM DUAL;

-- �ֹι�ȣ ù��°�ڸ����� �����ڸ� ������ ������ ������� �����ʿ� *����ä���� 14���� ��ȯ�ϱ�

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;


--------------------------------------------------------------------------------

/*
    LTRIM/RTRIM(STRING, [�����ϰ����ϴ� ���ڵ�]) => ����� CHARACTER
    
    ���ڿ��� ���� Ȥ�� �����ʿ��� �����ϰ��� �ϴ� ���ڵ��� ã�Ƽ� ������ �������� ��ȯ

*/

SELECT LTRIM('   K H') FROM DUAL; -- �����ϰ��� �ϴ� ���� ������ �⺻���� ����
SELECT LTRIM('000123456', '0')FROM DUAL;
SELECT LTRIM('123123KH123','123') FROM DUAL;
SELECT LTRIM('ACABACCKH', 'ABC') FROM DUAL;
SELECT LTRIM('5782KH123','0123456789') FROM DUAL;

SELECT RTRIM('K H ',' ') FROM DUAL;
SELECT RTRIM('0012300456000','0') FROM DUAL;

---------------------------------------------------------------------------
/*
    * TRIM
    ���ڿ��� ��/��/���ʿ� �ִ� ������ ���ڸ� ������ �������� ��ȯ
*/
-- �⺻�����δ� ���ʿ� �ִ� ��������
SELECT TRIM(' K H ') FROM DUAL; -- �����ϰ��� �ϴ� ���ڻ���
-- SELECT TRIM('ZZZKHZZZ') FROM DUAL; ������
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL; --LEADING : ��
SELECT TRIM(TRAILING 'Z' FROM'ZZZKHZZZ') FROM DUAL; -- TRAILING : ��
SELECT TRIM(BOTH 'Z' FROM 'ZZZKHZZZ') FROM DUAL;

-- TRIM ([[LEADING|TRAILING|BOTH] �����ϰ��� �ϴ� ���� FROM] STRING)

/*
    * LOWER / UPPER / INITCAP
        
    LOWER : �� �ҹ��ڷ�
    UPPER : �� �빮�ڷ�
    INITCAP : �ձ��ڸ� �빮�ڷ�
    
    LOWER/UPPER/INITCAP(STRING)  => ��� �� CHARACTER
*/
SELECT LOWER('Welcome To My World!') FROM DUAL;
SELECT UPPER('Welcome To My World!')FROM DUAL;
SELECT INITCAP('welcome to my world!')FROM DUAL;

/*
    * CONCAT
    ���ڿ� �ΰ� ���޹޾� �ϳ��� ��ģ �� ��� ��ȯ
    
    CONCAT(STRING, STRING)          => ����� CHARACTER

*/
SELECT CONCAT('�����ٶ�', 'ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL; -- ���Ῥ���ڶ� ������ ���� ����

---------------------------------------------------------------

/*
    * REPLACE
    
    REPLACE(STRING, STR1, STR2)
    
*/
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '�Ｚ��') FROM DUAL;

SELECT EMP_NAME, EMAIL, REPLACE(EMAIL, 'kh.or.kr', 'gmail.com')
FROM EMPLOYEE;

----------------------------------------------------

/*
    <���� ���� �Լ�>
    ���밪 ���ϴ� �Լ�
    
    * ABS (NUMBER)      => ����� NUMBER
    
*/
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS (-10) FROM DUAL;

/*
    * MOD
    �� ���� ���� ���ڰ��� ������
    MOD(NUMBER,NUMBER)  => ����� NUMBER
*/
SELECT MOD(10, 3) FROM DUAL;
SELECT MOD(-10, 3) FROM DUAL;
SELECT MOD(10.9, 3) FROM DUAL;

/*
    * ROUND 
    �ݿø� ���ִ� �Լ�
    
    ROUND(NUMBER, [��ġ]) => ����� NUMBER
    
*/
SELECT ROUND(123.456) FROM DUAL;
SELECT ROUND(123.456, 0) FROM DUAL;
SELECT ROUND(123.456, 1) FROM DUAL;

----------------------------------

/*
    * CEIL
    �ø�ó�����ִ� �Լ� 
    CEIL (NUMBER)
*/
SELECT CEIL(123.456) FROM DUAL;
----------------------------------------

/*
    * FLOOR
    �Ҽ��� �Ʒ� �����ϴ� �Լ�
    
    FLOOR(NUMBER)
*/
SELECT FLOOR(123.456) FROM DUAL;
SELECT FLOOR(123.456) FROM DUAL;

----------------------------------
/*
    * TRUNC
    ��ġ ���������� ����ó�� ���ִ� �Լ� 
    TRUNC(NUMBER, [��ġ])
*/
SELECT TRUNC(123.456) FROM DUAL;
SELECT TRUNC(123.456,1) FROM DUAL;

--------------------------------------------

/*
    < ��¥ ���� �Լ� >
    
*/

-- * SYSDATE : �ý��� ��¥ ��ȯ(���ó�¥)
SELECT SYSDATE FROM DUAL;

-- * MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ���� �� --> DATE1-DATE2 (����� DATE)
-- EMPLOYEE ���̺��� ������, �Ի���, �ٹ� ���� �� 

SELECT EMP_NAME, HIRE_DATE, CEIL(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) || '������' �ٹ�������
FROM EMPLOYEE;

-- *ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� ���� ���� ���ؼ� �� ��¥ ����
-- ����� DATE

SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL;

-- EMPLOYEE ���̺��� ������, �Ի���, �Ի��� 6������ �� ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE, 6)
FROM EMPLOYEE;

-- * NEXT_DAY(DATE, ����(����|����)) : Ư����¥���� ���Ϸ��� ������ ���� ����� ��¥�� ��ȯ���ִ� �Լ�
-- => ����� DATE
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 5) FROM DUAL; -- 1:�Ͽ���,2:������
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ����


-- ����
ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL; -- ����

ALTER SESSION SET NLS_LANGUAGE = KOREAN;

-- * LAST_DAY(DATE) : �ش� ���� ������ ��¥�� ���ؼ� ��ȯ

-- => ����� DATE

SELECT LAST_DAY(SYSDATE) FROM DUAL;

-- EMPLOYEE ���̺��� ������, �Ի���, �Ի���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
    * EXTRACT : �⵵, ��, �� ������ �����ؼ� ��ȯ
    
    EXTRACT(YEAR FROM DATE) : �⵵�� ���� 
    EXTRACT(MONTH FROM DATE) : ���� ����
    EXTRACT(DAY FROM DATE) : �ϸ� ����
*/
-- EMPLOYEE ���̺��� ������, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME, 
       EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
       EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
       EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE  
-- �����ϰ� �ʹٸ�
ORDER BY �Ի�⵵;


-- ��¥ ���� ����

ALTER SESSION SET NLS_DATE_FORMAT='YYYY-MM-DD';
SELECT SYSDATE FROM DUAL;

ALTER SESSION SET NLS_DATE_FORMAT='RR/MM/DD';
SELECT SYSDATE FROM DUAL;

---------------------------------------------

/*
    < ����ȯ �Լ� > 
    
    * ����/��¥     --> ���ڷ� ��ȯ
    
    TO_CHAR(��¥|����,[����]) : ��¥�� �Ǵ� ������ �����͸� ����Ÿ������ ��ȯ

*/
-- ���� --> ����
SELECT TO_CHAR(1234) FROM DUAL;
SELECT TO_CHAR(1234, '99999') FROM DUAL; -- 5ĭ�ڸ� ����Ȯ��, ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') FROM DUAL; -- 5ĭ�ڸ� ����Ȯ��, ����������, ��ĭ0
SELECT TO_CHAR(1234, 'L00000') FROM DUAL; -- ���� ������ ����(LOCAL)�� ȭ�����
SELECT TO_CHAR(1234, 'L99999') FROM DUAL;
SELECT TO_CHAR(1234, '$99999') FROM DUAL; -- �޷� ǥ�⵵ ����

SELECT TO_CHAR(1234, 'L99,999')FROM DUAL; -- �ڸ��� ���� �޸�

-- EMPLOYEE �����, �޿� ��ȸ
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999')
FROM EMPLOYEE;


-- ��¥ --> ����
SELECT SYSDATE FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL;

SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD')
FROM EMPLOYEE;

-- 1990�� 02�� 06��
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��"')�Ի���
FROM EMPLOYEE;


-- �⵵ ���˵�
-- �⵵�� ������ ���˹��ڴ� 'Y','R' 
-- YY�� ������ ���缼�⸦ �ݿ�
-- RR�� 50�̸��̸� ���缼�⸦ �ݿ�, 50�̻��̸� �������� �ݿ�
-- 20 18 90 --> YY --> 2020 2018 2090
-- 20 18 90 --> RR --> 2020 2018 1990

SELECT TO_CHAR(SYSDATE, 'YYYY'),
       TO_CHAR(SYSDATE, 'RRRR'),
       TO_CHAR(SYSDATE, 'YY'),
       TO_CHAR(SYSDATE,'RR'),
       TO_CHAR(SYSDATE,'YEAR')
FROM DUAL;

-- ���� ���� ����

SELECT TO_CHAR(SYSDATE, 'MM'),
       TO_CHAR(SYSDATE, 'MON'),
       TO_CHAR(SYSDATE, 'MONTH'),
       TO_CHAR(SYSDATE, 'RM')-- �θ���ȣ
FROM DUAL;       

-- �Ͽ� ���� ����
SELECT TO_CHAR(SYSDATE, 'DDD'), --1�� ���� ���� ° 
       TO_CHAR(SYSDATE, 'DD'), -- 1�� ���� ���� ° 
       TO_CHAR(SYSDATE, 'D') -- 1�ֱ��� ���� °
FROM DUAL;       

-- ���Ͽ� ���� ����

SELECT TO_CHAR(SYSDATE,'DY'),
       TO_CHAR(SYSDATE, 'DAY')
FROM DUAL;

-- EMPLOYEE���̺��� ������, �Ի��� ��ȸ
-- �Ի����� ���������ؼ� ��ȸ (2017�� 12�� 06�� (��))
SELECT EMP_NAME, TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)')
FROM EMPLOYEE;
-----------------------------------------------------------------

/*
    * ����/���� --> ��¥
    
    TO_DATE(����|����, [����]) : ������ �Ǵ� ������ �����͸� ��¥Ÿ������ ��ȯ => ����� ����ƮŸ�� 
*/
SELECT TO_DATE(20100101) FROM DUAL;
SELECT TO_DATE('20100101') FROM DUAL;
SELECT TO_DATE('100101') FROM DUAL;
SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;

SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;

SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL; -- YY�� ������ ���缼�� 2098�⵵�� ���� 
SELECT TO_DATE('980630', 'RRMMDD') FROM DUAL; -- RR�� 50�̻��̸� ��������, 50�̸��̸� ���缼�� 1998�⵵�� ����

SELECT TO_DATE('140630', 'RRMMDD') FROM DUAL;
SELECT TO_DATE('140630', 'YYMMDD') FROM DUAL;

--EMPLOYEE ���̺��� 1998�⵵ ���Ŀ� �Ի��� ����� ���, �̸�, �Ի���

SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE > TO_DATE('980101', 'RRMMDD');

---------------------------------------------------

/*
    * ����    --> ����
    
     TO_NUMBER(���ڵ�����, [����]) : ������ �����͸� ����Ÿ������ ��ȯ
    
*/
SELECT TO_NUMBER('0123456789')FROM DUAL;

SELECT TO_NUMBER('0123456789')FROM DUAL;

SELECT '123' + '456' FROM DUAL; -->> �˾Ƽ� �ڵ����� ���ڷ� ����ȯ �� �� ����ó�� ����
SELECT '123' + '456A' FROM DUAL; --> �����߻�

-- ���ھȿ� ���ڵ鸸 ������� �� �ڵ� ����ȯ ��
SELECT EMP_NAME
FROM EMPLOYEE
WHERE EMP_ID >= 210;

SELECT '10,000,000' + '550,000' FROM DUAL; -- �����߻�

SELECT TO_NUMBER('10,000,000', '99,999,999') + TO_NUMBER('550,000','999,999')FROM DUAL;

------------------------------------------------------

/*
    < NULL ó�� �Լ� >
*/

-- * NVL(�÷���, �÷����� NULL�ϰ�� �ٲ� ��)
SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, (SALARY + SALARY*NVL(BONUS, 0)) * 12
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE, 'D0')
FROM EMPLOYEE;

-- * NVL2(�÷���, �ٲܰ�1, �ٲܰ�2)
-- �÷����� �����ϸ� �ٲܰ�1���� 
-- �÷����� NULL���̸� �ٲܰ�2�� 

SELECT EMP_NAME, BONUS, NVL(BONUS, 0), NVL2(BONUS,0.7, 0)
FROM EMPLOYEE;

-- * NULLIF(�񱳴��1, �񱳴��2)
-- �ΰ��� ���� �����ϸ� NULL ��ȯ
--             �������� ������ �񱳴��1 ��ȯ
SELECT NULLIF('123','123') FROM DUAL;
SELECT NULLIF('123','456') FROM DUAL;

-----------------------------------------------------

/*
    < �����Լ� >
    �������� ��쿡 ������ �� �� �ִ� ����� ����

    * DECODE(���ϰ����ϴ´��(�÷���|����), ���ǰ�1, �����1, ���ǰ�2, �����2, ...)
    ���ϰ��� �ϴ� ���� ���ǰ��� ��ġ �� ��� �׿� �ش��ϴ� ����� ��ȯ���ִ� �Լ� 
    (�ڹٿ����� SWITCH���� ���)
    
    SWITCH(���ϰ����ϴ� ���){
    CASE ���ǰ�1: �����1
    CASE ���ǰ�2: �����2
    DEFAULT: �����
    }
*/

-- ���, �����, �ֹι�ȣ, ���� 
SELECT EMP_ID, EMP_NAME, EMP_NO,
      DECODE(SUBSTR(EMP_NO, 8, 1),'1','��','2','��')����
FROM EMPLOYEE;      

-- ������ �޿� �λ��ؼ� ��ȸ
-- �����ڵ尡 J7�� ����� �޿��� 10%�λ� 
-- �����ڵ尡 J6�� ����� �޿��� 15%�λ�
-- �����ڵ尡 J5�� ����� �޿��� 20%�λ�
-- �� ���� ������ ����� �޿��� 5%�� �λ�

-- ������, �����ڵ�, �����޿�, �λ�� �޿� 
SELECT EMP_NAME,JOB_CODE, SALARY �����޿�,
       DECODE(JOB_CODE, 'J7', SALARY *1.1,
                        'J6', SALARY *1.15,
                        'J5', SALARY *1.2,
                              SALARY *1.05) �λ�޿�
FROM EMPLOYEE;

/*
    * CASE WHEN THEN
    
    CASE WHEN ���ǽ�1 THEN �����1
         WHEN ���ǽ�2 THEN �����2
         ELSE �����
     END    
     
     �� ������� ���ǽ� �ۼ� ����(������������)
     (�ڹٿ��� IF-ELSE IF��)
*/
SELECT EMP_ID, EMP_NAME, EMP_NO, 
       CASE WHEN SUBSTR(EMP_NO, 8, 1)='1' THEN '��'
            WHEN SUBSTR(EMP_NO, 8, 1)='2' THEN '��'
        END ����
FROM EMPLOYEE;        

-- �����, �޿�, �޿����('1���', '2���', '3���', '4���')
-- SALARY���� 500���� �ʰ��� ��� 1���
-- SALARY���� 500���� ���� 350���� �ʰ��� ��� 2��� 
-- SALARY���� 350���� ���� 200���� �ʰ��� ��� 3���
-- �� ���� ��� 4���

SELECT EMP_NAME, SALARY,
       CASE WHEN SALARY > 5000000 THEN '1���'
            WHEN SALARY > 3500000 THEN '2���'
            WHEN SALARY > 2000000 THEN '3���'
            ELSE '4���'
        END ���
FROM EMPLOYEE;  

-------------------------------- < �׷��Լ� > ---------------------------------------

-- 1. SUM(���ڿ� �ش��ϴ� �÷�) : ���հ踦 ��ȯ���ִ� �Լ� 
-- EMPLOYEE ���̺��� ������� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- �� ��� �ѱ޿���
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- �μ��ڵ尡 D5�� ������� �� ������ 
SELECT SUM(SALARY * 12)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 2. AVG(���ڿ� �ش��ϴ� �÷�) : ��հ��� ���ؼ� ��ȯ 
-- �� ����� �޿� ��� ��ȸ
SELECT ROUND( AVG(SALARY))
FROM EMPLOYEE;

-- 3. MIN(�÷���) : �÷����� �߿� ���� ������ ��ȯ 
--                  ����ϴ� �ڷ����� ANY TYPE!
SELECT MIN(EMP_NAME), MIN(EMAIL), MIN(SALARY),MIN(HIRE_DATE)
FROM EMPLOYEE;

-- 4. MAX (�÷���) : �÷����� �߿� ���� ū ���� ��ȯ 
--                  ����ϴ� �ڷ����� ANY TYPE!
SELECT MAX(EMP_NAME), MAX(EMAIL), MAX(SALARY),MAX(HIRE_DATE)
FROM EMPLOYEE;

-- 5. COUNT(*|�÷���) : �� ������ ���� ��ȯ 
--    COUNT(*) : ��ȸ����� �ش��ϴ� �� ���� �� ���� ��ȯ (NULL ����)
--    COUNT(�÷���) : �ش� �÷����� NULL�� �ƴ� �͸� �� ���� �� ���� ��ȯ 
--    COUNT (DISTINCT �÷���) : �ߺ��� ���� �� �� ���� ���� ��ȯ

-- ��ü ��� �� 
SELECT COUNT(*)
FROM EMPLOYEE;

-- ���� ��� �� 
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO, 8, 1) = '1';

-- �μ���ġ�� �� ��� �� (DEPT_CODE�� ���� �ִ� ��� �� )
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- ���� ������� �����ִ� �μ��� 
SELECT DEPT_CODE
FROM EMPLOYEE;

-- ���� ������� �����Ǿ��ִ� ������ ��
SELECT COUNT(DISTINCT JOB_CODE)
FROM EMPLOYEE;

