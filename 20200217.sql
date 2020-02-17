:dt ==> 202002;

SELECT DECODE (d, 1, iw+1, iw)i,
       MIN (DECODE(d, 1, dt)) sun,
       MIN (DECODE(d, 2, dt)) mon,
       MIN (DECODE(d, 3, dt)) tue,
       MIN (DECODE(d, 4, dt)) wed,
       MIN (DECODE(d, 5, dt)) tur,
       MIN (DECODE(d, 6, dt)) fri,
       MIN (DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (LEVEL -1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL -1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') + (LEVEL -1), 'iw') iw
FROM dual
CONNECT BY LEVEL  <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'DD'))
GROUP BY DECODE (d, 1, iw+1, iw)
ORDER BY DECODE (d, 1, iw+1, iw);
----------------------------------------------------------
실습 달력 쿼리 3p
1. 해당 월의 1일자가 속한 일요일 구하기
2. 해당 월의 마지막 일자가 속한 주의 토요일 구하기
3. 2-1을 하여 총 일수 구하기 
요일을 숫자로 표현할 수 있다
일주일 7개(1~7);

20200401 ==> 20200329(월요일)
20200430 ==> 20200502(토요일)
SELECT dt - (7-d),
        NEXT_DAY(dt2, 7)
FROM;  

SELECT TO_DATE(:dt || '01','YYYYMMDD') dt,
        TO_CHAR(TO_DATE (:dt || '01', 'yyyymmdd'), 'D') d,
        
        LAST_DAY(TO_DATE (:dt, 'yyyymm')) dt2,
        TO_CHAR(LAST_DAY(TO_DARE(:dt, 'yyyymm')), 'D')d2
FROM dual)
CONNECT BY LEVEL  <= NEXT_DAY(LAST_DAY(TO_DATE(:dt, 'yyyymm')) ,7)
                    -(TO_DAYE(:dt, 'yyyymm') - ((TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1));


기존 : 시작일자 1일, 마지막 날짜 : 해당월의 마지막 일자 ;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;
CONNECT BY LEVEL <= LAST_;    


변경 : 시작일자 : 해당월의 1일자가 속한 주의 일요일
      마지막 날짜 : 해당월의 마지막일자가 속한 주의 토요일
SELECT TO_DATE('20200126', 'YYYYMMDD') + (LEVEL -1)
FROM dual
CONNECT BY LEVEL <= 35;
---------------------------------------------------------------------------------------
원본쿼리 1일~말일자;
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  TO_CHAR(last_day(to_date(:dt,'yyyymm')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

1일자가 속한 주의 일요일구하기
마지막일자가 속한 주의 토요일구 하기
일수 구하기; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1일자, 말일자가 속한 주차까지 표현한 달력
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
-------------------------------------------------------------------------------------------------------------
실습 - 달력만들기 1

SELECT DT,MAX(sales)
FROM sales
GROUP BY DT ;

1. dt (일자) ==> 월, 월단위별 SUM(SALES) ==> 월의 수만큼 행이 그룹핑 된다.
SELECT NVL(SUM(jan),0) jan, NVL(SUM(feb),0) feb, 
       NVL(SUM(mar),0) mar,NVL(SUM(apr),0) apr, 
       NVL(SUM(may),0) may, NVL(SUM(jun),0) jun
FROM
(SELECT DECODE(TO_CHAR(dt, 'MM'),'01',  SUM(SALES)) JAN,
       DECODE(TO_CHAR(dt, 'MM'),'02',  SUM(SALES)) FEB,
       DECODE(TO_CHAR(dt, 'MM'),'03',  SUM(SALES)) MAR,
       DECODE(TO_CHAR(dt, 'MM'),'04',  SUM(SALES)) APR,
       DECODE(TO_CHAR(dt, 'MM'),'05',  SUM(SALES)) MAY,
       DECODE(TO_CHAR(dt, 'MM'),'06',  SUM(SALES)) JUN,
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));




SELECT *
FROM dept_h;

오라클 계층형 쿼리 문법
SELECT ...
FROM ...
WHERE
START WITH 조건 : 어떤 행을 시작점으로 삼을지

CONNECT BY 행과 행을 연결하는 기준 
          PRIOR : 이미 읽은 행 
          "   " : 앞으로 읽을 행 ; 
          
하향식 : 가장 상위에서 지식노드로 연결 (위 ==> 아래);

XX회사(최상위 조직)에서 시작하여 부서로 내려가는 계층 쿼리 ; 

SELECT LPAD(' ', 4, '*')
FROM dual;

SELECT dept_h.*, level, lpad(' ', (LEVEL -1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

행과 행의 연결 조건 (PRIOR XX회사 - 3가지 부(디자인부 , 정보기획부, 정보시스템부) )
PRIOR XX회사.deptcd = 디자인부.p_deptcd 
PRIOR 디자인부.p_deptcd = 디자인팀.p_deptcd

PRIOR XX회사.deptcd = 정보기획부.p_deptcd 
PRIOR 정보기획부.p_deptcd = 기획팀.p_deptcd
PRIOR 기획팀.deptcd = 기획파트.p_deptcd

PRIOR XX회사.deptcd = 정보시스템부.p_deptcd(개발1팀, 개발2팀)
PRIOR 정보시스템부.p_deptcd = 기획팀.p_deptcd
PRIOR 기획팀.............ㅜㅜ





