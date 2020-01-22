-- PROD ���̺��� ��� �÷��� �ڷ� ��ȸ(1��)
SELECT *
FROM PROD;


-- PROD ���̺��� PROD_ID, FROD_NAME �÷��� �ڷḸ ��ȸ(2��)
SELECT PROD_id, prod_name
FROM prod;


--PROD ���̺��� cart���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ�(3��)
SELECT *
FROM cart;


--member���̺��� mem_id, mem_pass, mem_name �����͸� ��ȸ�Ͻÿ�(4��) 
SELECT mem_id, mem_pass, mem_name
FROM member;




----users ���̺� ��ȸ
SELECT *
FROM users;


--���̺� � �÷��� �ִ��� Ȯ���ϴ� ��� 

SELECT id
FROM users;


--���̺� � �÷��� �ִ��� Ȯ���ϴ� ��� 
-- 1.SELECT *
-- 2. TOOL�� ��� (�����--TABELS)
-- 3. DESC ���̺�� (DESC-DESCRLBE)
DESC users;


-- users ���̺��� userid, usernm, reg_dt Į���� ��ȸ�ϴ� sql�� �ۼ��ϼ���

-- ��¥ ���� (reg_dt �÷��� date������ ���� �� �ִ� Ÿ��)
-- SQL ��¥�÷� +(���ϱ� ����)
-- �������� ��Ģ������ �ƴ� �͵� (5+5)
-- String h = "Hello";
-- String w = "World";
-- String hw = h+w; -- �ڹٿ����� �� ���ڿ��� ����
-- SQL���� ���ǵ� ��¥ ���� : ��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥ (2019/01/28 + 5 = 2019/02/28)
-- reg_dt : ������� �÷� 
-- null : ���� �𸣴� ����, �Ҵ���� ���� ��, 0, ������� �ٸ���
-- null�� Ư¡: null�� ���� ���� ����� �׻� null **

SELECT userid u_id, usernm, reg_dt, 
       reg_dt + 5 AS reg_dt_after_5day
FROM users;


--��������(2)
--prod ���̺��� prod_id, prod_name �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ� 
---                                      (�� prod_id ->id, ���� �÷� ��Ī�� ����)
SELECT prod_id, prod_name
FROM prod;

--lprod ���̺��� lprod_gu, lprod_nm �� �÷��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�
---
SELECT lprod_gu, lprod_nm
FROM lprod;

--
SELECT buyer_id ���̾���̵�, buyer_name �̸�
FROM buyer;



--���ڿ� ����
-- �ڹ� ���� ���ڿ� ���� : + ("hello" + "world")
--SQL������ : ||    ('Hello' || 'world')
--SQL������ : concat('Hello', 'world')


-- userid, usernm �÷��� ����, ��Ī id_name
SELECT usernm || usernm id_name,
       CONCAT(userid, usernm) doncat_id_name
FROM users;


-- ����, ��� 
--int a = 5; String msg = "Helloworld";

--����ϴ� ��� ũ�� �� ����

--//������ �̿��� ���
--System.out.println(msg);

--//����� �̿��� ���
--System.out.println("Hello, World")
--SQL������ ������ ���� (�÷��� ����� ����, pl/ sql ���� ������ ����)
--SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
--"Hellom World" --> 'Hello, World'


-- ���ڿ� ����� �÷����� ���� 
-- usre id : brown
-- user id : cony
SELECT 'user id : ' || userid  AS "use rid"
FROM users; 



SELECT TABLE_NAME
FORM user_tables ;


SELECT 'user id : ' || userid  AS "use rid"
FROM users; 

SELECT 'SELECT * FROM ' || table_name || ';'  query
FROM user_tables;

--SELECT  CONCAT( CONCAT('SECLECT * FROM ', table_name),';')
FROM user_tables;
SELECT  CONCAT('SECLECT * FROM ', table_name)
FROM user_tables;
SELECT 'SELECT * FROM ' || table_name || ';'  query
FROM user_tables;

����--CONCAT ���� (|| -> CONCAT���� �ٲٴ� �� )
--                        CONCAT(arg1, arg2)     tip. ctrl+shift �巡��  
SELECT usernm || usernm id_name,
       CONCAT(userid, usernm) doncat_id_name
FROM users;

SELECT  CONCAT( CONCAT('SECLECT * FROM ', table_name),';')
FROM user_tables;

-- int a = 5; // �Ҵ�, ���� ������ 
-- if (a == 5) (a�� ���� 5��ġ ��)
-- sql������ ������ ������ ���� (pl/s 
--������, sql���� sql = -> equal


--users�� ���̺��� ��� �࿡ ���ؼ� ��ȸ
--users���� 5���� �����Ͱ� ����
SELECT*
FROM users;


--WHERE �� : ���̺��� �����͸� ��ȸ�� �� ���� ���ǿ� �´� �ุ ��ȸ 
---EX : userid �÷��� ���� brown�� �ุ ��ȸ 
-- brown, 'brown' ����
--�÷�, ���ڿ� ��� 
SELECT *
FROM users
WHERE userid = 'brown';


--����
--userid�� brown�� �ƴ� �ุ ��ȸ 
---    ���� �� : =, �ٸ��� : !=, <>
SELECT *
FROM users
WHERE userid != 'brown';

-- emp ���̺� �����ϴ� �÷��� Ȯ���غ�����.
SELECT *
FROM emp;

--emp ���̺��� ename �÷� ����  JONES�� �ุ ��ȸ 
--- *SQL KEY WORD�� ��ҹ��ڸ� ������ ������
---�÷��� ���̳�, ���ڿ� ����� ��ҹ��ڸ� ������
---'JONES', 'JONES'�� ���� �ٸ� ��� 
SELECT *
FROM emp
WHERE ename = 'JONES';

SELECT *
FROM emp; --emp�� ���� //mgr : ���� 
DESC emp
5 > 10 --FALSE
5 > 5 --FALSE
5 >= 5 --TRUE

--emp ���̺��� detno(�μ���ȣ)�� 30���� ũ�ų� ���� ����鸸 ��ȸ (SQL���� ���� ���� ��)
SELECT *
FROM emp
WHERE dePtno >= 30;


-- ���ڿ� : '���ڿ�'
-- ���� : 50
-- ��¥ : ??? ----> �Լ��� ���ڿ��� �����Ͽ� ǥ�� 
--       ���ڿ��� �̿��Ͽ� ǥ�� ���� (������ �������� ����)
--     ������ �������� ��¥ ǥ�� ���(�ؼ����)�� �ٸ��� ������ ...
--     ex)    �츮���� : �⵵4�ڸ�-��2�ڸ�-����2�ڸ�
--            ��   �� : ��2�ڸ�-����2�ڸ�-�⵵4�ڸ�

--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ 
SELECT *
FROM emp
WHERE hiredate = '80/12/17';

-- TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ� 
-- TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)
-- '1980/02/03' �ι�° �ݷҰ� ����° �ݷ��� ����� ���̰� ������ �� �� ���� �׷��� ��ø� �ϴ� ���̴�.
SELECT *
FROM emp
WHERE hiredate = To_DATE('19801217', 'YYYY/MM/DD');  --�̷���



--�̹���
-- ��������
-- sal �÷��� ���� 1000���� 2000 ������ ��� 
--     sal >= 1000
--     sal <= 2000    
SELECT *
FROM emp
WHERE sal >= 100
AND sal <= 2000;        --�� �� ������ �����ϱ� ���ؼ��� AND�� �־��ָ� �ȴ� 


--���������ڸ� �ε�ȣ ��ſ� BETWEEN AND �����ڷ� ��ü 
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT *
FROM emp
WHERE sal >= 1000
AND 

To_DATE('19801217', 'YYYY/MM/DD');

SELECT ename, hiredate 
FROM emp 
WHERE hiredate BETWEEN To_DATE('19820101', 'YYYY/MM/DD') AND To_DATE('19830101', 'YYYY/MM/DD');
