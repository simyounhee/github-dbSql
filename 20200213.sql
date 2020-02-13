synonym : 동의어        115P
    1. 객체 별칭을 부여
        ==> 이름을 간단하게 표현
        
      언제 사용하냐면 sim사용자가 자신의 테이블 emp테이블에 사용해서 만든  v_emp view
                    hr 사용자가 사용할 수 있게 끔 권한을 부여
                    
                    v_emp : 민감한 정보 sal, comm 를 제외한 view; 
                    
                    hr 사용자 v_emp를 사용하기 위해 다음과 같이 작성
                    
                    SELECT *
                    FROM sim.v_emp;
                    
                    hr 계정예시
                    synonym sim.v_emp ==> v_emp
                    v_emp == sim.v_emp
                    
                    SELECT *
                    FROM v_emp;
                    
 1.sim계정에서 v_emp를 hr 계정에서 조회할 수 있도록 조회권한 부여;                        
 
 GRANT SELECT ON v_emp TO hr;
 
 2. hr 계정 v_emp 조회하는게 가능 (권한 1번에서 받았기 때문에)
    사용자 해당 객체의 소유자를 명시 : sem.v_emp
    간단하게 sim.V_emp ==> v_emp 사용하고 싶은 상황
    synonym 생성
    
 CREATE SYNONYM 시노님이름 FOR 원 객체명;   
 
 115P 117P 퍼블릭 : 모든 사용자가 사용할 수 있게 옵션을 줌 하지만 모든 사용자가 볼 수 있기 때문에 권한을 가진 사용자만 볼 수 있도록 생성이 가능하다
 118P 드럽 시노님 삭제하려면 
 *시노님 삭제 방법 
 DROP SYNONYM 시노님이름; 
 
 119P
 GRANT CONNECT TO SIM;        --시스템에 대한 권한
 GRANT SELECT ON 객체명 TO HR;  --객체 권한 
 
 120P 
 스키마 
 
 121P 
 테이블 스페이스 큰 객체를 담을 컨테이너라고 생각하면 된다. 
 
 122P
 비밀번호 바꿀 때  121 의 크레이트 빼고 그 부분이 같다 
 
 123P 
오라클 시스템 권한 
뷰를 처음 만들때 사용했음 
 124P 권한을 주는 것은 이런것들 ...
 권한을 줬으면 그것을 다시 해소하는 방법도 있다  RE
 
 125P 
 객체 권한 
 어떤 사용자에게 주겠다
 흘려들려도 된다 
 127P 
 그랜트 명령 시행할 때 WITH ADMIN OPTION 
 권한을 부여받은 사용자가 다른사용자에게 권한을 부여할 수 있다 
 128P 
 130P  주의
 객체권한을 회수할 때는 처음에 유저 원이 유저투에게 별도로 줬을 때 
 다시 회수할때는 시스템권한에서는 131 ....이런 개념이 있다는 것만 알아두기 
 
 132P ROLE 권한의 집합 
 각 사용자들에게 줌 그런데 롤에게 권한을 준다면 디비 관련된 롤에게 주는 것 중간에 한단계를 넣으면서 복잡성을 줄인다. 
 
 오라클은 권한 관리를 위해서 관리를 하고 있다. 
 
 133P  롤을 생성하는 방법 
 ---------------------------------------------------------------------------------------------------여기까지가 
 권한종류 
 1. 시스템권한 : TABLE을 생성, VIEW 생성 권한..
 2. 객체 권한 : 특정 객체에 대해 SELECT, UPDATE, INSERT, DELETE ...
 
 ROLE : 권한을 모아놓은 집합
 사용자별로 개별 권한을 부여하게 되면 관리의 부담. 
 특정 ROLE에 권한을 부여하고 해당 ROLE 사용자에게 부여
 해당 ROLE을 수정하게 되면 ROLE을 갖고 있는 모든 사용자에게 영향 
 
 권한을 부여/ 회수
 시스템 권한 : GRANT 권한 이름 TO 사용자 | ROLE;
       회수 : REVOKE 권한 이름 TO 사용자 | ROLE;
 객체 권한 : GRANT 권한이름  ON 객체명 TO 사용자 | ROLE;
       회수 :REVOKE 권한이름 ON 객체명 FROM 사용자 | ROLE;
 
 --------------------------------------------------------------
 데이터 딕셔너리 DATA DICTIONARY : 사용자가 관리하지 않고 DBMS가 자체적으로 관리하는 시스템정보를 담은 VIEW
 우리가 시스템을 개발할때 업무적으로 필요한 테이블 이렇게 만든것을 오라클 자체적으로 관리하는 시스템이 
 해당 사용자가 갖고있는 데이터, 컬럼 등 그래서 딕셔너리는 크게 네가지가 있다 
 135P 
 우리가 기존에
 
 DATA DICTIONARY : 사용자가 관리하지 않고 DBMS가 자체적으로 관리하는 시스템정보를 담은 VIEW
 
 DATA DICTIONARY 접두어
 1. USER : 해당 사용자가 소유한 객체
 2. ALL  : 해당 사용자가 소유한 객체 + 다른 사용자로부터 권한을 부여받은 객체
 3. DBA  : 모든 사용자의 객체 
 
 * V$ 특수 VIEW; 
 
SELECT *
FROM USER_TABLES;
 
SELECT *
FROM ALL_TABLES;

SELECT *
FROM DBA_TABLES;   --이건 일반사용자 볼 수 없음? 

DICTIONARY 종류 확인 : DICTIONARY;

SELECT *
FROM DICTIONARY ;    --설명은 되어있지만 필ㄴ요할때 검색을하여 원하는 정보를 확인하는 것이 빠를 것이다, 

많이쓰는 녀석들 
137P;
대표적인 dictionary 
OBJECT : 객체 정보 조회 (테이블, 인덱스, VIEW, SYNONYM..)
TABLE : 테이블 정보만 조회
TAB_COLUMNS : 테이블의 컬럼 정보 조회
INDEXES : 인덱스 정보 조회 ***************
IND_COLUMNS : 인덱스 구성 컬럼 조회 *************
CONSTRAINT : 제약조건 조회
CONS_COLUMNS : 제약조건 구성 컬럼 조회 
TAB_COMMENTS : 테이블 주석 ********
COL_COMMENTS : 테이블 컬럼 주석***********; 
SELECT *
FORM USER_OBJECTS;
137P 조회결과 

emp, dept 테이블의 인덱스와 인덱스 컬럼 정보 조회
user_indexes, user_ind_columns  join하기 
테이블명, 인덱스 명, 컬럼명 컬럼순서
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

------------------------------------------------sql 활용 문법 끝 ---------------------
----------------지금부터는 sql 응용 -------------------------------------
2p 
멀티플 인설트 
이녀석의 기본개념은 한번에 인설트해서 여러테이블에 삽입할 수 있다는 점 
조건을 만족하는 구문에다만 할 수 있고, 조건을 만족하는 첫 부분에다가도 

3p 내용이 와 닿지 않아서 
바로 실습하기 ;

multiple insert : 하나의 insert 구문으로 여러 테이블에 데이터를 입력하는  DML;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

동일한 값을 여러 테이블에 동시에 입력하는 multiple insert;
INSERT ALL 
    INTO dept_test                                  --안나옴 
    INTO dept_test2
SELECT 98, '대덕', '중앙로' FROM dual UNION ALL
SELECT 97, 'IT', '영민' FROM dual; 


테이블에 입력한 컬럼에 지정하여 multiple insert;
ROLLBACK;
INSERT ALL          
    INTO dept_test (deptno, loc) VALUES( deptno, loc)                                 
    INTO dept_test2
SELECT 98 deptno, '대덕' dname, '중앙로' loc  FROM dual UNION ALL
SELECT 97, 'IT', '영민' FORM dual; 


이번에는 조건에 따라 데이터를 입력해볼것이다
테이블에 입력할 데이터를 조건에 따라 multiple insert
조건에 따라서 하면 
CASE 
    WHEN 조건 기술 THEN 
END;

ROLLBACK;
INSERT ALL 
    WHEN deptno = 98 THEN
        INTO dept_test (deptno, loc) VALUES( deptno, loc)
         INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '대덕' dname, '중앙로' loc  FROM dual UNION ALL
SELECT 97, 'IT', '영민' FORM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;


조건을 만족하는 첫번째 insert만 실행하는 multiple insert

ROLLBACK;
INSERT FIRST     --조건을 만족하는 첫번째만 실행하는 것  
    WHEN deptno >= 98 THEN
        INTO dept_test (deptno, loc) VALUES( deptno, loc)
    WHEN deptno >= 97 THEN     
        INTO dept_test2
    ELSE
        INTO dept_test2
SELECT 98 deptno, '대덕' dname, '중앙로' loc  FROM dual UNION ALL
SELECT 97, 'IT', '영민' FROM dual;


오라클 객체 : 테이블에 여러개의 구역을 파티션으로 구분
테이블 이름은 동일하나 값의 종류에 따라 오라클 내부적으로 별도의
분리된 영역에 데이터를 저장 ; 

dept_test  ==> dept_test_20200201 

INSERT FIRST     
    WHEN deptno >= 98 THEN
        INTO dept_test
    WHEN deptno >= 97 THEN     
        INTO dept_test2 20200202
    ELSE
        INTO dept_test2
SELECT 98 deptno, '대덕' dname, '중앙로' loc  FROM dual UNION ALL
SELECT 97, 'IT', '영민' FROM dual;


MERGE : 통합  
테이블에 데이터를 입력/갱신 하려고 함 
1. 내가 입력하려고 하는 데이터가 존재하면 
   ==> 업데이트
2. 내가 입력하려고 하는 데이터가 존재하지 않으면
   ==> INSERT
   

1. SELECT 실행
2-1 SELECT 실행결과가 0 ROW이면 INSERT
2-2 SELECT 실행결과가 1 ROW이면 UPDATE

MERGE 구문을 사용하게 되면 SELECT 를 하지 않아도 자동으로 데이터 유무에 따라 
INSERT 혹은 UPDATE 실행한다.
2번의 쿼리를 한번으로 준다. 

MERGE INTO 테이블명 (alias) 
USING (TABLE | VIEW | IN-LINE-VIEW)
ON (조인조건)
WHEN MATCHED THEN 
    UPDATE SET col = 컬럼값, col2 = 컬럼값 ...
WHEN NOT MATCHED THEN 
    INSERT (컬럼1, 컬럼2, ...) VALUES (컬럼값1, 컬럼값2...);

SELECT *
FROM emp;

SELECT *
FROM emp_test;

DELETE emp_test;

로그를 안남긴다 ==> 즉, 복구가 안된다 ==> 그러므로 테스트용으로..
TRUNCATE TABLE emp_test;

emp테이블에서 emp_tset 테이블로 데이터를 복사 (7365 - SMITH);

INSERT INTO emp_test
SELECT empno, ename, deptno, '010'               --SQL 오류: ORA-00913: too many values
FROM emp
WHERE empno = 7369;

데이터가 잘 들어갔는지 확인;
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

emp 테이블의 모든 직원을 emp_test 테이블로 통합
emp 테이블에는 존재하지만 emp_test에는 존재하지 않으면 insert
emp 테이블에는 존재하고 emp_test 에도 존재하면 ename, deptno 를 update;

emp 테이블에 존재하는 14건의 데이터중 emp_test 에도 존재하는 7369를 제외한 13건 데이터가 
emp_test 테이블에 신규로 입력이 되고
emp_test에 존재하는 7369번의 데이터는 ename(brown) 이 emp테이블에 존재하는 이름인 SMITH로 갱신;

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


해당 테이블에 데이터가 있으면 insert, 없으면 update
emp_test 테이블에 사번이 9999번인 사람이 없으면 새롭게 insert
있으면 update
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
 
 merge , window function (분석함수) 
 
 13~15p merge 내용 다시 보기 
------------------------------------------------------ 
 16p-17p 고급 그룹함수   (실습) 
 1.부서별로 셀러리합계
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
한번 호출하는 것보다 성능이 좋음 

I/O
CPU CACHE > RAM > SSD > HDD > NETWORK;

그룹바이 단위가 변경된다면 
19P ROLLOP 
우리가 지금 배우려고 하는 것은 
REPORT GROUP FUNCTION
ROLLUP
CUBE
GROUPING; 

ROLLUP
사용방법 : GROUP BY ROLLUP (컬럼1, 컬럼2 ....)
SUBGROUP 을 자동적으로 생성
SUBGROUP 을 생성하는 규칙 :ㅣ ROLLUP에 기술한 컬럼을 오른쪽에서부터 하나씩 제거하면서 
                            SUB GROUP 을 생성 
EX : GROUP BY ROLLUP (deptno)
==>
첫번째 sub groub : GROUP BY deptno
두번째 sub groub : GROUP BY NULL ==> 전체 행을 대상 ; 

GROOP_ADI 을 GROUP BY ROLLUP 절을 사용하여 작성;
SELECT deptno, SUM (sal)
FROM emp
GROUP BY ROLLUP (deptno);

19p 기술 방법 
    오른쪽 컬럼을 하나씩 제거하며 groub by를 한다 ;
    
SELECT job, deptno, SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

GROUP BY job, deptno : 담당업무, 부서별 급여합
GROUP BY job : 담당업무별 급여합
GROUP BY  : 전체 급여합 ;



group ad2 실습  (case);
SELECT  CASE WHEN GROUPING (job) = 1 AND GROUPING(deptno) = 1 THEN '총계'
            ELSE job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);

 (decode);
SELECT  decode (GROUPING (job),1 AND GROUPING(deptno),1) AS '총계'
            ELSE job
        END job,
        deptno, 
        SUM(sal + NVL(comm, 0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);



