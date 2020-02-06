SUB7;
SELECT *
FROM customer;
SELECT *
FROM cycle;
SELECT *
FROM product;

SELECT .cid, .cnm, .pid, .pnm, .day, .cnt
FROM customer , cycle , product 
WHERE cycle.cid = 1
AND cycle.pid IN ( SELECT pid
                   FROM cycle 
                   WHERE cid = 2 );
                   
------------------------------------------------------------------------
������ �ִ� 5���� �� �ܹ�������
(kfc + ����ŷ + �Ƶ�����) / �Ե�����; 

--������ Ȯ��
SELECT sido, count(*)
FROM fastfood
where sido LIKE '%����%'
GROUP BY sido;

����(kfc, ����ŷ, �Ƶ�����)
������ 
����������	�߱�	7
����������	����	4
����������	����	17
����������	������	4
����������	�����	2;
SELECT sido, sigungu, count(*)
FROM fastfood
WHERE sido = '����������'
AND GB IN ('KFC', '����ŷ', '�Ƶ�����') 
GROUP BY sido, sigungu;


SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2, 2) hambuger_score
FROM
      (SELECT sido, sigungu, count(*) c1
       FROM fastfood
       WHERE /*sido = '����������'
       AND */GB IN ('KFC', '����ŷ', '�Ƶ�����') 
       GROUP BY sido, sigungu;)a,

       (SELECT sido, sigungu, count(*) c2
        FROM fastfood
        WHERE /*sido = '����������'
        AND*/ GB IN ('KFC', '����ŷ', '�Ƶ�����') 
        GROUP BY sido, sigungu;)b
WHERE a.sido = b.sido
AND a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;


SELECT *
FROM emp e, emp p
WHERE e.mgr = p.empno;

fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;
SELECT sido, sigungu, ROUND((kfc + BURGERKING + mac) / lot,2) burger_score
(SELECT sido, sigungu,  
        NVL(SUM(DECODE(gb,'kfc', 1)),0)kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)),0)BURGERKING,
        NVL(SUM(DECODE(gb, '�Ƶ�����', 1)),0)mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)),0)lot
FROM fastfood
WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
GROUP BY sido, sigungu
ORDER BY sido, sigungu)
ORDER BY butger_socre DESC);

SELECT *
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '������';


SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;


ROWNUM ���� ����
1. SELECT ==> ORDER BY
   ���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE-VIEW
2.1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE������ ����� ����
   ROWNUM = 1 (O)
   ROWNUM = 2 (X)
   ROWNUM < 10 (O)
   ROWNUM > 10 (X)  

�ܹ�������, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ�����(����)
����, ���κ� �ٷμҵ� �ݾ����� ���� �� ROWNUM�� ���� ������ �ο�
���� ������ �ೢ�� ���� 
�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ�������, ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��
����Ư���� �߱� 5.67      ����Ư���� ������  70
����Ư���� ������ 5       ����Ư���� ���ʱ�  69
��⵵ ������ 5          ����Ư���� ��걸  57
����Ư���� ������ 4.57     ��⵵ ��õ��      54
����Ư���� ���ʱ� 4        ����Ư���� ���α�   47    ;
--------------------------------------------------------------------------------

DESC emp;

empno �÷��� NOT NULL ���� ������ �ִ� -INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�.
empno �÷��� ������ ������ �÷��� NULLABLE�̴� (NULL ���� ����� �� �ִ�.);
INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', NULL);

SELECT *
FROM emp;

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN' );   --������ �� ���� : cannot insert NULL into ("SIM"."EMP"."EMPNO")

���ڿ� : '���ڿ�'  ==>"���ڿ�"
���ڿ� : 10
��¥�� : TO_DATE('20200226', 'YYYYMMDD'), SYSDATE ;  --emp���̺� hiredate�� �ִµ� ����ƮŸ���� ������ ���� �ٽ� �� ���

emp���̺��� hiredate�÷��� date Ÿ��
emp���̺��� 8���� �÷��� ���� �Է�; 
DESC emp;
INSERT INTO emp VALUES(9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99);

ROLLBACK;

�������� �����͸� �ѹ��� INSERT : 
INSERT INTO ���̺�� (�÷���1, �÷���2....)
SELECT ...
FROM ;

INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99
FROM dual
     UNION ALL  
SELECT 9999, 'brown', 'CLERK', NULL, TO_DATE('20200205', 'YYYYMMDD'), 1100, NULL, 99
FROM daul;

UPDATE����
UPDATE ���̺�� �÷���1 = ������ �÷� ��1, �÷���2= ������ �÷� ��2.....
WHERE �� ���� ����;
������Ʈ ���� �ۼ��� WHERE ���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��.
UPDATE, DELETE ���� WHERE���� ������ �ǵ��Ѱ� �´��� �ٽ��ѹ� Ȯ���Ѵ�.

WHERE���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT�ϴ� ������ �ۼ��Ͽ� �����ϸ�
UPDATE ��� ���� ��ȸ�� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�;

99�� �μ���ȣ�� ���� �μ� ������ DEPT���̺� �ִ� ��Ȳ
INSERT INTO dept VALUES ( 99, 'ddit', 'deajeon');
COMMIT;

SELECT *
FROM dept;

99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ;

UPDATE ���̺�� SET �÷���1 = ������ �÷� ��1, �÷���2 = ������;

UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;
ROLLBACK;

�Ǽ��� WHERE���� ������� �ʾ��� ���;
UPDATE dept SET dname = '���IT', loc = '���κ���'
/*WHERE deptno = 99*/;

����� - �ý��� ��ȣ�� �ؾ���� ==> �Ѵ޿� �ѹ��� ��� ������� ������� ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ
�ý��� ����� : �����(12,000), ������(550), ����(1,300)
UPDATE ����� SET ��й�ȣ = �ֹι�ȣ���ڸ�
WHERE ����ڱ��� => '�����';
COMMIT; 


10 ==> SUBQUERY; 
SMITHM WARD�� ���� �μ��� �Ҽӵ� ���� ����;
SELECT *
FROM emp
WHERE deptno IN(20,30); 

SELECT *
FROM emp
WHERE deptno IN(SELECT deptno
                FROM emp
                WHERE deptno IN('SMITHM', 'WARD')); 
                
UPDATE�ÿ��� ���� ���� ����� ����;
INSERT INTO emp(empno, ename) VALUES(9999, 'brown');
9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),--(��� ��ſ� ���������� ���ֱ�)
                job  = (SELECT job FROM emp WHERE ename = 'SMITH')        
WHERE empno = 9999;

SELECT *
FROM emp;
ROLLBACK;


DELET SQL : Ư�� ���� ����;
--����
DELECT [FROM] ���̺��
WHERE �� ���� ����;

SELECT *
FROM dept;
   
99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����;
DELETE dept
WHERE deptno = 99;
COMMIT;

SUBQUERY�� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE
�Ŵ����� 7698 ����� ������ �����ϴ� ������ �ۼ�;
DELETE emp
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;                