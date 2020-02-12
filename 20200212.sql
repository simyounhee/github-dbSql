어제 작성한게 두개가 있다 EMPNO 두번째는 JOB  이어서 진행할 것 

1. table full
2.idx1 : empno
3.idx2 : job;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE (dbms_xplan.display);      --84pt 테이블 접근했는데 라이크쪽으로 필터를 한 것이다 조건을 거르다보니까 클럭데이터만
                                        -- 나오게 된 설명이 85pt
                                        
                                        
CREATE INDEX idx_n_emp_03 ON emp ( job , ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE (dbms_xplan.display);   --아까는 테이블 엑세스 오퍼레이더 필터가 걸려있었는데 이번엔 엑세스가 걸려있고 필터가 한번 더 걸려있다 .
                                        테이블 엑세스 필터가 없어진것 도식화 하면 86P   -> 87설명 
                                        지금 인덱스를 하나 더 만들어서 
                                        접근자체를 클럭부터 한 것 ??  
                                        SELECT  job, ename,  
                                        
                                        88p 이번엔 씨로 끝나는거 앞에 어떤문자가 올지 모르는 것 얘는 어떻게 알까 ? 
                                        클락부터 읽었는데 뭐부터 올지 모르니까 브레이크가 온것 
                                        킹까지 조건에 만족하는게 하나도 없어서 실행은 그대로 나오는데 조건에 맞는게 나오질 않았다. 
                                        그러니 퍼센트가 앞에 있으면 나오지 않ㅡㄴㄴ다 
                                        
                                        이번에는 인덱스 구성을 바꿔볼것 
                                        
 1. table full
 2. idx1 : empno
 3. idx2 : job
 4. idx3 : job + ename
 5. idx4 : ename + job;
 
 CREATE INDEX idx_n_emp_04 ON emp (ename, job);
 
 SELECT ename, job, rowid
 FROM emp
 ORDER BY ename, job ;    세번째 ㄴㅔ번째 구성은 같은데 순서가 다르다는 것 이게 실행되면 어떻게 영향을 미치냐면 ;
 
 
 --확실하게 하게 하기위해서 3번째 인덱스를 지우겠음
 그래서 3,4번째 인덱스가 컬럼 구성이 동일하고 순서만 다르다 ; 
 
 DROP INDEX idx_n_emp_03;
 
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND                                           --세번째ㅑ는 네건을 읽은거고 91은 두건을 읽은 것 
                                            나중에 구성 컬럼을 잘 고려해야한다는 것이다
                                            
                                            94P  조건절에 부합하는 인덱스가 있다고 해서 항상 인덱스를 
                                            사용하는 것은 아니라는 점 중요 
                                            선생님이 에스쿠엘은 로직이 없다고 한 의미가 바로 이부분이다
                                            옵ㅌㅣ마이저가 상황에 맞게 쿼리를 실행하는데 개발자가 어떤
                                            방식으로 쿼리를 처리할지 설명해주는 것이 힌트이다
                                            일단 넘어가자 
                                            참 애매하게 모순인데 알티비에스는 디비엠에스에 맡기는 사상
                                            이였다 개발자가 원하는 정의를 내려주면 알아서 해줬는데
                                            사람들이 성능적인 부분때문에 역행을 한것이다 
                                            실행계획이 달라지는게 맞는데 개발자가 데이터를 매번
                                            체크하기 어렵기 때문에 디비엠에스에서 ... 
                                            
  

                                            이번엔 조인 95P 
    
 emp - table full, pk_emp(empno)
 dept - table full, pk_dept(deptno)
 
(emp-table full, dept-table full)
(dept-table full,emp-table full)

 (emp-table full, dept-pk_dept)
(dept-pk_dept,emp-table full )

 (emp-pk_emp, dept-table full)
 (dept-table full, emp-pk_emp)
 
 (emp-pk_emp, dept-pk_dept)
 (dept-pk_dept,emp-pk_emp)
 
 1.순서 
 
 2개 테이블 조인
 각각의 테이블에 인덱스 5개씩 있다면 
 한테이블에 접근 전략 : 6
 36 * 2 = 72
 
 ORACLE - 실시간 응답 : OLTP ( ON LINE TRANSACTION PROCESSING)
        전체 처리시간 : OLTP ( ON LINE ANALYSIS PROCESSING) -복잡한 쿼리의 실행계획을 세우는데 삼십눙에서 한시간 걸림 
  
  
  EMP 부터 읽을까 dept부터 읽을까 ??
  순서는 없다고 했다 . 그러니 ;
  EXPLAIN PLAN FOR
 SELECT ename, dname, loc
 FROM emp, dept
 WHERE emp.deptno = dept.deptno
 AND emp.empno = 7788;          -- 특정 부분만 가져오기

 SELECT *
FROM TABLE (dbms_xplan.display);

95p 테이블의 행을 읽은 것 인덱스 유니크 스캔 접근하래 

96p 처음부터 끝까지 읽는 것 전체 읽기 
97 언제 인덱스 접근 - 소수의 데이터 조회시 유리하다 한개의 블럭
언제 테이블 접근해야하는가  데이터를 읽을때 한번에 기본사이즈 8개씩 읽어온다 속도가 중요할 때 쓰임 

98p 인덱스를 쓰니까 속도면에서 원하는 데이터만 읽고 사용자에게 던저쥴슈 있어서 
인덱스가 있으면 시스템이 효율적인것같은데 
테이블에 인덱스가 많아지면 4개 과정 
99p  태이블 빈공간에 넣고 100 네개의 인덱스 구성 컬럼대로 정렬했을 때 올바른 위치에 찾아간다 
정렬의 과정이 계속 있는 것이다. 즉, 부담이다 여러개 할때는 
102*
그래서 인덱스가 많아지면 정렬하는 과정이 그만큼 일어나기때문에 데이터 부하가 커진다/
셀렉트실행시는 유리하지만, ...만능이라니라는것
그래서 테이블에 과도한 수의 인덱스를 생성하는 것은 바람직하지 않다. 
한 5개 정도가 바람직한 형태이다 
하나의 쿼리를 위한 인덱스는 쉽다. 웨어절쓰면되서 근데,., 
시스템에서 실행되는 모든 쿼릴를 분석하여 적절한 개수의 최적의 인덱스를 설계하는 것이 힘들다 
근데 아직은 버겁다 나 

오라클에서 사용하는 인덱스는 일반적인 바이너리트리는 아니다 
값이 크고 작고에 따라서 
쿠팡에서 주문할때 내가 주문한 날이 주문일자 
일자 특징은 한방향이다.
바이너리 값은 계속 값이 커지는 형테 104p 오른쪽만 계속 커짐 
이렇게 되면 댑스가 달라진다. 이런건 깨진아이
오라클은 깨지게 되면 조정이 가능하다 비틀 트리 105 p 
그래서 위치만 찾는다고 끝나는 것이 아니라 루트부터 레프까지 밸런스가 갖게 유지한다 101 
106 이런것들도 있더라 자동으로 생성 수동으로 생성방법이 있는데 
수동으로 생성하는것은 디디엘 우리가
인덱스를 구분 107 정리 
108인덱스 생성 과정  
109 드럽 테이블 삭제 
--------------------------------------------------------------------------------------------
110p 실습 idx 1 ;
<index 생성방법>
CREATE [UNIQUE :옵션] INDEX 인덱스할 테이블이름_인덱스번호 ON 테이블이름(인덱스할 컬럼이름) 
;
CREATE TABLE DEPT_TEST2 AS  -- 이거 쥴여서  CTAS : 제약조건 복사가 NOT NULL만 된다
                           --                     백업이나 ,테스트용으로만 쓰임 
SELECT * 
FROM DEPT   
WHERE 1 = 1; --(== dept) 
구문으로 DEPT_TEST 테이블 생성 후 다음 조건에 맞는 인덱스를 생성하기; 
<조건>
deptno 컬럼으로 unique index
dname  컬럼으로 non unique index
deptno, dname 컬럼으로 non unique index ;

CREATE UNIQUE INDEX idx_u_dept_test2_01 ON dept_test2(deptno);
CREATE INDEX idx_n_dept_test2_02 ON dept_test2(dname);
CREATE INDEX idx_n_dept_test2_03 ON dept_test2(deptno, dname); 
----------------------------------------------------------------------------------------------------
실습 index 2

DROP INDEX idx_u_dept_test2_01;
DROP INDEX idx_n_dept_test2_02;
DROP INDEX idx_n_dept_test2_03;
-------------------------------------------------------------------
실습 index 3













