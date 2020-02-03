SELECT 
FROM member JOIN cart ON (member.mem_id = cart.cart_member)
            JOIN prod ON cart.cart_;
            
            
-------------------------------------
SELECT *
FROM CUSTOMER;

SELECT *
FROM PRODUCT;

SELECT *
FROM CYCLE;

--판매점 : 200~250
--고객당 2.5개 제품을 먹음
--하루 : 500~750
--한달 : 15000~17500     

SELECT *
FROM daily ;

SELECT *
FROM batch;

--실습 join 4  join을 하면서 row를 제한하는 조건을 결합 하는것 (조건 브라운과 셀리만 조회 and로 연결해서 하기  ) 
SELECT *
FROM customer;

SELECT *
FROM cycle ;

SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer JOIN cycle on (customer.cid = cycle.cid)
AND customer.cnm IN ('brown', 'sally');

--실습 join 5  \join을 하면서 
SELECT *
FROM PRODUCT;

SELECT customer.cid, customer.cnm, cycle.pid, PRODUCT.pnm, day, cycle.cnt
FROM cycle JOIN customer ON(cycle.cid = customer.CID)
           JOIN PRODUCT ON(cycle.PID = product.pid)
AND customer.cnm IN ('brown', 'sally');

SELECT customer.cid, customer.cnm, cycle.pid, pnm, day, cycle.cnt
FROM
WHERE
AND      ; 

--실습 JOIN6  join을 하면서(3개 테이블) row를 제한하는 조건을 결합, 그룹함수 적용  ** 다시 풀어보기 
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, sum(cycle.cnt)
FROM customer, product, cycle
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;



--실습 join7 숙제 


해당 오라클 서버에 등록된 사용자(계정) 조회;  --sim, hr 유효기간 
SELECT *
FROM   dba_users;

HR 계정의 비밀번호 java로 초기화하는 법 ;
ALTER USER HR IDENTiFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

--join 8~13 숙제 

--join 종류 에서 OUTER 컬럼 연결이 실패해도 기준이 되는 테이블의 데이터가 나오도록 하는 것
--left : 왼쪽 테이블 기준이 실패하더라도 정보를 나오게 해라 
--right : 오른쪽의 테이블 연결이 실패하더라도 정보를 나오게 해라 
-- full : 왼쪽 오른쪽의 중복을 제거 하는 것 

outer join;
두 테이블을 조인할때 연결 조건을 만족 시키지 못하는 데이터를 기준으로 지정한 데이터만이라도 조회하는 조인 방식;

연결조건 : e.mgr = m.empno : KING의 MEG NULL이기 때문에 조인에 실패한다
EMP 테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 13건이 된다 (1건이 조인 실패);
SELECT e.empno, e.ename, mgr, e.mgr,  m.ename 
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANST OUTER 사용법 
1. 조인이 실패하더라도 조회가 될 테이블을 선정해줘야 한다 (매니저 정보가 없어도 사원정보는 나오게 하고 싶음);

SELECT e.empno, e.ename, mgr, e.mgr,  m.ename 
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno ;    --(왼쪽이 기준 

RIGHT OUTER 로 변경하는 법 ;   --테이블의 순서가 중요하다  
SELECT e.empno, e.ename,  e.mgr,  m.ename 
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno ;

ORACLE OUTER JOIN 방법 
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;
여기서 아우터를 쓰려면 데이터가 없는 쪽의 테이블 컬럼 뒤에 (+)기회를 붙여준다;
SELECT  e.empno, e.ename, e.mgr,  m.ename 
FROM emp e, emp m
WHERE e.mgr = m.empno(+);




SELECT  e.empno, e.ename, e.mgr,  m.ename , m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

아래 LEFT OUTER 조인을 실질적으로 OUTER 조인이 아니다
아래 INNER 조인과 결과가 동일하다;
위의 SQL을 안시 SQL(OUTER JOIN)으로 변경해보세요;
매니저의 부서번호가 10번인 직원만 조회;
SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND m.deptno = 10);

SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;


오라클 문법으로 OUTER JOIN 
오라클 OUTER JOIN시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야 정상적인 OUTER JOIN으로 동작한다
한 컬럼이라도 (+)를 누락하면 INNER조인으로 동작;

아래 ORACLE OUTER 조인은 INNER 조인으로 동작 : m.deptno 컬럼에 (+)가 붙지 않음
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;


pt 정리 226 
두 결과가 다르더라 밑에건 정상적인 아우터가 아니라는 것 그래서 결과가 227 각각 이렇게 나온다 
228 (+) 빼먹는거 주의 해야한다
229 그래서 만약에 누락을 하게 되면 정상적으로 나오지 않더라 
230 라이터아웃은 오른쪽페이지를 기준으로해서 나온다 
231 right outer 함수
;
사원 - 매니저간  RIGHT OUTER JOIN    (이해를 돕기 위해 엑셀로 정리 )
SELECT empno, ename, mgr
FROM emp e; 

SELECT empno, ename
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

231 참고하기 엑셀로 다시 정리해보기 ;

232 레프드 라이트 중복 제거한것이 풀  , 233
FULL OUTER : LEFT OUTER + RIGHT OUTER -중복 제거; --그런데 FULL은 사용 잘 안함 )
LEFT OUTER : 14건, RIGHT OUTER : 21건, FULL OUTER : 22건 
SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

234 집합 결합내용 교집합  유니온은 합집합 SQL 자체가 집합으로 중복을 제거하는 것 
풀아우터 :레프트 라이트 더해서 중복 제거하는 것 그러니 결론적으론 동일한 집합끼리 빼면 결과가 공집합이다 
intersect 는 유니온과 교집합 

오라클 OUTER JOIN 에서는 (+)기호를 이용하여 FULL OUTER 문법을 지원하지 않는다;


--outer join 실습 1
SELECT count(*)    --건수 148
FROM buyprod;

SELECT count(*)   --건수 74 
FROM prod;
--안시 문법 
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod 
WHERE prod.prod_id = buyprod.buy_prod
AND buyprod.buy_date(+) = To_DATE('20050125', 'yyyymmdd');
--오라클로 하면 
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod LEFT OUTER JOIN buyprod ON ( prod.prod_id = buyprod.buy_prod)
AND buyprod.buy_date = To_DATE('20050125', 'yyyymmdd');


--OUTRT JOIN 실습2  buy_date가 NULL항목이 안나오도록 
SELECT nvl(buyprod.buy_date,  To_date('2005)
FROM prod LEFT OUTER JOIN buyprod ON ( prod.prod_id = buyprod.buy_prod)
AND buyprod.buy_date(+) != To_date('null);