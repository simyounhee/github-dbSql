SUB 4
dept ���̺��� 5���� �����Ͱ� ����
emp ���̺��� 14���� ������ �ְ�, ������ �ϳ��� �μ��� ���� �ִ� (deptno)
�μ��� ������ ���� ���� ���� �μ� ������ ��ȸ ; 

������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�; 
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
SELECT deptno      --�̰� ���������� �� �� 
FROM emp;
GROUP BY deptno;

--distinct �����ϰ� �����Ǵ� �� �� �״�� ���� �ߺ��� �����ϴ� �����̴�.  �׷���̿� ������ ������ �Ѵ� �׷��� 
SELECT * 
FROM dept
WHERE deptno NOT IN (SELECT DISTINCT deptno     
                     FROM emp);

--------------------------------------------------
�ǽ� SUB 5;
����ȣ�� 1���� ���� �ֿ����� �ʴ� �� ��ȸ ;
��� ��ǰ�� ���� 4����
SELECT *
FROM product;

cid= 1�� ���� �����ϴ� ��ǰ;
SELECT pid
FROM cycle
WHERE cid = 1; 

SELECT *
FROM product 
WHERE pid NOT IN (100, 400);

��;
SELECT *
FROM product 
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1);
---------------------------------------------------------
�ǽ� SUB 6;
cid=2�� ���� �����ϴ� ��ǰ�� cid=1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ���� �ۼ�;

cid=1�� ���� �������� ==>100, 400���� ��ǰ�� �������̴�.;
SELECT *
FROM cycle
WHERE cid= 1;

cid =2 �� ���� �����ϴ� ��ǰ ==>100, 200��ǰ�� ������;
SELECT pid 
FROM cycle
WHERE cid =2; 

cid =1, cid=2�� ���� ���ÿ� �����ϴ� ��ǰ�� 100��;
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

���Ĺ��;
SELECT cycle.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN (SELECT pid
            FROM cycle
            WHERE cid= 2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

��Į�󼭺����� ���(�������� �ʴ� ���); 
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
�Ŵ����� �����ϴ� ������ ��ȸ(KING�� ������ 13���� �����Ͱ� ��ȸ);  sub8�� ����
SELECT *
FROM emp;  ���� ��ȸ �츮�� ���ϴ� �Ŵ����� �ִ� ����� ���ϴ� ���̱⶧���� ���⿡ 
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

EXSITS ���ǿ� �����ϴ� ���� �����ϴ��� Ȯ���ϴ� ������
�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴµ� 
   . WHERE empno =7365
   . WHERE EXISTS (SELECT 'x'
                   FROM......);
                
�Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ;
�Ŵ����� ����;
SELECT empno, ename, mgr       
FROM emp e
WHERE EXISTS (SELECT 'X'
             FROM emp m
             WHERE e.mgr = m.empno); 

SELECT empno, ename, mgr         --������ �׷����� 
FROM emp e
WHERE EXIST (SELECT 'X'
             FROM emp m
             WHERE 7982 = m.empno);
---------------------------------------------------------------------
SUB 9 EXIST������ �̿��ؼ� Ǯ��
1�� ���� �����ϴ� ��ǰ ==> 100, 400;
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
              
              
�ǽ� SUB10;              
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle 
                  where cid = 1
                  AND cycle.pid =product.pid); 
---------------------------------------------------------------------------------
���տ��� 277 �����͸� Ȯ���ϴ� SQL �� �� ��� 
������ : UNION - �ߺ�����(���հ���) / UNION - �ߺ��� �������� ����(�ӵ� ���)
������ : INTERSECT (���հ���_)�� ������ ����� �κ�
������ : MINUS (���հ��� ) �� ���տ��� ���ϴ� ������ 
���տ��� �������
�� ������ �÷��� ����, Ÿ���� ��ġ�ؾ��Ѵ�; 

UNION ������ �κ��� �������ϱ� ������ �ߺ��ϴ� �����ʹ� �ѹ��� ����ȴ�.; 
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

INTERSECT (������) :�� �Ʒ� ���տ��� ���� ���� �ุ ��ȸ ;
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698, 7369)

INTERSECT

MINUS 
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

MINUS

UNION ALL �����ڴ� UNION�����ڿ� �ٸ��� �ߺ��� ����Ѵ�. ;
SELECT empno, ename
FROM emp
WHERE empno IN(7566, 7698)

������ ��� ������ ������ ���� ���տ�����
A UNION B =    B UNION A ==>  ����
A UNION ALL B  B UNION ALL A ==> ����(���հ��信��)
A INTERSECT B  B INTERSECT A ==> ���� 
A MINUS B      B MINUS A ======> �ٸ�; 


���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������; 
SELECT 'X' fir, 'B'sec
FROM dual

UNION

SELECT 'Y', 'A'
FROM dual; 


����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ��� ;

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10, 20)
    

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (30, 40)
ORDER BY deptno; 

285   286orderby�� �߰��� �־��ָ� �ȵȴٴ� �� ;

--------------------------------------------------------------------------
�ܹ��� ���� ��������;

SELECT *
FROM fastfood;

�������� ==> (kfc���� + ����ŷ ���� + �Ƶ����� ����) / �Ե����� ���� 
�õ�, �ñ���, ��������
�������� ���� ���� ���ð� ���� �������� ����; 

SELECT count(*) kfc����
FROM fastfood
WHERE gb = 'KFC';

SELECT count(*) ����ŷ����
FROM fastfood
WHERE gb = '����ŷ';

SELECT count(*) �Ƶ����尳��
FROM fastfood
WHERE gb = '�Ƶ�����';

SELECT count(*)�Ե����ư���
FROM fastfood
WHERE gb = '�Ե�����' ;

----------------------------
������ �ۼ����� ���� ����� �Ʒ� �ټ����� �ñ��� �� ���������� ����� �����ּ���; 
������ ����� �������� : 
������ �߱� �������� :
������ ���� �������� :
������ ������ �������� : 
������ ���� �������� :

SELECT 
FROM fastfood
ORDER BY ADDR;