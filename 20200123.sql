--����
<<<<<<< Updated upstream
---emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
--     (��, �����ڴ� �񱳿����ڸ� ����Ѵ�.)
=======
---emp ���̺��� �Ի� ���ڰ� 1982�� 1�� 1�� ���ĺ��� 1983�� 1�� 1�� ������ ����� ename, hiredate �����͸� ��ȸ�ϴ� ������ 
-- �ۼ��Ͻÿ�.(��, �����ڴ� �񱳿����ڸ� ����Ѵ�.)
>>>>>>> Stashed changes
-----*where���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
----�� ������ SQL�� ������ ������ ���� �ֱ� �����̴�. ������ ��Ȯ�ؾ��� 
--���� : Ű�� 185cm�̻��̰� �����԰� 70kg�̻��� ������� ����
--      -->�����԰� 70kg�̻��̰� Ű�� 185cm�̻��� ������� ����
--������ Ư¡ : ���տ��� ������ ���� 
--(1, 5, 10) --> (10, 5, 1) : �� ������ ���� �����ϴ�.
-- ���̺��� ������ ������� �ʴ´�.
--SELECT ����� ������ �ٸ����� ���� �����ϸ� �����̴�.
--> ���ı�� ����( ORDER BY)
--      �߻��� ����� ���� -->���� X
--
SELECT *    
FROM emp;


SELECT ename ,hiredate
FROM emp
WHERE hiredate >=To_Date('1982/01/01', 'YYYY/MM/DD') and hiredate <=To_Date('1983/01/01', 'YYYY/MM/DD'); 


-- IN ������ 
--Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
--�μ���ȣ�� 10�� Ȥ��(=OR) 20���� ���ϴ� ���� ��ȸ      
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20); 

--IN �����ڸ� ������� �ʰ� OR ������ ���
SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10 
OR    deptno = 20;


-- emp ���̺��� ����̸��� SMITH, JONES �� ������ ��ȸ (empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH' OR ename = 'JONES';


-- AND / OR �򰥸��� ���� !  IN= OR (�׷��� ���� ����� �ٸ���)
<<<<<<< Updated upstream
--���� ��� 
=======

>>>>>>> Stashed changes


-�ǽ�
--users ���̺��� userid �� brown, cony, sally�� �����͸� ������ ���� ��ȸ�Ͻÿ� ( IN ������ ��� )

SELECT *
FROM users;


SELECT userid ���̵�, usernm �̸�
FROM users
WHERE userid IN  ( 'brown', 'cony', 'sally');


--���ڿ� ��Ī ������ : LIKE, %
--������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
--�̸��� BR�� �����ϴ� ����� ��ȸ
--�̸��� R ���ڿ��� ���� ����� ��ȸ

--��� �̸��� S�� �����ϴ� ��� ��ȸ 
--SMITH, SMILE, SKC
--% � ���ڿ� (�ѱ���, ���� ���� ���� �ְ�, ���� ���ڿ��� �� ���� �ִ�)
SELECT *
FROM emp;

SELECT 
FROM
WHERE ename LIKE 'S%';

--���ڼ��� ������ ���� ��Ī
-- _��Ȯ�� �ѹ���
--���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ���� 
--S_____
SELECT *
FROM emp
WHERE ename LIKE 'S____';


--��� �̸��� S���ڰ� ���� ��� ��ȸ
--ename LIKE '%S%'
SELECT *
FROM emp
WHERE ename LIKE '%S%';


--�ǽ�  WHERE4
-- ����
--1
SELECT *
FROM member;

--2
SELECT mem_id, mem_name
FROM member;

--3
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';


--�ǽ� WHERE5
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name 



--nuall �� ���� (IS)
-- come �÷��� ���� null�� �����͸� ��ȸ (WHERE comm = null)
SELECT *
<<<<<<< Updated upstream
FROM emp;
WHERE comm = null;

SELECT *
FROM emp;
WHERE comm = '';

SELECT *
FROM emp;
WHERE comm IS null;

SELECT *
FROM emp;
WHERE comm IS NOT null;
=======
FROM emp
WHERE comm = null;      ---X

SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;    ---null

SELECT *
FROM emp
WHERE comm IS NOT null; ---null(X)
>>>>>>> Stashed changes


SELECT *
FROM emp
<<<<<<< Updated upstream
WHERE comm >= 0
=======
WHERE comm >= 0;
>>>>>>> Stashed changes


--�ǽ� where6
SELECT *
FROM emp
WHERE comm IS NOT null;
--�� �ٸ� Ǯ��
SELECT *
FROM emp
WHERE comm >= 0


--������ ��� ������ �ϴ°� 
--����� �����ڰ� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ 
--NOT IN �����ڿ����� NULL ���� ���� ��Ű�� �ȵȴ� *******�ٽ�!!
SELECT *
<<<<<<< Updated upstream
FROM emp;
WHERE mgr not in( 7698, 7839, null);
--����� ���� �Ǹ� -->
SELECT *
FROM emp;
=======
FROM emp
WHERE mgr not in( 7698, 7839, null);
--����� ���� �Ǹ� -->
SELECT *
FROM emp
>>>>>>> Stashed changes
WHERE mgr not in( 7698, 7839)
AND mgr IS NOT NULL;


--�ǽ� WHERE7
SELECT *
FROM emp
WHERE job = 'SALESMAN'
AND hiredate > TO_Date ('1981/06/01', 'yyyy/mm/dd');

--where8
SELECT *
FROM emp
WHERE DEPTNO != 10
AND HIREDATE > TO_Date ('1981/06/01', 'yyyy/mm/dd') ;

--where9
SELECT *
FROM emp
WHERE DEPTNO NOT IN(10)
AND HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;


--10
SELECT *
FROM emp
WHERE DEPTNO IN(20,30)
AND HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;

--11
SELECT *
FROM emp
WHERE job = 'salesman'
OR HIREDATE > TO_Date('1981/06/01', 'yyyy/mm/dd') ;


--12
SELECT *
FROM emp
WHERE JOB = 'SALESMAN'
or empno LIKE '78%';

--13
SELECT *
FROM emp 
WHERE job = 'SALESMAN'        --���� ���� ��ҹ��� �� Ȯ���ϱ�  
OR empno LIKE '78%';    





-- ������ �켱���� 
--*, / �����ڰ� +, - ���� �켱������ ���� 
--ex) 1+5*2 = 11 -> (1+5)*2 (X)
--�켱���� ���� : ()
--AND > OR    (AND�� OR���� �켱������ ���� )

--emp ���̺��� ��� �̸��� SMITH �̰ų�
--             ��� �̸��� ALLEN �̸鼭 �������� SALLESMAN�� ��� ��ȸ 
SELECT *
FROM emp
WHERE ename = 'SMITH'
<<<<<<< Updated upstream
OR (ename = 'ALLEN' AND JOB = 'SALLESMAN');      
=======
OR (ename = 'ALLEN' AND JOB = 'SALESMAN');      
>>>>>>> Stashed changes


--��� �̸��� SMITH �̰ų� ALLEN �̸鼭 
--�������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp                        
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN' ;                        --  �ҹ��ڷ� �Ἥ Ʋ����.. 


--14
SELECT *
FROM emp
WHERE JOB = 'SLAESMAN'
OR (empno Like '78%' AND HIREDATE >= To_Date('1981/06/01', 'yyyy/mm/dd')); 



--����
--SELECT *
--FROM TABLE
--[WHERE]
--ORDER BY {�÷�|��Ī|Į���ε��� {ASD | DESC}, ....}


--emp ���̺��� ��� ����� ename �÷� ���� �������� ���� ���� ������ ����� ��ȸ�Ͻÿ�.
SELECT *
FROM emp     ---DESC : DESCRIBE (�����ϴ� )       
ORDER BY ename DESC; --DESC : DESCENDING  (����)                -������ ��� WHERE�� ���� �ʴ´� 


--emp ���̺��� ��� ������ ename�÷����� ��������,
--ename ���� ���� ��� mrg �÷����� �������� �����ϴ� ������ �ۼ��ϼ���
SELECT *
FROM emp
ORDER BY ename DESC, mrg;


--���Ľ� ��Ī�� ���
SELECT empno, ename nm, sal*12 year_sal --�̷��Ե� ������ �����ϴٴ� ��    --???????
FROM emp 
ORDER BY year_sal;

--�÷� �ε����� ����
--java array(0���� ����)
--SQL COLUMN INDEX : 1���� ����
SELECT empno, ename nm, sal*12 year_sal 
FROM emp 
ORDER BY 3;



----ORDER BY 1 
SELECT *
FROM dept
ORDER BY DNAME ;      --���������� ��������  

SELECT *
FROM dept
ORDER BY LOC DESC;   --�μ���ġ 


----ORDER BY 2
SELECT *
FROM emp
WHERE comm is not null AND comm != 0
ORDER BY comm DESC , empno ;



----3
SELECT * 
FROM emp
WHERE mgr IS NOT NULL
ORDER BY Job, empno DESC;          --??????????????


 


ELECT *
FROM users;

SELECT userid ���̵� , usernm �̸� , alias ����
FROM users
WHERE userid IN( 'brown', 'cony', 'sally');



