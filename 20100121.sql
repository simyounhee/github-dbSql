-- PROD 테이블의 모든 컬럼의 자료 조회(1번)
SELECT *
FROM PROD;


-- PROD 테이블에서 PROD_ID, FROD_NAME 컬럼의 자료만 조회(2번)
SELECT PROD_id, prod_name
FROM prod;


--PROD 테이블에서 cart테이블에서 모든 데이터를 조회하는 쿼리를 작성(3번)
SELECT *
FROM cart;


--member테이블에서 mem_id, mem_pass, mem_name 데이터를 조회하시오(4번) 
SELECT mem_id, mem_pass, mem_name
FROM member;




----users 테이블 조회
SELECT *
FROM users;


--테이블에 어떤 컬럼이 있는지 확인하는 방법 

SELECT id
FROM users;


--테이블에 어떤 컬럼이 있는지 확인하는 방법 
-- 1.SELECT *
-- 2. TOOL의 기능 (사용자--TABELS)
-- 3. DESC 테이블명 (DESC-DESCRLBE)
DESC users;


-- users 테이블에서 userid, usernm, reg_dt 칼럼만 조회하는 sql을 작성하세요

-- 날짜 연산 (reg_dt 컬럼은 date정보를 담을 수 있는 타입)
-- SQL 날짜컬럼 +(더하기 연산)
-- 수학적인 사칙연산이 아닌 것들 (5+5)
-- String h = "Hello";
-- String w = "World";
-- String hw = h+w; -- 자바에서는 두 문자열을 결합
-- SQL에서 정의된 날짜 연산 : 날짜 + 정수 = 날짜에서 정수를 일자로 취급하여 더한 날짜 (2019/01/28 + 5 = 2019/02/28)
-- reg_dt : 등록일자 컬럼 
-- null : 값을 모르는 상태, 할당되지 않은 값, 0, 공백과는 다르다
-- null의 특징: null에 대한 연산 결과는 항상 null **

SELECT userid u_id, usernm, reg_dt, 
       reg_dt + 5 AS reg_dt_after_5day
FROM users;


--연습문제(2)
--prod 테이블에서 prod_id, prod_name 두 컬럼을 조회하는 쿼리를 작성하시오 
---                                      (단 prod_id ->id, 으로 컬럼 별칭을 지정)
SELECT prod_id, prod_name
FROM prod;

--lprod 테이블에서 lprod_gu, lprod_nm 두 컬럼을 조회하는 퀴리를 작성하시오
---
SELECT lprod_gu, lprod_nm
FROM lprod;

--
SELECT buyer_id 바이어아이디, buyer_name 이름
FROM buyer;



--문자열 결합
-- 자바 언어에서 문자열 결합 : + ("hello" + "world")
--SQL에서는 : ||    ('Hello' || 'world')
--SQL에서는 : concat('Hello', 'world')


-- userid, usernm 컬럼을 결합, 별칭 id_name
SELECT usernm || usernm id_name,
       CONCAT(userid, usernm) doncat_id_name
FROM users;


-- 변수, 상수 
--int a = 5; String msg = "Helloworld";

--출력하는 방법 크게 두 가지

--//변수를 이용한 출력
--System.out.println(msg);

--//상수를 이용한 출력
--System.out.println("Hello, World")
--SQL에서의 변수는 없음 (컬럼이 비슷한 역할, pl/ sql 변수 개념이 존재)
--SQL에서 문자열 상수는 싱글 퀘테이션으로 표현
--"Hellom World" --> 'Hello, World'


-- 문자열 상수와 컬럼간의 결합 
-- usre id : brown
-- user id : cony
SELECT 'user id : ' || userid  AS "use rid"
FROM users; 



SELECT TABLE_NAME
FORM user_tables ;


SELECT 'user id : ' || userid  AS "use rid"
FROM users; 

SELECT 'SELECT * FROM ' || table_name || ';'  query
FROM user_tables;

--SELECT  CONCAT( CONCAT('SECLECT * FROM ', table_name),';')
FROM user_tables;
SELECT  CONCAT('SECLECT * FROM ', table_name)
FROM user_tables;
SELECT 'SELECT * FROM ' || table_name || ';'  query
FROM user_tables;

참고--CONCAT 사용법 (|| -> CONCAT으로 바꾸는 법 )
--                        CONCAT(arg1, arg2)     tip. ctrl+shift 드래그  
SELECT usernm || usernm id_name,
       CONCAT(userid, usernm) doncat_id_name
FROM users;

SELECT  CONCAT( CONCAT('SECLECT * FROM ', table_name),';')
FROM user_tables;

-- int a = 5; // 할당, 대입 연산자 
-- if (a == 5) (a의 값이 5인치 비교)
-- sql에서는 대입의 개념이 없다 (pl/s 
--하지만, sql에선 sql = -> equal


--users의 테이블의 모든 행에 대해서 조회
--users에는 5건의 데이터가 존재
SELECT*
FROM users;


--WHERE 절 : 테이블에서 데이터를 조회할 때 행을 조건에 맞는 행만 조회 
---EX : userid 컬럼의 값이 brown인 행만 조회 
-- brown, 'brown' 구분
--컬럼, 문자열 상수 
SELECT *
FROM users
WHERE userid = 'brown';


--연습
--userid가 brown이 아닌 행만 조회 
---    같을 때 : =, 다를때 : !=, <>
SELECT *
FROM users
WHERE userid != 'brown';

-- emp 테이블에 존재하는 컬럼을 확인해보세요.
SELECT *
FROM emp;

--emp 테이블에서 ename 컬럼 값이  JONES인 행만 조회 
--- *SQL KEY WORD는 대소문자를 가리지 않지만
---컬럼의 값이나, 문자열 상수는 대소문자를 가린다
---'JONES', 'JONES'는 값이 다른 상수 
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --emp의 약자 //mgr : 직원 
DESC emp
5 > 10 --FALSE
5 > 5 --FALSE
5 >= 5 --TRUE

--emp 테이블에서 detno(부서번호)가 30보다 크거나 같은 사원들만 조회 (SQL에서 많이 쓰는 것)
SELECT *
FROM emp
WHERE dePtno >= 30;


-- 문자열 : '문자열'
-- 숫자 : 50
-- 날짜 : ??? ----> 함수와 문자열을 결합하여 표현 
--       문자열만 이용하여 표현 가능 (하지만 권장하지 않음)
--     이유는 국가별로 날짜 표기 방법(해석방법)이 다르기 때문에 ...
--     ex)    우리나라 : 년도4자리-월2자리-일자2자리
--            미   국 : 월2자리-일자2자리-년도4자리

--입사일자가 1980년 12월 17일 직원만 조회 
SELECT *
FROM emp
WHERE hiredate = '80/12/17';

-- TO_DATE : 문자열을 date 타입으로 변경하는 함수 
-- TO_DATE(날짜형식 문자열, 첫번째 인자의 형식)
-- '1980/02/03' 두번째 콜롬과 세번째 콜롬이 어느게 월이고 일인지 알 수 없다 그래서 명시를 하는 것이다.
SELECT *
FROM emp
WHERE hiredate = To_DATE('19801217', 'YYYY/MM/DD');  --이렇게



--이번엔
-- 범위연산
-- sal 컬럼의 값이 1000에서 2000 사이인 사람 
--     sal >= 1000
--     sal <= 2000    
SELECT *
FROM emp
WHERE sal >= 100
AND sal <= 2000;        --이 두 조건을 만족하기 위해서는 AND를 넣어주면 된다 


--범위연산자를 부등호 대신에 BETWEEN AND 연산자로 대체 
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND 

To_DATE('19801217', 'YYYY/MM/DD');

SELECT ename, hiredate 
FROM emp 
WHERE hiredate BETWEEN To_DATE('19820101', 'YYYY/MM/DD') AND To_DATE('19830101', 'YYYY/MM/DD');
