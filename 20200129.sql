--���� fn1
SELECT sysdate-29 AS "LASTDAY",        --sysdate ���� ��¥   / , �� �־��ֱ� !! / dual �� ���̺�
       sysdate -34 AS"LASTDAT_BEFORE5",
       sysdate As,
       sysdate -3 AS  "NOW_BEFORE3" 
FROM dual;


--DATE : TO_DATE ���ڿ� -> ��¥(DATE)
--       TO_CHAR ��¥ -> ���ڿ�(��¥ ���� ����)
-- JAVA������ ��¥ ������ ��ҹ��ڸ� ������ (MM / mm -> ��, ��)
-- �ְ�����(1~7) :  �Ͽ��� 1, ������ 2 ......����� 7
-- ( )�� �� IW : ISOǥ�� - �ش� ���� ������� �������� ( )�� ���� ����
--           2019/12/31 ȭ���� --> 2020/01/02(�����) --> �׷��� ������ 1�� ���� ����

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),          --������ 2020/01/29/��
       TO_CHAR(SYSDATE, 'D'),                              --���� �߰� ��¥ ���غ���  4�� ������ �����̱⿡ ���� ���� ���� �����غ���
       TO_CHAR(SYSDATE, 'IW'),                             --���ó�¥�� ����°�� ���ԵǴ��� �˾ƺ��� 
       TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'), 'IW')  
FROM dual;



-- emp ���̺��� hiredate(�Ի�����)�÷��� ����� ��:��:��
SELECT ename, hiredate,
       To_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:ss'), 
       To_CHAR(hiredate + 1,'YYYY-MM-DD HH24:MI:ss'),
       To_CHAR(hiredate + 1/24, 'YYYY-MM-DD HH24:MI:ss'),
       --hiredate�� 30���� ���Ͽ� TO_CHAR�� ǥ��
       To_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:ss')
FROM emp;

--�ǽ� fn2
SELECT 
    To_CHAR(SYSDATE,'YYYY-MM-DD') AS DT_DASH,
    To_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS DT_DASH_WITH_TIME,
    To_CHAR(SYSDATE, 'DD-MM-YYYY') AS DT_DD_MM_YYYY
FROM dual;


--MONTHS_BETWEEN(DATE, DATE)
SELECT ename, hiredate,
        MONTHS_BETWEEN(hiredate,sysdate)     --  
FROM emp
WHERE ename='SMITH';
--
SELECT ename, hiredate,
        MONTHS_BETWEEN(sysdate, hiredate)        
FROM emp
WHERE ename='SMITH';
--
SELECT ename, hiredate,
        MONTHS_BETWEEN(sysdate, hiredate),   --���ڱ����� ��ġ�����ָ�      
        MONTHS_BETWEEN(TO_DATE('2020-01-17', 'YYYY-MM-DD'), hiredate)       
FROM emp
WHERE ename='SMITH';


--ADD_MONTHS(DATE, ����-������ ������)
SELECT ADD_MONTHS(SYSDATE, 5),   --2020/01/29   --> 2020/06/29
       ADD_MONTHS(SYSDATE, -5)  --2020/01/29   --> 2020/08/29
FROM dual;


-- NEXT_DAY(DATE, �ְ�����), ex: NEXT_DAY(SYSDATE, 5) --> SYSDATE���� ó�� �����ϴ� �ְ����� 5(��)�� �ش��ϴ� ����
--                                SYSDATE 2020/01/29(��) ���� ó�� �����ϴ� 5(��)���� -> 2020/01/30(��)
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;


--LAST_DAY(DATE) DATE�� ���� ���� ������ ���ڸ� ����
SELECT LAST_DAY(SYSDATE) --SYSDATE 2020/01/29 --> 2020/01/31
FROM dual;


---����. LAST _DAY�� ���� ���ڷ� ���� date�� ���� ���� ������ ���ڸ� ���� �� �ִµ�
--      date�� ù��° ���ڴ� ��� ���ұ�?
SELECT SYSDATE,
        LAST_DAY(SYSDATE),
        TO_DATE('01','DD'),       --ù��° ���
       ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),  --�ι�° ��� 
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')  --����° ���
FROM dual;


--hiredate ���� �̿��Ͽ� �ش� ���� ù��° ���ڷ� ǥ���غ���
SELECT ename, hiredate
FROM emp;
-- Ǯ��
SELECT ename, hiredate,
       ADD_MONTHS(LAST_DAY(hiredate) +1, -1)            
FROM emp;
-- �� �ٸ� Ǯ��
SELECT ename, hiredate,
       TO_DATE(TO_CHAR(hiredate, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM emp;


--empno�� NUMBERŸ��, ���ڴ� ���ڿ�
--Ÿ���� ���� �ʱ� ������ ������ ����ȯ�� �Ͼ
--���̺� �÷��� Ÿ�Կ� �°� �ùٸ� ���� ���� �ִ°��� �߿�
SELECT *
FROM emp
WHERE empno='7369';
--


--hiredate�� ��� DATE����, ���ڴ� ���ڿ��� �־����� ������ ������ ����ȯ�� �߻�
--��¥ ���ڿ� ���� ��¥ Ÿ������ ��������� ����ϴ� ���� ����
SELECT *
FROM emp
WHERE hiredate = '80/12/17';       --�ȵǴ� ������ ? ������ yyyy�� �ٲ�� ������ .. �׷��� 1980
--�ùٸ� Ǯ��
ELECT *
FROM emp
WHERE hiredate = ;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';
   1 - filter("EMPNO"=7369)      --�ڵ������� ����ȯ�Ȱ� 
--���ڸ� ���ڿ��� �ٲٴ°� (�̷��Դ� ���� ���ƾ��Ѵٴ� ���ø� ������ ��) 
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_DATE(empno)='7369';
   

SELECT *
FROM table(dbms_xplan.display);



--                          ���ڸ� ���ڷ� �� �ٲܱ� ? 
--���ڸ� ���ڿ��� �����ϴ� ��� : ���˶����� 
--õ���� ������
--1000�̶�� ���ڸ� 
--�ѱ� : 1,000.50
--���� : 1,000,50

--emp sal �÷�(NUNMBR Ÿ��)�� ������
-- 9 : ����
-- 0 : ���� �ڸ� ����(0���� ǥ��)
-- L : ��ȭ����
SELECT ename, sal, TO_CHAR(sal, '9,999')
FROM emp;
--
SELECT ename, sal, TO_CHAR(sal, '0,999')
FROM emp;
--
SELECT ename, sal, TO_CHAR(sal, 'L0,999')
FROM emp;



--NULLó�� �ϴ� ������ ?
--NULL�� ���� ������ ����� �׻� NULL
--emp ���̺��� sal �÷����� null �����Ͱ� �������� ���� (14���� �����Ϳ� ����)
--emp ���̺��� comm �÷����� null �����Ͱ� ����(14���� �����Ϳ� ����)
--sal + comm --> comm�� null�� �࿡ ���ؼ��� ��� null�� ���´�
--�䱸������ comm�� null�̸� sal �÷��� ���� ��ȸ
--�䱸������ ���� ��Ű�� ���Ѵ� -> SW������ [����]

--NVL(Ÿ��, ��ü��)
--Ÿ���� ���� NULL�̸� ��ü���� ��ȯ�ϰ�
--Ÿ���� ���� NULL�� �ƴϸ� Ÿ�� ���� ��ȯ
--if (Ÿ�� == null )
--      reture ��ü��; 
-- else
--      reture Ÿ��;
SELECT ename, sal, comm, sal+comm
FROM emp;
--
SELECT ename, sal, NVL(comm, 0), 
       sal+NVL(comm, 0),
        NVL(sal+comm, 0)
FROM emp;


--NVL2(expr1, expr2, expr3)     ù��° ����,,,,, *******************
--if(expr1 != NULL)
--      return expr2
--else
--      return expr3;
SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;


--NULLIF(expr1, expr2)
-- if(expr1 == expr2)
--      return null;
--else
--      return expr1;

--sal 1250�� ����� null�� ����, 1250�� �ƴѻ���� sal�� ����
SELECT ename, sal, comm, NULLIF(sal, 1250) 
FROM emp;


--��������
--COALESCE �����߿� ���� ó������ �����ϴ� NULL�� �ƴ� ���ڸ� ��ȯ�Ѵ� 
--COALESCE(expr1, expr2....)
--if(expr1 != null)
--  return expr1;
--else
--  return COALESCE(expr2, expr3....);

--COALESCE(comm, sal) : comm�� null�� �ƴϸ� comm
--                        comm�� null�̸� sal (��, sal �÷��� ���� NULL�� �ƴҶ�) 
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;


--�ǽ� fn4    (nvl, nvl2, coalesce �̿�)       **********
SELECT empno, ename, mgr, 
       nvl(mgr, 9999) mgr_n,
       nvl2(mgr, mgr, 9999),
       coalesce( mgr,9999)
FROM emp;


--pair programing (¦ ���� �ڵ� ������� ����鳢���ؾ� ������ ��)


--�ǽ� fn5
SELECT userid, usernm, reg_dt     
FROM users;
--
SELECT userid, usernm, reg_dt, nvl(reg_dt, SYSDATE) n_reg_dt     
FROM users
WHERE userid != 'brown';


--Condition : ������
--CASE : JAVA�� if - else if - else
--���� ��
-- CASE
--      WHEN ���� THEN ���ϰ�1
--      WHEN ����2 THEN ���ϰ�2
--      ELSE �⺻��
-- END
-- emp ���̺��� job �÷��� ���� SALESMAN �̸� SAL * 1.05 ����
--                             MANAGER �̸� SAL * 1.1 ����
--                             PRESIDENT �̸� SAL * 1.2 ����
--                             �� ���� ������� SAL�� ����
SELECT ename, job, sal,
       CASE
           WHEN job = 'SALESMAN' THEN SAL * 1.05
           WHEN job = 'MANAGER' THEN sal * 1.1
           WHEN job = 'PRESIDENT' THEN sal * 1.2
           ELSE sal
       END bonus_sal
FROM emp;

--DECODE �Լ� : CASE���� ����
-- (�ٸ��� CASE�� : WHEN ���� ���Ǻ񱳰� �����Ӵ�
--      DECODE �Լ� : �ϳ��� ���� ���ؼ� = �񱳸� ���
--DECODE �Լ� : ��������(������ ������ ��Ȳ�� ���� �þ ���� ����)
--DECODE(col|expr, ù��° ���ڿ� ���� ��1, ù��° ���ڿ� �ι�° ���ڰ� ������� ��ȯ ��,
--                  ù��° ���ڿ� ���� ��1, ù��° ���ڿ� �ι�° ���ڰ� ������� ��ȯ ��....
--  �񱳴���� ������  option - else ���������� ��ȯ�� �⺻��)



--���빮��
-- emp ���̺��� job �÷��� ���� SALESMAN �̸鼭  sal�� 1400���� ũ�� SAL * 1.05 ����
--                             SALESMAN �̸鼭  sal�� 1400���� ������ SAL * 1.1 ����
--                             MANAGER �̸� sal * 1.1 ����
--                             PRESIDENT�̸� SAL * 1.2 ���� 
--                             �� ���� ������� SAL�� ���� 


SELECT ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;       
--1. CASE �� �̿��ؼ�
SELECT ename, job, sal,
       CASE
           WHEN job = 'SALESMAN' AND SAL > 1400 THEN SAL * 1.05
           WHEN job = 'SALESMAN' AND SAL < 1400 THEN SAL * 1.1
           WHEN job = 'MANAGER' THEN sal * 1.1
           WHEN job = 'PRESIDENT' THEN sal * 1.2
           ELSE sal
       END bonus_sal
FROM emp;
--2. DECODE, case      
--                      DECODE�ȿ� CASE�� DECODE ������ ��ø�� �����ϴ�. 
SELECT ename, job, sal,
       DECODE(job,  'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, 
                     CASE
                       WHEN job = 'SALESMAN' AND SAL > 1400 THEN SAL * 1.05
                       WHEN job = 'SALESMAN' AND SAL < 1400 THEN SAL * 1.1
                       ELSE sal
                   END
                    ) bonus_sal
FROM emp;


-- emp ���̺��� job �÷��� ���� SALESMAN �̸鼭  sal�� 1400���� ũ�� SAL * 1.05 ����
--                             SALESMAN �̸鼭  sal�� 1400���� ������ SAL * 1.1 ����
--                             MANAGER �̸� sal * 1.1 ����
--                             PRESIDENT�̸� SAL * 1.2 ���� 
--                             �� ���� ������� SAL�� ����

SELECT ename, job, sal,
    DECODE (job, 'SALESMAN', CASE
                                 WHEN sal > 1400 THEN sal * 1.05
                                 WHEN sal < 1400 THEN sal * 1.1
                                 END,
                  'MANAGER', sal * 1.1,
                  'PRESIDENT', sal * 1.2
                  ELSE sal)