62p
�������� ����Ŭ������ ���������� ���� ������ 64p
�ó�������� �������°� Ʈ���� Ž���ϰ� �츮�� �����͸� ���� �� 

lpad 
---------------------------������� ���� 
�̹����� ����� �������� (leaf ==> root node(���� node))
��ü ��带 �湮�ϴ°� �ƴ϶� �ڽ��� �θ��常 �湮 ( ����İ� �ٸ��� ) 
������ : ��������
������ : �����μ� 

SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1) * 4 )||deptnm  deptnm
FROM dept_h
START WITH deptnm = '��������'
CONNECT BY PRIOR p_deptcd = deptcd ;        75p

����Ŭ������ Ʈ�������� pre order �̶�� �� ;


------------------------------------------------------------------------
�ǽ� h_4;
**************************************************************
create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;
*************************************************************
SELECT  LPAD(' ', (LEVEL -1) * 4 ) || s_id s_id, VALUE
FROM h_sum
START WITH s_id = 0
CONNECT BY PRIOR s_id = ps_id;

�ǽ� h_5
*********************************************************
create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;
*************************************************************
SELECT * 
FROM no_emp;

SELECT LPAD(' ', (level-1)*5) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;
----------------------------------------------------------------
82p ����ġ�� ����� 2������ �ִ� 
5�� �ǽ������� �ѹ� ������ ������ 
������ ������ �� ���� ���� ��� ��ġ�� ���� ��� ��(pruning branch -����ġ��)
FROM => START WITH, CONNECT BY => WHERE
1.WHERE : ���� ������ �ϰ� ���� ���� ����
2.CONNECT BY : ���� ������ �ϴ� �������� ���� ����; 

WHERE �� ����� : �� 9���� ���� ��ȸ�Ǵ� �� Ȯ��
WHERE �� (org_cd != '������ȹ��' ) : ������ȹ�θ� ������ 8���� �� ��ȸ�ϴ� �� Ȯ��;

SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY ���� ������ ��� ;

SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd AND org cd != '������ȹ��';

83p
84p �������������� ����� �� �ִ� 3���� �Լ��� �ִ� 
-connect_by_root(�÷�) -�ش�ο쿡�� �ֻ��� �������� �÷� ���� ��ȸ �Ҷ�  ��
-sys_connect_by_path(�÷�, ������) : �� ���� �� ���� ��� 71p ���θ� ���� ǥ���Ѱ� 
-CONNECT_BY_ISLEAF :�ڽ��� �ִ��� ������ ǥ�����ִ� ���� �̰͵� �����ϰ� ���϶��� �ִ� 

-
1.connect_by_root(�÷�) : �ش� �÷��� �ֻ��� ���� ���� �˰� ������ ����  
                        ; 
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root 
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd ;

2.sys_connect_by_path(�÷�, ������) : �ش� ���� �÷��� ���Ŀ� �÷� ���� ��õ, �����ڷ� �̾��ش�
                                     �ڱ� ���� �ֵ� ���� �׻� �����ڿ� ���� �־��ش�  ;
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM (SYS_CONNECT_BY_PATH(org_cd, '-'), '-' )path
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd ;

3.CONNECT_BY_ISLEAF : �ش� ���� LEAF �������(����� �ڽ��� ������)���� ���� ( 1 : leaf , 0 : no leaf) 
                                        ;
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM (SYS_CONNECT_BY_PATH(org_cd, '-'), '-' )path,
        CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH ORG_CD = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd ;      

87p �Խñ� 
�ǽ� h6
*********************************************************
?create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;
************************************************************
SELECT *
FROM board_test;

SELECT seq, lpad(' ', (level-1)*4) || TITLE  title
FROM board_test
START WITH PARENT_seq IS NULL 
CONNECT BY PRIOR seq = parent_seq
;
-----------------------------------------------------------------------------------
�ǽ� H7

90P�������¸� �����ؼ� ������ ������ �� �̾߱� 
�ǽ� H8
92- 93P ���� �ֽű� �ö���� �ϴ� �� order siblings by
94P �θ�� �ֻ����� ���ʿ� �ִ� ��۵��� ������� ������������ �ϴ� ��� 95Pó�� ���;��� 

SELECT seq, lpad(' ', (level-1)*4) || TITLE  title
FROM board_test
START WITH PARENT_seq IS NULL 
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

�׷��ȣ�� ������ �÷��� �߰� ;
ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN (4, 5, 6, 7, 8, 10, 11);

UPDATE board_test SET gn = 2
WHERE seq IN (2, 3);

UPDATE board_test SET gn = 1
WHERE seq IN (1, 9);

COMMIT;

SELECT gn, seq, LPAD(' ', (LEVEL -1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;

SELECT gn, seq, LPAD(' ', (LEVEL -1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;
-----------------------------------------------------------------------------------
5000�޴� ����� �̸��� �ñ��Ҷ��� 
SELECT ename, MAX(sal)
FROM emp
WHERE sal =(SELECT MAX(sal)
            FROM emp);

98p
�ش� ���� ������ �Ѿ� �ٸ� ������ �����ϴ� 

99p �μ��� �μ��޿���ŷ�� ���ϰ� ������ (http://www.gurubee.net/lecture/1284 �����ϱ� ^0^);
SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_rank
FROM emp
ORDER BY deptno; 
--������ ��� (ing..)
SELECT *
FROM
(SELECT LEVEL lv
FROM dual
CONNECT BY LEVEL <= 14) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno)b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv;

