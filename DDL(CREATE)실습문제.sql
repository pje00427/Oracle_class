-- �ǽ����� --
-- �������� ���α׷��� ����� ���� ���̺�� ����� 
-- �̶�, �������ǿ� �̸��� �ο��� ��
-- �� �÷��� �ּ��ޱ�


CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER PRIMARY KEY,
    PUB_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR(40) 
);

INSERT INTO TB_PUBLISHER
VALUES(1,'�׳�',02-1111-2222);

SELECT * FROM TB_PUBLISHER;