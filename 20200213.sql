synonym : ���Ǿ�        115P
    1. ��ü ��Ī�� �ο�
        ==> �̸��� �����ϰ� ǥ��
        
      ���� ����ϳĸ� sim����ڰ� �ڽ��� ���̺� emp���̺� ����ؼ� ����  v_emp view
                    hr ����ڰ� ����� �� �ְ� �� ������ �ο�
                    
                    v_emp : �ΰ��� ���� sal, comm �� ������ view; 
                    
                    hr ����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�
                    
                    SELECT *
                    FROM sim.v_emp;
                    
                    hr ��������
                    synonym sim.v_emp ==> v_emp
                    v_emp == sim.v_emp
                    
                    SELECT *
                    FROM v_emp;
                    
 1.sim�������� v_emp�� hr �������� ��ȸ�� �� �ֵ��� ��ȸ���� �ο�;                        
 
 GRANT SELECT ON v_emp TO hr;
 
 2. hr ���� v_emp ��ȸ�ϴ°� ���� (���� 1������ �޾ұ� ������)
    ����� �ش� ��ü�� �����ڸ� ��� : sem.v_emp
    �����ϰ� sim.V_emp ==> v_emp ����ϰ� ���� ��Ȳ
    synonym ����
    
 CREATE SYNONYM �ó���̸� FOR �� ��ü��;   
 
 115P 117P �ۺ� : ��� ����ڰ� ����� �� �ְ� �ɼ��� �� ������ ��� ����ڰ� �� �� �ֱ� ������ ������ ���� ����ڸ� �� �� �ֵ��� ������ �����ϴ�
 118P �巴 �ó�� �����Ϸ��� 
 *�ó�� ���� ��� 
 DROP SYNONYM �ó���̸�; 
 
 119P
 GRANT CONNECT TO SIM;        --�ý��ۿ� ���� ����
 GRANT SELECT ON ��ü�� TO HR;  --��ü ���� 
 
 120P 
 ��Ű�� 
 
 121P 
 ���̺� �����̽� ū ��ü�� ���� �����̳ʶ�� �����ϸ� �ȴ�. 
 
 122P
 ��й�ȣ �ٲ� ��  121 �� ũ����Ʈ ���� �� �κ��� ���� 
 
 123P 
����Ŭ �ý��� ���� 
�並 ó�� ���鶧 ������� 
 124P ������ �ִ� ���� �̷��͵� ...
 ������ ������ �װ��� �ٽ� �ؼ��ϴ� ����� �ִ�  RE
 
 125P 
 ��ü ���� 
 � ����ڿ��� �ְڴ�
 �������� �ȴ� 
 127P 
 �׷�Ʈ ��� ������ �� WITH ADMIN OPTION 
 ������ �ο����� ����ڰ� �ٸ�����ڿ��� ������ �ο��� �� �ִ� 
 128P 
 130P  ����
 ��ü������ ȸ���� ���� ó���� ���� ���� ���������� ������ ���� �� 
 �ٽ� ȸ���Ҷ��� �ý��۱��ѿ����� 131 ....�̷� ������ �ִٴ� �͸� �˾Ƶα� 
 
 132P ROLE ������ ���� 
 �� ����ڵ鿡�� �� �׷��� �ѿ��� ������ �شٸ� ��� ���õ� �ѿ��� �ִ� �� �߰��� �Ѵܰ踦 �����鼭 ���⼺�� ���δ�. 
 
 ����Ŭ�� ���� ������ ���ؼ� ������ �ϰ� �ִ�. 
 
 133P  ���� �����ϴ� ��� 
 ---------------------------------------------------------------------------------------------------��������� 
 �������� 
 1. �ý��۱��� : TABLE�� ����, VIEW ���� ����..
 2. ��ü ���� : Ư�� ��ü�� ���� SELECT, UPDATE, INSERT, DELETE ...
 
 ROLE : ������ ��Ƴ��� ����
 ����ں��� ���� ������ �ο��ϰ� �Ǹ� ������ �δ�. 
 Ư�� ROLE�� ������ �ο��ϰ� �ش� ROLE ����ڿ��� �ο�
 �ش� ROLE�� �����ϰ� �Ǹ� ROLE�� ���� �ִ� ��� ����ڿ��� ���� 
 
 ������ �ο�/ ȸ��
 �ý��� ���� : GRANT ���� �̸� TO ����� | ROLE;
       ȸ�� : REVOKE ���� �̸� TO ����� | ROLE;
 ��ü ���� : GRANT �����̸�  ON ��ü�� TO ����� | ROLE;
       ȸ�� :REVOKE �����̸� ON ��ü�� FROM ����� | ROLE;
 
 --------------------------------------------------------------
 ������ ��ųʸ� DATA DICTIONARY : ����ڰ� �������� �ʰ� DBMS�� ��ü������ �����ϴ� �ý��������� ���� VIEW
 �츮�� �ý����� �����Ҷ� ���������� �ʿ��� ���̺� �̷��� ������� ����Ŭ ��ü������ �����ϴ� �ý����� 
 �ش� ����ڰ� �����ִ� ������, �÷� �� �׷��� ��ųʸ��� ũ�� �װ����� �ִ� 
 135P 
 �츮�� ������
 
 DATA DICTIONARY : ����ڰ� �������� �ʰ� DBMS�� ��ü������ �����ϴ� �ý��������� ���� VIEW
 
 DATA DICTIONARY ���ξ�
 1. USER : �ش� ����ڰ� ������ ��ü
 2. ALL  : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷκ��� ������ �ο����� ��ü
 3. DBA  : ��� ������� ��ü 
 
 * V$ Ư�� VIEW; 
 
SELECT *
FROM USER_TABLES;
 
SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES;   --�̰� �Ϲݻ���� �� �� ����? 

DICTIONARY ���� Ȯ�� : DICTIONARY;

SELECT *
FROM DICTIONARY ;    --������ �Ǿ������� �ʤ����Ҷ� �˻����Ͽ� ���ϴ� ������ Ȯ���ϴ� ���� ���� ���̴�, 

���̾��� �༮�� 
137P;
��ǥ���� dictionary 
OBJECT : ��ü ���� ��ȸ (���̺�, �ε���, VIEW, SYNONYM..)
TABLE : ���̺� ������ ��ȸ
TAB_COLUMNS : ���̺��� �÷� ���� ��ȸ
INDEXES : �ε��� ���� ��ȸ ***************
IND_COLUMNS : �ε��� ���� �÷� ��ȸ *************
CONSTRAINT : �������� ��ȸ
CONS_COLUMNS : �������� ���� �÷� ��ȸ 
TAB_COMMENTS : ���̺� �ּ� ********
COL_COMMENTS : ���̺� �÷� �ּ�***********; 
SELECT *
FORM USER_OBJECTS;
137P ��ȸ��� 

emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ
user_indexes, user_ind_columns  join�ϱ� 
���̺��, �ε��� ��, �÷��� �÷�����
emp  ind_n_emp_04 ename
emp  ind_n_emp_04 job

SELECT *
FROM user_indexes;

SELECT table_name, index_name, column_name
FROM user_ind_columns
ORDER BY table_name, index_name, column_position;

SELECT a.table_name, a.index_name, b.
FROM user_indexes a, user_ind_columns b
WHERE a.index_name = b.index_name;

------------------------------------------------sql Ȱ�� ���� �� ---------------------
----------------���ݺ��ʹ� sql ���� -------------------------------------
2p 
��Ƽ�� �μ�Ʈ 
�̳༮�� �⺻������ �ѹ��� �μ�Ʈ�ؼ� �������̺� ������ �� �ִٴ� �� 
������ �����ϴ� �������ٸ� �� �� �ְ�, ������ �����ϴ� ù �κп��ٰ��� 

3p ������ �� ���� �ʾƼ� 
�ٷ� �ǽ��ϱ� ;

multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ�  DML;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

������ ���� ���� ���̺� ���ÿ� �Է��ϴ� multiple insert;
INSERT ALL 
    INTO dept_test                                  --�ȳ��� 
    INTO dept_test2
SELECT 98, '���', '�߾ӷ�' FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual; 


���̺� �Է��� �÷��� �����Ͽ� multiple insert;
ROLLBACK;
INSERT ALL          
    INTO dept_test (deptno, loc) VALUES( deptno, loc)                                 
    INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc  FROM dual UNION ALL
SELECT 97, 'IT', '����' FORM dual; 


�̹����� ���ǿ� ���� �����͸� �Է��غ����̴�
���̺� �Է��� �����͸� ���ǿ� ���� multiple insert
���ǿ� ���� �ϸ� 
CASE 
    WHEN ���� ��� THEN 
END;

ROLLBACK;
INSERT ALL 
    WHEN deptno = 98 THEN
        INTO dept_test (deptno, loc) VALUES( deptno, loc)
         INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc  FROM dual UNION ALL
SELECT 97, 'IT', '����' FORM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;


������ �����ϴ� ù��° insert�� �����ϴ� multiple insert

ROLLBACK;
INSERT FIRST     --������ �����ϴ� ù��°�� �����ϴ� ��  
    WHEN deptno >= 98 THEN
        INTO dept_test (deptno, loc) VALUES( deptno, loc)
    WHEN deptno >= 97 THEN     
        INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc  FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;


����Ŭ ��ü : ���̺� �������� ������ ��Ƽ������ ����
���̺� �̸��� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������
�и��� ������ �����͸� ���� ; 

dept_test  ==> dept_test_20200201 

INSERT FIRST     
    WHEN deptno >= 98 THEN
        INTO dept_test
    WHEN deptno >= 97 THEN     
        INTO dept_test2 20200202
    ELSE
        INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc  FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;


MERGE : ����  
���̺� �����͸� �Է�/���� �Ϸ��� �� 
1. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
   ==> ������Ʈ
2. ���� �Է��Ϸ��� �ϴ� �����Ͱ� �������� ������
   ==> INSERT
   

1. SELECT ����
2-1 SELECT �������� 0 ROW�̸� INSERT
2-2 SELECT �������� 1 ROW�̸� UPDATE

MERGE ������ ����ϰ� �Ǹ� SELECT �� ���� �ʾƵ� �ڵ����� ������ ������ ���� 
INSERT Ȥ�� UPDATE �����Ѵ�.
2���� ������ �ѹ����� �ش�. 

MERGE INTO ���̺�� (alias) 
USING (TABLE | VIEW | IN-LINE-VIEW)
ON (��������)
WHEN MATCHED THEN 
    UPDATE SET col = �÷���, col2 = �÷��� ...
WHEN NOT MATCHED THEN 
    INSERT (�÷�1, �÷�2, ...) VALUES (�÷���1, �÷���2...);

SELECT *
FROM emp;

SELECT *
FROM emp_test;

DELETE emp_test;

�α׸� �ȳ���� ==> ��, ������ �ȵȴ� ==> �׷��Ƿ� �׽�Ʈ������..
TRUNCATE TABLE emp_test;

emp���̺��� emp_tset ���̺�� �����͸� ���� (7365 - SMITH);

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'               --SQL ����: ORA-00913: too many values
FROM emp
WHERE empno = 7369;

�����Ͱ� �� ������ Ȯ��;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

emp ���̺��� ��� ������ emp_test ���̺�� ����
emp ���̺��� ���������� emp_test���� �������� ������ insert
emp ���̺��� �����ϰ� emp_test ���� �����ϸ� ename, deptno �� update;

emp ���̺� �����ϴ� 14���� �������� emp_test ���� �����ϴ� 7369�� ������ 13�� �����Ͱ� 
emp_test ���̺� �űԷ� �Է��� �ǰ�
emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown) �� emp���̺� �����ϴ� �̸��� SMITH�� ����;

MERGE INTO emp_test a
USING emp b
ON ( a.empno = b.empno)            --missing SET keyword"
WHEN MATCHED THEN
    UPDATE  SET a.ename=b.ename, 
                a.deptno=b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) VALUES (b.empno, b.ename, b.deptno);


SELECT *
FROM emp_test; 


�ش� ���̺� �����Ͱ� ������ insert, ������ update
emp_test ���̺� ����� 9999���� ����� ������ ���Ӱ� insert
������ update
(9999, 'brown', 10, '010');

INSERT INT dept_test (9999, 'brown', 10, '010')
UPDATE dept_test SET ename = 'brown'
                     deptno = 10
                     hp = '010'
WHERE empno = 9999;

MERGE INTO emp_test 
USING dual 
ON (empno = 9999)
WHEN MATCHED THEN 
    UPDATE SET ename = ename || '_u',
                deptno = 10
WHEN NOT MATCHED THEN 
    INSERT VALUES (9999, 'brown', 10);
    
 SELECT *
 FROM emp_test; 
 
 merge , window function (�м��Լ�) 
 
 13~15p merge ���� �ٽ� ���� 
------------------------------------------------------ 
 16p-17p ��� �׷��Լ�   (�ǽ�) 
 1.�μ����� �������հ�
 2.   ;
 
 SELECT *
 FROM emp;
 
SELECT  deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null,SUM(sal)
FROM emp;
---------------------------------------------------
18P
�ѹ� ȣ���ϴ� �ͺ��� ������ ���� 

I/O
CPU CACHE > RAM > SSD > HDD > NETWORK;

�׷���� ������ ����ȴٸ� 
19P ROLLOP 
�츮�� ���� ������ �ϴ� ���� 
REPORT GROUP FUNCTION
ROLLUP
CUBE
GROUPING; 

ROLLUP
����� : GROUP BY ROLLUP (�÷�1, �÷�2 ....)
SUBGROUP �� �ڵ������� ����
SUBGROUP �� �����ϴ� ��Ģ :�� ROLLUP�� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭 
                            SUB GROUP �� ���� 
EX : GROUP BY ROLLUP (deptno)
==>
ù��° sub groub : GROUP BY deptno
�ι�° sub groub : GROUP BY NULL ==> ��ü ���� ��� ; 

GROOP_ADI �� GROUP BY ROLLUP ���� ����Ͽ� �ۼ�;
SELECT deptno, SUM (sal)
FROM emp
GROUP BY ROLLUP (deptno);

19p ��� ��� 
    ������ �÷��� �ϳ��� �����ϸ� groub by�� �Ѵ� ;
    
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP BY job, deptno : ������, �μ��� �޿���
GROUP BY job : �������� �޿���
GROUP BY  : ��ü �޿��� ;



group ad2 �ǽ�  (case);
SELECT  CASE WHEN GROUPING (job) = 1 AND GROUPING(deptno) = 1 THEN '�Ѱ�'
            ELSE job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

 (decode);
SELECT  decode (GROUPING (job),1 AND GROUPING(deptno),1) AS '�Ѱ�'
            ELSE job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);



