--실습 cond1       --다시 풀어보기 
SELECT empno, ename, deptno,
    CASE    
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESERCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END    
FROM emp;
--또 다른 풀이
SELECT empno, ename, deptno,
    DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES', 40, 'OPERATIONS')
FROM emp;


--실습cond2    //꼭 다시 풀어보기******************
--  올해년도 가 짝수이면
--      입사년도가 짝수일 때 건강검진 대상자
--      입사년도가 홀수일 때 건강검진 비대상자
-- 올해년도가 홀수이면
--      입사년도가 짝수일 때 건강검진 비대상자
--      입사년도가 홀수일 때 건강검진 대상자
--선생님과 함께 푼것 
--    올해년도가 짝수인지, 홀수인지 확인하기한뒤, 년도만 빼오기
-- DATE 타입 -> 문자열(여러가지 포맷, YYYY-MM-DD HH24:MT:SS)
-- 짝수 -> 2로 나눴을때 나머지 값이 0
-- 홀수 -> 2로 나눴을때 나머지 값이 1
SELECT empno, ename, hiredate,
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 0 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 0
      THEN '건강검진 대상자'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 1 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 1
       THEN '건강검진 대상자'
       ELSE '건강검진 비대상자'
       END CONTACT_TO_DOCTOR
FROM emp;       
--
SELECT empno, ename, hiredate,
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )=  MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)
      THEN '건강검진 대상자'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )=   MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)
       THEN '건강검진 대상자'
       ELSE '건강검진 비대상자'
       END CONTACT_TO_DOCTOR
FROM emp;       
--DECODE방법
SELECT empno, ename, hiredate,
    
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 0 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 0
      THEN '건강검진 대상자'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 1 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 1
       THEN '건강검진 대상자'
       ELSE '건강검진 비대상자'
       END CONTACT_TO_DOCTOR
       DECODE(MOD(TO_NUMBER
FROM emp;       

SELECT empno, ename, hiredate,
        
FROM emp;


--실습 cond3 (과제 풀어오기)************
SELECT * 
FROM users;

-----------------------------


SELECT *
FROM emp;

SELECT *
FROM dept;


--GROUP BY 행을 묶을 기준
--부서번호 같은 ROW 끼리 묶는 경우 : GROUP BY deptno
-- 담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY job
--mgr가 같고 담당업무가 같은 ROW 끼리 묶는 경우 : GROUP BY mgr, job
--그룹함수의 종류
-- SUM : 합계
-- COUNT : 갯수
-- MAX : 최대값
-- MIN : 최소값
-- AVG : 평균

--그룹함수의 특징
-- 해당 컬럼에 NULL값을 갖는 ROW가 존재할 경우 해당 값은 무시하고 계산한다. (NULL 연산의 결과는 null)



-- 부서별 급여 합

--그룹함수 주의점******************짱 중요함
-- GROUP BY 절에 나온 컬럼외의 다른컬럼이 SELECT절에 표현되면 에러
SELECT deptno, ename  
        SUM(sal)sum_sal, MAX(sal), MIN(sal), ROUND(AVG(sal),2), COUNT(sal)       
FROM emp
GROUP BY deptno; 


--GROUP BY 절에 없는 상태에서 그룹함수를 사용한 경우
--   -->전체행을 하나의 행으로 묶는다 
SELECT  SUM(sal) sum_sal, MAX(sal), MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),     -- sal 컬럼의 값이 null이 아닌 row의 갯수
        COUNT(comm),    --COMM 컬럼의 값이 null이 아닌 row의 갯수 
        COUNT(comm)   --몇건의 데이터가 있는지      
FROM emp;
 
SELECT *
FROM emp;

-- GROUP BY 기준이 empno이면 결과수가 몇건?? 
--그룹화와 관련없는 임의의 문자열, 함수, 숫자등은 SELECT절에 나오는 것이 가능 
SELECT 1, SYSDATE , SUM(sal)sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),     -- sal 컬럼의 값이 null이 아닌 row의 갯수
        COUNT(comm),    --COMM 컬럼의 값이 null이 아닌 row의 갯수 
        COUNT(*),   --몇건의 데이터가 있는지      
FROM emp
GROUP BY  empno;


--SINGLE ROW FUNCTION 경우 WHEN 절에서 사용하는 것이 가능하다
-- NULI ROW FUNCTION(GROUP FUNCTION)의 경우 WHEN 절에서 사용하는 것이 불가능 하고
-- HAVING 절에서 조건을 기술한다.

--부서별 급여 합 조회, 단 급여합이 9000이상인 row만 조회
--deptno, 급여합
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


--실습 grp1 
SELECT deptno,  MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal),
        COUNT(sal),     -- sal 컬럼의 값이 null이 아닌 row의 갯수
        COUNT(comm),    --COMM 컬럼의 값이 null이 아닌 row의 갯수 
        COUNT(comm)   --몇건의 데이터가 있는지      
FROM emp;



--실습 grp2 부서기준으로   
SELECT MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal),
        COUNT
FROM emp;

--실습 grp3
  CASE    
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESERCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END    ;
    
SELECT DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES'),    
        MAX(sal) max_sal , MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal),
        SUM(sal)
        COUNT(sal)sal_count,     -- sal 컬럼의 값이 null이 아닌 row의 갯수
        COUNT(comm)mgr_count,    --COMM 컬럼의 값이 null이 아닌 row의 갯수 
        COUNT(*)all_count   --몇건의 데이터가 있는지      
FROM emp
GROUP BY DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES')
ORDER BY DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES');



--실습 grp4     다시풀어보기    입사 년월로 그룹기준을 삼기
-- ORACLE 9i 이전까지는 GROUP BY절에 기술한 컬럼으로 정렬을 보장
-- ORACLE 9i 이후 부터는 GROUP BY절에 기술한 컬럼으로 정렬을 보장하지 않는다 (GROUP BY

SELECT  To_CHAR(hiredate, 'YYYYMM'),count(*)
FROM emp
GROUP BY To_CHAR(hiredate, 'YYYYMM');
--ORDER BY To_CHAR(hiredate, 'YYYYMM')    //정렬을 원하면 넣기 


--실습 grp5
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

--실습 grp6
--문제 의도 파악하기 : dept 테이블의 건수가 몇개인지 물어보는것
SELECT count(*) cnt
FROM dept;

--실습 grp7
-- emp테이블에 값의 건수가 몇개가 있는지 물어보는것 
SELECT *
FROM emp
ORDER BY deptno;

SELECT  COUNT(*) cnt
FROM 
(SELECT deptno
 FROM emp   
GROUP BY deptno);



--부서가 뭐가 있는지 : 10, 20, 30 -->3개의 row가 존재
-- > 테이블의 row 수를 조회 : GROUP BY 없이 COUNT(*)
--배열, 포인터, 파일 입출력
--GROUP BY -논리적으로 생각하기........., JOIN (차지하는 비중이 매우 큼)
