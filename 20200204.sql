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
CROSS JOIN ==>ī��� ���δ�Ʈ(Cartesisan product)
�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
������ ��� ���տ� ���� ����(����)�� �õ�
dept(4��), emp(14��)�� CROSS JOIN�� ����� 4*14 = 56��

dept ���̺�� emp���̺� ������ �ϱ� ���� FROM���� �ΰ��� ���̺��� ��� 
WHERE���� �� ���̺��� ���� ������ ����;

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp 
WHERE dept.deptno = 10
AND dept.deptno = emp.deptno;

--�ǽ� crossjoin 1 
SELECT *
FROM customer;
SELECT *
FROM product;

SELECT * 
FROM custmoer, pruduct;

--��������� join 
--------------------------------------------------------------
subquery : ���� �ȿ� �ٸ� ������ ����ִ� ���
SUBQUERY�� ���� ��ġ�� ���� 3������ �з��� �ȴ�. 
    SELECT�� �ȿ� ���Ǵ� ���� : SUBQUERY <- Ư¡:���� �� �ϳ��� �����ϱ⿡  �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� �ʴ´� .
    FROM ���� ���� ���� : INLINE - VIEW(VIEW)    
    WHERE���� ���� ���� : SUBQUERY QUERY ���� ����� ��� 
    247
    PT250�� ���� ���� ��  ���� ���� �ȿ� �ٸ� ������ ���� 
    251 ���� ���� ���� ���� ���ʿ� ���� ������ �Ϲ������� �츮�� ���� ����Ʈ�� ��� 
    252 ���������� 20�� ��ü�� ���� �ϳ��� ������ ���ϴ� ���� �����ϴ� �� 
    253 �ǽ����� - ��ձ޿��� �������� ������ ���� �� �޿����� ���� �޿� �޴� ���� ������ ������ 
    
 -- �ǽ� SUB 1  �ٽ�Ǯ��� ��ձ޿����� ���� �޿��� �޴� ������ ���� ���ϴ� �� 
 1. ��ձ޿� ���ϱ�
 2. ���� ��� �޿����� ���� �޿��� �޴� ���; 
 1.;
 SELECT AVG(SAL)
 FROM emp;
 2.;
 SELECT *
 FROM emp
 WHERE sal > 2073;
 3.;  ��ġ�� 
 SELECT count(*)
 FROM emp
 WHERE sal >(SELECT AVG(sal)
            FROM emp);
            
 sub2;           
 SELECT *
 FROM emp
 WHERE sal > (SELECT AVG(sal)
              FROM emp);
              
              
            
���ϰ��� �ϴ� �� 
SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
1. SMITH�� ��� �μ����� �μ� ��ȣ�� ���Ѵ�. 
2. 1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�.

1.;
SELECT deptno
FROM emp
WHERE ename = 'SMITH' ; 

2. 1���� ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno = 20; 

SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ �����ϴ�;

SELECT *
FROM emp
WHERE deptno =(SELECT deptno 
               FROM emp
               WHERE ename = 'SMITH'); 
               


������ ������
IN ���������� �������� ��ġ�ϴ� ���� ���� �� �� 
ANY (Ȱ�뵵�� �ټ� ������) : ���������� �������� �� ���̶� ������ ������ �� 
ALL (Ȱ�뵵�� �ټ� ������) : ���������� �������� ��� �࿡ ���� ������ ������ ��;

SUB 3;
�Ʊ�� �츮�� ������ 
SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ �� �������µ� ������ �ϳ� �� �߰��ؼ� 
SMITH�� WARD������ ���ϴ� �μ��� ��� ������ ��ȸ 

SELECT deptno
FROM emp
WHERE ename IN('SMITH', 'WORD');

SELECT *
FROM emp
WHERE deptno IN('20', '30');

���������� ����� ���� ���� ���� '='�����ڸ� ������� �� �Ѵ� .
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename IN('SMITH', 'WORD'));
             
             
                
 SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ ( SMITH, WARD�� �޿��� �ƹ��ų�)
SMITH(SAL) : 800
WARD(SAL) : 1250
       ==> 1250���� ���� ���;
���� ���̽��� ���� ���
SELECT *
FROM emp
WHERE sal < ANY (800, 1250);   --ANY : ����̵� �� 

SELECT sal
FROM emp
WHERE ename IN ('SMITH', 'WARD');

SELECT *
FROM emp
WHERE sal < ANY ( SELECT sal
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));
                  
 
 SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ ( SMITH, WARD�� �޿� 2���� ��ο� ���� ���� �� )
SMITH(SAL) : 800
WARD(SAL) : 1250                  
   ==>1250���� �޿��� ���� ���    
SELECT *
FROM emp
WHERE sal > ALL ( SELECT sal
                  FROM emp
                  WHERE ename IN ('SMITH', 'WARD'));
                  
 
 
 *IN, NOT IN �� NULó�� ���� ���� ;
 ������ ������ ����� 7902 �̰ų�(OR) NULL�� ��� ; 
 IN �����ڴ� OR �����ڷ� ġȯ�� �����ϴ�.
 
 SELECT *
 FROM emp
 WHERE mgr IN (7902, NULL);   
 
 NULL �񱳴� '='�����ڰ� �ƴ϶� IS NULL�� �� �ؾ������� IN�����ڴ� '='�� ����Ѵ�;
 SELECT *
 FROM emp
 WHERE mgr = 7902
 OR mgr = null;  
 
 NOT IN (7902, NULL)   �ؼ� �����ȣ�� 7902�� �ƴϸ鼭 NULL�� �ƴ� ��� 
 �ؼ� - ��� ��ȣ�� 7902�� �ƴϸ鼭(AND) NULL�� �ƴ� ������ ;
 SELECT *
 FROM emp
 WHERE empno NOT IN (7902, NULL);
 
 SELECT *
 FROM emp
 WHERE empno != 7902
 AND empno != NULL;    -- �� ���Ƕ����� ���� �ȳ��´�. �׷��� ������ IS NOT�� ����� �Ѵ�. != -> IS NOT
 
 260 NOT IN�� ���� ��ü�� NULLó�� �����Ѵ� �� ���� ������ �ʴ´� 
 261 �ΰ��� ���õǾ� ������ ���� ������ 
 262 �� �񱳿� ���ؼ� ����µ� ��Ƽ PAIRWISE ���������� ����� �����ϴ� ������ �̾� ����
        �����ȣ�� 7499 �� 7782 �� ��ü ������ ��� ��������
 SELECT mgr, deptno
 FROM emp
 WHERE empno IN (7499, 7782);   -- �� �ΰ��� �÷��� ���ÿ� �����ϴ� ����� ã�ƺ��� 
 
 pairwise (������)
 �������� ����� ���ÿ� ���� ��ų�� ���;
 (mgr, deptno)
 (7698, 30 ) , (7839, 10)
 SELECT *
 FROM emp
 WHERE (mgr, deptno) IN (SELECT mgr, deptno
                         FROM emp
                         WHERE empno IN (7499, 7782));
 
 non-pairwise (������) �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ� 
 mgr ���� 7689�̰ų� 7839 �̸鼭 
 deptno�� 10�̰ų� 30���� ����         
 ����� ����  mgr, deptno
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
                
 
 ��Į�� �������� :  SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
 ��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϴ�;
 
 SELECT SYSDATE 
 FROM dual;
 
 SELECT (SELECT SYSDATE FROM dual), 
        dept.*      --������ ���� ������ ���̺� ��Ī�� ��������� ������ �ȳ���  * -> dept.*
 FROM dept;
 
 ��Į�� ���� �̷��Ե� ��밡���ϴٴ� ���� ������ ���̴� ;
SELECT empno, ename, deptno, 
      (SELECT dename 
       FROM dept 
       WHERE deptno = emp.deptno)dname    --��Į�� ���������� MAIN ������ �÷��� ����ϴ°� �����ϱ⿡ 
FROM emp;


INLINE VIEW : FROM���� ���� ��������;

MAIN������ �÷��� SUBQUERY���� ����ϴ� ������ ���� �з� 
����� ��� : correlated subquery(��ȣ ���� ����), ���������� �ܵ����� ���� �ϴ°� �Ұ����ϴ� �� ���������� �־�� �Ѵ� . 
(SELECT dename                     --��, �̰Ǹ� ���� �Ұ����ϴٴ� �ǰ� ? ?      
       FROM dept 
       WHERE deptno = emp.deptno)
       correlated subquery��� ��������� �������ִ� (main ==>sub)
������� ���� ��� : non-correlated subquery(���ȣ ���� ��������), ���������� �ܵ����� �����ϴ°� �����ϴ�. ;
                   ��������� ������ ���� �ʴ� (main ==> sub, sub ==>main)

��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ;
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ ; 
(main������ ���������� ����Ǿ� �־�� ��);
SELECT AVG(sal)
FROM emp
WHERE deptno = 10;     --�� ������ �޿������ ���ϱ� 

SELECT *
FROM emp m     --��������� ��������      

WHERE sal > (SELECT AVG(sal)
              FROM emp s
              WHERE s.deptno = m.deptno)     --������������ �����ͼ� ���   pt266   267 ��ȣ������������ ����. �������� ���� ������ ����Ŀ�� ����  267 ������, ���ȣ�������������� �������� ������ 
              ;

���� ������ ������ �̿��ؼ� Ǯ���
1. ���� ���̺� ����
  ù��°. emp, �μ��� �޿� ���(inline view����϶�� �ǹ�)
  
  SELECT emp.* --emp.*ename, sal, deptno, dept_sal.* �� ���� 
  FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
             FROM emp
             GROUP BY deptno) dept_sal
  WHERE emp.deptno = dept_sal.deptno-- ���� ������ �ؾ��� 
  AND emp.sal > dept_sal.avg_sal;
  
  
�ǽ� sub4
������ �߰�;
INSERT INTO dept VALUES (99, 'ddit', 'deajeon');
�����Ѱ� ���� Ȯ��;
SELECT *
FROM dept;

DELETE dept        --�ٽ� ���
WHERE deptno = 99;

SELECT *  --����Ѱ� Ȯ�� 
FROM dept;

ROLLBACK; --Ʈ����� ���
COMMIT;   --Ʈ����� Ȯ��    ���� �۾��� �ϴ��� �� Ʈ����� Ȯ���� ���� ������ �ٸ�â���� �ٽ� �۾��� �ϸ� ���� �����Ͱ� �ҷ��´�. 
  
 
 pt 269 ���������� �̿��ؼ� ������ �ѹ��� ���� �μ��� ���غ��� ������   ��Ʈ  not in ������ �̿��غ��� 
 
 SELECT *
 FROM dept 
 WHERE deptno NOT IN (SELECT deptno
                      FROM emp);    --emp 99,40���� �μ��� �ϳ��� ���� ������ ������ ���� �� �ʿ䰡 ����  
                      --WHERE deptno IN (10, 20, 30));