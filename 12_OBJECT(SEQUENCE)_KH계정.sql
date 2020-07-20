/*
    < ������ SEQUENCE>
    
    �ڵ���ȣ �߻��� ������ �ϴ� ��ü
    �������� �ڵ����� ���������� ��������

*/

/*
    1.������ ���� ����
    
    [ǥ����]
    
    CREATE SEQUENCE ��������
    [START WITH ����]         --> ó�� �߻���ų ���۰� ����
    [INCREMENT BY ����]       --> ���� �߻��� ���� ���� ����ġ 
    [MAXVALUE ����]           --> �߻���ų �ִ밪 ����
    [MINVALUE ����]           --> �ּҰ� ����
    [CYCLE | NOCYCLE]        --> �� ��ȯ ���� ����
    [CACHE ����Ʈũ�� | NOCACHE] --> ĳ�ø޸� �Ҵ� (�⺻�� 20����Ʈ)
    
    * ĳ�ø޸� : �̸� ���������� �����ؼ� �����ص�
                 �Ź� ȣ���� �� ���� ������ ������ �ϴ°� ���� ĳ�ø޸� ������ �̸������� ������ ������ ����
                 �ξ� �ӵ��� ����
*/

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

-- [����] �� ������ ������ �ִ� �������� ���� ����
SELECT * FROM USER_SEQUENCES;

/*
    2. SEQUENCE ��� ����
    
    ��������.CURRVAL  : ���� �������� ��
    ��������.NEXTVAL  : ���������� ������Ű�� ������ ������ ��
                        == ��������.CURRVAL + INCREMENT


*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;
--> NEXTVAL�� �ѹ��̶� �������� ������ CURRVAL�� �� �� ����
--> ��? CURRVAL�� ��� ���������� ����� NEXTVAL���� �����ؼ� �����ִ� �ӽð�

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 305
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310
SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --> 310 �ʰ��ϸ� ����

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; -- 310

SELECT * FROM USER_SEQUENCES;

/*
    3. ������ ����
    
    [ǥ����]
    
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]
    [MAXVALUE ����]
    [MINVALUE ����]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈ�� | NOCACHE];
    
    * START WITH ���� �Ұ� --> �缳���ϰ��� �Ѵٸ� ���� ������ DROP �� �����
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPNO.CURRVAL FROM DUAL; --310
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL; --320

DROP SEQUENCE SEQ_EMPNO;

--------------------------------------

-- �Ź� ���ο� ����� �߻��Ǵ� ������ ����
DROP SEQUENCE SEQ_EID;
CREATE SEQUENCE SEQ_EID
START WITH 300;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿','666666-6666666', 'hong@iei.or.kr',
        '01041112222', 'D2','J3', 5000000,0.1,NULL, SYSDATE, NULL, DEFAULT);

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL,'�ϰ�','111111-2222222', 'gong@iei.or.kr',
        '01011112222','D1','J3',6000000, NULL,NULL,SYSDATE, NULL,DEFAULT);
ROLLBACK;   


