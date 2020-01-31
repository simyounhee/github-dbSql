--과제 fn1
SELECT sysdate-29 AS "LASTDAY",        --sysdate 현재 날짜   / , 꼭 넣어주기 !! / dual 빈 테이블
       sysdate -34 AS"LASTDAT_BEFORE5",
       sysdate As,
       sysdate -3 AS  "NOW_BEFORE3" 
FROM dual;


--DATE : TO_DATE 문자열 -> 날짜(DATE)
--       TO_CHAR 날짜 -> 문자열(날짜 포맷 지정)
-- JAVA에서는 날짜 포맷의 대소문자를 가린다 (MM / mm -> 월, 분)
-- 주간일자(1~7) :  일요일 1, 월요일 2 ......토요일 7
-- ( )주 차 IW : ISO표준 - 해당 주의 목요일을 기준으로 ( )주 차를 산정
--           2019/12/31 화요일 --> 2020/01/02(목요일) --> 그렇기 때문에 1주 차로 산정

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),          --오늘은 2020/01/29/수
       TO_CHAR(SYSDATE, 'D'),                              --오늘 중간 날짜 구해보기  4가 나오면 정상이기에 위에 나온 문자 대입해보기
       TO_CHAR(SYSDATE, 'IW'),                             --오늘날짜가 몇주째에 포함되는지 알아보기 
       TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'), 'IW')  
FROM dual;



-- emp 테이블의 hiredate(입사일자)컬럼의 년월일 시:분:초
SELECT ename, hiredate,
       To_CHAR(hiredate, 'YYYY-MM-DD HH24:MI:ss'), 
       To_CHAR(hiredate + 1,'YYYY-MM-DD HH24:MI:ss'),
       To_CHAR(hiredate + 1/24, 'YYYY-MM-DD HH24:MI:ss'),
       --hiredate에 30분을 더하여 TO_CHAR로 표현
       To_CHAR(hiredate + (1/24/60)*30, 'YYYY-MM-DD HH24:MI:ss')
FROM emp;

--실습 fn2
SELECT 
    To_CHAR(SYSDATE,'YYYY-MM-DD') AS DT_DASH,
    To_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') AS DT_DASH_WITH_TIME,
    To_CHAR(SYSDATE, 'DD-MM-YYYY') AS DT_DD_MM_YYYY
FROM dual;


--MONTHS_BETWEEN(DATE, DATE)
SELECT ename, hiredate,
        MONTHS_BETWEEN(hiredate,sysdate)     --  
FROM emp
WHERE ename='SMITH';
--
SELECT ename, hiredate,
        MONTHS_BETWEEN(sysdate, hiredate)        
FROM emp
WHERE ename='SMITH';
--
SELECT ename, hiredate,
        MONTHS_BETWEEN(sysdate, hiredate),   --일자까지만 일치시켜주면      
        MONTHS_BETWEEN(TO_DATE('2020-01-17', 'YYYY-MM-DD'), hiredate)       
FROM emp
WHERE ename='SMITH';


--ADD_MONTHS(DATE, 정수-가감할 개월수)
SELECT ADD_MONTHS(SYSDATE, 5),   --2020/01/29   --> 2020/06/29
       ADD_MONTHS(SYSDATE, -5)  --2020/01/29   --> 2020/08/29
FROM dual;


-- NEXT_DAY(DATE, 주간일자), ex: NEXT_DAY(SYSDATE, 5) --> SYSDATE이후 처음 등장하는 주간일자 5(목)에 해당하는 일자
--                                SYSDATE 2020/01/29(수) 이후 처음 등장하는 5(목)요일 -> 2020/01/30(목)
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;


--LAST_DAY(DATE) DATE가 속한 월의 마지막 일자를 리턴
SELECT LAST_DAY(SYSDATE) --SYSDATE 2020/01/29 --> 2020/01/31
FROM dual;


---문제. LAST _DAY를 통해 인자로 들어온 date가 속한 월의 마지막 일자를 구할 수 있는데
--      date의 첫번째 일자는 어떻게 구할까?
SELECT SYSDATE,
        LAST_DAY(SYSDATE),
        TO_DATE('01','DD'),       --첫번째 방법
       ADD_MONTHS(LAST_DAY(SYSDATE)+1,-1),  --두번째 방법 
       TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM') || '-01', 'YYYY-MM-DD')  --세번째 방법
FROM dual;


--hiredate 값을 이용하여 해당 월의 첫번째 일자로 표현해보기
SELECT ename, hiredate
FROM emp;
-- 풀이
SELECT ename, hiredate,
       ADD_MONTHS(LAST_DAY(hiredate) +1, -1)            
FROM emp;
-- 또 다른 풀이
SELECT ename, hiredate,
       TO_DATE(TO_CHAR(hiredate, 'YYYY-MM') || '-01', 'YYYY-MM-DD')
FROM emp;


--empno는 NUMBER타입, 인자는 문자열
--타입이 맞지 않기 때문에 묵시적 형변환이 일어남
--테이블 컬럼의 타입에 맞게 올바른 인자 값을 주는것이 중요
SELECT *
FROM emp
WHERE empno='7369';
--


--hiredate의 경우 DATE차입, 인자는 문자열로 주어졌기 때문에 묵지석 형변환이 발생
--날짜 문자열 보다 날짜 타입으로 명시적으로 기술하는 것이 좋음
SELECT *
FROM emp
WHERE hiredate = '80/12/17';       --안되는 이유는 ? 설정을 yyyy로 바꿨기 때문에 .. 그러니 1980
--올바른 풀이
ELECT *
FROM emp
WHERE hiredate = ;


EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';
   1 - filter("EMPNO"=7369)      --자동적으로 형변환된것 
--숫자를 문자열로 바꾸는것 (이렇게는 쓰지 말아야한다는 예시를 보여준 것) 
EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_DATE(empno)='7369';
   

SELECT *
FROM table(dbms_xplan.display);



--                          숫자를 문자로 왜 바꿀까 ? 
--숫자를 문자열로 변경하는 경우 : 포맷때문에 
--천단위 구분자
--1000이라는 숫자를 
--한국 : 1,000.50
--독일 : 1,000,50

--emp sal 컬럼(NUNMBR 타입)을 포맷팅
-- 9 : 숫자
-- 0 : 강제 자리 맞춤(0으로 표기)
-- L : 통화단위
SELECT ename, sal, TO_CHAR(sal, '9,999')
FROM emp;
--
SELECT ename, sal, TO_CHAR(sal, '0,999')
FROM emp;
--
SELECT ename, sal, TO_CHAR(sal, 'L0,999')
FROM emp;



--NULL처리 하는 이유는 ?
--NULL에 대한 연산의 결과는 항상 NULL
--emp 테이블의 sal 컬럼에는 null 데이터가 존재하지 않음 (14건의 데이터에 대해)
--emp 테이블의 comm 컬럼에는 null 데이터가 존재(14건의 데이터에 대해)
--sal + comm --> comm인 null인 행에 대해서는 결과 null로 나온다
--요구사항이 comm이 null이면 sal 컬럼의 값만 조회
--요구사항이 충족 시키지 못한다 -> SW에서는 [결함]

--NVL(타겟, 대체값)
--타겟의 값이 NULL이면 대체값을 반환하고
--타겟의 값이 NULL이 아니면 타겟 값을 반환
--if (타겟 == null )
--      reture 대체값; 
-- else
--      reture 타겟;
SELECT ename, sal, comm, sal+comm
FROM emp;
--
SELECT ename, sal, NVL(comm, 0), 
       sal+NVL(comm, 0),
        NVL(sal+comm, 0)
FROM emp;


--NVL2(expr1, expr2, expr3)     첫번째 인이,,,,, *******************
--if(expr1 != NULL)
--      return expr2
--else
--      return expr3;
SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;


--NULLIF(expr1, expr2)
-- if(expr1 == expr2)
--      return null;
--else
--      return expr1;

--sal 1250인 사원은 null을 리턴, 1250이 아닌사람은 sal를 리턴
SELECT ename, sal, comm, NULLIF(sal, 1250) 
FROM emp;


--가변인자
--COALESCE 인자중에 가장 처음으로 등장하는 NULL이 아닌 인자를 반환한다 
--COALESCE(expr1, expr2....)
--if(expr1 != null)
--  return expr1;
--else
--  return COALESCE(expr2, expr3....);

--COALESCE(comm, sal) : comm이 null이 아니면 comm
--                        comm이 null이면 sal (단, sal 컬럼의 값이 NULL이 아닐때) 
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;


--실습 fn4    (nvl, nvl2, coalesce 이용)       **********
SELECT empno, ename, mgr, 
       nvl(mgr, 9999) mgr_n,
       nvl2(mgr, mgr, 9999),
       coalesce( mgr,9999)
FROM emp;


--pair programing (짝 협동 코딩 엇비슷한 사람들끼리해야 도움이 됨)


--실습 fn5
SELECT userid, usernm, reg_dt     
FROM users;
--
SELECT userid, usernm, reg_dt, nvl(reg_dt, SYSDATE) n_reg_dt     
FROM users
WHERE userid != 'brown';


--Condition : 조건절
--CASE : JAVA의 if - else if - else
--쓰는 법
-- CASE
--      WHEN 조건 THEN 리턴값1
--      WHEN 조건2 THEN 리턴값2
--      ELSE 기본값
-- END
-- emp 테이블에서 job 컬럼의 값이 SALESMAN 이면 SAL * 1.05 리턴
--                             MANAGER 이면 SAL * 1.1 리턴
--                             PRESIDENT 이면 SAL * 1.2 리턴
--                             그 밖의 사람들은 SAL을 리턴
SELECT ename, job, sal,
       CASE
           WHEN job = 'SALESMAN' THEN SAL * 1.05
           WHEN job = 'MANAGER' THEN sal * 1.1
           WHEN job = 'PRESIDENT' THEN sal * 1.2
           ELSE sal
       END bonus_sal
FROM emp;

--DECODE 함수 : CASE절과 유사
-- (다른점 CASE절 : WHEN 절에 조건비교가 자유롭다
--      DECODE 함수 : 하나의 값에 대해서 = 비교만 허용
--DECODE 함수 : 가변인자(인자의 개수가 상황에 따라서 늘어날 수가 있음)
--DECODE(col|expr, 첫번째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을경우 반환 값,
--                  첫번째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을경우 반환 값....
--  비교대상이 없을때  option - else 최종적으로 변환할 기본값)



--응용문제
-- emp 테이블에서 job 컬럼의 값이 SALESMAN 이면서  sal가 1400보다 크면 SAL * 1.05 리턴
--                             SALESMAN 이면서  sal가 1400보다 작으면 SAL * 1.1 리턴
--                             MANAGER 이면 sal * 1.1 리턴
--                             PRESIDENT이면 SAL * 1.2 리턴 
--                             그 밖의 사람들은 SAL을 리턴 


SELECT ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;       
--1. CASE 만 이용해서
SELECT ename, job, sal,
       CASE
           WHEN job = 'SALESMAN' AND SAL > 1400 THEN SAL * 1.05
           WHEN job = 'SALESMAN' AND SAL < 1400 THEN SAL * 1.1
           WHEN job = 'MANAGER' THEN sal * 1.1
           WHEN job = 'PRESIDENT' THEN sal * 1.2
           ELSE sal
       END bonus_sal
FROM emp;
--2. DECODE, case      
--                      DECODE안에 CASE나 DECODE 구분이 중첩이 가능하다. 
SELECT ename, job, sal,
       DECODE(job,  'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, 
                     CASE
                       WHEN job = 'SALESMAN' AND SAL > 1400 THEN SAL * 1.05
                       WHEN job = 'SALESMAN' AND SAL < 1400 THEN SAL * 1.1
                       ELSE sal
                   END
                    ) bonus_sal
FROM emp;


-- emp 테이블에서 job 컬럼의 값이 SALESMAN 이면서  sal가 1400보다 크면 SAL * 1.05 리턴
--                             SALESMAN 이면서  sal가 1400보다 작으면 SAL * 1.1 리턴
--                             MANAGER 이면 sal * 1.1 리턴
--                             PRESIDENT이면 SAL * 1.2 리턴 
--                             그 밖의 사람들은 SAL을 리턴

SELECT ename, job, sal,
    DECODE (job, 'SALESMAN', CASE
                                 WHEN sal > 1400 THEN sal * 1.05
                                 WHEN sal < 1400 THEN sal * 1.1
                                 END,
                  'MANAGER', sal * 1.1,
                  'PRESIDENT', sal * 1.2
                  ELSE sal)