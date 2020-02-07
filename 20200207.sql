TRUNCATE 테스트
1.REDO로그를 생성하지 않기 때문에 삭제시 데이터 복구가 불가하다.
2.DML(SELECT, INSERT, UPDATE, DELETE)이 아니라
  DDL로 분류(ROLLBACK이 불가)
  
 테스트 시나리오
 EMP테이블 복사를 하여 EMP_COPY라는 이름으로 테이블 생성
 EMP_COPY테이블을 대상으로 TRUNCATE EMP_COPY 실행
 
 EMP_COPY테이블에 데이터가 존재하는지 (정상적으로 삭제가 되었는지)확인;
 
 EMP_COPY테이블 복사;
 
 CREATE ==> DDL (ROLLBACK이 안된다.)
 CREATE TABLE EMP_COPY AS
 SELECT *
 FROM emp; 
 
 SELECT *
 FROM emp_copy;
 
 TRUNCATE TABLE emp_copy; 
 TRUNCATE TABLE 명령어는 DDL이기 때문에 ROLLBACK이 불가하다
 ROLLBACK 후 SELECT를 해보면 데이터가 복구 되지 않은 것을 알 수 있다;
 ROLLBACK;
 
 -------------------------------------------------------------------
 트랜젝션 : 여러 단계 과정을 하나의 작업 행위로 묶는 단위
            그래서  DML문장을 하나로 처리하기 위해 사용하는 것으로 
            DML문을 실행함과 동시에 트랙잭션이 시작된다. 
            COMMIT : 트랜젝션이 올바르게 종료하고 데이터를 확정할 떄 
            ROLLBACK : 
            
            실무적인 예 
            계시글 입력할 때 복수개 첨부파일 등록했을 떄
            게시글 내용안에 첨부파일을 세개 네게 할 때 (일반적으로 복수개가 첨부 파일을 할 수 있게끔 해야한다. )
            왜냐하면 나중에 확정성을 위해서 여러개로 첨부파일을 담을 수있는 테이블을 별도로 빼놓는 이유는 여러개 중복이 될때이다. 
            중복되는 속성 : 첨부파일을 별도의 테이블로 속성을 하면 유리하게 쓸 수있다 .
            만약 게시글이 잘 들어갔지만, 첨부파일에 저장이 제대로 안됬을 때 1번은 303
            디씨엘 디디엘은 롤백이 불가하다 
            읽기 일관성 : 브라운이 데이터 입력했는데 커밋을 안했을 때 
                        코니가 데이블 입력햇는데 브라운이 커밋을 안해서 변경하기 전의 데이터로 나오게 된다. 
                        작업이 일어날때 여러가지 작업을 하는데 코니입장에서 코니가 봐야할 데이터를 오라클에서 알아서 찾아준다 .
                        그래서 멀티블럭때문에 다른 문제점을 감해준다 .
                        그러니 확정을 줘야지만 데이터를 볼 수 있다 .
                        그러니 에스큐앨 실행시 306
                        그래서 읽기 일관성은 다른 사람에게 어떻게 영향을 미치는지 정의 총 레벨 4단계가 있다 
                        아이솔레이션  고이타레벨 0 리드 커미티드 오라클에선아쉽게도 얘는 지원 못해주기 때문에 선생님이 예시 못 보여주심 
                        그래서 다른 형태로 한게 리드언커미티드라고 한다. 
                        레벨1은 커밋되지 않은 데이터는 후행 트랜젝션에서 볼 수 없다. 이것이 일반적인 디비엠에스의 기본설정 
                        커밋을 안했더니 못 본 (예시)  우리가 알게모르게 썼던것 
                        309 T3시점에선 데이터가 6건의 데이터가 나온다 왜냐하면 이미 4건에 자기가 1건  실행 310
                        레벨 2는 리피터블리드 내가 읽은 데이터를 작업을 하고 싶어서 읽은 것인데 다른 트랜젝션이 수정하지 못하게끔하는 것
                        그래서 선행트랜젝션에서 같은 조회 쿼리를 실행시 결과가 같다 
                        내가 조회를 했을 때 다른 사람들이 못보게한다는 것 그런데 오라클에서는 이런 고식적이 지원을 못한다 그대신
                        비슷한 FOR 업데이트 절을 이용해서 그 효과를 얻을 수 있다. ;
                        (트랜젝션은 커밋이나 롤백을 해야 끝날 수 있다는 점 꼭 알아두자) 
                        하지만 후행 트랜잭션에선 신규입력은 가능하다  패텀 리드 (유령읽기)없던 데이터가 새로 조회되는 현상 
                        312 그래서 정식 오라클에선 없다 
                        313 레벨3 고위 레벨 트랜젝션이 선행 트랜젝션 하게 되면 후행 트랜젝션은 기다려야 한다 
                        그런데 이 아이는 공식적으로 지원을 해주는 아이기 때문에 314 우리가 수정을 해줘야한다. ? 
                        315 레벨3 이용한 결과 
                        그러니 고위타 레벨 할 수록 유리하지만, 임의로 올라는 것은 위험하니 이 레벨을 임의로 수정할 일은 없다 
                        그런데 오라클은 디비엠에스 라킹마카니즘이 다른 디엠에스와 차이가 있어 일관성 레벨을 오려도 타 디비엠에스 만큼 동시성이 
                        저하되지 않는다. 하지만 메카니즘의 차이로 다른 디엠에스에 없는 에러가 있다. 
                        스냅스  오라클로 프로그램이기 때문에 메모리게 옮겨 두지만, 한계가 있다 . 305 오라클에서 데이터블럭을 이력에 따라멀티버전을
                        할 수 있는건가 ? 
                        오래된거 내려보내는 것 오라클에서도 누군가가 인설트 할 때 데이터가 변경이 되고 여러가지 버전으로 기록을 남기게 되는데
                        이것이 많아지게 되면 용량이 한계가 오기때문에 내려보낸다 .
                        그래서 최종적으로 발생하는 오류가 317에 나온 스냅스 에러이다. 
                        그런데 이 에러는 최근에는 잘 보기 어렵다 너무 좋아져서 
                        하지만 이거 몰라도 괜찮다 ^^
                        이제 PART 2 할 ㅊㅏ례 
                        DML 부분 다 배웠고 이제는 DDL 배울 차례이다. 
                        인라인은 별도의 뷰(인라인뷰를 사전에 정리한것 )로 만든 것 
                        오라클의 객체를 삭제하고 추가하는 거 배울 것임 
                        오라클의 대표적인 객체들이다. 
                        P2. 테이블:  데이터저장소로 순서를 보장하지 않는다 그저 그냥 빈 공간
                            그 전에 인덱스라는 것으로 성능향상을 위해 컬럼순으로 정렬을 한다 
                            뷰는 인라인 뷰를 실제 객체로 생성한 것으로 재사용이 가능하다. 
                            시컨스는 중복되지 않는 숫자를 생성하는 것이다. 객체로 존재하는 것이다. 그래서 예를 들어 사본, 순차적값을 중복되지안흔것 
                            시는? 별칭의 뜻으로 오라클의 객체를 다른이름으로 부를수 있게끔 하는 것이다. 
                            
                        우리가 이제는 테이블을 만들어 볼 것이다. 
                        규칙이 있다. 영문자로 시작, 길이는 1~30글자, 알파벳 대소문자,_,$,#만 사용 가능하다 (자바에선 _,$만 허용)
                                    해당 유저가 소유한 다른 객체와 이름이 겹치면 안된다.  숫자 가능 , 
                                    또한 오라클 키워드와 객체명이 동일할 수 없다. 
                        드랍은 디디엘로 롤백이 안된다. 
                       
DDL : DATE Defintion Language - 데이터 정의어
 객체를 생성, 수정, 삭제시 사용
 ROLLBACK 불가 
자동 COMMIT 해야한다 ;
             
 테이블 생성
 CREATE TABLE [스키마명.(접속개정이라고 생각하면 된다.)]테이블명(
     컬럼명 컬럼타입 [DEFAULT 기본값] ,   --[기본값을 설정(할 수있다)]
     컬럼2명 컬럼2타입 [DEFAULT 기본값],.....
 );
 
 ranger라는 이름의 테이블 생성해보기 ; 
 CREATE TABLE ranger (
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE 
    );
    
    --테이블이 정상적으로 실행이 되면 
 SELECT *
 FROM ranger;
 
 INSERT INTO ranger(ranger_no, ranger_nm)  VALUES(1, 'brown');   --데이터 입력
 COMMIT;    --잘 들어갔는지 다시한번더 테이블 실행해보고 커밋해주기 
 
 --그럼 이번엔 생성을 햇다면 삭제도 해볼까 
                     
 테이블 삭제
DROP TABLE 테이블명 ; 

DROP TABLE ranger;    --ranger 테이블 삭제(drop)

SELECT *
DROP ranger;

DDL은 올백 불가;      --그리고 당연히 드롭을 하면 데이터는 당ㅇ히 삭제되며 관련된 객체까지 삭제가 된다 ㅡ 또한 롤백 안됨!! 그래서 운영디비에서 주의 
ROLLBACK;           --운영회사를 다 관리를 해야하는 거라면 위험하다 

6
7데이터 파일 선언할때 자주쓰는 것 
    우리가 문자열을 다루는 타입은 다차2와 캐릭터가 있다 
    다차2눈 가변길이문자열이다. 해당문자열을 넣고 타이핑을 할 수 있는데 다차라고 써놨어도 3바이트까지만 넣을 수있으며 사이즈는 4000바이트만가능 (약 130자)
    캐릭터는 고정길이 문자열이다. 캐릭터같은 경우는 
    
데이터타입
문자열  (캐릭터를 쓰지 말라고 공식적으로 말함 다차2 사용, 캐릭터타입 지양)
varchar2(10) : 가변길이 문자열, 사이즈 1~4000byte
                입력되는 값이 컬럼 사이즈보다 작아도 남은 공간을 공백으로 채우지 않는다
char(10) : 해당 컬럼에 문자열으 5btye만 지정하면 나머지 5byte 공백으로 채워진다.
            'test' ==> 'test'
            'test' != 'test     '    --다섯칸 공백으로 채워진다는 점 

숫자
숫자는 크게 한가지만 알면된다
NUMBER(p,s) : P - 전체 자리수 (38) ㅡ S - 소수점 자리수
INTEGER ==> NUMBER(38,0)
ranger_no NUMBER ==> NUMBER(38, 0)

날짜
DATE - 일자와 시간 정보를 저장
        7BYTE 
        
 *날짜를 데이테타입으로 관리하는 곳이 있고 다차2로 관리하는 회사가 있다*
   - DATE --7바이트      
   - VARCHAR(8) '20200207'   --사이즈 8바이트     
          위 두개의 타입은 하나의 데이터당 1BYTE의 사이즈가 차이가 난다. 
          데이터 양이 많아지게 되면 무시할 수 없는 사이즈로, 설계시 타입에 대한 고려가 필요하다; 
 
LOB(Lage OBject) 큰객체 -  최대 4GB
CLOB - Character Large OBject(캐릭터를 담을 수 있는 큰 객체)
        vachar2로 담을 수 없는 사이즈의 문자열 (4000byte 초과 문자열)   
        ex : 웹 에디터에서 생성된 html코드 
        
BLOB - Byte Large OBject 
        파일을 데이터베이스의 테이블에서 관리할 때 사용한다.
        
        일반적으로 게시글 첨부파일을 테이블에 직접 관리하지 않고 
        보통 첨부파일을 디스크의 특정 공간에 저장하고, 해당 [경로]만 문자열로 관리한다 (일반적으로 )
        
        그런데 만약
        첨부파일이 날라갔을때 괜찮은 경우도 있지만,
        파일이 매우 중요한 경우 : 예> 고객 정보사용 동의서  -> [파일]을 테이블에 저장을 한다. 
        
  10P DDL에서 나오기 애매한 장 데이터에서 특정 필드를 추철할 수 있다 (요일 날짜 등 ) 참고만 하기  
 데이트로부터 일자를 가져올 수 있고 
 익스트렉트로 가져올 수도 있고
 
 이번엔 어려워
 DDL 제약조건 
 제약조건이란 데이터가 무결성을 지키로록 위한 설정
            예, 학원에 동일한 사람이 들어올 수 없다. 그래서 151001001 이진우
                                                    151001002 유웅 
1. UNIQUE 제약조건
    해당 컬럼의 값이 다른 행의 데이터와 중복되지 않도록 제약 
    예시> 사번이 같은 사원은 있을 수가 없다 
2. NOT NULL 제약조건(CHECK  제약조건)
    해당 컬럼에 값이 반드시 존재해야하는 제약이 있다
    가장 대표적인 예시로 사번 컬럼에 NULL인 사원은 존재할 수가 없다. 
                    회원가입시 필수 입력사항 (GITHUB -이메일이랑 이름)
3. PRIMART KEY 제약조건
    UNIQUE제약 + NOT NULL제약조건 합쳐진것 
    예시> 사번이 같은 사원이 있을 수가 없고, 사번이 없는 사원이 있을 수가 없다. 
    PRIMARY KEY 제약 조건을 생성할 경우 해당 컬럼으로 UNQUE INDEX가 생성한다   --나중에 자세히 설명해주실것임 
    
    
4. FOREIGN KEY 제약 조건 (참조무결성)
    해당 컬럼이 참조하는 다른 테이블에 값이 존재하는 행이 있어야 한다.
    emp 테이블의 deptno컬럼이 dept테이블의 deptno컬럼을 참조(관계)
    emp테이블의 deptno컬럼에는 dept 테이블에 존재하지 않는 부서번호가 입력 될 수 없다.
    예> 만약 dept 테이블의 부서번호가 10, 20, 30, 40번만 존재 할 경우
        emp 테이블에 새로운 행을 추가하면서 부서번호 값을 99번으로 등록할 경우 
        행 추가가 실패한다 

5. CHECK 제약조건(값을 체크 ) --많이 쓰진 않음
    NOT NULL 제약조건도 CHECK 제약에 포함된다
    emp 테이블에 job컬럼에 들어 올 수 있는 값을 'SALESMAN', 'PRESIDENT', 'CLEARK'
    
 제약조건 생성 방법
 1. 테이블을 생성하면서 컬럼에 기술 
 2. 테이블을 생성하면서 컬럼 기술 이후에 별도로 제약조건을 기술
 3. 테이블 생성과 별도로 추가적으로 제약저건을 추가
 
 CREATE TABLE 테이블명(
    컬럼1 컬럼 타입 [1.제약조건],
    컬럼1 컬럼 타입 [1.제약조건]
    
    [2.TABLE_CONSTRAINT]--별도로 제약조건을 걸 수 있음
  );  
  
3. ALTER TABLE emp....;

이제는 실습해볼 차례 

PRIMARY KEY 제약조건을 컬럼 레벨로 생성 (1번 방법) --1번 옆에다가 기술을 하겠다 .
dept 테이블을 참고하여 dept_test 테이블을 PRIMARY KEY 제약조건과 함께 생성한다
단, 이 방식은 테이블의 KEY컬럼이 복합 컬럼은 불가하고 단일컬럼일때만 가능하다 ;
--이 형태는 테스트 형태로 많이 쓴다 . 
CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    danme  VARCHAR2(14),
    loc VARCHAR2(13)
);

DESC dept;

INSERT INTO dept_test (deptno) VALUES(99); 정상적으로 실행;
INSERT INTO dept_test (deptno) VALUES(99); --unique constraint (SIM.SYS_C007090) violated : 바로 위의 쿼리를 통해 같은 값의 데이터가 이미 저장됨 

참고사항 부서테이블에 할 것임  우리가 지금까지 기존에 사용한  dept테이블의 deptno컬럼에는
UNIQUE 제약이나 PRIMART KEY 제약 조건이 없었기 때문에 
아래 두개의 INSERT 구문이 정상적으로 실행되는 것이다 ;  
INSERT INTO dept (deptno) VALUES(99);
INSERT INTO dept (deptno) VALUES(99);
ROLLBACK;

다른사람이 제약조건을 만들었나 확인하는 방법
제약조건 확인방법; 
1. TOOL을 통해 확인한다
    확인하고자 하는 테이블을 선택; 예를 들면 DEPT테이블을 클릭하게 되면 상단에 제약조건이 있다 제약조건 컨시에티 이름은 그 숫자는 오라클에서 이름을 임의로 부여한것이다. 
2. dictionary 를 통해 확인한다. (우리가 이미 사용했다 .
                               user_tables;
  SELECT *
  FROM USER_CONSTRAINTS
  WHERE tabLe_name = 'DEPT_TEST'; --대문자로 써야한다
  
  SELECT *
  FROM USER_CONS_COLUMNS;  제약조건이름을 복사한 이유는 여기에 조건을 쓰기 위한 것이다. 
  WHERE CONSTRAINT_NAME = 'SYS_C007090'; --이름번호는 다를 수 있다
  
 이것보다 좋은것은 exerd에서 모델링을 보고 판단하는 것이다
 3.모델링 (ex. exerd) 콜인키 . 
    
 제약조건 명을 기술하지 않을 경우 오라클에서 제약조건이름을 임의로 부여한다. (ex :  SYS_C007090)
 그런데 이렇게하면 가독성이 떨어지기 때문에 
 명명규칙을 지정하고 생성하는게 개발, 운영 관리에 유리하다.
 PRIMARY KEY 제약조건 : PK_테이블명
 PRIMARY KEY 제약조건 : FK_대상테이블명_참조형테이블명;
 
 DROP TABLE dept_test;
 
 컬럼 레벨의 제약조건을 생성하면서 제약조건 이름을 부여
 CONSTRAINT 제약조건명 제약조건타입(PRIMARY KEY);
 
 CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    danme  VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test (deptno) VALUES(99);  -- 그러나 모든 조건에 제약조건을 달 필요는 없다 
INSERT INTO dept_test (deptno) VALUES(99);




2.테이블 생성시 컬럼 기술이후 별도로 제약조건 기술;
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2), 
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)--여기다가 컬럼 명 지정해준다   
);
    


NON NULL 제약조건 생성하기
1. 컬럼에 기술하기(O)
    단 컬럼에 기술하면서 제약조건 이름을 부여하는 건 불가하다;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) 
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);

NOT NULL 제약조건 확인;
INSERT INTO dept_test (deptno, dname) VALUES(99, NULL);

2. 테이블 생성시 컬럼 기술 이후에 제약 조건 추가; 
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) CONSTRAINT NM_dept_test_dname CHECK (dname IS NOT NULL),
    loc VARCHAR2(13)
    
);

UNIQUE 제약 : 해당 컬럼에 중복되는 값이 들어오는것을 방지한다. 단, NULL은 입력이 가능하다
PRIMARY KEY = UNIQUE + NOT NULL;

1. 테이블 생성시 컬럼 레벨 UNIQUE 제약조건
     dname 컬럼에 UNIQUE 제약조건;
     
DROP TALBE dept_test;     
CREATE TABLE dept_test(
    deptno NUMBER(2),CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14)UNIQUE,
    loc VARCHAR2(13)
    
);

dept_test 테이블의 dname컬럼에 설정된 unoque 제약조건을 확인;
INSERT INTO dept_test VALUES(98, 'ddit' , 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit' , 'daejeon');

2.테이블 생성시 컬럼에 제약조건 기술, 제약조건 이름 부여;
DROP TALBE dept_test;     
CREATE TABLE dept_test(
    deptno NUMBER(2),CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14)UNIQUE UK_dept_test_dname UNIQUE,
    loc VARCHAR2(13)
    
);

dept_test 테이블의 dname컬럼에 설정된 unoque 제약조건을 확인;
INSERT INTO dept_test VALUES(98, 'ddit' , 'daejeon');
INSERT INTO dept_test VALUES(99, 'ddit' , 'daejeon');

3. 테이블 생성시 컬럼 기술이후 제약조건 생성- 복합컬럼 (deptno-dname)(UNIQUE);
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT UK_dept_test_deptno_UNIQUE(deptno, dname)
);    

복합 컬럼에 대한 UNIQUE 제약 확인 (deptno, dname);
INSERT INTO dept_test VALUES (99, 'ddit', 'deajeon');
INSERT INTO dept_test VALUES (98, 'ddit', 'deajeon');
INSERT INTO dept_test VALUES (98, 'ddit', '대전 '); -- 유니크제약조건이 위배함 

지금까지 한게 21p 
foreign key  22 사원테이블에는 부서테이블이 존재하지 ㅇ낳는 값을 저장할 수 있고 폴인은 제약이 될 수 있다는 점 

FOREIGN KEY 제약조건
참조하는 테이블의 컬럼에 존재하는 값만 대상 테이블의 컬럼에 입력할 수 있도록 설정
EX : emp테이블에서 deptno 컬럼에 값을 입력할 때 , dept테이블의 deptno 컬럼에 존재하는 부서번호만 
     입력 할 수 있도록 설정
     존재하지 않는 부서번호를 emp 테이블에서 사용하지 못하게끔 방지; 
     

1.dept_test 테이블생성
2.emp_test 테이블 생성 
  .emp_test 테이블 생성시 deptno 컬럼으로 dept.deptno 컬럼을 참조하도록 FK를 설정; 
 
 DROP TABLE dept_test;
 CHECK TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT pk_dept_test PRIMARY KEY
    );
    
DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno),
    
    CONSTRAINT pk_EMP_TEST PRIMARY KEY (empno)
    );
    
 데이터 입력순서 
 emp_test 테이블에 데이터를 입력하는 게 가능한가 ? 
    .지금상황(dept_test, emp_test 테이블을 방금 생성 - 데이터가 존재하지 않을 때 )
 INSERT INTO emp_test VALUES (9999, 'brown', NULL);  FK이 설정된 컬럼에 NULL은 허용;
 INSERT INTO emp_test VALUES (9999, 'sally', 10); 10번 부서가 dept_test 테이블에 존재하지 않아서 에러;
 
 deopt_test 테이블에 데이터를 준비;
 INSERT INTO dept_test VALUES (99, 'ddit', 'deajeon');
 INSERT INTO emp_test VALUES(9998, 'sally', 10);  10번 부서가 dept_test에 존재하지 않으므로 에러 
 INSERT INTO emp_test VALUES (9999, 'sally', 99); 99번 부서는 dept_test에 존재하지 않으므로 정상 실행;
 
 
 테이블 생성시 컬럼 기술 이후 foreign key 제약조건 생성
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR(14),
    loc VARCHAR2(13),
    CONSTRAINT pk_dept_test PRIMARY
    
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT FK_emp_test FOREIGN KEY (deptno) PRIMARY dept_test (deptno)
 );
 
 INSERT INTO emp_test VALUES (9999, 'brown', 10); dept_test 테이블에 10번 부서가 존재하지 않아 에러;
 INSERT INTO emp_test VALUES (9999, 'brown', 99); 정상 실행 
    
    );