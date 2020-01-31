
-- orderby 4   다시풀기
SELECT * 
FROM emp
WHERE deptno =10  OR deptno =  30
AND  sal >= 1500 
ORDER BY ename DESC ;

SELECT *                            --또 다른 풀이
FROM emp
WHERE deptno IN(10,30)
AND  sal >= 1500 
ORDER BY ename DESC;  


--FFWNUM : 행번호를 나타내를 컬럼      정렬에 많이 씀 ? 
SELECT empno, ename
FROM emp
WHERE deptno IN (10, 30)
AND sal > 1500;



--ROWNUM을 WHERE절에서도 사용가능
--동작하는 것 : = ROWNUM = 1, ROWNUM <= 2  --> ROWNUM = 1, ROWNUM <= N
--동작하지 않는 것 : ROWNUM =2, ROWNUM >= 2  --> ROWNUM (N은 1이 아닌 정수), ROWNUM >= N (N은 1이 아닌 정수)
--ROWNUM 이미 읽은 데이터에다가 순서를 부여
--**유의점 1. 읽지 않은 상대의 값들(ROWNUM이 부여되지 않는 행)은 조회할 수 없다.  ****************
--**유의점 2. ORDER BY 절은 SELECT 절 이후에 실행할 수 있다.
--사용용도 : 페이지 처리
--테이블에 있는 모든 행을 조회하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다.
--페이지 처리시 고려사항 : 1페이지당 건수, 정렬 기준 (작성 시간)
--emp테이블 중 row rjstn : 14
--페이지당 5건의 데이터를 조회
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <=2;    


--**유의점 2. ORDER BY 절은 SELECT 절 이후에 실행할 수 있다.
SELECT ROWNUM rn, empno, ename        --순서 뒤죽박죽   순서 보정하려면 우리가 아직 배우지 않은 것을 사용해야함 
FROM emp
ORDER BY ename ;
-- 정렬한 결과에 ROWNUM을 부여하기 위해서는 IN LINE VIEW를 사용한다.
-- 요점정리 : 1. 정렬을 먼저 한다  2.ROWNUM 부여

--SELECT *를 기술할 경우 다룬 EXPRESSION을 표기하기 위해서 테이블 명.*로 표현해야한다
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;


--      ROWNUM  -> rn
-- *page size : 5, 정렬기준은 ename
-- 1page : rn 1~5
-- 2page : rn 6~10
-- 3page : rn 11~15
-- n page : rn (page-1)* pageSize + 1 ~ n * pageSize
SELECT ROWNUM rn, a.*
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename          --    <--테이블 이름 없음 별칭으로 이름 정할 수 있ㅇ,ㅡㅁ 
         FROM emp
         ORDER BY ename ) a ) 
WHERE rn BETWEEN (1 - 1 ) * 5   AND 1 * 5;     --WHERE rn >=6  AND rn <= 10;  



--ROWNUM 실습 row_1
SELECT *
FROM
    (SELECT ROWNUM rn,emp.*
     FROM emp)
WHERE rn >=1 AND rn <= 10;
--                 또 다른 풀이
SELECT *
FROM 
(SELECT ROWNUM ru, empno, ename 
FROM emp)
WHERE ROWNUM ;


--row_2
SELECT *
FROM
    (SELECT ROWNUM rn,emp.*
     FROM emp)
WHERE rn BETWEEN 11  AND 14;

--row_3
SELECT *
FROM
    (SELECT ROWNUM RN , a.*
     FROM
        (SELECT emp.*
         FROM emp
         ORDER BY ename) a)
WHERE RN  BETWEEN 11  AND 14;



--row 3 다시풀이
SELECT *
FROM
    (SELECT ROWNUM rn, a.* 
     FROM
        (SELECT empno, ename
          FROM emp
ORDER BY ename)a)
WHERE rn BETWEEN (:page -1 ) * :pageSize +1 AND :page * :pageSize; --WHERE RN BETWEEN 11 AND 14;     --WHERE rn BETWEEN ( 1 - 1 )*10 +1 AND 1*10; 

--sql이 제대로 돌아가는지가 궁금................ㅠㅠㅠㅠ



--R
SELECT empno, ename
FROM emp;


---------------------------------------------
--실습 row 3
-----------------------------------------------
--메소드? 함수 
--single     
--character 문자열 조작
--  low 소문자 만드는 것 up 대문자 만드는 것 ini 대문자로 시작하고 나머지는 소문자  trim 
--dual tanble 


-- DUAL 테이블 : 데이터와 관계없이, 함수를 테스트 해볼 목적으로 사용
SELECT LENGTH('TEST')
FROM dual;
--문자열 대소문자 : LOWER, UPPER, INITCAP
SELECT LOWER ( 'Hello, World!' ), UPPER( 'Hello, World!' ), INITCAP('Hello, World!')
FROM emp;

SELECT LOWER ( ename ), UPPER(ename), INITCAP(ename)
FROM emp;

-- 함수는 WHERE 절 에서도 사용 가능하다
--EX. 사원 이름이 SMITH인 사원만 조회
SELECT *
FROM emp
WHERE ename = 'SMITH';
--바인드로 입력할 경우
SELECT *
FROM emp
WHERE ename = :ename;

SELECT *
FROM emp
WHERE ename = UPPER (:ename);

--- SQL 작성시 아래 형태는 지양해야한다.
-- 주의!  테이블의 컬럼을 가공하지 않는 형태로 SQL을 작성해야한다.            
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;     

--
SELECT CONCAT ('Hello', ', World' ) CONCAT
FROM dual;

SELECT CONCAT('Hello', ' World' ), 
       SUBSTR('Hello, World', 1, 5)    --     <--Hello 까지만 쓰고 싶을 때
FROM dual;

SELECT CONCAT ('Hello', ', World' )  CONCAT,
    SUBSTR('Hello, World', 1, 5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World', 'o') ins,
    INSTR('Hello, World', 'o', 6 ) ins2,
    LPAD('Hello, World', 15, '*') RP,
    REPLACE('Hello, World', 'H','T') REP,
    TRIM('   Hello, World    ') TR, --공백을 제거
    TRIM('d' FROM 'Hello, World') TR, --공백이 아닌 소문자 d 제거
FROM dual;


-- 숫자 함수
--ROUND : 반올림 (10.6을 소수점 첫번째 자리에서 반올림 -> 11)
--TRUND : 절삭(버림) (10.6을 소수점 첫번째 자리에서 절삭 --> 10)
--ROUND, TRUND : 어떤 값을 몇번째 자리에서 반올림 /절삭
--MOD : 나머지 (몫이 아니라 나누기 연산을 한 나머지 값) (13/5 -> 몫:2, 나머지:3)   ******많이 쓰는 함수 외우기! 
 
 -- ROUND (대상 숫자, 최종 결과 자리)
 SELECT ROUND (105.54, 1), --반올림 결과가 소수점 첫번째 자리까지 나오도록 --> 두번째 자리에서 반올림하겠다는 소리 
        ROUND (105.55, 1),--반올림 결과가 소수점 첫번째 자리까지 나오도록 --> 두번째 자리에서 반올림하겠다는 소리
        ROUND (105.55, 0), --반올림 결과가 정수부분만 --> 소수점 첫번째 자리에서 반올림 
        ROUND (105.55, -1), --반올림 결과가 십의 자리까지만 --> 일의 자리에서 반올림 
        ROUND (105.55) --두번째 인자를 입력하지 않을 경우 0으로 적용된다. 그래서 세번째답과 같게 나온 것 
 FROM dual;
 
SELECT TRUNC (105.54, 1),  --절삭의 결과가 소수점 첫번째 자리까지 나오도록 ->두번째 자리에서 절삭
       TRUNC (105.55, 1),  --절삭의 결과가 소수점 첫번째 자리까지 나오도록 ->두번째 자리에서 절삭
       TRUNC (105.55, 0)  --절삭의 결과가 정수부(일의 자리)까지 나오도록 ->소수점 첫번째 자리에서 절삭
       TRUNC (105.55, 0), 
       TRUNC (105.55, -1) -- 절삭의 결과가 10의 자리까지 나오도록 -> 일의 자리에서 절삭
       TRUNC(105.55, 0 ) --두번째 인자를 입력하지 않을 경우 0이 적용 
FROM dual;


--emp테이블에서 사원의 급여(sal)를 1000으로 나눴을 때 몫을 구해보세요
SELECT ename, sal, sal/1000      
FROM emp;
------

SELECT ename, sal, TRUNC(sal/1000)      
FROM emp;

--나머지를 구할 때 MOD
 SELECT ename, sal, 
        TRUNC(sal/1000),
        MOD (sal, 1000)       --mod의 결과는 divisor보다 항상 적다  그래서 -- 0~999
FROM emp;
 

--날짜 관련된 것 
DESC emp;

DESC emp; 

--년도2자리/월2자리/일자2자리  설정을 바꾸면 
SELECT ename, hiredate
FROM emp;

--SYSDATE : 현재 오라클 서버의 시,분,초가 포함된 날짜 정보를 리턴하는 특수 함수  
--함수명(인자1, 인자2)
SELECT SYSDATE
FROM dual;

-- <복습하기>
-- date + 정수 = 일자연산
--   1 = 하루
--   1시간 = 1/24
--    2020/01/28 + 5

--  숫자 표기 : 숫자
--  문자 표기 : 싱글 퀘테이션 + 문자열 + 싱클 퀘테이션 --> '문자열'
--  날짜 표기 : TO_DATE('문자열 된 날짜 값', '문자열된 날짜 값의 표기형식')   -->TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE + 5, SYSDATE + 1/24
FROM dual;

