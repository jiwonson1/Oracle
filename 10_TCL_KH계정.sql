/*
    < TCL : TRANSACTION CONTROL LANGUAGE >
    트랜잭션을 제어하는 언어
    
    * 트랜잭션
    - 데이터베이스의 논리적 연산단위
    - 데이터의 변경사항(DML)들을 하나의 트랜잭션에 묶어서 처리
        COMMIT 하기 전 까지의 벼경하샇ㅇ들을 하나의 트랜잭션에 담게됨
        
    - 트랜잭션의 대상이 되는 SQL : INSERT, UPDATE, DELETE (DML)
    
    COMMIT (트랜잭션 종료처리 후 확정), ROLLBACK (트랜잭션 취소), SAVEPINT (임시저장)
    
    COMMIT 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 실제 DB에 반영하겠따는 의미
    ROLLBACK 진행 : 하나의 트랜잭션에 담겨있는 변경사항들을 삭제한 후 마지막 COMMIT 시점으로 돌아감
    
    SAVEPOINT : 임시저장점을 정의해두는 거
    
                ROLLBACK 진행시 전체작업을 다 삭제하는게 아닌 SAVEPOINT까지의 일부만 ROLLBACK 가능
                
                SAVEPINT 포인트명1;             --저장점 지정
                ROLLBACK TO 포인트명1;          --해당 포인트 지점까지의 트랜잭션만 롤백함
    
*/

SELECT * FROM EMP_01;

DELETE FROM EMP_01
WHERE EMP_ID = 901;

DELETE FROM EMP_01
WHERE EMP_ID = 900;


----------------------------------------------------


--200번 사원 지우기
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 800, 홍길동, 총무부, 
INSERT INTO EMP_01 VALUES(800, '홍길동', '총무부');

COMMIT;

SELECT * FROM EMP_01;

ROLLBACK;
---------------------------------------------------------


DELETE FROM EMP_01
WHERE EMP_ID IN (217, 216, 214);

-- 3개의 행이 삭제된 시점에 SAVEPOINT 지정
SAVEPOINT SP1;

INSERT INTO EMP_01 VALUES(801, '김말똥', '인사부');

DELETE FROM EMP_01 WHERE EMP_ID = 218;

ROLLBACK TO SP1;
COMMIT;

DELETE FROM EMP_01
WHERE EMP_ID IN (900, 901);

DELETE FROM EMP_01
WHERE EMP_ID = 218;

-- 테이블 생성 (DDL)
CREATE TABLE TEST (
    TID NUMBER
);

--> DDL 구문(CREATE, ALTER, DROP)을 실행하는 순간 기존에 트랜잭션에 있던 변경사항들을 무조건 실제 DB에 반영해버림(COMMIT 시켜버림)

ROLLBACK;
SELECT * FROM EMP_01;