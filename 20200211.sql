�������� Ȯ�� ���
1. tool
2. dictionary view
�������� : USER_CONSTRAINTS
��������-�÷� : USER_CONS_COLIMNS
���������� ��� �÷��� ���õǾ� �ִ��� �� �� ���� ������ ���̺��� ������ �и��Ͽ� ����

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');

2.EMP, 'DEPT', 'PK', 'FK'������ �������� ���� 
���̺� �������� �������� �߰� ; 
3.EMP : PK (empno)
      fk (depno) - dept.deptno 
      (fk ������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ��Ѵ�)

1.dept : pk (deptno);      

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);
ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);


���̺�, �÷� �ּ� : DICTIONARY �� Ȯ�� �����ϴ�
���̺� �ּ� : USER_TAB_COMMENTS
�÷� �ּ� : USER_COL_COMMENTS;

�ּ�����
���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
�÷� �ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�';

emp : ����
dept : �μ�; 

COMMENT ON TABLE emp IS '����';
COMMENT ON TABLE dept IS '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ( 'EMP', 'DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

DEPT	DEPTNO : �μ���ȣ	
DEPT	DNAME  : �μ���	
DEPT	LOC	   : �μ���ġ
EMP	EMPNO	   : ������ȣ
EMP	ENAME	   : �����̸�
EMP	JOB	       : ������
EMP	MGR	       : �Ŵ��� ������ȣ
EMP	HIREDATE   : �Ի�����	
EMP	SAL	       : �޿�
EMP	COMM	   : ������
EMP	DEPTNO	   : �ҼӺμ���ȣ 

���Ѱ��� �÷��� �ѹ� ������ ;

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';

COMMENT ON COLUMN emp.empno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ������ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';




--47P DDL(TALE-comments �ǽ� comment1)   [����] --------------------------------------------------------------
SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ( 'EMP', 'DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

SELECT t.table_name, t.table_type, t.comments AS tab_comment, c.column_name, c.comments AS col_comment
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name
AND t.table_name IN ('CUSTOMER', 'PRODUCT', 'CYCLE', 'DAILY');
------------------------------------------------------------------------------------------------------

View (48~49p)
����ڿ��� �Ⱥ����ְ� ���� �� ����Ѵ�.(����.�޿����� �ΰ��� ���� )
�÷��� ��ȸ�ϰ� ���� �� �並 ����Ѵ� 
�׸��� �÷��� �����ϴ� �� �Ӹ��ƴ϶� ���� ���̸� ��Ȱ���� ���� �ְ� ���̸� �����ų ���� �ִ� 
�並 �ѹ� ����� ���ž� 
VIEW ���� : ��� ����(QUERY)�̴�.  [VIEW=TABLE (X) ]
            TABLE ó�� DBMS�� �̸� �ۼ��� ��ü�̴�. 
            ==>�ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVIEW ==> �̸��� ���� ������ ��Ȱ���� �Ұ�

������ 
1. ���� ����(Ư�� �÷��� �����ϰ� ������ ����� �����ڿ��� ����)
2. INLINE-VIEW�� VIEW�� �����Ͽ� ��Ȱ��
   .���� ���� ����
   
�������
CREATE [OR REPLACE] VIEW ���Ī [(COLUMN1,COLUMN2 ....)] AS
SUBQUERY;

emp ���̺��� 8���� �÷� �� sal, comm �÷��� ������ 6�� �÷��� �����ϴ� v_emp VIEW ����;

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno   
FROM emp;
 --���� : insufficient privileges ������� ��ȯ �׷��Ƿ�
�ý��� �������� sim�������� VIEW �������� �߰��� �ؾ��Ѵ�.;
GRANT CREATE VIEW TO SIM;       --<-�ý����� �����ؼ� �ؾ� ������ �����ϴ� ������ ���ϰ� ���� �ý��� ������ �ٷ� ��������������Ѵ� 
                                   -- �� ���� ���� �������� �ٲ��ֱ� 
                                   --���� ���� CREATE ������ �� ���̴�. 
                                   
���� �ζ��� ��� �ۼ���;                                   
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp;)
      
VIEW ��ü Ȱ��;     
SELECT *
FROM v_emp;

emp���̺��� �μ����� ���� ==> dept ���̺�� ������ ����ϰ� ����
���ε� ����� view �� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ� �� �����ϴ� ;

VIEW : v_emp_dept
dname(�μ���), empno(������ȣ), ename(�����̸�), job(������), hiredate(�Ի�����);

CREATE OR REPLACE VIEW v_emp_dept AS                              
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate      --�� ¥�����ֳ� ������ �� �����ϱ�
FROM emp, dept
WHERE emp.deptno = dept.deptno;

�ζ��� ��� �ۼ���;
SELECT *
FROM (SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate     
      FROM emp, dept
      WHERE emp.deptno = dept.deptno);
      
VIEW Ȱ���;
SELECT *
FROM v_emp_dept;

���� �̿��� ���̺� ���̽��� ����� �Ǹ� ������ �ʴ´� �� ������ ��� �����̱� �����̴�. �׷��� 
SELECT *
FROM v_emp_dept;    --�� 14�� �׷���

SMITH ���� ���� �� v_emp_dept view �Ǽ� ��ȭ�� Ȯ��;
DELETE emp
WHERE ename = 'SMITH' ;

55P �׳� �����̸� �������� �����Ͱ� �ƴ϶� ������ �������̴�. �׷��� �䰡 �����ϴ� ���̺��� �����ϸ� �� �信�� ������ ��ģ��. 
VIEW�� �������� �����͸� ���� �ʰ�, ������ �������� ���� ����(SQL)�̱� ������
VIEW���� �����ϴ� ���̺��� �����Ͱ� ������ �Ǹ� VIEW�� ��ȸ������� ������ ��ģ��;

ROLLBACK;

56P
���� ���� 
�Լ��� �����ϴ��Ŀ� ���� 
�׷��Լ��� ����ϸ� ���÷������ �ϰ� �ƴϸ� ���� 
�並 ���� ���� ����� ������ �Ϲ������� ����������, ���÷����� �Ұ����� ��찡 ����
�Ϲ������� �信 ������Ʈ�ϴ� �͵� �����ϴ� �� ���� 

�׷��� �信 �𿥿� �� �� �ִµ� ���÷����� �ȵ�����
�׷���� 57 �̰͵��� �ȵȴ� 

58P SEQUENCE :  ���� �긦 ���ٰ� ���� ? 
             �׻� ���еǴ� ���� �ʿ��ϴ� �׷��� ������ ���� ����� ����� �� 3���� �̴�. 
             ���̺��� ���ڿ� �� ����� ���°� 
             �׸��� ��� ���θ� ����� �� (������ ���� �Ƚ�� ���� �ֽŵ����͸� ���� ���� )
             1.KEY
             �б� �ϰ��� ���� �а� ������ ������Ʈ�������ϰ� ���� ���� �ϴ°� ��, �б⸸�ϰ� ���� ���ϰ� �ϴ� ���� �ִ� 
             2. UUID���̵� �ڹٱ�ɿ��� ���� ���ε��Ҷ� ���� ����. 
                            ����������� ���� ���ε带 �ϰ� �Ǹ� 
                           �����α׷��� �Ҷ� ���� �� ���̴�. ����� ���� ���̺귯���� ����. 
            3.sequence ����Ŭ���� �����ϴ� ���� �� ��ü�� ���ؼ� ������ ������ �� �ִ�. 
                      59p �׷��� ������ ���� ���� �������ִ� ����Ŭ ��ü�� pk���÷��� ���Ƿ� ������ �� �ִ� 
                      60p ������ �������� �����ϴ� ^^ 
                      
                      
SEQUENCE  : ������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
CREATE SEQUENCE ������_�̸�
[OPTION....]
����Ģ : SEQ_���̺��

emp ���̺��� ����� ������ ����;

CREATE SEQUENCE seq_emp;    --������ ���ΰ�ħ ���ŵȰ� ���ϰ��� ������ 
****************************************************
CREATED	2020/02/11
LAST_DDL_TIME	2020/02/11
SEQUENCE_OWNER	SIM
SEQUENCE_NAME	SEQ_EMP
MIN_VALUE	1
MAX_VALUE	9999999999999999999999999999
INCREMENT_BY	1     --1�� �����Ѵٴ� �� �� ��� �Ⱦ� 
CYCLE_FLAG	N         --1���� �ݺ��� �� ���̳� ����� �� ������ �Ϲ������� �ƽ����� �ʹ� Ŀ�� �ݺ����� �ʴ´� . 
ORDER_FLAG	N
CACHE_SIZE	20
LAST_NUMBER	1         --���������� ������ �� 
************************************************************
���⼭ �������� �������ִ� �Լ��� 
NEXTVAL : ���������� ���� ���� �����ö� ���
CURRVAL : NEXTVAL �� ����ϰ��� ���� �о� ���� ���� ��Ȯ��;

SELECT seq_emp.NEXTVAL
FROM dual; 

SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'james', 99, '017');

������ ������
ROLLBACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´�.
NEXTVAL�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����;
�ð������� �߿��ϴٸ� �ٸ��� ���������, �������� ����ϰԵǸ� ������ �� ���� �� �ִٴ� �� 
;

64~65P ĳ�� ��ŷ���� ���ÿ� ������ ���� �ϴ� �� �̰��� �޸𸮿� �̸� �÷����� ���� ���� ������ �ؼҽ�ų �� �ִ�. 
            �̸� �о �ִ� �� �о���̴µ� �ð��� ���̴°�
66P ������� ���� ����ڰ� ���� �Ǹ� ó���ϱⰡ �Ұ��� �ϴ� 
    ����Ŭ�� �ִ밪���� ���޽� �ּҰ����� �ٽ� �����ϴ� �� 
    

�ε��� ��� ���� ��������� ���� �����ټ����� �����س����� Ư�� �ܾ ã���� �Ҷ� ã�� �� 
�ٸ� �ε����� 
69P �ε����� �� �������� �˾ƺ��� 
���̺��� �Ϻ��÷����� ������ ������ ���̴� 
���̺��� row�� ����Ű�� �ּҸ� ������ �ִ� (ROWID)
���ĵ� �ε����� �������� �Ͽ� �ο��� ��ġ�� ������ �˻��Ͽ� ���ϴ� �࿡ ������ ������ �� �ִ� 
�׷��� �����Ͱ��� �ٲ�� �ε��� ������ ������ �ȴٴ� �� 
�׿� ���� 
70P ���̺��� �Է¼����� �����Ϳ� ������ ���Ѵ�. 
    �׷��� �߰��� �� ���� �ִ�. 
    �׸��� ���U ���̺��� �� �� ��
    
    �ε����� �ּ����� �б⸦ ���� ���� ���ϴ� �����͸� �а� ���� �� ���� ã�� ���� �� ����Ѵ�. 
    �׷��� �츮�� ���ݱ��� �ε����� ��� ���ߴٸ� 72ó�� ������ ����ڿ��� ������ �ƴϸ� �Ⱥ����� ... 
    �а� ������ �ƴϸ� ���� �ʿ��� �κи� ã���� 
    ���̳ʸ�Ʈ�� 73P ������ Ŭ���� ���������� Ʈ���� ���� ==> 
    ������ �ε����� ������ 75P 
  
�ε����� ������ empno ������ ��ȸ�ϴ� ���;
emp���̺��� pk_emp ���������� �����ؼ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ����� ���̴�;

ALTER TABLE emp DROP CONSTRAINT pk_emp;     --�ε����� ���� ����
-------------------------------------------------------------------����δ� ;; 
explain plan for 
SELECT *
FORM emp
WHERE empno = 7782;
  
SELECT *
FROM TABLE (dbms_explain --��75p ���� 



emp ���̺��� empno �÷����� pk������ �����ϰ� ������ sql�� ����
pk : UNIQUE + NOT NULL
    (UNIQUE �ε����� �������ش�)
==> empno �÷����� unique �ε����� ������

�ε����� sql�� �����ϰ� �Ǹ� �ε����� ���� ���� ��� �ٸ��� ������ Ȯ��;

ALTER TABLE emp ADD CONSTRAINT PK_emp  PRIMARY KEY (empno);

SELECT RO
  
INDEX;

SELECT ROWID, emp.*
FROM emp; 

SELECT *
FROM  emp
WHERE ROWID = 'AAAE5uAAFAAAAD8AAH'  --�������� ����


SELECT empno, rowid
FROM emp
ORDER BY empno ;

SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE


SELECT *
FROM emp
WHERE ename = 'SMITH';    --Ȱ���� �� �ִ� �ε����� ���� �� �ֳ��ϸ� ......�̤̤̤̤̤̤̤̤̤̤�
77~78P �̿��ǿ��� �� ���� ���ϰ� �Ǹ� Ȱ���� �� ���� �ε����� �߰����� ���߱⶧���� ���̺��� ....�ش����̺� 

78

SELECT ��ȸ �÷��� ���̺� ���ٿ� ��ġ�� ���� ;
SELECT * FROM emp WHERE empno = 7782
==>
SELECT empno FROM emp WHERE empno = 7782;

explain plan for
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_x
7782�� ������ȣ�� ���� ������ ���� �˰� ���� �÷��� empno�ۿ� �𸦶�  �̷� ����Ť��� ��Ƽ��79p�� ���������� �� �о�� !!!!!!!

�״������� ���� �ٸ� ���¸� �����ֽǰǵ� 
�����̸Ӹ� �����̵Ǵ� �ε����� ����ũ�ε����̴� 
�ε����� ���ϼ� ������ ���� �ٸ��� 
������ũ�͵����� �غ����̴� ;

UNIQUE   VS  NON-UNIQUE �ε����� ���� Ȯ���� 
1.PK_EMP ����
2.EMPNO �÷����� NON-UNIQUE �ε��� ����
3. �����ȹ Ȯ��; 

ALTER TABLE emp DROP CONSTRAINT PK_emp;      
CREATE INDEX idx_n_emp_01 ON emp (empno);

explain plan for
SELECT *
FROM emp 
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms

80p ���� ������ũ�ε����ϰ�� 

�̰Ÿ� ����ȭ - 81p �о�� �� !!!!

�׸��� �ε����� ���̺� ������ ���� �� �ֱ⿡ ��  �÷� �������� �� ����ũ�� �������̴� 
emp ���̺� job �÷��� �������� �ϴ� ���ο� non-unique�ε����� ����;

CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

���ð����� ����
1.emp ���̺��� ��ü �б�
2.idx_n_emp_01(empno) �ε��� Ȱ��
3.idx_n_emp_02 �ε��� Ȱ��;    --���� ���ϴ� �ε��� ��� �� �־ 3��°�� ���� 

explain plan for
SELECT *
FROM emp
WHERE job = 'MANAGER' 

SELECT *
FROM TABLE (dbms_xplain.display);    -- �̰��� ����ȭ �ϰ� �Ǹ� 82p    �Ŵ����� ������ ���� ������ ��� ���� ���̴� ���ǿ����ؼ���
                                     --           ����ڿ��� �����ִ°� 
                                     
                                     