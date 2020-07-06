/*
    <함수 FUNCTION>
    
    컬럼값을 읽어서 계산한 결과를 반환함
    
    - 단일행 함수 : N개의 값을 읽어서 N개의 결과를 리턴
    - 그룹 함수 : N개의 값을 읽어서 1개의 결과를 리턴
    
    * SELECT절에 단일행함수와 그룹함수를 함께 사용할 수 없다.
    * 함수를 기술 할 수 있는 위치 : SELECT절, WHERE절, ORDER BY절, GROUP BY절, HAVING절
    

*/

--------------------------< 단일행 함수 > -------------------
/*

    < 문자 관련 함수>
    * LENGTH / LENGTHB      => 결과 값 NUMBER
    
    LENGTH(컬럼|'문자값') : 글자 개수 반환
    LENGTH(컬럼|'문자값') : 글자의 바이트 수 반환
     
    '강' '나'한글 한글자 => 3BYTE
    영문자, 숫자, 특수문자 한글자 => 1BYTE

*/
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상테이블 (DUMMY TABLE)

SELECT EMAIL, LENGTH(EMAIL),LENGTHB(EMAIL), 
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
FROM EMPLOYEE;

--------------------------------------------------------------

/*
    * INSTR
    지정한 위치부터 지정한 숫자번째로 나타내는 문자의 시작 위치 반환
    
    INSTR(컬럼명|'문자값', '문자', [찾을위치의 시작값, 순번])
    
    찾을위치의 시작값
    1   : 앞에서부터 찾겠다.
    -1  : 뒤에서부터 찾겠다.
    

*/
SELECT INSTR('AABAACAABBAA', 'B' ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1 ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', 1,3 ) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B', -1,3 ) FROM DUAL;

SELECT EMAIL, INSTR(EMAIL, '@' )"@위치", INSTR(EMAIL,'S',1,2)
FROM EMPLOYEE;

/*
    * SUBSTR
    문자열에서 지정한 위치부터 지정한 개수 만큼의 문자열을 추출해서 반환
    (자바에서의 substring(start, end)와 유사)
    
    SUBSTR(STRING, POSITION, [LENGTH])      => 결과 값이 CHARACTER
    STRING : 문자타입 컬럼 또는 '문자값'
    POSITION : 문자열을 잘라 낼 위치
    LENGTH : 추출할 문자 개수 (생략시 끝까지 의미)

*/
SELECT SUBSTR('SHOWMETHEMONEY', 7) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 5,2) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', 1,6) FROM DUAL;
SELECT SUBSTR('SHOWMETHEMONEY', -8,3) FROM DUAL;
SELECT SUBSTR('쇼우 미 더 머니', 2, 5) FROM DUAL;

-- 주민번호에서 성별을 나타내는 부분만 잘라보기 
SELECT EMP_NAME, SUBSTR(EMP_NO, 8, 1)
FROM EMPLOYEE;

-- 남자사원만 조회
SELECT EMP_NAME
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) ='1';

-- 여자사원만 조회
SELECT EMP_NAME, '여' 성별
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) ='2';

-- 함수 중첩 사용
SELECT EMP_NAME, EMAIL, SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1) 아이디
FROM EMPLOYEE;

/*
    * LPAD / RPAD
    문자에 대해 통일감있게 보여주고자 할 때 사용
    
    LPAD/RPAD(STRING, 최종적으로 반환 할 문자의 길이(바이트), [덧붙이고자하는 문자])
    
    제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여 최종 N길이 만큼의 문자열을 반환
    덧붙이고자 하는 문자 생략시 공백으로 처리 
*/
-- 20만큼의 길이 중 EMAIL값은 
SELECT LPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 891201-2******       => 총글자수 : 14글자
SELECT RPAD('891201-2',14, '*')
FROM DUAL;

-- 주민번호 첫번째자리부터 성별자리 까지를 추출한 결과값에 오른쪽에 *문자채워서 14글자 반환하기

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;
