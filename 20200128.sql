
-- orderby 4   �ٽ�Ǯ��
SELECT * 
FROM emp
WHERE deptno =10  OR deptno =  30
AND  sal >= 1500 
ORDER BY ename DESC ;

SELECT *                            --�� �ٸ� Ǯ��
FROM emp
WHERE deptno IN(10,30)
AND  sal >= 1500 
ORDER BY ename DESC;  


--FFWNUM : ���ȣ�� ��Ÿ���� �÷�      ���Ŀ� ���� �� ? 
SELECT empno, ename
FROM emp
WHERE deptno IN (10, 30)
AND sal > 1500;



--ROWNUM�� WHERE�������� ��밡��
--�����ϴ� �� : = ROWNUM = 1, ROWNUM <= 2  --> ROWNUM = 1, ROWNUM <= N
--�������� �ʴ� �� : ROWNUM =2, ROWNUM >= 2  --> ROWNUM (N�� 1�� �ƴ� ����), ROWNUM >= N (N�� 1�� �ƴ� ����)
--ROWNUM �̹� ���� �����Ϳ��ٰ� ������ �ο�
--**������ 1. ���� ���� ����� ����(ROWNUM�� �ο����� �ʴ� ��)�� ��ȸ�� �� ����.  ****************
--**������ 2. ORDER BY ���� SELECT �� ���Ŀ� ������ �� �ִ�.
--���뵵 : ������ ó��
--���̺� �ִ� ��� ���� ��ȸ�ϴ� ���� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�� �Ѵ�.
--������ ó���� ������� : 1�������� �Ǽ�, ���� ���� (�ۼ� �ð�)
--emp���̺� �� row rjstn : 14
--�������� 5���� �����͸� ��ȸ
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM <=2;    


--**������ 2. ORDER BY ���� SELECT �� ���Ŀ� ������ �� �ִ�.
SELECT ROWNUM rn, empno, ename        --���� ���׹���   ���� �����Ϸ��� �츮�� ���� ����� ���� ���� ����ؾ��� 
FROM emp
ORDER BY ename ;
-- ������ ����� ROWNUM�� �ο��ϱ� ���ؼ��� IN LINE VIEW�� ����Ѵ�.
-- �������� : 1. ������ ���� �Ѵ�  2.ROWNUM �ο�

--SELECT *�� ����� ��� �ٷ� EXPRESSION�� ǥ���ϱ� ���ؼ� ���̺� ��.*�� ǥ���ؾ��Ѵ�
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;


--      ROWNUM  -> rn
-- *page size : 5, ���ı����� ename
-- 1page : rn 1~5
-- 2page : rn 6~10
-- 3page : rn 11~15
-- n page : rn (page-1)* pageSize + 1 ~ n * pageSize
SELECT ROWNUM rn, a.*
FROM
    (SELECT ROWNUM rn, a.*
     FROM
        (SELECT empno, ename          --    <--���̺� �̸� ���� ��Ī���� �̸� ���� �� �֤�,�Ѥ� 
         FROM emp
         ORDER BY ename ) a ) 
WHERE rn BETWEEN (1 - 1 ) * 5   AND 1 * 5;     --WHERE rn >=6  AND rn <= 10;  



--ROWNUM �ǽ� row_1
SELECT *
FROM
    (SELECT ROWNUM rn,emp.*
     FROM emp)
WHERE rn >=1 AND rn <= 10;
--                 �� �ٸ� Ǯ��
SELECT *
FROM 
(SELECT ROWNUM ru, empno, ename 
FROM emp)
WHERE ROWNUM ;


--row_2
SELECT *
FROM
    (SELECT ROWNUM rn,emp.*
     FROM emp)
WHERE rn BETWEEN 11  AND 14;

--row_3
SELECT *
FROM
    (SELECT ROWNUM RN , a.*
     FROM
        (SELECT emp.*
         FROM emp
         ORDER BY ename) a)
WHERE RN  BETWEEN 11  AND 14;



--row 3 �ٽ�Ǯ��
SELECT *
FROM
    (SELECT ROWNUM rn, a.* 
     FROM
        (SELECT empno, ename
          FROM emp
ORDER BY ename)a)
WHERE rn BETWEEN (:page -1 ) * :pageSize +1 AND :page * :pageSize; --WHERE RN BETWEEN 11 AND 14;     --WHERE rn BETWEEN ( 1 - 1 )*10 +1 AND 1*10; 

--sql�� ����� ���ư������� �ñ�................�ФФФ�



--R
SELECT empno, ename
FROM emp;


---------------------------------------------
--�ǽ� row 3
-----------------------------------------------
--�޼ҵ�? �Լ� 
--single     
--character ���ڿ� ����
--  low �ҹ��� ����� �� up �빮�� ����� �� ini �빮�ڷ� �����ϰ� �������� �ҹ���  trim 
--dual tanble 


-- DUAL ���̺� : �����Ϳ� �������, �Լ��� �׽�Ʈ �غ� �������� ���
SELECT LENGTH('TEST')
FROM dual;
--���ڿ� ��ҹ��� : LOWER, UPPER, INITCAP
SELECT LOWER ( 'Hello, World!' ), UPPER( 'Hello, World!' ), INITCAP('Hello, World!')
FROM emp;

SELECT LOWER ( ename ), UPPER(ename), INITCAP(ename)
FROM emp;

-- �Լ��� WHERE �� ������ ��� �����ϴ�
--EX. ��� �̸��� SMITH�� ����� ��ȸ
SELECT *
FROM emp
WHERE ename = 'SMITH';
--���ε�� �Է��� ���
SELECT *
FROM emp
WHERE ename = :ename;

SELECT *
FROM emp
WHERE ename = UPPER (:ename);

--- SQL �ۼ��� �Ʒ� ���´� �����ؾ��Ѵ�.
-- ����!  ���̺��� �÷��� �������� �ʴ� ���·� SQL�� �ۼ��ؾ��Ѵ�.            
SELECT *
FROM emp
WHERE LOWER(ename) = :ename;     

--
SELECT CONCAT ('Hello', ', World' ) CONCAT
FROM dual;

SELECT CONCAT('Hello', ' World' ), 
       SUBSTR('Hello, World', 1, 5)    --     <--Hello ������ ���� ���� ��
FROM dual;

SELECT CONCAT ('Hello', ', World' )  CONCAT,
    SUBSTR('Hello, World', 1, 5) sub,
    LENGTH('Hello, World') len,
    INSTR('Hello, World', 'o') ins,
    INSTR('Hello, World', 'o', 6 ) ins2,
    LPAD('Hello, World', 15, '*') RP,
    REPLACE('Hello, World', 'H','T') REP,
    TRIM('   Hello, World    ') TR, --������ ����
    TRIM('d' FROM 'Hello, World') TR, --������ �ƴ� �ҹ��� d ����
FROM dual;


-- ���� �Լ�
--ROUND : �ݿø� (10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� -> 11)
--TRUND : ����(����) (10.6�� �Ҽ��� ù��° �ڸ����� ���� --> 10)
--ROUND, TRUND : � ���� ���° �ڸ����� �ݿø� /����
--MOD : ������ (���� �ƴ϶� ������ ������ �� ������ ��) (13/5 -> ��:2, ������:3)   ******���� ���� �Լ� �ܿ��! 
 
 -- ROUND (��� ����, ���� ��� �ڸ�)
 SELECT ROUND (105.54, 1), --�ݿø� ����� �Ҽ��� ù��° �ڸ����� �������� --> �ι�° �ڸ����� �ݿø��ϰڴٴ� �Ҹ� 
        ROUND (105.55, 1),--�ݿø� ����� �Ҽ��� ù��° �ڸ����� �������� --> �ι�° �ڸ����� �ݿø��ϰڴٴ� �Ҹ�
        ROUND (105.55, 0), --�ݿø� ����� �����κи� --> �Ҽ��� ù��° �ڸ����� �ݿø� 
        ROUND (105.55, -1), --�ݿø� ����� ���� �ڸ������� --> ���� �ڸ����� �ݿø� 
        ROUND (105.55) --�ι�° ���ڸ� �Է����� ���� ��� 0���� ����ȴ�. �׷��� ����°��� ���� ���� �� 
 FROM dual;
 
SELECT TRUNC (105.54, 1),  --������ ����� �Ҽ��� ù��° �ڸ����� �������� ->�ι�° �ڸ����� ����
       TRUNC (105.55, 1),  --������ ����� �Ҽ��� ù��° �ڸ����� �������� ->�ι�° �ڸ����� ����
       TRUNC (105.55, 0)  --������ ����� ������(���� �ڸ�)���� �������� ->�Ҽ��� ù��° �ڸ����� ����
       TRUNC (105.55, 0), 
       TRUNC (105.55, -1) -- ������ ����� 10�� �ڸ����� �������� -> ���� �ڸ����� ����
       TRUNC(105.55, 0 ) --�ι�° ���ڸ� �Է����� ���� ��� 0�� ���� 
FROM dual;


--emp���̺��� ����� �޿�(sal)�� 1000���� ������ �� ���� ���غ�����
SELECT ename, sal, sal/1000      
FROM emp;
------

SELECT ename, sal, TRUNC(sal/1000)      
FROM emp;

--�������� ���� �� MOD
 SELECT ename, sal, 
        TRUNC(sal/1000),
        MOD (sal, 1000)       --mod�� ����� divisor���� �׻� ����  �׷��� -- 0~999
FROM emp;
 

--��¥ ���õ� �� 
DESC emp;

DESC emp; 

--�⵵2�ڸ�/��2�ڸ�/����2�ڸ�  ������ �ٲٸ� 
SELECT ename, hiredate
FROM emp;

--SYSDATE : ���� ����Ŭ ������ ��,��,�ʰ� ���Ե� ��¥ ������ �����ϴ� Ư�� �Լ�  
--�Լ���(����1, ����2)
SELECT SYSDATE
FROM dual;

-- <�����ϱ�>
-- date + ���� = ���ڿ���
--   1 = �Ϸ�
--   1�ð� = 1/24
--    2020/01/28 + 5

--  ���� ǥ�� : ����
--  ���� ǥ�� : �̱� �����̼� + ���ڿ� + ��Ŭ �����̼� --> '���ڿ�'
--  ��¥ ǥ�� : TO_DATE('���ڿ� �� ��¥ ��', '���ڿ��� ��¥ ���� ǥ������')   -->TO_DATE('2020-01-28', 'YYYY-MM-DD')

SELECT SYSDATE + 5, SYSDATE + 1/24
FROM dual;

