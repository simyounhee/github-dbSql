62p
계층쿼리 오라클에서는 계층쿼리에 대한 문법을 64p
시나리오대로 내려오는것 트리를 탐색하고 우리가 데이터를 봤을 때 

lpad 
---------------------------여기까지 복습 
이번에는 상향식 계층쿼리 (leaf ==> root node(상위 node))
전체 노드를 방문하는게 아니라 자신의 부모노드만 방문 ( 하향식과 다른점 ) 
시작점 : 디자인팀
연결은 : 상위부서 

SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1) * 4 )||deptnm  deptnm
FROM dept_h
START WITH deptnm = '디자인팀'
CONNECT BY PRIOR p_deptcd = deptcd ;        75p

오라클에서는 트리구조가 pre order 이라는 것 ;


------------------------------------------------------------------------
실습 h_4;
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

실습 h_5
*********************************************************
create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XX회사', null, 1);
insert into no_emp values('정보시스템부', 'XX회사', 2);
insert into no_emp values('개발1팀', '정보시스템부', 5);
insert into no_emp values('개발2팀', '정보시스템부', 10);
insert into no_emp values('정보기획부', 'XX회사', 3);
insert into no_emp values('기획팀', '정보기획부', 7);
insert into no_emp values('기획파트', '기획팀', 4);
insert into no_emp values('디자인부', 'XX회사', 1);
insert into no_emp values('디자인팀', '디자인부', 7);

commit;
*************************************************************
SELECT * 
FROM no_emp;

SELECT LPAD(' ', (level-1)*5) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;
----------------------------------------------------------------
82p 가지치기 방법엔 2가지가 있다 
5번 실습과제로 한번 예제를 만들어보자 
계층형 쿼리의 행 제한 조건 기술 위치에 따른 결과 비교(pruning branch -가지치기)
FROM => START WITH, CONNECT BY => WHERE
1.WHERE : 계층 연결을 하고 나서 행을 제한
2.CONNECT BY : 계층 연결을 하는 과정에서 행을 제한; 

WHERE 절 기술전 : 총 9개의 행이 조회되는 것 확인
WHERE 절 (org_cd != '정보기획부' ) : 정보기획부를 제외한 8개의 행 조회하는 것 확인;

SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY 절에 조건을 기술 ;

SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd AND org cd != '정보기획부';

83p
84p 계층쿼리에서만 사용할 수 있는 3가지 함수가 있다 
-connect_by_root(컬럼) -해당로우에서 최상위 데이터의 컬럼 정보 조회 할때  ㅊ
-sys_connect_by_path(컬럼, 구분자) : 를 많이 씀 예를 들면 71p 어떤경로를 따라 표현한것 
-CONNECT_BY_ISLEAF :자식이 있는지 없는지 표현해주는 아이 이것도 유용하게 쓰일때가 있다 

-
1.connect_by_root(컬럼) : 해당 컬럼의 최상위 행의 값을 알고 싶을때 쓰임  
                        ; 
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root 
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd ;

2.sys_connect_by_path(컬럼, 구분자) : 해당 행의 컬럼이 거쳐온 컬럼 값을 추천, 구분자로 이어준다
                                     자기 값이 있든 없든 항상 구분자에 값을 넣어준다  ;
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM (SYS_CONNECT_BY_PATH(org_cd, '-'), '-' )path
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd ;

3.CONNECT_BY_ISLEAF : 해당 행이 LEAF 노드인지(연결된 자식이 없는지)값을 리턴 ( 1 : leaf , 0 : no leaf) 
                                        ;
SELECT LPAD(' ', (level-1)*4) || org_CD org_cd, No_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM (SYS_CONNECT_BY_PATH(org_cd, '-'), '-' )path,
        CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH ORG_CD = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd ;      

87p 게시글 
실습 h6
*********************************************************
?create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, '첫번째 글입니다');
insert into board_test values (2, null, '두번째 글입니다');
insert into board_test values (3, 2, '세번째 글은 두번째 글의 답글입니다');
insert into board_test values (4, null, '네번째 글입니다');
insert into board_test values (5, 4, '다섯번째 글은 네번째 글의 답글입니다');
insert into board_test values (6, 5, '여섯번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (7, 6, '일곱번째 글은 여섯번째 글의 답글입니다');
insert into board_test values (8, 5, '여덜번째 글은 다섯번째 글의 답글입니다');
insert into board_test values (9, 1, '아홉번째 글은 첫번째 글의 답글입니다');
insert into board_test values (10, 4, '열번째 글은 네번째 글의 답글입니다');
insert into board_test values (11, 10, '열한번째 글은 열번째 글의 답글입니다');
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
실습 H7

90P계층형태를 유지해서 정렬을 만들어라 는 이야기 
실습 H8
92- 93P 가장 최신글 올라오게 하는 것 order siblings by
94P 부모글 최상위글 안쪽에 있는 답글들은 어센딩으로 오름차순으로 하는 방법 95P처럼 나와야함 

SELECT seq, lpad(' ', (level-1)*4) || TITLE  title
FROM board_test
START WITH PARENT_seq IS NULL 
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

그룹번호를 저장할 컬럼을 추가 ;
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
5000받는 사람의 이름이 궁금할때는 
SELECT ename, MAX(sal)
FROM emp
WHERE sal =(SELECT MAX(sal)
            FROM emp);

98p
해당 행의 범위를 넘어 다른 연상이 가능하다 

99p 부서별 부서급여랭킹을 구하고 싶을때 (http://www.gurubee.net/lecture/1284 참고하기 ^0^);
SELECT ename, sal, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS sal_rank
FROM emp
ORDER BY deptno; 
--선생님 방법 (ing..)
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

