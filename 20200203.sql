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

--�Ǹ��� : 200~250
--���� 2.5�� ��ǰ�� ����
--�Ϸ� : 500~750
--�Ѵ� : 15000~17500     

SELECT *
FROM daily ;

SELECT *
FROM batch;

--�ǽ� join 4  join�� �ϸ鼭 row�� �����ϴ� ������ ���� �ϴ°� (���� ����� ������ ��ȸ and�� �����ؼ� �ϱ�  ) 
SELECT *
FROM customer;

SELECT *
FROM cycle ;

SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer JOIN cycle on (customer.cid = cycle.cid)
AND customer.cnm IN ('brown', 'sally');

--�ǽ� join 5  \join�� �ϸ鼭 
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

--�ǽ� JOIN6  join�� �ϸ鼭(3�� ���̺�) row�� �����ϴ� ������ ����, �׷��Լ� ����  ** �ٽ� Ǯ��� 
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, sum(cycle.cnt)
FROM customer, product, cycle
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid 
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm;



--�ǽ� join7 ���� 


�ش� ����Ŭ ������ ��ϵ� �����(����) ��ȸ;  --sim, hr ��ȿ�Ⱓ 
SELECT *
FROM   dba_users;

HR ������ ��й�ȣ java�� �ʱ�ȭ�ϴ� �� ;
ALTER USER HR IDENTiFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;

--join 8~13 ���� 

--join ���� ���� OUTER �÷� ������ �����ص� ������ �Ǵ� ���̺��� �����Ͱ� �������� �ϴ� ��
--left : ���� ���̺� ������ �����ϴ��� ������ ������ �ض� 
--right : �������� ���̺� ������ �����ϴ��� ������ ������ �ض� 
-- full : ���� �������� �ߺ��� ���� �ϴ� �� 

outer join;
�� ���̺��� �����Ҷ� ���� ������ ���� ��Ű�� ���ϴ� �����͸� �������� ������ �����͸��̶� ��ȸ�ϴ� ���� ���;

�������� : e.mgr = m.empno : KING�� MEG NULL�̱� ������ ���ο� �����Ѵ�
EMP ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ� (1���� ���� ����);
SELECT e.empno, e.ename, mgr, e.mgr,  m.ename 
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANST OUTER ���� 
1. ������ �����ϴ��� ��ȸ�� �� ���̺��� ��������� �Ѵ� (�Ŵ��� ������ ��� ��������� ������ �ϰ� ����);

SELECT e.empno, e.ename, mgr, e.mgr,  m.ename 
FROM emp e LEFT OUTER JOIN emp m ON e.mgr = m.empno ;    --(������ ���� 

RIGHT OUTER �� �����ϴ� �� ;   --���̺��� ������ �߿��ϴ�  
SELECT e.empno, e.ename,  e.mgr,  m.ename 
FROM emp m RIGHT OUTER JOIN emp e ON e.mgr = m.empno ;

ORACLE OUTER JOIN ��� 
SELECT *
FROM emp e, emp m
WHERE e.mgr = m.empno;
���⼭ �ƿ��͸� ������ �����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+)��ȸ�� �ٿ��ش�;
SELECT  e.empno, e.ename, e.mgr,  m.ename 
FROM emp e, emp m
WHERE e.mgr = m.empno(+);




SELECT  e.empno, e.ename, e.mgr,  m.ename , m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

�Ʒ� LEFT OUTER ������ ���������� OUTER ������ �ƴϴ�
�Ʒ� INNER ���ΰ� ����� �����ϴ�;
���� SQL�� �Ƚ� SQL(OUTER JOIN)���� �����غ�����;
�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ;
SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno AND m.deptno = 10);

SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;

SELECT e.empno, e.name, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON(e.mgr = m.empno)
WHERE m.deptno = 10;


����Ŭ �������� OUTER JOIN 
����Ŭ OUTER JOIN�� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ��� �������� OUTER JOIN���� �����Ѵ�
�� �÷��̶� (+)�� �����ϸ� INNER�������� ����;

�Ʒ� ORACLE OUTER ������ INNER �������� ���� : m.deptno �÷��� (+)�� ���� ����
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;


pt ���� 226 
�� ����� �ٸ����� �ؿ��� �������� �ƿ��Ͱ� �ƴ϶�� �� �׷��� ����� 227 ���� �̷��� ���´� 
228 (+) ���Դ°� ���� �ؾ��Ѵ�
229 �׷��� ���࿡ ������ �ϰ� �Ǹ� ���������� ������ �ʴ��� 
230 �����;ƿ��� �������������� ���������ؼ� ���´� 
231 right outer �Լ�
;
��� - �Ŵ�����  RIGHT OUTER JOIN    (���ظ� ���� ���� ������ ���� )
SELECT empno, ename, mgr
FROM emp e; 

SELECT empno, ename
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON(e.mgr = m.empno);

231 �����ϱ� ������ �ٽ� �����غ��� ;

232 ������ ����Ʈ �ߺ� �����Ѱ��� Ǯ  , 233
FULL OUTER : LEFT OUTER + RIGHT OUTER -�ߺ� ����; --�׷��� FULL�� ��� �� ���� )
LEFT OUTER : 14��, RIGHT OUTER : 21��, FULL OUTER : 22�� 
SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

234 ���� ���ճ��� ������  ���Ͽ��� ������ SQL ��ü�� �������� �ߺ��� �����ϴ� �� 
Ǯ�ƿ��� :����Ʈ ����Ʈ ���ؼ� �ߺ� �����ϴ� �� �׷��� ��������� ������ ���ճ��� ���� ����� �������̴� 
intersect �� ���Ͽ°� ������ 

����Ŭ OUTER JOIN ������ (+)��ȣ�� �̿��Ͽ� FULL OUTER ������ �������� �ʴ´�;


--outer join �ǽ� 1
SELECT count(*)    --�Ǽ� 148
FROM buyprod;

SELECT count(*)   --�Ǽ� 74 
FROM prod;
--�Ƚ� ���� 
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod, buyprod 
WHERE prod.prod_id = buyprod.buy_prod
AND buyprod.buy_date(+) = To_DATE('20050125', 'yyyymmdd');
--����Ŭ�� �ϸ� 
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_date
FROM prod LEFT OUTER JOIN buyprod ON ( prod.prod_id = buyprod.buy_prod)
AND buyprod.buy_date = To_DATE('20050125', 'yyyymmdd');


--OUTRT JOIN �ǽ�2  buy_date�� NULL�׸��� �ȳ������� 
SELECT nvl(buyprod.buy_date,  To_date('2005)
FROM prod LEFT OUTER JOIN buyprod ON ( prod.prod_id = buyprod.buy_prod)
AND buyprod.buy_date(+) != To_date('null);