제약조건 확인 방법
1. tool
2. dictionary view
제약조건 : USER_CONSTRAINTS
제약조건-컬럼 : USER_CONS_COLIMNS
제약조건이 몇개의 컬럼에 관련되어 있는지 알 수 없기 때문에 테이블을 별도로 분리하여 설계

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');

2.EMP, 'DEPT', 'PK', 'FK'제약이 존재하지 않음 
테이블 수정으로 제약조건 추가 ; 
3.EMP : PK (empno)
      fk (depno) - dept.deptno 
      (fk 제약을 생성하기 위해서는 참조하는 테이블 컬럼에 인덱스가 존재해야한다)

1.dept : pk (deptno);      

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);
ALTER TABLE dept ADD CONSTRAINT fk_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);
ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY (deptno);


테이블, 컬럼 주석 : DICTIONARY 로 확인 가능하다
테이블 주석 : USER_TAB_COMMENTS
컬럼 주석 : USER_COL_COMMENTS;

주석생성
테이블 주석 : COMMENT ON TABLE 테이블명 IS '주석'
컬럼 주석 : COMMENT ON COLUMN 테이블.컬럼 IS '주석';

emp : 직원
dept : 부석; 

COMMENT ON TABLE emp IS '직원';
COMMENT ON TABLE dept IS '부서';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ( 'EMP', 'DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

DEPT	DEPTNO : 부서번호	
DEPT	DNAME  : 부서명	
DEPT	LOC	   : 부서위치
EMP	EMPNO	   : 직원번호
EMP	ENAME	   : 직원이름
EMP	JOB	       : 담당업무
EMP	MGR	       : 매니저 직원번호
EMP	HIREDATE   : 입사일자	
EMP	SAL	       : 급여
EMP	COMM	   : 성과급
EMP	DEPTNO	   : 소속부서번호 

열한개의 컬럼을 한번 만들어보자 ;

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치';

COMMENT ON COLUMN emp.empno IS '직원번호';
COMMENT ON COLUMN emp.ename IS '직원이름';
COMMENT ON COLUMN emp.job IS '담당업무';
COMMENT ON COLUMN emp.mgr IS '매니저 직원번호';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '성과급';
COMMENT ON COLUMN emp.deptno IS '소속부서번호';




--47P DDL(TALE-comments 실습 comment1)   [과제] --------------------------------------------------------------
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
사용자에게 안보여주고 싶을 때 사용한다.(예시.급여정보 민감한 문제 )
컬럼을 조회하고 싶을 때 뷰를 사용한다 
그리고 컬럼을 제한하는 것 뿐만아니라 쿼리 길이를 재활용할 수도 있고 길이를 단축시킬 수도 있다 
뷰를 한번 만들어 볼거야 
VIEW 정의 : 뷰는 쿼리(QUERY)이다.  [VIEW=TABLE (X) ]
            TABLE 처럼 DBMS에 미리 작성한 객체이다. 
            ==>작성하지 않고 QUERY에서 바로 작성한 VIEW : IN-LINEVIEW ==> 이름이 없기 때문에 재활용이 불가

사용목적 
1. 보안 목적(특정 컬럼을 제외하고 나머지 결과만 개발자에게 제공)
2. INLINE-VIEW를 VIEW로 생성하여 재활용
   .쿼리 길이 단축
   
생성방법
CREATE [OR REPLACE] VIEW 뷰명칭 [(COLUMN1,COLUMN2 ....)] AS
SUBQUERY;

emp 테이블에서 8개의 컬럼 중 sal, comm 컬럼을 제외한 6개 컬럼을 제공하는 v_emp VIEW 생성;

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno   
FROM emp;
 --에러 : insufficient privileges 불충분한 전환 그러므로
시스템 계정에서 sim계정으로 VIEW 생성권한 추가를 해야한다.;
GRANT CREATE VIEW TO SIM;       --<-시스템을 연결해서 해야 실행이 가능하다 실행을 다하고 나면 시스템 과정을 바로 접속해제해줘야한다 
                                   -- 그 다음 원래 계정으로 바꿔주기 
                                   --이제 위에 CREATE 생성이 될 것이다. 
                                   
기존 인라인 뷰로 작성시;                                   
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp;)
      
VIEW 객체 활용;     
SELECT *
FROM v_emp;

emp테이블에는 부서명이 없음 ==> dept 테이블과 조인을 빈번하게 진행
조인된 결과를 view 로 생성 해놓으면 코드를 간결하게 작성하는 게 가능하다 ;

VIEW : v_emp_dept
dname(부서명), empno(직원번호), ename(직원이름), job(담당업무), hiredate(입사일자);

CREATE OR REPLACE VIEW v_emp_dept AS                              
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate      --잘 짜여져있나 실행한 뒤 생성하기
FROM emp, dept
WHERE emp.deptno = dept.deptno;

인라인 뷰로 작성시;
SELECT *
FROM (SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate     
      FROM emp, dept
      WHERE emp.deptno = dept.deptno);
      
VIEW 활용시;
SELECT *
FROM v_emp_dept;

만약 이엠피 테이블에 스미스를 지우게 되면 나오지 않는다 그 이유는 뷰는 쿼리이기 때문이다. 그래서 
SELECT *
FROM v_emp_dept;    --총 14건 그런데

SMITH 직원 삭제 후 v_emp_dept view 건수 변화를 확인;
DELETE emp
WHERE ename = 'SMITH' ;

55P 그냥 쿼리이며 물리적인 데이터가 아니라 논리적인 데이터이다. 그래서 뷰가 참조하는 테이블을 수정하면 그 뷰에도 영향을 미친다. 
VIEW는 물리적인 데이터를 갖지 않고, 논리적인 데이터의 정의 집합(SQL)이기 때문에
VIEW에서 참조하는 테이블의 데이터가 변경이 되면 VIEW의 조회결과에도 영향을 미친다;

ROLLBACK;

56P
뷰의 종류 
함수를 포함하느냐에 따라서 
그룹함수를 사용하면 컴플렉스라고 하고 아니면 심플 
뷰를 통한 디엠일 실행시 심플은 일반적으로 가능하지만, 컴플렉스는 불가능한 경우가 많다
일반적으로 뷰에 업데이트하는 것도 가능하는 점 참고 

그래서 뷰에 디엠엘 할 수 있는데 컴플렉스는 안되지만
그룹바이 57 이것들은 안된다 

58P SEQUENCE :  순서 얘를 어디다가 쓸까 ? 
             항상 구분되는 값이 필요하다 그래서 유일한 값을 만드는 방법은 총 3가지 이다. 
             에이부터 문자열 쭉 만들어 놓는것 
             그리고 사용 여부를 만드는 것 (했으면 적고 안썼던 것을 최신데이터를 먼저 오게 )
             1.KEY
             읽기 일관성 내가 읽고서 누군가 업데이트하지못하게 막아 놓게 하는것 즉, 읽기만하고 쓰진 못하게 하는 것이 있다 
             2. UUID아이디 자바기능에서 파일 업로드할때 많이 쓴다. 
                            여러사람들이 파일 업로드를 하게 되면 
                           웹프로그래밍 할때 많이 쓸 것이다. 유료다 별도 라이브러리를 쓴다. 
            3.sequence 오라클에서 제공하는 아이 이 객체를 통해서 정수를 리턴할 수 있다. 
                      59p 그래서 유일한 정수 값을 생성해주는 오라클 객체로 pkㄹ컬럼에 임의로 생성할 수 있다 
                      60p 시퀀스 생성과정 복잡하다 ^^ 
                      
                      
SEQUENCE  : 시퀀스 - 중복되지 않는 정수값을 리턴해주는 오라클 객체
CREATE SEQUENCE 시퀀스_이름
[OPTION....]
명명규칙 : SEQ_테이블명

emp 테이블에서 사용한 시퀀스 생성;

CREATE SEQUENCE seq_emp;    --시퀀스 새로고침 갱신된게 보일것임 시퀀스 
****************************************************
CREATED	2020/02/11
LAST_DDL_TIME	2020/02/11
SEQUENCE_OWNER	SIM
SEQUENCE_NAME	SEQ_EMP
MIN_VALUE	1
MAX_VALUE	9999999999999999999999999999
INCREMENT_BY	1     --1씩 증가한다는 것 잘 사용 안씀 
CYCLE_FLAG	N         --1부터 반복을 할 것이냐 물어보는 것 하지만 일반적으로 맥스값이 너무 커서 반복하지 않는다 . 
ORDER_FLAG	N
CACHE_SIZE	20
LAST_NUMBER	1         --마지막으로 읽혀질 값 
************************************************************
여기서 시퀀스를 제공해주는 함수는 
NEXTVAL : 시퀀스에서 다음 값을 가져올때 사용
CURRVAL : NEXTVAL 을 사용하고나서 현재 읽어 들인 값을 재확인;

SELECT seq_emp.NEXTVAL
FROM dual; 

SELECT seq_emp.CURRVAL
FROM dual;

SELECT *
FROM emp_test;

INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'james', 99, '017');

시퀀스 주의점
ROLLBACK을 하더라도 NEXTVAL을 통해 얻은 값이 원복되진 않는다.
NEXTVAL를 통해 값을 받아오면 그 값을 다시 사용할 수 없다;
시각적으로 중요하다면 다른걸 써야하지만, 시퀀스를 사용하게되면 구멍이 좀 생길 수 있다는 점 
;

64~65P 캐싱 락킹제어 동시에 접근을 막게 하는 것 이것을 메모리에 미리 올려놓고 락을 쓰면 경합을 해소시킬 수 있다. 
            미리 읽어서 주는 것 읽어들이는데 시간을 줄이는것
66P 오더라는 것은 사용자가 많게 되면 처리하기가 불가능 하다 
    사이클은 최대값까지 도달시 최소값으로 다시 시작하는 것 
    

인덱스 라는 것은 국어사전에 보면 가나다순으로 정렬해놨을때 특정 단어를 찾고자 할때 찾는 것 
다른 인덱스는 
69P 인덱스는 왜 배우는지를 알아보자 
테이블의 일부컬럼으로 기준을 정렬한 것이다 
테이블의 row를 가리키는 주소를 가지고 있다 (ROWID)
정렬된 인덱스를 기준으로 하여 로우의 위치를 빠르게 검새하여 원하는 행에 빠르게 접근할 수 있다 
그런데 데이터값이 바뀌면 인덱스 구조도 갱신이 된다는 점 
그에 반해 
70P 테이블은 입력순서를 데이터에 저장을 못한다. 
    그래서 중간이 빌 수도 있다. 
    그리고 대용랼 테이블을 할 시 에
    
    인덱스는 최소한의 읽기를 통해 내가 원하는 데이터만 읽고 싶을 때 딱딱 찾고 싶을 때 사용한다. 
    그래서 우리가 지금까지 인덱스를 사용 안했다면 72처럼 맞으면 사용자에게 보내고 아니면 안보내고 ... 
    읽고서 버릴지 아니면 내가 필요한 부분만 찾을지 
    바이너리트리 73P 작을때 클때로 여러가지로 트리를 만듦 ==> 
    지금은 인덱스가 없을때 75P 
  
인덱스가 없을때 empno 값으로 조회하는 경우;
emp테이블에서 pk_emp 제약조건을 삭제해서 empno컬럼으로 인덱스가 존재하지 않는 환경을 만드는 것이다;

ALTER TABLE emp DROP CONSTRAINT pk_emp;     --인덱스가 없는 상태
-------------------------------------------------------------------여기부더 ;; 
explain plan for 
SELECT *
FORM emp
WHERE empno = 7782;
  
SELECT *
FROM TABLE (dbms_explain --ㅂ75p 설명 



emp 테이블의 empno 컬럼으로 pk제약을 생성하고 동일한 sql을 실행
pk : UNIQUE + NOT NULL
    (UNIQUE 인덱스를 생성해준다)
==> empno 컬럼으로 unique 인덱스가 생성됨

인덱스로 sql을 실행하게 되면 인덱스가 없을 때와 어떻게 다른지 차이점 확인;

ALTER TABLE emp ADD CONSTRAINT PK_emp  PRIMARY KEY (empno);

SELECT RO
  
INDEX;

SELECT ROWID, emp.*
FROM emp; 

SELECT *
FROM  emp
WHERE ROWID = 'AAAE5uAAFAAAAD8AAH'  --이쪽으로 접근


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
WHERE ename = 'SMITH';    --활용할 수 있는 인덱스가 없는 것 왜냐하면 ......ㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜㅜ
77~78P 이엠피엔오 로 값을 구하게 되면 활용할 수 없는 인덱스를 발견하지 못했기때문에 테이블이 ....해당테이블에 

78

SELECT 조회 컬럼이 테이블 접근에 미치는 영향 ;
SELECT * FROM emp WHERE empno = 7782
==>
SELECT empno FROM emp WHERE empno = 7782;

explain plan for
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE (dbms_x
7782인 직원번호를 갖고 싶을때 내가 알고 싶은 컬럼이 empno밖에 모를때  이런 내요ㅕㅇ이 피티에79p에 나와있으니 꼭 읽어보기 !!!!!!!

그다음에는 조금 다른 형태를 보여주실건데 
프라이머리 생성이되는 인덱스는 유니크인덱스이다 
인덱스의 유일성 유무로 인해 다르다 
논유니크익덱스를 해볼것이다 ;

UNIQUE   VS  NON-UNIQUE 인덱스의 차이 확인점 
1.PK_EMP 삭제
2.EMPNO 컬럼으로 NON-UNIQUE 인덱스 생성
3. 실행계획 확인; 

ALTER TABLE emp DROP CONSTRAINT PK_emp;      
CREATE INDEX idx_n_emp_01 ON emp (empno);

explain plan for
SELECT *
FROM emp 
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms

80p 만약 논유니크인덱스일경우 

이거를 도식화 - 81p 읽어보기 꼭 !!!!

그리고 인덱스가 테이블에 여러개 있을 수 있기에 잡  컬럼 기준으로 논 유니크를 만들어볼것이다 
emp 테이블에 job 컬럼을 기준으로 하는 새로운 non-unique인덱스를 생성;

CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

선택가능한 사항
1.emp 테이블을 전체 읽기
2.idx_n_emp_01(empno) 인덱스 활용
3.idx_n_emp_02 인덱스 활용;    --내가 원하는 인덱스 집어낼 수 있어서 3번째가 좋다 

explain plan for
SELECT *
FROM emp
WHERE job = 'MANAGER' 

SELECT *
FROM TABLE (dbms_xplain.display);    -- 이것을 도식화 하게 되면 82p    매니저가 나오지 않을 때까지 계속 나올 것이다 세건에대해서만
                                     --           사용자에게 보여주는것 
                                     
                                     