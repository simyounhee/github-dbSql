1.PRIMARY KEY ���� ���� ������ ����Ŭ dbms�� �ش� �÷����� unique index�� �ڵ����� �����Ѵ�. 
 (***��Ȯ���� UNIQUE ���࿡ ���� UNIQUE �ε����� �ڵ����� �����ȴ�
    �׷��� PRIMARY KEY = UNIQUE + NOT NULL)
index : �ش� �÷����� �̸� ������ �س��� ��ü
������ �Ǿ��ֱ� ������ ã���� �ϴ� ���� �����ϴ��� ������ �� ���� �ִ�. 
���࿡ �ε����� ���ٸ� ���ο� �����͸� �Է��� �� �ߺ��Ǵ� ���� ã�� ���ؼ�
�־��� ��� ���̺��� ��� �����͸� ã�ƾ� �Ѵ�. 
������, �ε����� ������ �̹� ������ �Ǿ��ֱ� ������ �ش� ���� ���� ������ ������ �� �� �ִ�. 
 
 debt_test 
 
 ������ ã�� �� �ִ� ���� 
 2.FOREIGN KEY ���� ���ǵ� 
 �����ϴ� ���̺� ���� �ִ��� Ȯ���ؾ��Ѵ�.
 �׷��� �����ϴ� �÷��� �ε����� �־������ FOREIGN KEY ������ ������ ���� �ִ�.
 
 �ε������ ���� �ӵ� �������� ���� ���̱⶧���� ���� ���� ��ƴ�. 
 26P �ܷ�Ű ���ǻ��� 
 ���� �� ���� ���Ἲ ��������̺� �μ� �� �ִ� ������ ���� �μ��������� ���� 
 �μ����̺��� ���ڴٴ� �� 
 �׷��� �μ�
 �׷��� ����Ŭ������ �ӵ����� �̽��� �ε����� �ݵ�� �����ϵ��� ������ �����Ѵ� 
 �� �� ���������� �̾߱� �ϸ� 
 �����̸Ӹ�Ű������ ����� �ƴ϶� ����ũ���࿡ ���� ����ũ�ε����� �ڵ� �����Ǵ� ���̴�.
 
 FOREIGN KEY ������ �ɼ�
 ����Ű�� (���� ���Ἲ ) : �����ϴ� ���̺��� �÷��� �����ϴ� ���� �Է� �� �� �ֵ��� ����
 (����. emp ���̺� ���ο� �����͸� �Է½� deptno �÷����� dept ���̺� �����ϴ� �μ���ȣ�� �Էµ� �� �ִ� );
 
 foreign key�� �����ʿ� ���� �����͸� ������ �� �������� �ִ�
 ���� �� � ���̺��� �����ϰ� �ִ� �����͸� �ٷ� ������ �ȵȴ�.
 �� emp.deptno ==> DEPT.deptno �÷��� �����ϰ� ���� �� 
    �μ� ���̺��� �����͸� ���� �� ���� ���� 
-- ������� �ȵ�     

SELECT *
FROM emp_test; 

INSERT INTO dept_test VALUES (98, 'ddit2', '����');
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);
COMMIT;
emp : 9999, 99
dept : 98, 99
==> 98�� �μ��� �����ϴ� emp ���̺��� �����ʹ� ���� 
    99�� �μ��� �����ϴ� emp ���̺��� �����ʹ� 9999�� brown ����� ���� 
    
 ���࿡ ���� ������ �����ϰ� �Ǹ�; ���� ���Ἲ�� �����ϱ� ������ 9999�� 99�� �����ϱ� ������  
 DELETE dept_test
 WHERE deptno = 99; 
 �������ǿ� ���ؼ� ���谡 �Ǿ���. �θ� �־�� �ڽ��� �ִµ� ���� �θ� ���� ���ȱ� ������ 
 ���谡 �� ���̴�. emp���̺��� �η� �� ������Ʈ�� �ϰ� ������� ...;; 
 
 ���� emp ���̺��� �����ϴ� �����Ͱ� ���� 98�� �μ��� �����ϸ� ��� �ɱ� ? 
  DELETE dept_test
 WHERE deptno = 98; 
 �������̸� �ɾ��� �� 
 SELECT *
 FROM emp_test;
 
 FOREIGN KEY �ɼ� 
 1. ON DELETE CASCADE : �θ� ������ ���(dept) �����ϴ� �ڽ� �����͵� ���� �����Ѵ�(emp) ; --�����ؼ� �� �Ȥ���
 2. ON DELETE SET NULL : �θ� ������ ��� (deot)�����ϴ� �ڽ� �������� �÷��� null�� ����
 
 emp_test���̺��� DROP �� �ɼ��� ������ ���� ���� �� ���� �׽�Ʈ;
 
 DROP TABLE emp_test;
 CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10),
        deptno NUMBER(2),
        
        CONSTRAINT PK_emp_test PRIMARY KEY(empno),
        CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno)
                REFRENCES dept_test(deptno) ON DELETE CASCADE
        );
INSERT INTO emp_test VALUES (9999, 'brown' , 99);
COMMIT;
���� ��Ȳ�� �ٽ� �������ڸ� 
emp ���̺��� deptno �÷��� dept ���̺��� deptno �÷��� ���� (ON DELETE CASCADE)
�ɼǿ� ���� �θ����̺�(dpet_test)������ �����ϰ� �ִ� �ڽ� �����͵� ���� �����ȴ�.
DELETE dept_test
WHERE deptno = 99;

�ɼ� �ο����� �ʾ��� ���� ���� DELETE ������ ������ �߻�
�ɼǿ� ���� �����ϴ� �ڽ� ���̺��� �����Ͱ� ���������� ������ �Ǿ����� SELECT Ȯ��;

SELECT *
FROM emp_test ;

�̹����� �ι�° �ɼ� 
FK ON DELETE SET NULL �ɼ� �׽�Ʈ
�θ� ���̺��� ������ ������ (dept_test) �ڽ����̺��� �����ϴ� �����͸� null�� ������Ʈ;
 ROLLBACK;
 -- �� �� �� �� �� ����ִ��� dept dhk 
 SELECT *
 FROM dept_test;
 
 SELECT *
 FROM emp_test;
 DROP TABLE emp_test;
 CREATE TABLE emp_test(
        empno NUMBER(4),
        ename VARCHAR2(10),
        deptno NUMBER(2),
        
        CONSTRAINT PK_emp_test PRIMARY KEY(empno),
        CONSTRAINT FK_emp_test_dept_test FOREIGN KEY(deptno)
                REFERENCES dept_test(deptno) ON DELETE SET NULL
        );
INSERT INTO emp_test VALUES (9999, 'brown' , 99);
COMMIT;

dept_test ���̺��� 99�� �μ��� �����ϰ� �Ǹ� (�θ� ���̺��� �����ϸ� )
99�� �μ��� �����ϴ� emp_test ���̺��� 9999��(brown)�������� deptno�÷���
FK �ɼǿ� ���� NULL�� �����Ѵ�; 

DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

�θ� ���̺��� ������(���� dept_test) ���� �� �ڽ� ���̺��� �����Ͱ� NULL�� ����Ǿ����� Ȯ��; 

SELECT *
FROM emp_test;

29 �׷��� ���ݱ��� 

���ݤ��� 30ȥ�� �غ��� 
������ �ɼǿ� ���ؼ� �ѹ� �����ϸ鼭 �غ��� 

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2 (13)
    );


CHECK �������� : �÷��� ���� ���� ������ ������ �� ���
���� : �޿� �÷��� ���ڷ� ����, �޿��� ������ �� �� ������ ?
        �Ϲ����� ��� �޿����� > 0
        CHECK ������ ����� ��� �޿����� 0���� ū���� �˻� ����.
        EMP���̺��� job �÷��� ���� ���� ���� 4������ ���� ���� 
        'SALESMAN', 'PRESIDENT'. 'ANALYST', 'MANAGER';
        
 ���̺� ������ �÷� ����� �Բ� CHECK ���� ����
 emp_test ���̺��� sal �÷��� 0���� ũ�ٴ� CHECK �������� ����;
 
 INSERT INTO dept_test VALUES (99, 'ddit', '����');--�ؿ� (���� �ٽÿ����߻� ������) �̰Ÿ� �����߱⶧���� �׷��� �ٽ� �����ϱ�  
 
 DROP TABLE emp_test; 
 CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    sal NUMBER CHECK (sal > 0),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno)
            REFERENCES dept_test (deptno)
 );
 --���� �ٽ� ���� �߻� 
 INSERT INTO emp_test VALUES (9999, 'brown', 99, 1000);
 INSERT INTO emp_test VALUES(9998, 'sally', 99, -1000); (sal üũ���ǿ� ���� 0���� ū ���� �Է� ���� );-- ���ǿ� ���� �ʾƼ� sal NUMBER CHECK (sal > 0)�̰� ������ �����߻�
 
 31�÷� ��� �Ҷ��� �������� �̷��� ����Ѵٴ� ��  �������÷� ��� �Ҷ� ,�޸��� �� �־�����Ѵٴ� �� 
 34������ üũ �������� �̷������ε� �������� �� �� �ִٴ°��� �����ֽ� 
 �׷��� üũ������ �ܼ��� ���¹ۿ� �ȵǱ� ������ �������� Ȱ�뵵�� ���� �ʴ� 
 �׷��ٸ� ��񿡼� �̰��� �Ȥ��ǳ� �ڹٿ��� �̸� üũ�ؼ� �������� ���� ...;; 
 
 �״��� ���� ���� 35 ���� ���̺��� ���ؼ� ����Ʈ ��Ÿ�� 

���ο� ������ ����
CREATE TABLE ���̺�� ( 
    �÷�1 .....
    ); �̷������� �߾��µ� ; 
    
 CREATE TABLE ���̺�� AS
 SELECT ����� ���ο� ���̺�� ������ ���� �ϴ� ; 
 
 ���� ��� 
 emp ���̺��� �̿��ؼ� �μ���ȣ�� 10�� ����鸸 ��ȸ�Ͽ� �ش� �����ͷ� 
 emp_test2 ���̺� ����;
 
 �ϴ� emp ���̺��� �μ���ȣ�� 10���� ����鸸 ��ȸ�غ��� 
SELECT *
FROM emp
WHERE deptno = 10; 
�׷� �� ������ �����ͷ� ���̺��� ������ 
CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE deptno = 10;
--Ȯ���غ��� 
SELECT *
FROM emp_test2;

35 ��ũ�� ����� ���� ���̺��� �����ϰ� �Ǹ� 36 ���θ� ������ �׷��� �̰� �����Ҷ� ������ ����� �׽�Ʈ �����Ҷ� ����Ѵ�. ����� ���� �ϰ� ������ 
�׷��� ���� ���
SELECT *
FROM emp_20200210; ������Ʈ �ؾ��ϴµ� �Ҿ��ؼ� �׳� ��¥�� ���缭 ���̺��� ������ �� �� ����� �س������̴� ; ������ ���⿣ ���� �ʴ� ���� �ƴϴ� ;
CREATE TABLE emp_20200210 AS

�׷��� �̹��ִ� ���̺�� ����� �����ϴٸ� �̷��� ��뤾�� �Ѵ�. 

CREATE TABLE emp_test3 AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 10;

�׸��� �� ���� ������ 35 ���̺� �� ���� �̸��� ��� �� �� �ִ� dept_test(      ) ������ ���־��� ���� ���� �ϱ� 
���⼭�� �׳� ���������� ����� �ִٴ� �� ;

������ 37 ������ ���ؼ� �츮�� ���������� ...
TABLE ����
1.�÷� �߰�
2. �÷� ������ ����, Ÿ�Ժ���
3.�⺻�� ���� 
4.�÷����� RENAME
5.�÷��� ����
6. �������� �߰�/����;

TABLE ���� 1.�÷� �߰� (HP VARCHAR2 (20)); 

DROP TABLE emp_test;
--������
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
    );
    
ALTER TABLE ���̺�� ADD (�ű��÷��� �ű��÷� Ÿ��); 
    
ALTER TALBE emp_test ADD (HP VARCHAR2(20));
DESC emp_test;
    
SELECT *
FROM emp_test;


TABLE ���� 2.�÷� �������, Ÿ�Ժ���
������ �� �� �Ⱦ� �ֳĸ� 
�� : �÷� VARCHAR2(20) ==> VARCHAR2(5)
    ������ �����Ͱ� ������ ��� ���������� ������ �ȵ� Ȯ���� �ſ� ���� �����̴�. 
    �׷��� �Ϲ������δ� �����Ͱ� �������� �ʴ� ����, �� ���̺��� ������ ���� �÷��� ������, Ÿ���� �߸� �� ���
    �÷� ������, Ÿ���� �����Ѵ�.
    
    �����Ͱ� �Էµ� ���ķδ� Ȱ�뵵�� �ſ� ��������. (������ �ø��� �� ���������� �� �ܴ� �ȵȴٴ� �� @!);
 
 DESC emp_test;
 hp VARCHAR(20) ==> HP VARCHAR(30);
 
 ALTER TABLE ���̺�� MODIFY (���� �÷��� �ű� �÷� Ÿ�� (������));
 ALTER TABLE emp_test MODIFY (HP VARCHAR2(30));
 DESC emp_test;
 ----------------------
 �̸�     ��?       ����           
------ -------- ------------ 
EMPNO  NOT NULL NUMBER(4)    
ENAME           VARCHAR2(10) 
DEPTNO          NUMBER(2)    
SAL             NUMBER   
-----------------------------

�÷� Ÿ�� ����
hp VARCHAR2 (30) ==> HP NUMBER;
������ �����Ͽ�
ALTER TABLE emp_test MODIFY(HP NUMBER);

DESC emp_test;

�÷� �⺻�� ����; 
ALTER TABLE ���̺�� MODIFY (�÷��� DEFAULT �⺻��);

HP NUMBER ==> HP VARCHAR(20) DEFAULT '010';
ALTER TABLE emp_test MODIFY (HP_N VARCHAR2(20) DEFAULT '010');
DESC emp_test;

hp�÷����� ���� ���� �ʾ����� DEFAULT ������ ���� '010' ���ڿ��� �⺻������ ����ȴ�; 
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown' , 99);

SELECT *
FROM emp_test;

TABLE 4.����� �÷� ���� 
�����Ϸ��� �ϴ� �÷��� FK����, PK������ �־ ��������� �̸��ٲٴ� �Ϳ� �Ű澲���� 
ALTER TABLE ���̺�� RENAME COLUMN ���� �÷��� TO �ű� �÷���;
HP ==> HP_n;

ALTER TABLE emp_test RENAME COLUMN HP TO HP_n;
SELECT *
FROM emp_test;

ALTER TABLE emp_test ADD (HP VARCHAR2(20));

DELETE emp_test
WHERE deptno = 99;


------------
SELECT *
FROM emp_test;

���̺� ���� 5. �÷�����
ALTER TABLE ���̺�� DROP COLUMN �÷���
emp_test ���̺��� hp_n �÷� ����; 

emp_test�� hp_n �÷��� �ִ� ���� Ȯ��;
SELECT *
FROM emp_test;

ALTER TABLE emp_test DROP COLUMN hp_n;

emp_test hp_n �÷��� �����Ǿ����� Ȯ��;

SELECT *
FROM emp_test;

***************************************************************<����>;
1.emp_test ���̺��� drop�� �� empno, ename, deptno, hp 4���� �÷����� ���̺� ���� 
2.empno, ename , deptno 3���� �÷����� (9999, 'brown', 99)�����ͷ� INSERT 
3.emp_test ���̺��� hp �÷��� �⺻���� '010'���� ����
4.2�� ������ �Է��� �������� hp �÷� ���� ��� �ٲ���� Ȯ�� (�׷��� ���� �ٲ��� ���� ���̴�)
**********************************************************************************

TABLE ���� 6.�������� �߰�/ ����; 
ALTER TABLE ���̺�� ADD CONSTRAINT �������Ǹ� ��������Ÿ�� (PRIMARY KEY, FOREIGN KEY) (�ش��÷�);
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ�; 

1.emp_test ���̺� ���� �� 
2.�������� ���� ���̺� �����ϱ�
3. PRIMARY KEY, FOREIGN KEY ������ ALTER TABLE ������ ���� ����;
4. �ΰ��� �������� �׽�Ʈ 
DROP TABLE emp_test;

CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER (2));

ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_dept_test FOREIGN KEY (deptno) REFERENCES  dept_test (deptno);

PRIMARY KEY �׽�Ʈ;
INSERT INTO emp_test VALUES (9999, 'brown' , 99);
INSERT INTO emp_test VALUES (9999, 'sally' , 99); ù��°  INSERT ������ ���� �ߺ��ǹǷ� ����;


FOREIGN KEY �׽�Ʈ; 
INSERT INTO emp_test VALUES (9998, 'sally', 98); dept_test ���̺� �������� ���� �μ���ȣ�̹Ƿ� ����;

�������� ���� : PRIMARY KEY, FOREIGN KEY;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_dept_test;

���������� �����Ƿ� empno �� �ߺ��� ���� �� �� �ְ�, dept_test ���̺� �������� ���� 
deptno ���� �� ���� �ִ�;

INSERT INTO emp_test VALUES (9999, 'brown' , 99);
INSERT INTO emp_test VALUES (9999, 'sally', 99);

�������� ���� 98���μ��� ������ �Է�;
INSERT INTO emp_test VALUES (9998, 'sally', 98);

SELECT *
FROM emp_test;

���ͷ� �����̸Ӹ� , ���� ���� 
������ 
NOT NULL, CHECK, UNIQUE         42 üũ�� üũ���� �Լ��� ���� ��� �̸��� �����ڰ� �Ѿ���ϴ� ���� ������ �����ϱ⿡ 
                                ������ Ű����� ���� ���⿡ ���̺� ������ �� ���� ���� �� �÷��� ���ؼ� ������ �߰� �� 
                                �������� ���� 
                                43 �������� ���� ���� STATUS�� �� �� ���� ���̴�. �츮�� ���࿡ ���������� �����ϰԵǸ� �ٽ� ��������
                                ��� �׽�Ʈ������ ���� ������ �̰� �츮������� ��Ȱ��ȭ ���״ٰ� Ȱ��ȭ ��Ű��� 
 
 �������� Ȱ��ȭ/ ��Ȱ��ȭ;
 ALTER TABLE ���̺�� ENABLE | DISABLE CONSTRAINT �������Ǹ�;
 
 1.emp_test ���̺� ����
 2.emp_test ���̺� ����
 3.ALTER TABLE PRIMARY KEY(empno), foreign key(dept_test deptno) �������� ����
 4. �ΰ��� ���������� ��Ȱ��ȭ
 5.��Ȱ��ȭ�� �Ǿ����� insert �� ���� Ȯ��
 6.���������� ������ �����Ͱ� �� ���¿��� �������� Ȱ��ȭ; 
 
 DROP TABLE emp_test;
 
 CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) );
    
ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test primary key (empno);    
ALTER TABLE emp_test ADD CONSTRAINT fk_emp_test primary key (empno)
                                            REFERENCES dept_test (deptno);
                                           
ALTER TABLE emp_test DISABLE CONSTRAINT PK_emp_test;
ALTER TABLE emp_test DISABLE CONSTRAINT fK_emp_test_dept_test;

INSERT INTO emp_test VALUES (9999, 'brown', 99);
INSERT INTO emp_test VALUES (9999, 'sally', 98);
commit;

SELECT *
FROM emp_test;
emp_test ���̺��� empno �÷��� ���� 9999�� ����� �θ� �����ϱ� ������ 
primary key ���������� Ȱ��ȭ �� �� ����.
==> empno �÷��� ���� �ߺ����� �ʵ��� �����ϰ� �������� Ȱ��ȭ �� �� �ִ�;
ALTER TABLE emp_test ENABLE CONSTRAINT PK_emp_test;
ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;   --ALTER TABLE emp_test DISABLE CONSTRAINT PK_emp_test�ߺ��� �����Ͷ����� 

empno �ߺ� ������ ����;
DELETE emp_test
WHERE ename = 'brown';

primary key ��������Ȱ��ȭ;
ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;

SELECT *
FROM emp_test;

dept_test ���̺� �������� �ʴ� �μ���ȣ 98�� emp_test���� �����
1.dept_test ���̺� 98�� �μ��� ����ϰų�
2.sally�� �μ���ȣ�� 99������ �����ϰų�
3.sally�� ����ų�; 

update emp_test set deptno = 99
where ename = 'sally';

alter table emp_test enable constraint fk_emp_test_dept_test;
commit;

ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;