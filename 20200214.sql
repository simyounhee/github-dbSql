MERGE : SELECT 하고나서 데이터가 조회되면 UPDATE 가 됨
        SELECT 하고나서 데이터가 조회되지 않으면 INSERT
        
        SELECT + UPDATE / SELECT + INSERT ==>MERGE ;

REPORT GROUP FUNCTION
1. ROLLUP
    -GROUP BY ROLLUP (컬럼1, 컬럼2)
    -ROLLUP절에 기술한 컬럼을 오른쪽에서 하나씩 제거한 컬럼으로 SUBGROUP 
    -GROUP BY 컬럼 1, 컬럼2
    UNION
    GROUP BY 컬럼 1
    UNION
    GROUP BY
2. CUBE
3. GROUPING SET;
-----------------------------어제 배운 거 복습 했음

--실습 GROUP_AD3
ROLLUP사용해서 만들기(컬럼의 순서가 중요하다 )
group by deptno, job
group by deptno
group by;

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno, job) ;

--실습 group_ad4    
SELECT dept.dname, emp.job, SUM(emp.sal + NVL(comm, 0)) AS sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dept.dname,job);
--이번엔 AD4를 인라인뷰를 이용해서 만들어보기 
SELECT dname, job, sal
FROM 
    (SELECT deptno, job, SUM(sal) AS sal
     FROM emp
     GROUP BY ROLLUP(deptno,job)) a, dept b
WHERE a.deptno = b.deptno(+);       --outer 조인을 써줘야 함 (데이터가 없는쪽에 붙여 주는 것이 오라클 문법)

SELECT *
FROM emp;
SELECT *
FROM dept;

--실습 group_ad5**********************************************
--1 CASE 문
SELECT CASE 
        WHEN GROUPING(dname) = 1 AND GROUPING(job) =1 THEN '총합'
        ELSE dname
        END dname,
        job, SUM(sal + NVL(comm, 0))sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--2 DECODE 문
SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '총합',
                                                  '00', dname,
                                                  '01', dname) dname,
       job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;
****************************************************************

REPORT GROUP FUNCTION
1.ROLLUP
2.CUBE
3.GROUPING SETS
활용도
3,1 >>>>>>>>>>>>>>>>>>>>>>>CUBE;

GROUPING SETS
  순서와 관계없이 서브 그룹을 사용자가 직접 선언
  사용방법 : GROUP BY GROUPING SETS(col1,col2...)
  GROUP BY GROUPING SETS(col1, col2,...)
  ==>
  GROUP BY col1
  UNION ALL
  GROUP BY col2
  
  GROUP BY GROUPING SETS ( (col1, col2), col3, col4)
  ==>
  GROUP BY col1, col2
  UNION ALL
  GROUP BY col3
  UNION ALL
  GROUP BY col4;
 
GROUPING SETS 의 경우 컬럼 기술 순서가 결과에 영향을 미치지 않는다
ROLLUP 은 컬럼 기술 순서가 결과 영향을 미친다; 
 
  GROUP BY GROUPING SETS (col1, col2)
  ==>
  GROUP BT col1
  UNION ALL        --UNION을 안쓰고 UNION ALL을 쓰는 이유는 ? 몰라 
  GROUP BY col2
  
  GROUP BY GROUPING SETS (col2, col1)


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

GROUP BY GROUPING SETS(job, deptno)
==>
GROUP BY job
UNION ALL
GROUP BY deptno;


job, deptno 로 GROUP BY 한 결과와
mgr 로 GROUP BY 한 결과를 조회하는 SQL을 GROUPING SETS로 급여합 SUM(sal)작성하기;
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);


32p 두개의 서브구조를 하나의 있는 롤로 묶은 것 
그다음 배울 것은 

CUBE 그룹바이를 확장한것
가능한 모든 조합으로 컬럼을 조합한 SUB GROUP 을 생성한다
단 기술한 컬럼의 순서는 지킨다;

EX : GROUP BY CUBE (col1, col2);

(col1, col2)          
컬럼 원이 포함되냐 안되냐
컬럼 투가 포함되냐 안되냐     ==>
(null, col2) == GROUP BY col2
(null, null) == GROUP BY 전체
(col1, null) == GROUP BY col1
(col1, col2) == GROUP BY col1, col2

만약 컬럼 3개를 CUBE 절에 기술한 경우 나올 수 있는 가지수는 ?? 

SELECT job, deptno, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY CUBE (job, deptno);

                       --지난번처럼 엑셀로 선생님이 설명해주심 (4가지로 색깔 나온 엑셀 참고하기 )
GROUP BY cube (job, deptno);    34p 
UNION ALL
GROUP BY (job, deptno);
UNION ALL 
GROUP BY (job, null);
UNION ALL 
GROUP BY (deptno, null);
UNION ALL 
GROUP BY (null, null);



사실 큐브는 잘 쓰지 않는다 
즁요한건 다 배웠다.
*****************************************************************
혼종;    //이거 선생님이 엑셀로 보여주신 것처럼 색칠해보기 과제 !!!!! ****
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp                          
GROUP BY job, rollup(deptno), cube(mgr);
*****************************************************************
GROUP BY job, deptno, mgr  == GROUP BY job, deptno, mgr
GROUP BY job, deptno == GROUP BY job, deptno
GROUP BY job, null, mar == GROUP BY job,  mar
GROUP BY job, null, null == GROUP BY job
;
37p
38p 총 경우의 수는 6가지 중복X  => 39 p

40p 어드벤스서브쿼리 
다른 테이블의 값을 가지고 서브쿼리 값을 업데이트 하는 것 

서브쿼리  UPDATE
1.기존 emp_test 테이블 drop 
2.emp 테이블을 이용해서 emp_test 테이블생성 (모든행에 대해 ctas)
3.emp_test 테이블에 dname VARCHAR2(14) 컬럼추가
4.emp_test.dname 컬럼을 dept 테이블을 이용해서 부서명을 업데이트;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;


ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;     --행마다 가져와야하는 부서 이름이 달라질 수 있다 그래서 우리가 이것을 서브쿼리로 작성

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno)    --상호 연관 서브쿼리 emp_test.deptno 이부분은 계속 바뀔 것
 COMMIT;      
 

실습 SUB_a1 43p
--기존 거 지우고 
DROP TABLE dept_test ;
--dept_test 테이블 생성 
CREATE TABLE dept_test AS
SELECT *
FROM dept ; 
--확인하기
SELECT *
FROM dept_test;
--dept_test 테이블에 empcnt (number)컬럼 추가 
ALTER TABLE dept_test ADD ( empcnt NUMBER );
--SUBQUERY를 이용하여 dept_test 테이블의 empcnt 컬럼에 해당 부서원 수를 update 하는 쿼리를 작성하세요 

deptno, dname, loc
10	ACCOUNTING	NEW YORK	10번부서에 해당하는....
20	RESEARCH	DALLAS	
30	SALES	CHICAGO	
40	OPERATIONS	BOSTON	
만약 ;
UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*) cnt
                                FROM emp
                                WHERE deptno = dept_test.deptno
                                GROUP BY deptno),0);
                               
SELECT *
FROM dept_test;

SELECT *
FROM dept_test ;     4건 
WHERE dname = 'SALES';          --WHERE 절은 행을 제한한다 


DESC DEPT; 
SELECT *
FROM emp_test; 

44P
실습 SUP_a2;
dept_test테이블에 있는 부서중에 직원이 속하지 않은 부서 정보를 삭제
*dept_test.empcnt 컬럼은 사용하지 않고
emp테이블을 이용하여 삭제; 
INSERT INTO dept_test values( 99, 'it1', 'deajeon' , 0);
INSERT INTO dept_test values( 98, 'it2', 'deajeon' , 0);
commit;

직원이 속하지 않은 부서 정보 조회?
직원이 있다 없다 ..?
10번 부서에 직원 있다 없다..? 

SELECT COUNT(*)
FROM emp 
WHERE deptno = 20;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)                --이 서브쿼리의 값이 영인 것 
           FROM emp
           WHERE deptno = dept_test.deptno)
           
DELETE dept_test          
WHERE 0 = (SELECT COUNT(*)                
           FROM emp
           WHERE deptno = dept_test.deptno) ;  
           
           
--실습 sub_a3
emp 테이블에서 본인이 속한 부서의 (sal)평균 급여보다 급여자 작은 직원의 급여를 현 급여에서 200 추가해서 업데이트 하는 쿼리 작성하시오 
그럼 일단 본인이 속한 부서의 (sal)평균 급여보다 급여자 작은 직원의 급여를 구해보기 

SELECT *
FROM emp_test;
7369	SMITH	20	CLERK	    7902	1980/12/17	800		   
7499	ALLEN	30	SALESMAN	7698	1981/02/20	1600	300
7521	WARD	30	SALESMAN	7698	1981/02/22	1250	500	

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
             FROM emp_test b
             WHERE a.deptno = b.deptno);

--part 1 에서 서브쿼리 연습문제 다시풀어보기 ㅜㅜ


WITH 절
하나의 쿼리에서 반복되는 SUBQUERY가  있을때 
해당  SUBQUERY를 별도로 선언하여 재사용.

MAIN 쿼리가 실행될 때 WITH 선언한 쿼리 블럭이 메모리에 임시적으로 저장
==> MAIN 쿼리가 종료 되면 메모리 헤제

SUBQUERY 작성시에는 해당 SUBQUERY의 결과를 조회하기 위해서 I/O 반복적으로 일어나지만

WITH 절을 통해 선언하면서 한번만 SUBQUERY 가 실행되고 그 결과를 메모리에 저장해 놓고 재사용

단, 하나의 쿼리에서 동일한 SUBQUERY 가 반복적으로 나오는거 잘못 작성한 SQL일 확률이 높음;

사용하는 방법은 
WITH  쿼리블럭이름 AS (
    서브쿼리
)

SELECT *
FROM 쿼리블럭이름; 

예를들면 이걸 한번 해보자 
직원의 부서별 급여 평균을 구하는 쿼리블럭을 WITH절을 통해 선언해보자;

WITH sal_avg_dept AS (
    SELECT deptno, ROUND(AVG(sal), 2) sal
    FROM emp
    GROUP BY deptno
),
    dept_empcnt AS (
        SELECT  deptno, COUNT(*) empcnt
        FROM emp
        GROUP BY deptno)
    
SELECT *
FROM sal_avg_dept;


WITH 절을 이용한 테스트 테이블 작성 
WITH temp AS (
        SELECT sysdate -1 FROM dual UNION  ALL
        SELECT sysdate -2 FROM dual UNION  ALL
        SELECT sysdate -3 FROM dual )
SELECT *
FROM temp;


그 다음은 계층쿼리를 나갈건데 
기초가 되는 달력만들기 PT
특정 년월을 파라미터로 받아서 ..3P 처럼 아무것도 없는 상테에서 테이블을 만들어서 하는 것 
4P 여기서 핵심은 행을 열로 바꾸는 것이다.  이것을 레포트 쿼리에서 많이 쓰인다. 속성이 중복되는 것을 방지한다. 
5P 
6P 이걸 하려면 .....

달력만들기 ; 
CONNECT BY LEVEL <[=] 정수
해당 테이블의 행을 정수만큼 복제하고, 복제된 행을 구별하기 위해서 LEVEL을 부텨
LEVEL 은 1부터 시작; 

SELECT dummy, LEVEL
FROM dual 
CONNECT BY LEVEL <= 10 ;

SELECT dept.* , LEVEL
FROM dept 
CONNECT BY LEVEL <= 5 ;

2020년 2월의 달력을 생성
일단 필요한건 
1. 해당월의 일수가 필요 
    :dt = 202002, 202003 ;
SELECT TO_DATE ('202002', 'YYYYMM') + (LEVEL -1)
FROM  dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD')
FROM dual; 

달력의 특징은 
일  월  화  수  목  금  토
SELECT TO_DATE ('202002', 'YYYYMM') + (LEVEL -1)
      TO_CHAR( TO_DATE ('202002', 'YYYYMM') + (LEVEL -1), 'D' ) 
      DECODE(TO_CHAR( TO_DATE ('202002', 'YYYYMM') + (LEVEL -1), 'D'),
                1. TO_DATE( ('202002', 'YYYYMM') + (LEVEL -1))s ,
     DECODE(TO_CHAR( TO_DATE ('202002', 'YYYYMM') + (LEVEL -1), 'D'),
                2. TO_DATE( ('202002', 'YYYYMM') + (LEVEL -1)) m,
     DECODE(TO_CHAR( TO_DATE ('202002', 'YYYYMM') + (LEVEL -1), 'D')t,
                3. TO_DATE( ('202002', 'YYYYMM') + (LEVEL -1))w,
    DECODE(TO_CHAR( TO_DATE ('202002', 'YYYYMM') + (LEVEL -1), 'D'),
                4. TO_DATE( ('202002', 'YYYYMM') + (LEVEL -1)),s
FROM  dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD')
FROM dual; 