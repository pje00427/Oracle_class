--> 사용자가 회원 전체 조회 요청시 실행해야되는 sql문
INSERT INTO MEMBER VALUES(SEQ_USERNO.NEXTVAL, 'XXX','XXXX','XXX','X',XX,'XXXX');

--> 사용자가 "회원 전체 조회 요청"시 실행해야되는 SQL문 --> 여러행 조회
SELECT * FROM MEMBER;

--> 사용자가"회원아이디"로 검색 요청시 실행해야되는 sql문 --> 한 행 조회
select * FROM MEMBERWHERE USERID = 'pje';

--> 사용자가 "회원 이름으로 키워드 검색 요청" 시 실행해야되는 sql문
SELECT * FROM MEMBER WHERE USERNAME LIKE '%XXX%';

--> 사용자가 "회원정보 변경 요청"시 실행해야되는 sql문
-- 비밀번호, 이메일, 전화번호, 주소 
UPDATE MEMBER
SET USERPWD = 'XX',
      EMAIL = 'XX',
      PHONE = 'XX',
    ADDRESS = 'XX'
WHERE USERID = 'XX';
