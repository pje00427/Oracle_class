--> ����ڰ� ȸ�� ��ü ��ȸ ��û�� �����ؾߵǴ� sql��
INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'XXX','XXXX','XXX','X',XX,'XXXX');

--> ����ڰ� "ȸ�� ��ü ��ȸ ��û"�� �����ؾߵǴ� SQL�� --> ������ ��ȸ
SELECT * FROM MEMBER;

--> ����ڰ�"ȸ�����̵�"�� �˻� ��û�� �����ؾߵǴ� sql�� --> �� �� ��ȸ
select * FROM MEMBERWHERE USERID = 'pje';

--> ����ڰ� "ȸ�� �̸����� Ű���� �˻� ��û" �� �����ؾߵǴ� sql��
SELECT * FROM MEMBER WHERE USERNAME LIKE '%XXX%';

--> ����ڰ� "ȸ������ ���� ��û"�� �����ؾߵǴ� sql��
-- ��й�ȣ, �̸���, ��ȭ��ȣ, �ּ� 
UPDATE MEMBER
SET USERPWD = 'XX',
      EMAIL = 'XX',
      PHONE = 'XX',
    ADDRESS = 'XX'
WHERE USERID = 'XX';
