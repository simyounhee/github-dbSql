--�ǽ� cond1       --�ٽ� Ǯ��� 
SELECT empno, ename, deptno,
    CASE    
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESERCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END    
FROM emp;
--�� �ٸ� Ǯ��
SELECT empno, ename, deptno,
    DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES', 40, 'OPERATIONS')
FROM emp;


--�ǽ�cond2    //�� �ٽ� Ǯ���******************
--  ���س⵵ �� ¦���̸�
--      �Ի�⵵�� ¦���� �� �ǰ����� �����
--      �Ի�⵵�� Ȧ���� �� �ǰ����� ������
-- ���س⵵�� Ȧ���̸�
--      �Ի�⵵�� ¦���� �� �ǰ����� ������
--      �Ի�⵵�� Ȧ���� �� �ǰ����� �����
--�����԰� �Բ� Ǭ�� 
--    ���س⵵�� ¦������, Ȧ������ Ȯ���ϱ��ѵ�, �⵵�� ������
-- DATE Ÿ�� -> ���ڿ�(�������� ����, YYYY-MM-DD HH24:MT:SS)
-- ¦�� -> 2�� �������� ������ ���� 0
-- Ȧ�� -> 2�� �������� ������ ���� 1
SELECT empno, ename, hiredate,
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 0 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 0
      THEN '�ǰ����� �����'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 1 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 1
       THEN '�ǰ����� �����'
       ELSE '�ǰ����� ������'
       END CONTACT_TO_DOCTOR
FROM emp;       
--
SELECT empno, ename, hiredate,
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )=  MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)
      THEN '�ǰ����� �����'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )=   MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)
       THEN '�ǰ����� �����'
       ELSE '�ǰ����� ������'
       END CONTACT_TO_DOCTOR
FROM emp;       
--DECODE���
SELECT empno, ename, hiredate,
    
    CASE
      WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 0 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 0
      THEN '�ǰ����� �����'
       WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2 )= 1 AND MOD(To_NUMBER(TO_CHAR(hiredate, 'YYYY')),2)= 1
       THEN '�ǰ����� �����'
       ELSE '�ǰ����� ������'
       END CONTACT_TO_DOCTOR
       DECODE(MOD(TO_NUMBER
FROM emp;       

SELECT empno, ename, hiredate,
        
FROM emp;


--�ǽ� cond3 (���� Ǯ�����)************
SELECT * 
FROM users;

-----------------------------


SELECT *
FROM emp;

SELECT *
FROM dept;


--GROUP BY ���� ���� ����
--�μ���ȣ ���� ROW ���� ���� ��� : GROUP BY deptno
-- �������� ���� ROW ���� ���� ��� : GROUP BY job
--mgr�� ���� �������� ���� ROW ���� ���� ��� : GROUP BY mgr, job
--�׷��Լ��� ����
-- SUM : �հ�
-- COUNT : ����
-- MAX : �ִ밪
-- MIN : �ּҰ�
-- AVG : ���

--�׷��Լ��� Ư¡
-- �ش� �÷��� NULL���� ���� ROW�� ������ ��� �ش� ���� �����ϰ� ����Ѵ�. (NULL ������ ����� null)



-- �μ��� �޿� ��

--�׷��Լ� ������******************¯ �߿���
-- GROUP BY ���� ���� �÷����� �ٸ��÷��� SELECT���� ǥ���Ǹ� ����
SELECT deptno, ename  
        SUM(sal)sum_sal, MAX(sal), MIN(sal), ROUND(AVG(sal),2), COUNT(sal)       
FROM emp
GROUP BY deptno; 


--GROUP BY ���� ���� ���¿��� �׷��Լ��� ����� ���
--   -->��ü���� �ϳ��� ������ ���´� 
SELECT  SUM(sal) sum_sal, MAX(sal), MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),     -- sal �÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),    --COMM �÷��� ���� null�� �ƴ� row�� ���� 
        COUNT(comm)   --����� �����Ͱ� �ִ���      
FROM emp;
 
SELECT *
FROM emp;

-- GROUP BY ������ empno�̸� ������� ���?? 
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� ������ ���� ���� 
SELECT 1, SYSDATE , SUM(sal)sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
        COUNT(sal),     -- sal �÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),    --COMM �÷��� ���� null�� �ƴ� row�� ���� 
        COUNT(*),   --����� �����Ͱ� �ִ���      
FROM emp
GROUP BY  empno;


--SINGLE ROW FUNCTION ��� WHEN ������ ����ϴ� ���� �����ϴ�
-- NULI ROW FUNCTION(GROUP FUNCTION)�� ��� WHEN ������ ����ϴ� ���� �Ұ��� �ϰ�
-- HAVING ������ ������ ����Ѵ�.

--�μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ
--deptno, �޿���
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;


--�ǽ� grp1 
SELECT deptno,  MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal),
        COUNT(sal),     -- sal �÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),    --COMM �÷��� ���� null�� �ƴ� row�� ���� 
        COUNT(comm)   --����� �����Ͱ� �ִ���      
FROM emp;



--�ǽ� grp2 �μ���������   
SELECT MAX(sal), MIN(sal), ROUND(AVG(sal),2), SUM(sal),
        COUNT
FROM emp;

--�ǽ� grp3
  CASE    
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESERCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERATIONS'
        ELSE 'DDIT'
    END    ;
    
SELECT DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES'),    
        MAX(sal) max_sal , MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal, SUM(sal),
        SUM(sal)
        COUNT(sal)sal_count,     -- sal �÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm)mgr_count,    --COMM �÷��� ���� null�� �ƴ� row�� ���� 
        COUNT(*)all_count   --����� �����Ͱ� �ִ���      
FROM emp
GROUP BY DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES')
ORDER BY DECODE (deptno, 10, 'ACCOUNTING', 20, 'RESERCH', 30, 'SALES');



--�ǽ� grp4     �ٽ�Ǯ���    �Ի� ����� �׷������ ���
-- ORACLE 9i ���������� GROUP BY���� ����� �÷����� ������ ����
-- ORACLE 9i ���� ���ʹ� GROUP BY���� ����� �÷����� ������ �������� �ʴ´� (GROUP BY

SELECT  To_CHAR(hiredate, 'YYYYMM'),count(*)
FROM emp
GROUP BY To_CHAR(hiredate, 'YYYYMM');
--ORDER BY To_CHAR(hiredate, 'YYYYMM')    //������ ���ϸ� �ֱ� 


--�ǽ� grp5
SELECT TO_CHAR(hiredate, 'YYYY'), COUNT(*)
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY')
ORDER BY TO_CHAR(hiredate, 'YYYY');

--�ǽ� grp6
--���� �ǵ� �ľ��ϱ� : dept ���̺��� �Ǽ��� ����� ����°�
SELECT count(*) cnt
FROM dept;

--�ǽ� grp7
-- emp���̺� ���� �Ǽ��� ��� �ִ��� ����°� 
SELECT *
FROM emp
ORDER BY deptno;

SELECT  COUNT(*) cnt
FROM 
(SELECT deptno
 FROM emp   
GROUP BY deptno);



--�μ��� ���� �ִ��� : 10, 20, 30 -->3���� row�� ����
-- > ���̺��� row ���� ��ȸ : GROUP BY ���� COUNT(*)
--�迭, ������, ���� �����
--GROUP BY -�������� �����ϱ�........., JOIN (�����ϴ� ������ �ſ� ŭ)
