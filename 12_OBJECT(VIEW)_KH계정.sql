/*
    <VIEW 뷰 >
    
    SELECT문 (쿼리문)을 저장해둘 수 있는 객체 (자주 쓰는 긴 SELECT문을 저장해두면 긴 SELECT문을 매번 다시 기술 할 필요없음)
    
    
*/

-- '한국'근무하는 사원의 사번, 이름 , 부서명, 급여, 근무국가명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';
-- '러시아'에서 근무하는 사원의 사번, 이름, 부서명, 급여, 근무국가명을 조회하시오
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';


-----------------------------------------------------
/*
 1. VIEW 생성 방법
 
 (표현법)
  CREATE [OR REPLACE] VIEW 뷰명
  AS 서브쿼리;
  
  [OR REPLACE] : 뷰 생성시 기존에 중복된 뷰가 없다면 새로이 뷰를 생성하고
                         기존에 중복된 뷰가 있다면 해당 뷰를 변경하는 키워드
                         
                        
 */

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS  SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    JOIN NATIONAL USING (NATIONAL_CODE);
    
    --> 처음 생성시 CREATE VIEW 권한이 없었기 때무에 권한문제! = > CREATE VIEW 권한부여받아야됨
    
    SELECT *
    FROM VW_EMPLOYEE;
    
    -- 한국에서 근무하는 사원
    SELECT * 
    FROM VW_EMPLOYEE
    WHERE NATIANL_NAME = '한국';
    
    -- 러시아에서 근무하는 사원
    SELECT EMP_NAME, SALARY
    FROM VW_EMPLOYEE
    WHERE NATIONAL_NAME = '러시아';
    
    -- 중국에서 근무하는 사원
    SELECT *
    FROM VW_EMPLOYEE
    WHERE NATIONAL_NAME = '중국';
    
    --뷰는 논리적인 가상테이블 --> 실질적으로 데이터를 저장하고 있지 않음 ( 단순히 쿼리문이 TXT문구로 저장되어잇는거 뿐)
    
    -- [ 참고] 해당 계정이 가지고있는 VIEW들에 대한 내용 조회시 
    SELECT * FROM USER_VIEWS;
    
    -- 뷰 컬럼에 별칭부여
    -- 서브쿼리의 SELECT 절에 함수식이나 산술연산식이 기술되어있는 경우 반드시 별칭 지정!!
    
    -- 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수 있는 SELECT문을 뷰로 정의
    CREATE OR REPLACE VIEW VW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME, JOB_NAME, 
                DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별",
                EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);
        
        CREATE OR REPLACE VIEW VW_EMP_JOB
    AS SELECT EMP_ID, EMP_NAME 사원명, JOB_NAME, 
                DECODE(SUBSTR(EMP_NO, 8, 1), '1', '남', '2', '여') "성별",
                EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) "근무년수"
        FROM EMPLOYEE
        JOIN JOB USING (JOB_CODE);
        
SELECT 사원명, 근무년수
FROM VW_EMP_JOB;

SELECT 사원명, 근무년수
FROM VW_EMP_JOB
WHERE 성별 = '여';

SELECT *
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

-- 뷰 삭제 하고자 한다면
DROP VIEW VW_EMP_JOB;

-------------------------------------------------------
        
  -- 뷰를 통해서 변경하게 되면 실제 데이터가 남겨있는 베이스테이블에 적용됨
  
  CREATE OR REPLACE VIEW VW_JOB
  AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
    SELECT * FROM VW_JOB;
    SELECT * FROM JOB;
    
    -- 뷰에 INSERT
    INSERT INTO VW_JOB VALUES('J8', '인턴'); --> 베이스테이블에 값 INSERT
    
    -- 뷰로 UPDATE(J8 직급명을 '알바'로 변경)
    UPDATE VW_JOB
    SET JOB_NAME = '알바'
    WHERE JOB_CODE = 'J8';
    
    -- 뷰에 DELETE
    DELETE FROM VW_JOB
    WHERE JOB_CODE = 'J8'; -->    베이스테이블에 값 DELETE
    
    --------------------------------------------
    
    /*
        * 하지만 DML 명령어로 조작이 불가능한 경우가 더 많음.....ㅎ
        
        1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
        2) 뷰에 정의되어있지 않은 컬럼 중에 베이스테이블 상에 NOT NULL제약 조건이 지정된 경우
        3) 산술연산식 또는 함수식으로 정의된 경우
        4) 그룹함수나 GROUP BY절이 포함된 경우
        5) DISTINCT 구문이 포함된 경우
        6) JOIN을 이용해서 여러 테이블을 연결시켜놓은 경우
        
    */
    
    --1) 뷰에 정의되어 있지 않은 컬럼을 조작하는 경우
    
    CREATE OR REPLACE VIEW VW_JOB2
        AS SELECT JOB_NAME, JOB_CODE
        FROM JOB;
        
    SELECT * FROM VW_JOB2;
    INSERT INTO VW_JOB2(JOB_CODE, JOB_NAME) VALUES ('J8', '인턴');
    
    UPDATE VW_JOB2
    SET JOB_NAME = '인턴'
    WHERE JOB_CODE = 'J7';
    
    DELETE FROM VW_JOB2
    WHERE JOB_NAME = '사원';
    
    -- 2) 뷰에 정의되어있지 않은 컬럼 중에서 NOT NULL 제약조건이 지정된 경우
    CREATE OR REPLACE VIEW VW_JOB3
    AS SELECT JOB_NAME
        FROM JOB;
        
    SELECT * FROM VW_JOB3;
    
    --INSERT
    INSERT INTO VW_JOB3 VALUES('인턴');
    
    UPDATE VW_JOB3
    SET JOB_NAME = '알바'
    WHERE JOB_NAME = '사원';
    
    ROLLBACK;
    
    INSERT INTO JOB VALUES('J8', '인턴');
    
    
    DELETE FROM VW_JOB3
    WHERE JOB_NAME = '인턴';

    -- 3) 함수식 산술연산식으로 정의된 경우
    
    -- 사원의 사번, 사원명, 급여 ,연봉에 대해서 조회하는 뷰
    CREATE OR REPLACE VIEW VW_EMP_SAL
    AS SELECT EMP_ID, EMP_NAME, SALARY * 12
    FROM EMPLOYEE;
    
    SELECT * FROM VW_EMP_SAL;
    
    
    CREATE OR REPLACE VIEW VW_JOINEMP
    AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE
        FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);
        
    SELECT * FROM VW_JOINEMP;
    
    INSERT INTO VW_JOINEMP VALUES(888, '조세오', '총무부');
    
    UPDATE VW_JOINEMP
    SET EMP_NAME = '서동일'
    WHERE EMP_ID = '200';
    
    SELECT * FROM EMPLOYEE;
    
    UPDATE VW_JOINEMP
    SET DEPT_TITLE = '총무1팀'
    WHERE DEPT_TITLE = '총무부';
    
    DELETE FROM VW_JOINEMP
    WHERE EMP_ID =200;
    
    ROLLBACK;
    
    SELECT * FROM EMPLOYEE;
    
    -------------------------------------------------
    
    /*
        * VIEW 옵션
        
        [상세표현법]
        CREATE [OR REPALCE] VIEW 뷰명
        AS 서브쿼리
        [WITH CHECK OPTION]
        [WITH READ ONLY];
        WITH CHECK OPTION : 서브쿼리에 기술된 조건에 부합하지 않은 값으로 수정하는 경우 오류 발생
        
        FORCE / NOFORCE 옵션
        --NOFORCE : 서브쿼리에 기술된 테이블이 존재해야만 뷰가 생성
        
           
    */
    
    CREATE OR REPLACE FORCE VIEW VW_EMP
    AS SELECT TCOED, TNAME, TCONTENT 
        FROM TT;
        
    SELECT * FROM VW_EMP;
    
    CREATE TABLE TT( --> TT 테이블 생성해야만 그때부터 VIEW 조회 가능
        TCODE NUMBER,
        TNAME VARCHAR2(30),
        TCONTENT VARCHAR2(50), ;
        
    CREATE OR REPLACE VIEW VW_EMP2
    AS SELECT *
    FROM EMPLOYEE
    WHERE SALARY >= 3000000;
    
    SELECT * FROM VW_EMP2; -- 8명조회
    
    --200번 사원의 급여를 200만원으로 변경 -- 서브쿼리의 조건에 부합하지 않아도 잘 변경됨!!
    
    UPDATE VW_EMP2
    SET SALARY = 200000
    WHERE EMP_ID = 200;
   
   ROLLBACK;
   
   SELECT * FROM EMPLOYEE; 
   
   CREATE OR REPLACE VIEW VW_EMPBONUS
    AS SELECT EMP_ID, EMP_NAME, BONUS
        FROM EMPLOYEE
        WHERE BONUS IS NOT NULL
  WITH READ ONLY;
  
  SELECT * FROM VW_EMPBONUS;
  
  DELETE FROM VW_EMPBONUS
  WHER EMP_ID = 200;
  
  
        
  
    
    