--실습 grp7
SELECT COUNT(*)
FROM
        (SELECT deptno ,       
        count(*)
FROM emp
GROUP BY deptno)
;
---------------------------------------------------------------------------------------------------------------
--      sql 문법 중 가장 중요한 데이터 결합  JOIN
--    RDBMS 로 통합이 됨     중복을 최소화 하는
--만약 테이블에 중복된 과정이 있다면, 필요한게 있으면 다른 데이터에서 가져와서 결합을 하여 쓰는 것 
--join하여 가져오는 법 


SELECT *
FROM dept;
    
-- JOIN 두 테이블을 연결하는 작업
-- JOIN 문법
--    1. ANST 문법
--    2. ORACLE 문법 

--Natural Join
-- 두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결(조언)
-- emp, dept 테이블에는 deptno 라는 컬럼이 존재
SELECT *
FROM emp NATURAL JOIN dept;

--Natural join에 사용된 조언 컬럼(deptno)는 한정자(ex. 테이블명, 테이블 별칭)을 사용하지 않고
-- 컬럼명만 기술한다 (dept.deptno ->deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno  -- dept.deptno   앞에 한정자를 없애야지만 에러가 뜨지 않음
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용가능 
SELECT e.empno, e.ename, d.dname, deptno  -- 이렇게 별칭을 사용해서 사용 가능 핟다
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--  FROM 절에 조인할 테이블 목록을 ,로 구분하여 나열한다
-- 조인할 테이블의 연결 조건을  WHERE절에 기술한다 
-- emp, dept 테이블에 존재하는 deptno 컬럼이 [같을 때] 조인
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;           --건수를 보기 


SELECT emp.ename, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno;




EXPLAIN PLAN FOR
SELECT emp.ename, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno;





오라클 조언의 테이블 별칭;
SELECT e.depno, e.ename, d.dname, deptno      --오라클에서는 어떤 테이블에서 갖고올건지 써줘야 함 
FROM emp e, dept d
WHERE e.deptno = d.deptno;


ANSI : join with USING
조인하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만, 하나의 컬럼으로만 조인을 하고자 할 때 조인하려는 기준 컬럼을 기술 ;
emp, dept 테이블의 공통 컬럼 : deptno   <-내가 조인하려는 컬럼을 구체적으로 명시하는 것 ;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING(deptno);


JOIN WITH USING을 ORACLE로 표현하려면?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;


ANSI : JOIN WITH ON
조인 하려고하는 테이블의 컬럼 이름이 서로 다를때 사용한다;
SELECT emp.ename, dept.dname, emp.deptno                -- 얘는 또 써줘야 함 
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


JOIN WITH ON --> ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;


SELF JOIN : 같은 테이블간의 조인;     --같은 테이블로 조인하는 이유는 스미스 사원의 관리자 알고 싶은데 
예 : emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여 관리자 이름을 조회할 때; 
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);       -- null이면 같이 입력되지 않는다


오라클 문법으로 작성;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;



--p202 null끼리는 연결 안된다 그래서 14 -> 13 건만 나오는 것이다 .
-- 지금까지 우리는 이것을 배운 것
equal  조인 : =
non-equal 조인 : !=, >, <, BETWEEN AND;             


사원의 급여 정보와 급여 등급 테이블을 이용하여 해당사원의 급여 등급을 구해보자 ;
SELECT ename, sal
FROM emp;
오라클 문법으로 해보기;
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal 
              AND salgrade.hisal;
              
ANSI 문법을 이용하여 위의 조인 문을 작성해보기; ????????????????????????????????????????????????             
SELECT *
FROM salgrade;

--ANSI : JOIN WITH ON
--조인 하려고하는 테이블의 컬럼 이름이 서로 다를때 사용한다;
--SELECT emp.ename, dept.dname, emp.deptno                -- 얘는 또 써줘야 함 
--FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT emp.ename, e.sal, salgrade.grade
FROM emp e JOIN salgrade s ON (e.sal );    --on 절에 조인 조건 기술 할 수 있다



--실습 join0
SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.empno,e.ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;  



실습 join0_1
SELECT e.empno, e.ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.deptno in(10, 30)
AND d.deptno in(10,30);

SELECT e.empno, e.ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno 
AND e.deptno !=20
;

실습 join0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.sal > 2500;

실습 join0_3
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.sal > 2500
AND e.empno > 7600;

실습 join0_4
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'RESEARCH';

--실습 join1               다시풀어보기 
PROD : PROD_LGU
LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

SELECT l.lprod_gu, l.lprod_nm, p.prod_id, p.prod_name
FROM prod p, lprod l
WHERE p.prod_lgu = l.LPROD_GU;


--실습 join2
SELECT *
FROM buyer;     --buyer_lgu

SELECT *
FROM prod;   --prod_lgu

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name 
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer;

--실습 join3   숙제 

