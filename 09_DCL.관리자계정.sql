/*
    < DCL : DATA CONTROL LANGUAGE >
    데이터를 제어하는 언어
    
    계정에게 시스템권한 또는 객체접근권한을 부여(GRANT)하거나 회수(REVOKE)하는 언어
    
    > 시스템권한 : DB에 접근하는 권한, 객체를 생성할 수 있는 권한
    > 객체접근권한 : 특정 객체를 조작할 수 있는 권한
    
    > 시스템권한 종류 <
    
    - CREATE SESSION : 계정에 접속할 수 있는 권한
    - CREATE TABLE : 테이블을 생설 할 수 있는 권한
    - CREATE VIEW :  뷰 생성할 수 있는 권한
    - CREATE SEQUENCE : 시퀀스 생성할 수 있는 권한
    - CREATE USER : 계정 생성할 수 있는 권한
    - ......
    
    [표현법]
    GRANT 권한1, 권한2, .. TO계정명;
    
*/
    
--1.  SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
--2. 계정에 접속하기 위해서 CERATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;

--3_1. 계쩡에 테이블을 생성할 수 있는 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;

--3_2. 테이블 스페이스 할당해줘야됨! ( SAMPLE 계정 변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;

--4. 계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여하기
GRANT CREATE VIEW TO SAMPLE;

-------------------------------

/*
    > 객체 권한 종류<
    특정 객체를 조작할 수 있는 권한
    INSERT      TABLE, VIEW
    UPDATE      TABLE, VIEW
    DELETE      TABLE, VIEW

    [표기법]
    GRANT 권한종류 ON 특정객체 TO 계쩡명;
    
*/

--5 계정에게 KHEMPLOYEE테이블에 조회(SELECT)할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;
--------------------------------------------


/*
    <롤 ROLE>
    특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : CREATE SESSION ( 데이터베이스에 접속할 수 있는 권한)
    RESOURCE : CREATE TABLE, 
    
    
*/
