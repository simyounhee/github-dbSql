--문제
<<<<<<< Updated upstream
---emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 작성하시오.
--     (단, 연산자는 비교연산자를 사용한다.)
=======
---emp 테이블에서 입사 일자가 1982년 1월 1일 이후부터 1983년 1월 1일 이전인 사원의 ename, hiredate 데이터를 조회하는 쿼리를 
-- 작성하시오.(단, 연산자는 비교연산자를 사용한다.)
>>>>>>> Stashed changes
-----*where절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
----그 이유는 SQL은 집합의 개념을 갖고 있기 때문이다. 집합은 명확해야함 
--집합 : 키가 185cm이상이고 몸무게가 70kg이상인 사람들의 모임
--      -->몸무게가 70kg이상이고 키가 185cm이상인 사람들의 모임
--집합의 특징 : 집합에는 순서가 없다 
--(1, 5, 10) --> (10, 5, 1) : 두 집합은 서로 동일하다.
-- 테이블에는 순서가 보장되지 않는다.
--SELECT 결과가 순서가 다르더라도 값이 동일하면 정답이다.
--> 정렬기능 제공( ORDER BY)
--      잘생긴 사람의 모임 -->집합 X
--
SELECT *    
FROM emp;


SELECT ename ,hiredate
FROM emp
WHERE hiredate >=To_Date('1982/01/01', 'YYYY/MM/DD') and hiredate <=To_Date('1983/01/01', 'YYYY/MM/DD'); 


-- IN 연산자 
--특정 집합에 포함되는지 여부를 확인
--부서번호가 10번 혹은(=OR) 20번에 속하는 직원 조회      
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20); 

--IN 연산자를 사용하지 않고 OR 연산자 사용
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10 
OR    deptno = 20;


-- emp 테이블에서 사원이름이 SMITH, JONES 인 직원만 조회 (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';


-- AND / OR 헷갈리지 말기 !  IN= OR (그러나 쓰는 방식은 다르다)
<<<<<<< Updated upstream
--문자 상수 
=======

>>>>>>> Stashed changes


-실습
--users 테이블에서 userid 가 brown, cony, sally인 데이터를 다음과 같이 조회하시오 ( IN 연산자 사용 )

SELECT *
FROM users;


SELECT userid 아이디, usernm 이름
FROM users
WHERE userid IN  ( 'brown', 'cony', 'sally');


--문자열 매칭 연산자 : LIKE, %
--위에서 연습한 조건은 문자열 일치에 대해서 다룸
--이름이 BR로 시작하는 사람만 조회
--이름에 R 문자열이 들어가는 사람만 조회

--사원 이름이 S로 시작하는 사원 조회 
--SMITH, SMILE, SKC
--% 어떤 문자열 (한글자, 글자 없을 수도 있고, 여러 문자열이 올 수도 있다)
SELECT *
FROM emp;

SELECT 
FROM
WHERE ename LIKE 'S%';

--글자수를 제한한 패턴 매칭
-- _정확한 한문자
--직원 이름이 S로 시작하고 이름의 전체 길이가 5글자 인 직원 
--S_____
SELECT *
FROM emp
WHERE ename LIKE 'S____';


--사원 이름에 S글자가 들어가는 사원 조회
--ename LIKE '%S%'
SELECT *
FROM emp
WHERE ename LIKE '%S%';


--실습  WHERE4
-- 순서
--1
SELECT *
FROM member;

--2
SELECT mem_id, mem_name
FROM member;

--3
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';


--실습 WHERE5
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name 



--nuall 비교 연산 (IS)
-- come 컬럼의 값이 null인 데이터를 조회 (WHERE comm = null)
SELECT *
<<<<<<< Updated upstream
FROM emp;
WHERE comm = null;

SELECT *
FROM emp;
WHERE comm = '';

SELECT *
FROM emp;
WHERE comm IS null;

SELECT *
FROM emp;
WHERE comm IS NOT null;
=======
FROM emp
WHERE comm = null;      ---X

SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;    ---null

SELECT *
FROM emp
WHERE comm IS NOT null; ---null(X)
>>>>>>> Stashed changes


SELECT *
FROM emp
<<<<<<< Updated upstream
WHERE comm >= 0
=======
WHERE comm >= 0;
>>>>>>> Stashed changes


--실습 where6
SELECT *
FROM emp
WHERE comm IS NOT null;
--또 다른 풀이
SELECT *
FROM emp
WHERE comm >= 0


--논리연산 어떻게 묶을지 하는것 
--사원의 관리자가 7698, 7839 그리고 null이 아닌 직원만 조회 
--NOT IN 연산자에서는 NULL 값을 포함 시키면 안된다 *******핵심!!
SELECT *
<<<<<<< Updated upstream
FROM emp;
WHERE mgr not in( 7698, 7839, null);
--제대로 쓰게 되면 -->
SELECT *
FROM emp;
=======
FROM emp
WHERE mgr not in( 7698, 7839, null);
--제대로 쓰게 되면 -->
SELECT *
FROM emp
>>>>>>> Stashed changes
WHERE mgr not in( 7698, 7839)
AND mgr IS NOT NULL;


--실습 WHERE7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_Date ('1981/06/01', 'yyyy/mm/dd');

--where8
SELECT *
FROM emp
WHERE DEPTNO != 10
AND HIREDATE > TO_Date ('1981/06/01', 'yyyy/mm/dd') ;

--where9
SELECT *
FROM emp
WHERE DEPTNO NOT IN(10)
AND HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;


--10
SELECT *
FROM emp
WHERE DEPTNO IN(20,30)
AND HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;

--11
SELECT *
FROM emp
WHERE job = 'salesman'
OR HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;


--12
SELECT *
FROM emp
WHERE JOB = 'SALESMAN'
or empno LIKE '78%';

--13
SELECT *
FROM emp 
WHERE job = 'SALESMAN'        --행의 값은 대소문자 꼭 확인하기  
OR empno LIKE '78%';    





-- 연산자 우선순위 
--*, / 연산자가 +, - 보다 우선순위가 높다 
--ex) 1+5*2 = 11 -> (1+5)*2 (X)
--우선순위 변경 : ()
--AND > OR    (AND가 OR보다 우선순위가 높다 )

--emp 테이블에서 사원 이름이 SMITH 이거나
--             사원 이름이 ALLEN 이면서 담당업무가 SALLESMAN인 사원 조회 
SELECT *
FROM emp
WHERE ename = 'SMITH'
<<<<<<< Updated upstream
OR (ename = 'ALLEN' AND JOB = 'SALLESMAN');      
=======
OR (ename = 'ALLEN' AND JOB = 'SALESMAN');      
>>>>>>> Stashed changes


--사원 이름이 SMITH 이거나 ALLEN 이면서 
--담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp                        
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN' ;                        --  소문자로 써서 틀렸음.. 


--14
SELECT *
FROM emp
WHERE JOB = 'SLAESMAN'
OR (empno Like '78%' AND HIREDATE >= To_Date('1981/06/01', 'yyyy/mm/dd')); 



--정렬
--SELECT *
--FROM TABLE
--[WHERE]
--ORDER BY {컬럼|별칭|칼람인덱스 {ASD | DESC}, ....}


--emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 오름 차순 정렬한 결과를 조회하시오.
SELECT *
FROM emp     ---DESC : DESCRIBE (설명하다 )       
ORDER BY ename DESC; --DESC : DESCENDING  (내림)                -조건이 없어서 WHERE는 쓰지 않는다 


--emp 테이블에서 사원 정보를 ename컬럼으로 내림차순,
--ename 값이 같을 경우 mrg 컬럼으로 오름차순 정렬하는 쿼리를 작성하세요
SELECT *
FROM emp
ORDER BY ename DESC, mrg;


--정렬시 별칭을 사용
SELECT empno, ename nm, sal*12 year_sal --이렇게도 정렬이 가능하다는 점    --???????
FROM emp 
ORDER BY year_sal;

--컬럼 인덱스로 정렬
--java array(0부터 시작)
--SQL COLUMN INDEX : 1부터 시작
SELECT empno, ename nm, sal*12 year_sal 
FROM emp 
ORDER BY 3;



----ORDER BY 1 
SELECT *
FROM dept
ORDER BY DNAME ;      --오름차순은 생략가능  

SELECT *
FROM dept
ORDER BY LOC DESC;   --부서위치 


----ORDER BY 2
SELECT *
FROM emp
WHERE comm is not null AND comm != 0
ORDER BY comm DESC , empno ;



----3
SELECT * 
FROM emp
WHERE mgr IS NOT NULL
ORDER BY Job, empno DESC;          --??????????????


 


ELECT *
FROM users;

SELECT userid 아이디 , usernm 이름 , alias 별명
FROM users
WHERE userid IN( 'brown', 'cony', 'sally');



