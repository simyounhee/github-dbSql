--�ǽ� grp7
SELECT COUNT(*)
FROM
        (SELECT deptno ,       
        count(*)
FROM emp
GROUP BY deptno)
;
---------------------------------------------------------------------------------------------------------------
--      sql ���� �� ���� �߿��� ������ ����  JOIN
--    RDBMS �� ������ ��     �ߺ��� �ּ�ȭ �ϴ�
--���� ���̺� �ߺ��� ������ �ִٸ�, �ʿ��Ѱ� ������ �ٸ� �����Ϳ��� �����ͼ� ������ �Ͽ� ���� �� 
--join�Ͽ� �������� �� 


SELECT *
FROM dept;
    
-- JOIN �� ���̺��� �����ϴ� �۾�
-- JOIN ����
--    1. ANST ����
--    2. ORACLE ���� 

--Natural Join
-- �� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
-- emp, dept ���̺��� deptno ��� �÷��� ����
SELECT *
FROM emp NATURAL JOIN dept;

--Natural join�� ���� ���� �÷�(deptno)�� ������(ex. ���̺��, ���̺� ��Ī)�� ������� �ʰ�
-- �÷��� ����Ѵ� (dept.deptno ->deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno  -- dept.deptno   �տ� �����ڸ� ���־����� ������ ���� ����
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��밡�� 
SELECT e.empno, e.ename, d.dname, deptno  -- �̷��� ��Ī�� ����ؼ� ��� ���� ����
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--  FROM ���� ������ ���̺� ����� ,�� �����Ͽ� �����Ѵ�
-- ������ ���̺��� ���� ������  WHERE���� ����Ѵ� 
-- emp, dept ���̺� �����ϴ� deptno �÷��� [���� ��] ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;           --�Ǽ��� ���� 


SELECT emp.ename, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno;




EXPLAIN PLAN FOR
SELECT emp.ename, dept.dname
FROM emp,dept
WHERE emp.deptno != dept.deptno;





����Ŭ ������ ���̺� ��Ī;
SELECT e.depno, e.ename, d.dname, deptno      --����Ŭ������ � ���̺��� ����ð��� ����� �� 
FROM emp e, dept d
WHERE e.deptno = d.deptno;


ANSI : join with USING
�����Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ�������, �ϳ��� �÷����θ� ������ �ϰ��� �� �� �����Ϸ��� ���� �÷��� ��� ;
emp, dept ���̺��� ���� �÷� : deptno   <-���� �����Ϸ��� �÷��� ��ü������ ����ϴ� �� ;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING(deptno);


JOIN WITH USING�� ORACLE�� ǥ���Ϸ���?;
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;


ANSI : JOIN WITH ON
���� �Ϸ����ϴ� ���̺��� �÷� �̸��� ���� �ٸ��� ����Ѵ�;
SELECT emp.ename, dept.dname, emp.deptno                -- ��� �� ����� �� 
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


JOIN WITH ON --> ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;


SELF JOIN : ���� ���̺��� ����;     --���� ���̺�� �����ϴ� ������ ���̽� ����� ������ �˰� ������ 
�� : emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ�� ��; 
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);       -- null�̸� ���� �Էµ��� �ʴ´�


����Ŭ �������� �ۼ�;
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;



--p202 null������ ���� �ȵȴ� �׷��� 14 -> 13 �Ǹ� ������ ���̴� .
-- ���ݱ��� �츮�� �̰��� ��� ��
equal  ���� : =
non-equal ���� : !=, >, <, BETWEEN AND;             


����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش����� �޿� ����� ���غ��� ;
SELECT ename, sal
FROM emp;
����Ŭ �������� �غ���;
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal 
              AND salgrade.hisal;
              
ANSI ������ �̿��Ͽ� ���� ���� ���� �ۼ��غ���; ????????????????????????????????????????????????             
SELECT *
FROM salgrade;

--ANSI : JOIN WITH ON
--���� �Ϸ����ϴ� ���̺��� �÷� �̸��� ���� �ٸ��� ����Ѵ�;
--SELECT emp.ename, dept.dname, emp.deptno                -- ��� �� ����� �� 
--FROM emp JOIN dept ON (emp.deptno = dept.deptno);

SELECT emp.ename, e.sal, salgrade.grade
FROM emp e JOIN salgrade s ON (e.sal );    --on ���� ���� ���� ��� �� �� �ִ�



--�ǽ� join0
SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.empno,e.ename, d.deptno, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;  



�ǽ� join0_1
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

�ǽ� join0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.sal > 2500;

�ǽ� join0_3
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
and e.sal > 2500
AND e.empno > 7600;

�ǽ� join0_4
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500
AND e.empno > 7600
AND d.dname = 'RESEARCH';

--�ǽ� join1               �ٽ�Ǯ��� 
PROD : PROD_LGU
LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

SELECT l.lprod_gu, l.lprod_nm, p.prod_id, p.prod_name
FROM prod p, lprod l
WHERE p.prod_lgu = l.LPROD_GU;


--�ǽ� join2
SELECT *
FROM buyer;     --buyer_lgu

SELECT *
FROM prod;   --prod_lgu

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name 
FROM buyer b, prod p
WHERE b.buyer_id = p.prod_buyer;

--�ǽ� join3   ���� 

