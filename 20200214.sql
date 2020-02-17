MERGE : SELECT �ϰ��� �����Ͱ� ��ȸ�Ǹ� UPDATE �� ��
        SELECT �ϰ��� �����Ͱ� ��ȸ���� ������ INSERT
        
        SELECT + UPDATE / SELECT + INSERT ==>MERGE ;

REPORT GROUP FUNCTION
1. ROLLUP
    -GROUP BY ROLLUP (�÷�1, �÷�2)
    -ROLLUP���� ����� �÷��� �����ʿ��� �ϳ��� ������ �÷����� SUBGROUP 
    -GROUP BY �÷� 1, �÷�2
    UNION
    GROUP BY �÷� 1
    UNION
    GROUP BY
2. CUBE
3. GROUPING SET;
-----------------------------���� ��� �� ���� ����

--�ǽ� GROUP_AD3
ROLLUP����ؼ� �����(�÷��� ������ �߿��ϴ� )
group by deptno, job
group by deptno
group by;

SELECT deptno, job, SUM(sal) sal
FROM emp
GROUP BY ROLLUP(deptno, job) ;

--�ǽ� group_ad4    
SELECT dept.dname, emp.job, SUM(emp.sal + NVL(comm, 0)) AS sal
FROM emp, dept
WHERE emp.deptno = dept.deptno
GROUP BY ROLLUP(dept.dname,job);
--�̹��� AD4�� �ζ��κ並 �̿��ؼ� ������ 
SELECT dname, job, sal
FROM 
    (SELECT deptno, job, SUM(sal) AS sal
     FROM emp
     GROUP BY ROLLUP(deptno,job)) a, dept b
WHERE a.deptno = b.deptno(+);       --outer ������ ����� �� (�����Ͱ� �����ʿ� �ٿ� �ִ� ���� ����Ŭ ����)

SELECT *
FROM emp;
SELECT *
FROM dept;

--�ǽ� group_ad5**********************************************
--1 CASE ��
SELECT CASE 
        WHEN GROUPING(dname) = 1 AND GROUPING(job) =1 THEN '����'
        ELSE dname
        END dname,
        job, SUM(sal + NVL(comm, 0))sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--2 DECODE ��
SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '����',
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
Ȱ�뵵
3,1 >>>>>>>>>>>>>>>>>>>>>>>CUBE;

GROUPING SETS
  ������ ������� ���� �׷��� ����ڰ� ���� ����
  ����� : GROUP BY GROUPING SETS(col1,col2...)
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
 
GROUPING SETS �� ��� �÷� ��� ������ ����� ������ ��ġ�� �ʴ´�
ROLLUP �� �÷� ��� ������ ��� ������ ��ģ��; 
 
  GROUP BY GROUPING SETS (col1, col2)
  ==>
  GROUP BT col1
  UNION ALL        --UNION�� �Ⱦ��� UNION ALL�� ���� ������ ? ���� 
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


job, deptno �� GROUP BY �� �����
mgr �� GROUP BY �� ����� ��ȸ�ϴ� SQL�� GROUPING SETS�� �޿��� SUM(sal)�ۼ��ϱ�;
SELECT job, deptno, mgr, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno), mgr);


32p �ΰ��� ���걸���� �ϳ��� �ִ� �ѷ� ���� �� 
�״��� ��� ���� 

CUBE �׷���̸� Ȯ���Ѱ�
������ ��� �������� �÷��� ������ SUB GROUP �� �����Ѵ�
�� ����� �÷��� ������ ��Ų��;

EX : GROUP BY CUBE (col1, col2);

(col1, col2)          
�÷� ���� ���Եǳ� �ȵǳ�
�÷� ���� ���Եǳ� �ȵǳ�     ==>
(null, col2) == GROUP BY col2
(null, null) == GROUP BY ��ü
(col1, null) == GROUP BY col1
(col1, col2) == GROUP BY col1, col2

���� �÷� 3���� CUBE ���� ����� ��� ���� �� �ִ� �������� ?? 

SELECT job, deptno, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY CUBE (job, deptno);

                       --������ó�� ������ �������� �������ֽ� (4������ ���� ���� ���� �����ϱ� )
GROUP BY cube (job, deptno);    34p 
UNION ALL
GROUP BY (job, deptno);
UNION ALL 
GROUP BY (job, null);
UNION ALL 
GROUP BY (deptno, null);
UNION ALL 
GROUP BY (null, null);



��� ť��� �� ���� �ʴ´� 
�O���Ѱ� �� �����.
*****************************************************************
ȥ��;    //�̰� �������� ������ �����ֽ� ��ó�� ��ĥ�غ��� ���� !!!!! ****
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
38p �� ����� ���� 6���� �ߺ�X  => 39 p

40p ��庥���������� 
�ٸ� ���̺��� ���� ������ �������� ���� ������Ʈ �ϴ� �� 

��������  UPDATE
1.���� emp_test ���̺� drop 
2.emp ���̺��� �̿��ؼ� emp_test ���̺���� (����࿡ ���� ctas)
3.emp_test ���̺� dname VARCHAR2(14) �÷��߰�
4.emp_test.dname �÷��� dept ���̺��� �̿��ؼ� �μ����� ������Ʈ;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;


ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT *
FROM emp_test;     --�ึ�� �����;��ϴ� �μ� �̸��� �޶��� �� �ִ� �׷��� �츮�� �̰��� ���������� �ۼ�

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno)    --��ȣ ���� �������� emp_test.deptno �̺κ��� ��� �ٲ� ��
 COMMIT;      
 

�ǽ� SUB_a1 43p
--���� �� ����� 
DROP TABLE dept_test ;
--dept_test ���̺� ���� 
CREATE TABLE dept_test AS
SELECT *
FROM dept ; 
--Ȯ���ϱ�
SELECT *
FROM dept_test;
--dept_test ���̺� empcnt (number)�÷� �߰� 
ALTER TABLE dept_test ADD ( empcnt NUMBER );
--SUBQUERY�� �̿��Ͽ� dept_test ���̺��� empcnt �÷��� �ش� �μ��� ���� update �ϴ� ������ �ۼ��ϼ��� 

deptno, dname, loc
10	ACCOUNTING	NEW YORK	10���μ��� �ش��ϴ�....
20	RESEARCH	DALLAS	
30	SALES	CHICAGO	
40	OPERATIONS	BOSTON	
���� ;
UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*) cnt
                                FROM emp
                                WHERE deptno = dept_test.deptno
                                GROUP BY deptno),0);
                               
SELECT *
FROM dept_test;

SELECT *
FROM dept_test ;     4�� 
WHERE dname = 'SALES';          --WHERE ���� ���� �����Ѵ� 


DESC DEPT; 
SELECT *
FROM emp_test; 

44P
�ǽ� SUP_a2;
dept_test���̺� �ִ� �μ��߿� ������ ������ ���� �μ� ������ ����
*dept_test.empcnt �÷��� ������� �ʰ�
emp���̺��� �̿��Ͽ� ����; 
INSERT INTO dept_test values( 99, 'it1', 'deajeon' , 0);
INSERT INTO dept_test values( 98, 'it2', 'deajeon' , 0);
commit;

������ ������ ���� �μ� ���� ��ȸ?
������ �ִ� ���� ..?
10�� �μ��� ���� �ִ� ����..? 

SELECT COUNT(*)
FROM emp 
WHERE deptno = 20;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)                --�� ���������� ���� ���� �� 
           FROM emp
           WHERE deptno = dept_test.deptno)
           
DELETE dept_test          
WHERE 0 = (SELECT COUNT(*)                
           FROM emp
           WHERE deptno = dept_test.deptno) ;  
           
           
--�ǽ� sub_a3
emp ���̺��� ������ ���� �μ��� (sal)��� �޿����� �޿��� ���� ������ �޿��� �� �޿����� 200 �߰��ؼ� ������Ʈ �ϴ� ���� �ۼ��Ͻÿ� 
�׷� �ϴ� ������ ���� �μ��� (sal)��� �޿����� �޿��� ���� ������ �޿��� ���غ��� 

SELECT *
FROM emp_test;
7369	SMITH	20	CLERK	    7902	1980/12/17	800		   
7499	ALLEN	30	SALESMAN	7698	1981/02/20	1600	300
7521	WARD	30	SALESMAN	7698	1981/02/22	1250	500	

UPDATE emp_test a SET sal = sal + 200
WHERE sal < (SELECT AVG(SAL)
             FROM emp_test b
             WHERE a.deptno = b.deptno);

--part 1 ���� �������� �������� �ٽ�Ǯ��� �̤�


WITH ��
�ϳ��� �������� �ݺ��Ǵ� SUBQUERY��  ������ 
�ش�  SUBQUERY�� ������ �����Ͽ� ����.

MAIN ������ ����� �� WITH ������ ���� ���� �޸𸮿� �ӽ������� ����
==> MAIN ������ ���� �Ǹ� �޸� ����

SUBQUERY �ۼ��ÿ��� �ش� SUBQUERY�� ����� ��ȸ�ϱ� ���ؼ� I/O �ݺ������� �Ͼ����

WITH ���� ���� �����ϸ鼭 �ѹ��� SUBQUERY �� ����ǰ� �� ����� �޸𸮿� ������ ���� ����

��, �ϳ��� �������� ������ SUBQUERY �� �ݺ������� �����°� �߸� �ۼ��� SQL�� Ȯ���� ����;

����ϴ� ����� 
WITH  �������̸� AS (
    ��������
)

SELECT *
FROM �������̸�; 

������� �̰� �ѹ� �غ��� 
������ �μ��� �޿� ����� ���ϴ� �������� WITH���� ���� �����غ���;

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


WITH ���� �̿��� �׽�Ʈ ���̺� �ۼ� 
WITH temp AS (
        SELECT sysdate -1 FROM dual UNION  ALL
        SELECT sysdate -2 FROM dual UNION  ALL
        SELECT sysdate -3 FROM dual )
SELECT *
FROM temp;


�� ������ ���������� �����ǵ� 
���ʰ� �Ǵ� �޷¸���� PT
Ư�� ����� �Ķ���ͷ� �޾Ƽ� ..3P ó�� �ƹ��͵� ���� ���׿��� ���̺��� ���� �ϴ� �� 
4P ���⼭ �ٽ��� ���� ���� �ٲٴ� ���̴�.  �̰��� ����Ʈ �������� ���� ���δ�. �Ӽ��� �ߺ��Ǵ� ���� �����Ѵ�. 
5P 
6P �̰� �Ϸ��� .....

�޷¸���� ; 
CONNECT BY LEVEL <[=] ����
�ش� ���̺��� ���� ������ŭ �����ϰ�, ������ ���� �����ϱ� ���ؼ� LEVEL�� ����
LEVEL �� 1���� ����; 

SELECT dummy, LEVEL
FROM dual 
CONNECT BY LEVEL <= 10 ;

SELECT dept.* , LEVEL
FROM dept 
CONNECT BY LEVEL <= 5 ;

2020�� 2���� �޷��� ����
�ϴ� �ʿ��Ѱ� 
1. �ش���� �ϼ��� �ʿ� 
    :dt = 202002, 202003 ;
SELECT TO_DATE ('202002', 'YYYYMM') + (LEVEL -1)
FROM  dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD');

SELECT TO_CHAR(LAST_DAY(TO_DATE ('202002', 'YYYYMM')), 'DD')
FROM dual; 

�޷��� Ư¡�� 
��  ��  ȭ  ��  ��  ��  ��
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