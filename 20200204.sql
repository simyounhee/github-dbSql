--join 7
SELECT cycle.pid, product.pnm, sum(cycle.cnt)
FROM product, cycle
WHERE product.pid = cycle.pid
GROUP BY cycle.pid, product.pnm
ORDER BY ;
--join8
SELECT *
FROM countries;

SELECT *
FROM regions;

SELECT regions.id, regions.name, country.name
FROM countries, regions
WHERE countries.region_id = regions.region_id;

--join9
SELECT region_id, region_name, country_name, city, departments
FROM countries, regions, loctions, departments
WHERE departments

--join10
SELECT region_id, region_name, country_name, city, departments
FROM countries, regions, loctions, departments
WHERE

--join11
SELECT region_id, region_name, country_name, city, department_name, name 
FROM countries, regions, loctions, departments, employees
WHERE

--join12
SELECT employee_id, name, job_id, job_title
FROM employees, job
WHERE employees.employee_id = job.job_employee_id

--join13
SELECT mgr_id, mgr_name, employee_id, name, job_id, job_title
FROM employees, job
WHERE employees.employee_id = job.job_employee_id;


-----------------------------------------------------------------------------
CROSS JOIN ==>카디션 프로덕트(Cartesisan product)
조인하는 두 테이블의 연결 조건이 누락되는 경우
가능한 모든 조합에 대해 연결(조인)이 시도
dept(4건), emp(14건)의 CROSS JOIN의 결과는 4*14 = 56건

dept 테이블과 emp테이블에 조인을 하기 위해 FROM절에 두개의 테이블을 기술 
WHERE절에 두 테이블의 연결 조인을 누락;

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp 
WHERE dept.deptno = 10
AND dept.deptno = emp.deptno;

--실습 crossjoin 1 
SELECT *
FROM customer;
SELECT *
FROM product;

SELECT * 
FROM custmoer, pruduct;

--여기까지가 join 
--------------------------------------------------------------
subquery : 쿼리 안에 다른 쿼리가 들어있는 경우
SUBQUERY가 사용된 위치에 따라 3가지로 분류가 된다. 
    SELECT절 안에 사용되는 것이 : SUBQUERY <- 특징:값이 딱 하나만 가능하기에  하나의 행, 하나의 컬럼만 리턴해야 에러가 발생하지 않는다 .
    FROM 절에 오는 것을 : INLINE - VIEW(VIEW)    
    WHERE절에 오는 것을 : SUBQUERY QUERY 직접 기술한 기술 
    247
    PT250을 예를 들은 것  메인 쿼리 안에 다른 쿼리가 들어간것 
    251 쿼리 쓰는 사용법 예시 안쪽에 들어가는 쿼리는 일반적으로 우리가 쓰는 셀렉트절 사용 
    252 메인쿼리에 20을 대체할 것을 하나의 쿼리로 원하는 쿼릴 실행하는 것 
    253 실습문제 - 평균급여가 무엇일지 생각한 다음 그 급여보다 높은 급여 받는 메인 쿼리를 만들어보자 
    
 -- 실습 SUB 1  다시풀어보기 평균급여보다 높은 급여를 받는 직원은 수를 구하는 것 
 1. 평균급여 구하기
 2. 구한 평균 급여보다 높은 급여를 받는 사람; 
 1.;
 SELECT AVG(SAL)
 FROM emp;
 2.;
 SELECT *
 FROM emp
 WHERE sal > 2073;
 3.;  합치기 
 SELECT count(*)
 FROM emp
 WHERE sal >(SELECT AVG(sal)
            FROM emp);
            
 sub2;           
 SELECT *
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);
              
              
            
구하고자 하는 것 
SMITH가 속한 부서에 속하는 직원들의 정보를 조회
1. SMITH가 어느 부서인지 부서 번호를 구한다. 
2. 1번에서 구한 부서 번호에 속하는 직원들 정보를 조회한다.

1.;
SELECT deptno
FROM emp
WHERE ename = 'SMITH' ; 

2. 1번에 구한 부서번호를 이용하여 해당 부서에 속하는 직원 정보를 조회;
SELECT *
FROM emp
WHERE deptno = 20; 

SUBQUERY를 이용하면 두개의 쿼리를 동시에 하나의 SQL로 실행이 가능하다;

SELECT *
FROM emp
WHERE deptno =(SELECT deptno 
               FROM emp
               WHERE ename = 'SMITH'); 
               


다중행 연산자
IN 서브쿼리의 여러행중 일치하는 값이 존재 할 때 
ANY (활용도는 다소 떨어짐) : 서브쿼리에 여러행중 한 행이라도 조건을 만족할 때 
ALL (활용도는 다소 떨어짐) : 서브쿼리에 여러행중 모든 행에 대해 조건을 만족할 때;

SUB 3;
아까는 우리가 문제를 
SMITH가 속하는 부서의 모든 직원을 조회 가 문제였는데 문제를 하나 더 추가해서 
SMITH와 WARD직원이 속하는 부서의 모든 직원을 조회 

SELECT deptno
FROM emp
WHERE ename IN('SMITH', 'WORD');

SELECT *
FROM emp
WHERE deptno IN('20', '30');

서브쿼리의 결과가 여러 행일 때는 '='연산자를 사용하지 못 한다 .
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));
             
             
                
 SMITH, WARD 사원의 급여보다 급여가 작은 직원을 조회 ( SMITH, WARD의 급여중 아무거나)
SMITH(SAL) : 800
WARD(SAL) : 1250
       ==> 1250보다 작은 사원;
먼저 스미스랑 워드 사원
SELECT *
FROM emp
WHERE sal < ANY (800, 1250);   --ANY : 어떤것이든 다 

SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE sal < ANY ( SELECT sal
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));
                  
 
 SMITH, WARD 사원의 급여보다 급여가 높은 직원을 조회 ( SMITH, WARD의 급여 2가지 모두에 대해 높을 때 )
SMITH(SAL) : 800
WARD(SAL) : 1250                  
   ==>1250보다 급여자 높은 사람    
SELECT *
FROM emp
WHERE sal > ALL ( SELECT sal
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));
                  
 
 
 *IN, NOT IN 의 NUL처리 유의 사항 ;
 직원의 관리자 사번이 7902 이거나(OR) NULL인 사람 ; 
 IN 연산자는 OR 연산자로 치환이 가능하다.
 
 SELECT *
 FROM emp
 WHERE mgr IN (7902, NULL);   
 
 NULL 비교는 '='연산자가 아니라 IS NULL로 비교 해야하지만 IN연산자는 '='로 계산한다;
 SELECT *
 FROM emp
 WHERE mgr = 7902
 OR mgr = null;  
 
 NOT IN (7902, NULL)   해석 사원번호가 7902가 아니면서 NULL이 아닌 사람 
 해석 - 사원 번호가 7902가 아니면서(AND) NULL이 아닌 데이터 ;
 SELECT *
 FROM emp
 WHERE empno NOT IN (7902, NULL);
 
 SELECT *
 FROM emp
 WHERE empno != 7902
 AND empno != NULL;    -- 이 조건때문에 값이 안나온다. 그래서 별도로 IS NOT을 써줘야 한다. != -> IS NOT
 
 260 NOT IN을 쓰면 전체가 NULL처럼 동작한다 즉 값이 나오질 않는다 
 261 널값이 무시되어 나오는 값을 보여줌 
 262 각 비교에 대해서 배웠는데 멀티 PAIRWISE 서브쿼리의 결과가 만족하는 데이터 뽑아 낼때
        사원번호가 7499 와 7782 인 전체 동일한 사람 가져오는
 SELECT mgr, deptno
 FROM emp
 WHERE empno IN (7499, 7782);   -- 이 두가지 컬럼이 동시에 만족하는 사람을 찾아보자 
 
 pairwise (순서쌍)
 순서쌍의 결과를 동시에 만족 시킬때 사용;
 (mgr, deptno)
 (7698, 30 ) , (7839, 10)
 SELECT *
 FROM emp
 WHERE (mgr, deptno) IN (SELECT mgr, deptno
                         FROM emp
                         WHERE empno IN (7499, 7782));
 
 non-pairwise (순서쌍) 순서쌍을 동시에 만족시키지 않는 형태로 작성 
 mgr 값이 7689이거나 7839 이면서 
 deptno가 10이거나 30번인 직원         
 경우의 수는  mgr, deptno
 (7698, 10 ) , (7698, 30)
 (7839, 10), (7839, 30);
 SELECT *
 FROM emp
 WHERE (mgr, deptno) IN (SELECT mgr
                         FROM emp
                         WHERE empno IN (7499, 7782))
 AND deptno IN (SELECT deptno
                FROM emp
                WHERE empno IN(7499, 7782));
                
 
 스칼라 서브쿼리 :  SELECT 절에 기술, 1개의 ROW, 1개의 COL을 조회하는 쿼리
 스칼라 서브쿼리는 MAIN 쿼리의 컬럼을 사용하는게 가능하다;
 
 SELECT SYSDATE 
 FROM dual;
 
 SELECT (SELECT SYSDATE FROM dual), 
        dept.*      --에러가 나는 이유는 테이블 명칭을 적어야지만 에러가 안난다  * -> dept.*
 FROM dept;
 
 스칼라 사용법 이렇게도 사용가능하다는 것을 보여준 것이다 ;
SELECT empno, ename, deptno, 
      (SELECT dename 
       FROM dept 
       WHERE deptno = emp.deptno)dname    --스칼라 서브쿼리는 MAIN 쿼리의 컬럼을 사용하는게 가능하기에 
FROM emp;


INLINE VIEW : FROM절에 오는 서브쿼리;

MAIN쿼리의 컬럼을 SUBQUERY에서 사용하는 유무에 따른 분류 
사용할 경우 : correlated subquery(상호 연관 쿼리), 서브쿼리만 단독으로 실행 하는게 불가능하다 꼭 메인쿼리가 있어야 한다 . 
(SELECT dename                     --즉, 이건만 실행 불가능하다는 건가 ? ?      
       FROM dept 
       WHERE deptno = emp.deptno)
       correlated subquery경우 실행순서가 정해져있다 (main ==>sub)
사용하지 않을 경우 : non-correlated subquery(비상호 연관 서브쿼리), 서브쿼리만 단독으로 실행하는게 가능하다. ;
                   실행순서가 정해져 있지 않다 (main ==> sub, sub ==>main)

모든 직원의 급여 평균보다 급여가 높은 사람을 조회;
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회 ; 
(main쿼리와 서브쿼리가 연결되어 있어야 함);
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;     --각 부터의 급여평균을 구하기 

SELECT *
FROM emp m     --여기까지가 메인쿼리      

WHERE sal > (SELECT AVG(sal)
              FROM emp s
              WHERE s.deptno = m.deptno)     --메인쿼리에서 가져와서 사용   pt266   267 상호연관서브쿼리 정리. 메인쿼리 먼저 실행후 서브커리 실행  267 하지만, 비상호연관서브쿼리는 정해지지 ㅇ낳음 
              ;

위의 문제를 조인을 이용해서 풀어보자
1. 조인 테이블 선정
  첫번째. emp, 부서별 급여 평균(inline view사용하라는 의미)
  
  SELECT emp.* --emp.*ename, sal, deptno, dept_sal.* 와 동일 
  FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
             FROM emp
             GROUP BY deptno) dept_sal
  WHERE emp.deptno = dept_sal.deptno-- 이제 조인을 해야함 
  AND emp.sal > dept_sal.avg_sal;
  
  
실습 sub4
데이터 추가;
INSERT INTO dept VALUES (99, 'ddit', 'deajeon');
삽입한게 들어갔나 확인;
SELECT *
FROM dept;

DELETE dept        --다시 취소
WHERE deptno = 99;

SELECT *  --취소한거 확인 
FROM dept;

ROLLBACK; --트랜잭션 취소
COMMIT;   --트랜잭션 확정    내가 작업을 하더라도 꼭 트랜잭션 확정을 하지 않으면 다른창에서 다시 작업을 하면 기존 데이터가 불러온다. 
  
 
 pt 269 서브쿼리를 이용해서 직원이 한번도 없는 부서를 구해보고 싶을때   힌트  not in 연산자 이용해보기 
 
 SELECT *
 FROM dept 
 WHERE deptno NOT IN (SELECT deptno
                      FROM emp);    --emp 99,40번인 부서가 하나도 없기 때문에 조건을 따로 쓸 필요가 없다  
                      --WHERE deptno IN (10, 20, 30));