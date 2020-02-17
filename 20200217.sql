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
�ǽ� �޷� ���� 3p
1. �ش� ���� 1���ڰ� ���� �Ͽ��� ���ϱ�
2. �ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ�
3. 2-1�� �Ͽ� �� �ϼ� ���ϱ� 
������ ���ڷ� ǥ���� �� �ִ�
������ 7��(1~7);

20200401 ==> 20200329(������)
20200430 ==> 20200502(�����)
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


���� : �������� 1��, ������ ��¥ : �ش���� ������ ���� ;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;
CONNECT BY LEVEL <= LAST_;    


���� : �������� : �ش���� 1���ڰ� ���� ���� �Ͽ���
      ������ ��¥ : �ش���� ���������ڰ� ���� ���� �����
SELECT TO_DATE('20200126', 'YYYYMMDD') + (LEVEL -1)
FROM dual
CONNECT BY LEVEL <= 35;
---------------------------------------------------------------------------------------
�������� 1��~������;
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
 

1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
���������ڰ� ���� ���� ����ϱ� �ϱ�
�ϼ� ���ϱ�; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1����, �����ڰ� ���� �������� ǥ���� �޷�
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
�ǽ� - �޷¸���� 1

SELECT DT,MAX(sales)
FROM sales
GROUP BY DT ;

1. dt (����) ==> ��, �������� SUM(SALES) ==> ���� ����ŭ ���� �׷��� �ȴ�.
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

����Ŭ ������ ���� ����
SELECT ...
FROM ...
WHERE
START WITH ���� : � ���� ���������� ������

CONNECT BY ��� ���� �����ϴ� ���� 
          PRIOR : �̹� ���� �� 
          "   " : ������ ���� �� ; 
          
����� : ���� �������� ���ĳ��� ���� (�� ==> �Ʒ�);

XXȸ��(�ֻ��� ����)���� �����Ͽ� �μ��� �������� ���� ���� ; 

SELECT LPAD(' ', 4, '*')
FROM dual;

SELECT dept_h.*, level, lpad(' ', (LEVEL -1)*4, ' ') || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = P_deptcd;

��� ���� ���� ���� (PRIOR XXȸ�� - 3���� ��(�����κ� , ������ȹ��, �����ý��ۺ�) )
PRIOR XXȸ��.deptcd = �����κ�.p_deptcd 
PRIOR �����κ�.p_deptcd = ��������.p_deptcd

PRIOR XXȸ��.deptcd = ������ȹ��.p_deptcd 
PRIOR ������ȹ��.p_deptcd = ��ȹ��.p_deptcd
PRIOR ��ȹ��.deptcd = ��ȹ��Ʈ.p_deptcd

PRIOR XXȸ��.deptcd = �����ý��ۺ�.p_deptcd(����1��, ����2��)
PRIOR �����ý��ۺ�.p_deptcd = ��ȹ��.p_deptcd
PRIOR ��ȹ��.............�̤�





