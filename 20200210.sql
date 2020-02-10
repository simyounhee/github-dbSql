1.PRIMARY KEY 제약 조건 생성시 오라클 dbms는 해당 컬럼으로 unique index를 자동으로 생성한다. 
 (***정확히는 UNIQUE 제약에 의해 UNIQUE 인덱스가 자동으로 생성된다
    그래서 PRIMARY KEY = UNIQUE + NOT NULL)
index : 해당 컬럼으로 미리 정렬을 해놓는 객체
정렬이 되어있기 때문에 찾고자 하는 값이 존재하는지 빠르게 알 수가 있다. 
만약에 인덱스가 없다면 새로운 데이터를 입력할 때 중복되는 값을 찾기 위해서
최악의 경우 테이블의 모든 데이터를 찾아야 한다. 
하지만, 인덱스가 있으면 이미 정렬이 되어있기 때문에 해당 값의 존재 유무를 빠르게 알 수 있다. 
 
 debt_test 
 
 빠르게 찾을 수 있는 것은 
 2.FOREIGN KEY 제약 조건도 
 참조하는 테이블에 값이 있는지 확인해야한다.
 그래서 참조하는 컬럼에 인덱스가 있어야지만 FOREIGN KEY 제약을 생성할 수가 있다.
 
 인덱스라는 것은 속도 개선으로 쓰는 것이기때문에 눈에 보기 어렵다. 
 26P 외래키 주의사항 
 폴인 은 참조 무결성 사워네테이블에 부서 에 있는 데이터 들어갈때 부서존재하지 않은 
 부서테이블을 막겠다는 것 
 그래서 부서
 그래서 오라클에서는 속도적인 이슈로 인덱스를 반드시 생성하도록 강제로 생성한다 
 좀 더 세부적으로 이야기 하면 
 프라이머리키때문에 생긴게 아니라 유니크제약에 의해 유니크인덱스가 자동 생성되는 것이다.
 
 FOREIGN KEY 생성시 옵션
 폴인키는 (참조 무결성 ) : 참조하는 테이블의 컬럼에 존재하는 값만 입력 될 수 있도록 제한
 (예시. emp 테이블에 새로운 데이터를 입력시 deptno 컬럼에는 dept 테이블에 존재하는 부서번호만 입력될 수 있다 );
 
 foreign key가 생성됨에 따라서 데이터를 삭제할 때 유의점이 있다
 예를 들어서 어떤 테이블에서 참조하고 있는 데이터를 바로 삭제가 안된다.
 예 emp.deptno ==> DEPT.deptno 컬럼을 참조하고 있을 때 
    부서 테이블의 데이터를 삭제 할 수가 없다 
-- 여기부터 안됨     

SELECT *
FROM emp_test; 

INSERT INTO dept_test VALUES (98, 'ddit2', '대전');
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown', 99);
COMMIT;
emp : 9999, 99
dept : 98, 99
==> 98번 부서를 참조하는 emp 테이블의 데이터는 없음 
    99번 부서를 참조하는 emp 테이블의 데이터는 9999번 brown 사번이 있음 
    
 만약에 다음 쿼리를 실행하게 되면; 참조 무결성을 위배하기 때문에 9999가 99을 참조하기 때문에  
 DELETE dept_test
 WHERE deptno = 99; 
 제약조건에 대해서 위배가 되었다. 부모가 있어야 자식이 있는데 지금 부모를 없애 버렸기 때문에 
 위배가 된 것이다. emp테이블을 널로 다 업데이트를 하고 지우던가 ...;; 
 
 만약 emp 테이블에서 참조하는 데이터가 없는 98번 부서를 삭제하면 어떻게 될까 ? 
  DELETE dept_test
 WHERE deptno = 98; 
 에프케이를 걸었는 때 
 SELECT *
 FROM emp_test;
 
 FOREIGN KEY 옵션 
 1. ON DELETE CASCADE : 부모가 삭제될 경우(dept) 참조하는 자식 데이터도 같이 삭제한다(emp) ; --위험해서 잘 안ㅆ므
 2. ON DELETE SET NULL : 부모가 삭제될 경우 (deot)참조하는 자식 데이터의 컬럼을 null로 설정
 
 emp_test테이블을 DROP 후 옵셥을 번갈아 가며 생성 후 삭제 테스트;
 
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
지금 상황을 다시 정리하자면 
emp 테이블의 deptno 컬럼은 dept 테이블의 deptno 컬럼을 참조 (ON DELETE CASCADE)
옵션에 따라서 부모테이블(dpet_test)삭제시 참조하고 있는 자식 데이터도 같이 삭제된다.
DELETE dept_test
WHERE deptno = 99;

옵션 부여하지 않았을 때는 위의 DELETE 쿼리가 에러가 발생
옵션에 따라서 참조하는 자식 테이블의 데이터가 정상적으로 삭제가 되었는지 SELECT 확인;

SELECT *
FROM emp_test ;

이번에는 두번째 옵션 
FK ON DELETE SET NULL 옵션 테스트
부모 테이블의 데이터 삭제시 (dept_test) 자신테이블에서 참조하는 데이터를 null로 업데이트;
 ROLLBACK;
 -- 롤 백 한 뒤 잘 살아있는지 dept dhk 
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

dept_test 테이블의 99번 부서를 삭제하게 되면 (부모 테이블을 삭제하면 )
99번 부서를 참조하는 emp_test 테이블의 9999번(brown)데이터의 deptno컬럼을
FK 옵션에 따라 NULL로 변경한다; 

DELETE dept_test
WHERE deptno = 99;
ROLLBACK;

부모 테이블의 데이터(위의 dept_test) 삭제 후 자식 테이블의 데이터가 NULL로 변경되었는지 확인; 

SELECT *
FROM emp_test;

29 그레서 지금까지 

지금ㅇ느 30혼자 해보기 
세가지 옵션에 대해서 한번 복습하면서 해보기 

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2 (13)
    );


CHECK 제약조건 : 컬럼에 들어가는 값의 종류를 제한할 때 사용
ㅇㅖ : 급여 컬럼을 숫자로 관리, 급여가 음수가 들어갈 수 있을까 ?
        일반적인 경우 급여값은 > 0
        CHECK 제약을 사용할 경우 급여값이 0보다 큰값이 검사 가능.
        EMP테이블의 job 컬럼에 들어가는 값을 다음 4가지로 제한 가능 
        'SALESMAN', 'PRESIDENT'. 'ANALYST', 'MANAGER';
        
 테이블 생성시 컬럼 기술과 함께 CHECK 제약 생성
 emp_test 테이블의 sal 컬럼이 0보다 크다는 CHECK 제약조건 생성;
 
 INSERT INTO dept_test VALUES (99, 'ddit', '대전');--밑에 (여기 다시오류발생 이유는) 이거를 삭제했기때문에 그러니 다시 삽입하기  
 
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
 --여기 다시 오류 발생 
 INSERT INTO emp_test VALUES (9999, 'brown', 99, 1000);
 INSERT INTO emp_test VALUES(9998, 'sally', 99, -1000); (sal 체크조건에 따라 0보다 큰 값만 입력 가능 );-- 조건에 맞지 않아서 sal NUMBER CHECK (sal > 0)이거 때문에 오류발생
 
 31컬럼 기술 할때는 제약조건 이렇게 써야한다는 점  마지막컬럼 기술 할때 ,콤마를 꼭 넣어줘야한다는 점 
 34까지가 체크 제약조건 이런식으로도 제약조건 할 수 있다는것을 보여주심 
 그런데 체크제약은 단순한 형태밖에 안되기 때문에 생각보다 활용도는 높지 않다 
 그렇다면 디비에서 이것을 안ㅆ므녀 자바에서 미리 체크해서 정상적인 값을 ...;; 
 
 그다음 배우는 것이 35 기존 테이블을 통해서 셀렉트 시타스 

새로운 테읍ㄹ 생성
CREATE TABLE 테이블명 ( 
    컬럼1 .....
    ); 이런식으로 했었는데 ; 
    
 CREATE TABLE 테이블명 AS
 SELECT 결과를 새로운 테이블로 생성도 가능 하다 ; 
 
 예를 들어 
 emp 테이블을 이용해서 부서번호가 10인 사원들만 조회하여 해당 데이터로 
 emp_test2 테이블 생성;
 
 일단 emp 테이블에서 부서번호가 10번인 사원들만 조회해보자 
SELECT *
FROM emp
WHERE deptno = 10; 
그럼 이 세건의 데이터로 테이블을 만들어보쟈 
CREATE TABLE emp_test2 AS
SELECT *
FROM emp
WHERE deptno = 10;
--확인해보기 
SELECT *
FROM emp_test2;

35 시크스 명령을 통해 테이블을 생성하게 되면 36 낫널만 따른다 그러니 이건 개발할때 데이터 백업과 테스트 개발할때 사용한다. 백업을 쉽게 하고 싶을때 
그래서 예를 들어
SELECT *
FROM emp_20200210; 업데이트 해야하는데 불안해서 그날 날짜에 맞춰서 테이블을 생성한 것 즉 백업을 해놓은것이다 ; 하지만 보기엔 좋지 않다 정석 아니다 ;
CREATE TABLE emp_20200210 AS

그래서 이미있는 테이블로 사용이 가능하다면 이렇게 사용ㅎ을 한다. 

CREATE TABLE emp_test3 AS
SELECT empno, ename, sal
FROM emp
WHERE deptno = 10;

그리고 잘 쓰진 않지만 35 테이블 명 옆에 이름을 기술 할 수 있다 dept_test(      ) 하지만 자주쓰진 않음 참고만 하기 
여기서는 그냥 서브쿼리로 만들수 있다는 점 ;

이제는 37 변경을 통해서 우리가 제약조건을 ...
TABLE 변경
1.컬럼 추가
2. 컬럼 사이즈 변경, 타입변경
3.기본값 설정 
4.컬럼명을 RENAME
5.컬럼을 삭제
6. 제약조건 추가/삭제;

TABLE 변경 1.컬럼 추가 (HP VARCHAR2 (20)); 

DROP TABLE emp_test;
--오류ㅜ
CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    
    CONSTRAINT PK_emp_test PRIMARY KEY(empno),
    CONSTRAINT FK_emp_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
    );
    
ALTER TABLE 테이블명 ADD (신규컬럼명 신규컬럼 타입); 
    
ALTER TALBE emp_test ADD (HP VARCHAR2(20));
DESC emp_test;
    
SELECT *
FROM emp_test;


TABLE 변경 2.컬럼 사이즈변경, 타입변경
주의할 점 잘 안씀 왜냐면 
예 : 컬럼 VARCHAR2(20) ==> VARCHAR2(5)
    기존에 데이터가 존재할 경우 정상적으로 실행이 안될 확률이 매우 놓기 때문이다. 
    그래서 일반적으로는 데이터가 존재하지 않는 상테, 즉 테이블을 생성한 직후 컬럼의 사이즈, 타입이 잘못 된 경우
    컬럼 사이즈, 타입을 변경한다.
    
    데이터가 입력된 이후로는 활용도가 매우 떨어진다. (사이즈 늘리는 건 가능하지만 그 외는 안된다는 점 @!);
 
 DESC emp_test;
 hp VARCHAR(20) ==> HP VARCHAR(30);
 
 ALTER TABLE 테이블명 MODIFY (기존 컬럼명 신규 컬럼 타입 (사이즈));
 ALTER TABLE emp_test MODIFY (HP VARCHAR2(30));
 DESC emp_test;
 ----------------------
 이름     널?       유형           
------ -------- ------------ 
EMPNO  NOT NULL NUMBER(4)    
ENAME           VARCHAR2(10) 
DEPTNO          NUMBER(2)    
SAL             NUMBER   
-----------------------------

컬럼 타입 변경
hp VARCHAR2 (30) ==> HP NUMBER;
위에거 참조하여
ALTER TABLE emp_test MODIFY(HP NUMBER);

DESC emp_test;

컬럼 기본값 설정; 
ALTER TABLE 테이블명 MODIFY (컬럼명 DEFAULT 기본값);

HP NUMBER ==> HP VARCHAR(20) DEFAULT '010';
ALTER TABLE emp_test MODIFY (HP_N VARCHAR2(20) DEFAULT '010');
DESC emp_test;

hp컬럼에는 값을 넣지 않았지만 DEFAULT 설정에 의해 '010' 문자열이 기본값으로 저장된다; 
INSERT INTO emp_test (empno, ename, deptno) VALUES (9999, 'brown' , 99);

SELECT *
FROM emp_test;

TABLE 4.변경시 컬럼 변경 
변경하려고 하는 컬럼이 FK제약, PK제약이 있어도 상관없으니 이름바꾸는 것에 신경쓰ㄱㅣ 
ALTER TABLE 테이블명 RENAME COLUMN 기존 컬럼명 TO 신규 컬럼명;
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

테이블 변경 5. 컬럼삭제
ALTER TABLE 테이블명 DROP COLUMN 컬럼명
emp_test 테이블에서 hp_n 컬럼 삭제; 

emp_test에 hp_n 컬럼이 있는 것을 확인;
SELECT *
FROM emp_test;

ALTER TABLE emp_test DROP COLUMN hp_n;

emp_test hp_n 컬럼이 삭제되었는지 확인;

SELECT *
FROM emp_test;

***************************************************************<과제>;
1.emp_test 테이블을 drop한 후 empno, ename, deptno, hp 4개의 컬럼으로 테이블 생성 
2.empno, ename , deptno 3가지 컬럼에만 (9999, 'brown', 99)데이터로 INSERT 
3.emp_test 테이블의 hp 컬럼의 기본값을 '010'으로 설정
4.2번 과정에 입력한 데이터의 hp 컬럼 값이 어떻게 바뀌는지 확인 (그런데 값은 바뀌지 않을 것이다)
**********************************************************************************

TABLE 변경 6.제약조건 추가/ 삭제; 
ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 제약조건타입 (PRIMARY KEY, FOREIGN KEY) (해당컬럼);
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명; 

1.emp_test 테이블 삭제 후 
2.제약조건 없이 테이블 생성하기
3. PRIMARY KEY, FOREIGN KEY 제약을 ALTER TABLE 변경을 통해 생성;
4. 두개의 제약조건 테스트 
DROP TABLE emp_test;

CREATE TABLE emp_test (
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER (2));

ALTER TABLE emp_test ADD CONSTRAINT PK_emp_test PRIMARY KEY (empno);
ALTER TABLE emp_test ADD CONSTRAINT FK_emp_dept_test FOREIGN KEY (deptno) REFERENCES  dept_test (deptno);

PRIMARY KEY 테스트;
INSERT INTO emp_test VALUES (9999, 'brown' , 99);
INSERT INTO emp_test VALUES (9999, 'sally' , 99); 첫번째  INSERT 구문에 의해 중복되므로 실패;


FOREIGN KEY 테스트; 
INSERT INTO emp_test VALUES (9998, 'sally', 98); dept_test 테이블에 존재하지 않은 부서번호이므로 실패;

제약조건 삭제 : PRIMARY KEY, FOREIGN KEY;
ALTER TABLE emp_test DROP CONSTRAINT pk_emp_test;
ALTER TABLE emp_test DROP CONSTRAINT fk_emp_dept_test;

제약조건이 없으므로 empno 가 중복된 값이 들어갈 수 있고, dept_test 테이블에 존재하지 않은 
deptno 값도 들어갈 수가 있다;

INSERT INTO emp_test VALUES (9999, 'brown' , 99);
INSERT INTO emp_test VALUES (9999, 'sally', 99);

존재하지 않은 98번부서로 데이터 입력;
INSERT INTO emp_test VALUES (9998, 'sally', 98);

SELECT *
FROM emp_test;

엘터로 프라이머리 , 폴인 했음 
나머지 
NOT NULL, CHECK, UNIQUE         42 체크는 체크조건 함수도 썻네 사원 이름이 세글자가 넘어야하는 조건 삭제는 동일하기에 
                                낫널은 키워드는 많이 쓰기에 테이블 수정할 때 많이 쓰임 이 컬럼에 대해서 낫널이 추가 됨 
                                제약조건 해제 
                                43 제약조건 탭을 보면 STATUS을 볼 수 있을 것이다. 우리가 만약에 제약조건을 삭제하게되면 다시 만들어야함
                                잠깐 테스트용으로 빼고 싶은데 이걸 살리고싶으면 비활성화 시켰다가 활성화 시키면됨 
 
 제약조건 활성화/ 비활성화;
 ALTER TABLE 테이블명 ENABLE | DISABLE CONSTRAINT 제약조건명;
 
 1.emp_test 테이블 삭제
 2.emp_test 테이블 생성
 3.ALTER TABLE PRIMARY KEY(empno), foreign key(dept_test deptno) 제약조건 생성
 4. 두개의 제약조건을 비활성화
 5.비활성화가 되었는지 insert 를 통해 확인
 6.제약조건을 위배한 데이터가 들어간 상태에서 제약조건 활성화; 
 
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
emp_test 테이블에는 empno 컬럼의 값이 9999인 사원이 두명 존재하기 때문에 
primary key 제약조건이 활성화 할 수 없다.
==> empno 컬럼의 값이 중복되지 않도록 수정하고 제약조건 활성화 할 수 있다;
ALTER TABLE emp_test ENABLE CONSTRAINT PK_emp_test;
ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;   --ALTER TABLE emp_test DISABLE CONSTRAINT PK_emp_test중복된 데이터때문에 

empno 중복 데이터 제거;
DELETE emp_test
WHERE ename = 'brown';

primary key 제약조건활성화;
ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;

SELECT *
FROM emp_test;

dept_test 테이블에 존재하지 않는 부서번호 98을 emp_test에서 사용중
1.dept_test 테이블에 98번 부서를 등록하거나
2.sally의 부서번호를 99번으로 변경하거나
3.sally를 지우거나; 

update emp_test set deptno = 99
where ename = 'sally';

alter table emp_test enable constraint fk_emp_test_dept_test;
commit;

ALTER TABLE emp_test ENABLE CONSTRAINT fK_emp_test_dept_test;