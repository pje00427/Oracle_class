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
    LENGTH(�÷�|'���ڰ�') : ������ ����Ʈ �� ��ȯ
     
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
