SUB 4
dept 테이블에는 5건의 데이터가 존재
emp 테이블에는 14건의 직원이 있고, 직원은 하나의 부서에 속해 있다 (deptno)
부서중 직원이 속해 있지 않은 부서 정보를 조회 ; 

서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성; 
SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT deptno     
                     FROM emp);

SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT deptno     
                     FROM emp
                     GROUP BY deptno);
--                         |
SELECT deptno      --이게 서브쿼리로 들어갈 것 
FROM emp;
GROUP BY deptno;

--distinct 유일하게 구별되는 것 말 그대로 값의 중복을 제거하는 역할이다.  그룹바이와 동일한 역할을 한다 그래서 
SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno     
                     FROM emp);

--------------------------------------------------
실습 SUB 5;
고객번호가 1번인 고객이 애용하지 않는 것 조회 ;
모든 제품은 다음 4가지
SELECT *
FROM product;

cid= 1인 고객이 애음하는 제품;
SELECT pid
FROM cycle
WHERE cid = 1; 

SELECT *
FROM product 
WHERE pid NOT IN (100, 400);

답;
SELECT *
FROM product 
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);
---------------------------------------------------------
실습 SUB 6;
cid=2인 고객이 애음하는 제품중 cid=1인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리 작성;

cid=1인 고객의 애음정보 ==>100, 400번인 제품을 애음중이다.;
SELECT *
FROM cycle
WHERE cid= 1;

cid =2 인 고객이 애음하는 제품 ==>100, 200제품을 애음중;
SELECT pid 
FROM cycle
WHERE cid =2; 

cid =1, cid=2인 고객이 동시에 애음하는 제품은 100번;
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid= 2);
-------------------------------------------------------
SUB7;
SELECT *
FROM customer;
SELECT *
FROM cycle;
SELECT *
FROM product;

SELECT o.cid, o.cnm,p.pid, p.pnm, c.day, c.cnt
FROM customer o,cycle c, product p
WHERE o.cid = c.cid
AND c.pid = p.pid
AND o.cnm = 'brown'
AND c.pid IN (SELECT pid
              FROM cycle
              WHERE cid= 2);

정식방법;
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN (SELECT pid
            FROM cycle
            WHERE cid= 2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

스칼라서브쿼리 방법(권장하지 않는 방법); 
SELECT cycle.cid, (SELECT cnm FROM customer WHERE cid = cycle.cid)cnm,
       cycle.pid, (SELECT pnm FROM product WHERE pid = cycle.pid) pnm,
       cycle.day, cycle.cnt
FROM cycle
WHERE cid = 1
AND pid IN (SELECT pid
            FROM cycle
            WHERE cid= 2);
-------------------------------------------------------------------------------
pt 273
매니저가 존재하는 직원을 조회(KING을 제외한 13명의 데이터가 조회);  sub8번 문제
SELECT *
FROM emp;  먼저 조회 우리가 원하는 매니저가 있는 사람만 구하는 것이기때문에 여기에 
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

EXSITS 조건에 만족하는 행이 존재하는지 확인하는 연산자
다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는데 
   . WHERE empno =7365
   . WHERE EXISTS (SELECT 'x'
                   FROM......);
                
매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회;
매니저도 직원;
SELECT empno, ename, mgr       
FROM emp e
WHERE EXISTS (SELECT 'X'
             FROM emp m
             WHERE e.mgr = m.empno); 

SELECT empno, ename, mgr         --엑셀로 그려보기 
FROM emp e
WHERE EXIST (SELECT 'X'
             FROM emp m
             WHERE 7982 = m.empno);
---------------------------------------------------------------------
SUB 9 EXIST연산자 이용해서 풀기
1번 고객이 애음하는 제품 ==> 100, 400;
SELECT *
FROM cycle
WHERE cycle.cid = 1;

SELECT *
FROM product
WHERE PID IN (100, 400);   

SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle 
              where cid = 1
              AND cycle.pid =product.pid);   
              
              
실습 SUB10;              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle 
                  where cid = 1
                  AND cycle.pid =product.pid); 
---------------------------------------------------------------------------------
집합연산 277 데이터를 확장하는 SQL 의 한 방법 
합집합 : UNION - 중복제거(집합개념) / UNION - 중복을 제거하지 않음(속도 향상)
교집합 : INTERSECT (집합개념_)두 집합의 공통된 부분
차집합 : MINUS (집합개념 ) 한 집합에만 속하는 데이터 
집합연사 공통사항
두 집합의 컬럼의 개수, 타입이 일치해야한다; 

UNION 동일한 부분을 합집합하기 때문에 중복하는 데이터는 한번만 적용된다.; 
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

INTERSECT (교집합) :위 아래 집합에서 값이 같은 행만 조회 ;
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

INTERSECT

MINUS 
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

MINUS

UNION ALL 연산자는 UNION연산자와 다르게 중복을 허용한다. ;
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

집합의 기술 순서가 영향이 가는 집합연산자
A UNION B =    B UNION A ==>  같음
A UNION ALL B  B UNION ALL A ==> 같음(집합개념에서)
A INTERSECT B  B INTERSECT A ==> 같음 
A MINUS B      B MINUS A ======> 다름; 


집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다; 
SELECT 'X' fir, 'B'sec
FROM dual

UNION

SELECT 'Y', 'A'
FROM dual; 


정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술 ;

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10, 20)
    

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (30, 40)
ORDER BY deptno; 

285   286orderby를 중간에 넣어주면 안된다는 점 ;

--------------------------------------------------------------------------
햄버거 도시 발전지수;

SELECT *
FROM fastfood;

버거지수 ==> (kfc개수 + 버거킹 개수 + 맥도날드 개수) / 롯데리아 개수 
시도, 시군구, 버거지수
버거지수 값이 높은 도시가 먼저 나오도록 정렬; 

SELECT count(*) kfc개수
FROM fastfood
WHERE gb = 'KFC';

SELECT count(*) 버거킹개수
FROM fastfood
WHERE gb = '버거킹';

SELECT count(*) 맥도날드개수
FROM fastfood
WHERE gb = '맥도날드';

SELECT count(*)롯데리아개수
FROM fastfood
WHERE gb = '롯데리아' ;

----------------------------
쿼리를 작성하지 못한 사람은 아래 다섯개의 시군구 별 버거지수를 수기로 구해주세요; 
대전시 대덕구 버거지수 : 
대전시 중구 버거지수 :
대전시 서구 버거지수 :
대전시 유성구 버거지수 : 
대전시 동구 버거지수 :

SELECT 
FROM fastfood
ORDER BY ADDR;